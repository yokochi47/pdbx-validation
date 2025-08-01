<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:align="http://www.ebi.ac.uk/pdbe/docs/sifts/alignment.xsd"
  xmlns:data="http://www.ebi.ac.uk/pdbe/docs/sifts/dataTypes.xsd"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:sifts="http://www.ebi.ac.uk/pdbe/docs/sifts/eFamily.xsd"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  exclude-result-prefixes="align data dc rdf sifts">

  <xsl:param name="sifts_file" required="yes"/>
  <xsl:param name="sifts_entry" select="document($sifts_file)/sifts:entry"/>

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="datablock" select="/PDBx:datablock"/>

  <xsl:variable name="entry_id"><xsl:value-of select="$datablock/PDBx:entryCategory/PDBx:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat($entry_id,'-noatom')"/></xsl:variable>

  <xsl:variable name="pdb_id"><xsl:value-of select="translate($sifts_entry/@dbAccessionId,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></xsl:variable>

  <xsl:template match="/">

    <xsl:if test="$entry_id!=$pdb_id">
      <xsl:call-template name="error_handler">
	<xsl:with-param name="terminate">yes</xsl:with-param>
	<xsl:with-param name="error_message">
Unmatched entry ID in both documents (<xsl:value-of select="$entry_id"/> and <xsl:value-of select="$pdb_id"/>).
	</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <PDBx:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-v50.xsd pdbx-v50.xsd">
      <xsl:apply-templates select="PDBx:datablock/*[not(local-name()='pdbx_sifts_unp_segmentsCategory' or local-name()='pdbx_sifts_xref_db_segmentsCategory')]"/>

      <xsl:call-template name="merge_pdbx_sifts_unp_segments"/>

      <xsl:call-template name="merge_pdbx_sifts_xref_db_segments"/>

    </PDBx:datablock>
  </xsl:template>

  <xsl:template match="PDBx:array_dataCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:array_intensitiesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:array_structureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:array_structure_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:array_structure_list_axisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:array_structure_list_sectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_site_anisotropCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_sitesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_sites_altCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_sites_alt_ensCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_sites_alt_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_sites_footnoteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:atom_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:audit_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:audit_conformCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:audit_contact_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:audit_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:cellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:cell_measurementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:cell_measurement_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_compCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_chirCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_chir_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_planeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_plane_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_torCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp_tor_valueCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_chirCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_chir_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_planeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_plane_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_torCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chem_link_tor_valueCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chemicalCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chemical_conn_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chemical_conn_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:chemical_formulaCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:citationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:citation_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:citation_editorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:computingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:databaseCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_2Category">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_caveatCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_matrixCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_remarkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_revCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_rev_recordCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:database_PDB_tvectCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_attenuatorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_data_frameCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_detectorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_detector_axisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_detector_elementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_measurementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_orient_matrixCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_orient_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_radiationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_radiation_wavelengthCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflnsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflns_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scale_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scan_axisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scan_collectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scan_frameCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scan_frame_axisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_sourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_standard_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_standardsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_2d_crystal_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_2d_projection_selectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_crystal_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_fittingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_fitting_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_reconstructionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_adminCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_author_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_bufferCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_buffer_componentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_crystal_formationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_ctf_correctionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_db_referenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_db_reference_auxiliaryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_depuiCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_detectorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffractionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffraction_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffraction_statsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_embeddingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_molwtCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_naturalsourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_recombinantCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_syntheticCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_euler_angle_assignmentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_experimentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_fiducial_markersCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_figure_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_final_classificationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_focused_ion_beamCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_fsc_curveCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_grid_pretreatmentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_helical_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_high_pressure_freezingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_processingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_recordingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_scansCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_imagingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_imaging_opticsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_interpret_figureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_layer_linesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_layer_lines_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_mapCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_map_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_mask_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_motion_correctionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_obsoleteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_particle_selectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_sample_preparationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_sample_supportCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_shadowingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_single_particle_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_specimenCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_stainingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_start_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_structure_factorsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_structure_factors_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_supersedeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_support_filmCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_tomographyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_tomography_specimenCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_ultramicrotomyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_natural_hostCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_syntheticCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_vitrificationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_volume_selectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_keywordsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_name_comCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_name_sysCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_polyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_poly_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_src_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_src_natCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entry_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptlCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptl_crystalCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptl_crystal_faceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptl_crystal_growCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptl_crystal_grow_compCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geom_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geom_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geom_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geom_hbondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:geom_torsionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:journalCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:journal_indexCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_original_ndb_coordinatesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_conf_naCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_feature_naCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_na_base_pairCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_na_base_pair_stepCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_SG_projectCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_atlasCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_atom_site_aniso_tlsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_conformCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_conform_extensionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_categoryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_historyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_itemCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_supportCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_bond_distance_limitsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_branch_schemeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_bufferCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_buffer_componentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chain_remappingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_atom_editCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_atom_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_atom_relatedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_bond_editCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_descriptorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_identifierCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_importCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_instance_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_descriptorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_model_referenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_nonstandardCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_pcmCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_relatedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_subcomponent_entity_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_subcomponent_struct_connCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_synonymsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_chem_comp_upload_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_columninfoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_connectCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_connect_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_connect_modificationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_connect_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_constructCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_construct_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_contact_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_coordCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_coordinate_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_crystal_alignmentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_data_processing_cellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_data_processing_detectorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_data_processing_reflnsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_data_processing_statusCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_data_usageCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_PDB_masterCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_PDB_obs_sprCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_doiCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_messageCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_pdb_omitCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_procCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_relatedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_remarkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_statusCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_status_historyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dbrefCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_densityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_density_corrCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_geometryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_mapCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_mapmanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_rscc_mapmanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_rscc_mapman_overallCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_deposit_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_deposit_group_indexCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_deposition_message_file_referenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_deposition_message_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_entity_featuresCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_entity_status_flagsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_entry_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_status_flagsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_uploadCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_depui_validation_status_flagsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_batchCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_batch_scanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_cellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_detector_panel_mappingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_orientationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_reflns_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_distant_solvent_atomsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_domainCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_domain_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_drug_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branchCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_descriptorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_func_bind_modeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_func_enzymeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_func_otherCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_func_regulatoryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_func_structuralCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_instance_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_nameCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_name_instanceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_name_taxonomyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_name_taxonomy_treeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_nonpolyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_comp_link_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_domainCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_na_nonstandardCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_na_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_protein_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_prod_protocolCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_remappingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_characterCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_chromCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_cloneCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_clone_ligationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_clone_recombinationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_expressCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_express_timepointCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_fractCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_lysisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_prod_digestCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_prod_otherCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_prod_other_parameterCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_prod_pcrCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_proteolysisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_pureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_gen_refoldCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_src_synCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entry_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_exptl_crystal_cryo_treatmentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_exptl_crystal_grow_compCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_exptl_crystal_grow_solCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_exptl_pdCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_family_group_indexCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_family_prd_auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_feature_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_feature_domainCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_feature_entryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_feature_monomerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_feature_sequence_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_helical_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_helical_symmetry_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_hybridCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_inhibitor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_initial_refinement_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_investigationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_ion_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_linked_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_linked_entity_instance_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_linked_entity_link_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_linked_entity_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_missing_atom_nonpolyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_missing_atom_polyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_missing_residue_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_modification_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_moleculeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_molecule_featuresCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_molecule_features_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_na_strand_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_na_struct_keywdsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_assigned_chem_shift_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_experimentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_refCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_referenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_computingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_constraint_fileCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_constraintsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_ensembleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_ensemble_rmsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptlCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptl_sampleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptl_sample_conditionsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_force_constantsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_representativeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_sample_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_software_taskCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_spectral_dimCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_spectral_peak_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_spectral_peak_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_spectrometerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_systematic_chem_shift_offsetCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_uploadCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nonpoly_schemeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nonstandard_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_pdb_compndCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_pdb_sourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_set_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_set_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MRCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_dmCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_dm_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_point_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_point_symmetry_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_poly_seq_schemeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_post_process_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_post_process_statusCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_prd_auditCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_prerelease_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_protein_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_re_refinementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_nonpolyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_polyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_poly_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_poly_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_sequenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_src_natCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_entity_subcomponentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_linked_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_linked_entity_comp_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_linked_entity_comp_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_linked_entity_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_moleculeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_annotationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_familyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_featuresCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_related_structuresCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_molecule_synonymsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reference_publication_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_aux_fileCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_componentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_ls_restr_ncsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_tlsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_tls_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refln_signal_binningCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reflns_twinCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_related_exp_data_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_remediation_atom_site_mappingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_rmch_outlierCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_rms_devs_cov_by_monomerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_rms_devs_covalentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_robot_systemCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_seq_map_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sequence_annotationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sequence_patternCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sequence_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_serial_crystallography_data_reductionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_serial_crystallography_measurementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_serial_crystallography_sample_deliveryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_serial_crystallography_sample_delivery_fixed_targetCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_serial_crystallography_sample_delivery_injectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_unp_segmentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_xref_dbCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_xref_db_segmentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_soln_scatterCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_soln_scatter_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_solvent_atom_site_mappingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_solvent_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_stereochemistryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_auth_classificationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_auth_evidenceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_auth_evidence_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_gen_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_propCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_prop_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_asym_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_biol_funcCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_chem_comp_diagnosticsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_chem_comp_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_conn_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_entity_instCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_component_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_componentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_legacy_oper_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_mod_residueCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_msym_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ncs_virus_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_oper_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_oper_list_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_pack_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_deletionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_dif_depositor_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_featureCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_feature_propCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_insertionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_sheet_hbondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_special_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sugar_phosphate_geometryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_summary_flagsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_supporting_exp_data_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_tableinfoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_trna_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_unobs_or_zero_occ_atomsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_unobs_or_zero_occ_residuesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_unpairCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_val_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_val_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_val_chiralCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_val_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_val_sym_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_chiralCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_close_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_main_chain_planeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_peptide_omegaCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_planesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_planes_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_polymer_linkageCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_symm_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_torsionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_versionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_view_categoryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_view_category_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_view_itemCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_virtual_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_virtual_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_virtual_torsionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_xplor_fileCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MADCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_clustCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_exptCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_ratioCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIRCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_derCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_averagingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_isomorphousCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_set_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:publCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:publ_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:publ_bodyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:publ_manuscript_inclCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_B_isoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_analyzeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_funct_minimizedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_histCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restrCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restr_ncsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restr_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_occupancyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refln_sys_absCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflnsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_scaleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:space_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:space_group_symopCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:structCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_asymCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biolCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biol_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biol_keywordsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biol_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_confCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_conf_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_connCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_conn_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_keywordsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_nuclCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_protCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_prot_cisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_domCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_dom_limCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_ensCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_ens_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_operCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_refCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ref_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ref_seq_difCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheetCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_hbondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_orderCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_topologyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_site_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_site_keywordsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_site_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:symmetry_equivCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:valence_paramCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:valence_refCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:*" mode="category-element">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()" mode="data-item"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*" mode="category-element">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="PDBx:*" mode="data-item">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()" mode="data-item"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="node()" mode="data-item">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="@*" mode="data-item">
    <xsl:copy/>
  </xsl:template>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
	<xsl:message terminate="yes">
	  <xsl:text>ERROR in merge_pdbml_info.xsl: </xsl:text>
	  <xsl:value-of select="$error_message"/>
	</xsl:message>
      </xsl:when>
      <xsl:otherwise>
	<span style="font-weight: bold; color: red">
	  <xsl:text>ERROR: </xsl:text>
	  <xsl:value-of select="$error_message"/>
	</span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="extract_pdbx_sifts_unp_segments">

    <xsl:for-each select="$sifts_entry/sifts:entity">

      <xsl:variable name="asym_id"><xsl:value-of select="@entityId"/></xsl:variable>
      <xsl:variable name="entity_id"><xsl:value-of select="$datablock/PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme[@asym_id=$asym_id][1]/@entity_id"/></xsl:variable>

      <xsl:for-each select="sifts:segment">
	<xsl:variable name="segment_id"><xsl:value-of select="position()"/></xsl:variable>
	<xsl:variable name="seq_id_start"><xsl:value-of select="@start"/></xsl:variable>
	<xsl:variable name="seq_id_end"><xsl:value-of select="@end"/></xsl:variable>
	<xsl:variable name="seq_id_range"><xsl:value-of select="number(@end) - number(@start) + 1"/></xsl:variable>

	<xsl:variable name="max_range">
	  <xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource='UniProt']">
	    <xsl:sort select="number(@end) - number(@start)" data-type="number" order="descending"/>
	    <xsl:if test="position()=1"><xsl:value-of select="number(@end) - number(@start)"/></xsl:if>
	  </xsl:for-each>
	</xsl:variable>

	<xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource='UniProt']">

	  <xsl:variable name="instance_id"><xsl:value-of select="position()"/></xsl:variable>
	  <xsl:variable name="unp_acc"><xsl:value-of select="@dbAccessionId"/></xsl:variable>

	  <PDBx:pdbx_sifts_unp_segments entity_id="{$entity_id}" asym_id="{$asym_id}" unp_acc="{$unp_acc}" segment_id="{$segment_id}" instance_id="{$instance_id}">

	    <xsl:variable name="range"><xsl:value-of select="number(@end) - number(@start) + 1"/></xsl:variable>

	    <PDBx:unp_start><xsl:value-of select="@start"/></PDBx:unp_start>
	    <PDBx:unp_end><xsl:value-of select="@end"/></PDBx:unp_end>
	    <PDBx:seq_id_start><xsl:value-of select="$seq_id_start"/></PDBx:seq_id_start>
	    <PDBx:seq_id_end><xsl:value-of select="$seq_id_end"/></PDBx:seq_id_end>
	    <xsl:choose>
	      <xsl:when test="number(@end) - number(@start)=$max_range">
		<PDBx:best_mapping>Y</PDBx:best_mapping>
	      </xsl:when>
	      <xsl:otherwise>
		<PDBx:best_mapping>N</PDBx:best_mapping>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	      <xsl:when test="$seq_id_range > $range">
		<PDBx:identity>1.000</PDBx:identity>
	      </xsl:when>
	      <xsl:otherwise>
		<PDBx:identity><xsl:value-of select="format-number($seq_id_range div $range,'0.000')"/></PDBx:identity>
	      </xsl:otherwise>
	    </xsl:choose>

	  </PDBx:pdbx_sifts_unp_segments>

	</xsl:for-each>

      </xsl:for-each>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="extract_pdbx_sifts_xref_db_segments">

    <xsl:for-each select="$sifts_entry/sifts:entity">

      <xsl:variable name="asym_id"><xsl:value-of select="@entityId"/></xsl:variable>
      <xsl:variable name="entity_id"><xsl:value-of select="$datablock/PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme[@asym_id=$asym_id][1]/@entity_id"/></xsl:variable>

      <xsl:for-each select="sifts:segment">
	<xsl:variable name="segment_id"><xsl:value-of select="position()"/></xsl:variable>

	<xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource!='PDB' and @dbSource!='UniProt' and @dbSource!='EC']">

	  <xsl:variable name="seq_id_start"><xsl:value-of select="../@start"/></xsl:variable>
	  <xsl:variable name="seq_id_end"><xsl:value-of select="../@end"/></xsl:variable>

	  <xsl:variable name="instance_id"><xsl:value-of select="position()"/></xsl:variable>
	  <xsl:variable name="xref_db"><xsl:value-of select="@dbSource"/></xsl:variable>
	  <xsl:variable name="xref_db_acc">
	    <xsl:choose>
	      <xsl:when test="contains(@dbAccessionId,':') and @dbSource!='GO'">
		<xsl:value-of select="substring-after(@dbAccessionId,':')"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="@dbAccessionId"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>

	  <PDBx:pdbx_sifts_xref_db_segments entity_id="{$entity_id}" asym_id="{$asym_id}" xref_db="{$xref_db}" xref_db_acc="{$xref_db_acc}" segment_id="{$segment_id}" instance_id="{$instance_id}" seq_id_start="{$seq_id_start}" seq_id_end="{$seq_id_end}">
	    <!-- v4.356 or older
	    <PDBx:seq_id_start><xsl:value-of select="$seq_id_start"/></PDBx:seq_id_start>
	    <PDBx:seq_id_end><xsl:value-of select="$seq_id_end"/></PDBx:seq_id_end>
	    -->
	  </PDBx:pdbx_sifts_xref_db_segments>

	</xsl:for-each>

      </xsl:for-each>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="merge_pdbx_sifts_unp_segments">
    <xsl:if test="PDBx:datablock/PDBx:pdbx_sifts_unp_segmentsCategory or $sifts_entry/sifts:entity/sifts:segment/sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource='UniProt']">
      <xsl:element name="PDBx:pdbx_sifts_unp_segmentsCategory">
	<xsl:choose>
	  <xsl:when test="PDBx:datablock/PDBx:pdbx_sifts_unp_segmentsCategory">
	    <xsl:apply-templates select="PDBx:datablock/PDBx:pdbx_sifts_unp_segments/*" mode="category-element"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="extract_pdbx_sifts_unp_segments"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="merge_pdbx_sifts_xref_db_segments">
    <xsl:if test="PDBx:datablock/PDBx:pdbx_sifts_xref_db_segmentsCategory or $sifts_entry/sifts:entity/sifts:segment/sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource!='PDB' and @dbSource!='UniProt' and @dbSource!='EC']">
      <xsl:element name="PDBx:pdbx_sifts_xref_db_segmentsCategory">
	<xsl:choose>
	  <xsl:when test="PDBx:datablock/PDBx:pdbx_sifts_xref_db_segmentsCategory">
	    <xsl:apply-templates select="PDBx:datablock/PDBx:pdbx_sifts_xref_db_segments/*" mode="category-element"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="extract_pdbx_sifts_xref_db_segments"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

</xsl:stylesheet>