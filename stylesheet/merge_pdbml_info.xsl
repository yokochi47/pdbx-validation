<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v2.xsd">

  <xsl:param name="info_alt_file" required="yes"/>
  <xsl:param name="info_alt" select="document($info_alt_file)"/>

  <xsl:param name="alt_datablock" select="$info_alt/PDBxv:datablock"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="entry_id"><xsl:value-of select="/PDBxv:datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat($entry_id,'-validation-full')"/></xsl:variable>

  <xsl:variable name="pdb_id"><xsl:value-of select="$alt_datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>

  <xsl:template match="/">

    <xsl:if test="$entry_id!=$pdb_id">
      <xsl:call-template name="error_handler">
        <xsl:with-param name="terminate">yes</xsl:with-param>
        <xsl:with-param name="error_message">
Unmatched entry ID in both documents (<xsl:value-of select="$entry_id"/> and <xsl:value-of select="$pdb_id"/>).
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <PDBxv:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-validation-v2.xsd pdbx-validation-v2.xsd">
      <xsl:apply-templates select="PDBxv:datablock/*[not(local-name()='pdbx_validate_rmsd_angleCategory' or local-name()='pdbx_validate_rmsd_bondCategory' or local-name()='pdbx_validate_close_contactCategory' or local-name()='pdbx_validate_symm_contactCategory')]"/>
      <xsl:apply-templates select="$alt_datablock/*[not(local-name()='entryCategory' or local-name()='pdbx_validate_rmsd_angleCategory' or local-name()='pdbx_validate_rmsd_bondCategory' or local-name()='pdbx_validate_close_contactCategory' or local-name()='pdbx_validate_symm_contactCategory')]"/>

      <xsl:call-template name="merge_pdbx_validate_rmsd_angle"/>

      <xsl:call-template name="merge_pdbx_validate_rmsd_bond"/>

      <xsl:call-template name="merge_pdbx_validate_close_contact"/>

      <xsl:call-template name="merge_pdbx_validate_symm_contact"/>

    </PDBxv:datablock>
  </xsl:template>

  <xsl:template match="PDBxv:diffrnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_attenuatorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_detectorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_measurementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_orient_matrixCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_orient_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_radiationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_radiation_wavelengthCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_reflnsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_reflns_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_scale_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_sourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_standard_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:diffrn_standardsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_2d_crystal_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_3d_crystal_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_3d_fittingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_3d_fitting_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_3d_reconstructionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_bufferCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_buffer_componentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_crystal_formationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_ctf_correctionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_diffractionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_diffraction_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_diffraction_statsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_embeddingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_entity_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_entity_assembly_molwtCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_entity_assembly_naturalsourceCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_entity_assembly_recombinantCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_experimentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_helical_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_image_processingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_image_recordingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_image_scansCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_imagingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_imaging_opticsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_particle_selectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_single_particle_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_specimenCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_stainingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_virus_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_virus_natural_hostCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_virus_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_vitrificationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:em_volume_selectionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entity_name_comCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entity_name_sysCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entity_polyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entity_poly_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:entry_linkCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:exptlCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:ndb_struct_conf_naCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:ndb_struct_na_base_pairCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:ndb_struct_na_base_pair_stepCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_authorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_revision_categoryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_revision_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_revision_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_revision_historyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_audit_revision_itemCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_bond_distance_limitsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_coordinate_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_database_relatedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_database_statusCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_densityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_density_corrCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_entity_geometryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_geometryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_mapCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_map_overallCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_mapmanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_mon_geometryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_rscc_mapmanCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_rscc_mapman_overallCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_diffrn_reflns_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_distant_solvent_atomsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_domainCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_domain_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_atom_inclusionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_atom_inclusion_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_density_distributionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_density_distribution_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_fsc_curveCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_fsc_curve_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_fsc_cutoff_curveCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_fsc_cutoff_curve_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_fsc_resolutionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_rapsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_raps_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_validate_map_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_validate_map_model_entityCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_validate_map_model_overallCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_volume_estimateCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_em_volume_estimate_markerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_branch_descriptorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_descriptorCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_nonpolyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_poly_comp_link_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entry_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_helical_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_missing_nmr_star_itemCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_assigned_chem_shift_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_chem_shift_annotationCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_chem_shift_completenessCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_chem_shift_re_offsetCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_constraintsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_ensembleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_ensemble_rmsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_exptlCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_exptl_sampleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_exptl_sample_conditionsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_force_constantsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_representativeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_spectrometerCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_unmapped_chem_shiftCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nmr_unparsed_chem_shiftCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_nonpoly_schemeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_percentile_conditionsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_percentile_entity_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_percentile_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_percentile_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_MAD_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_MAD_set_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_MAD_set_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_MAD_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_MRCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_dmCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_phasing_dm_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_point_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_poly_seq_schemeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_re_refinementCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_refine_componentCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_refine_tlsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_refine_tls_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_reflns_twinCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_sequence_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_soln_scatterCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_soln_scatter_modelCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_assemblyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_assembly_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_assembly_propCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_asym_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_chem_comp_diagnosticsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_conn_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_entity_instCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_group_component_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_group_componentsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_group_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_infoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_legacy_oper_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_mod_residueCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_msym_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_clustCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_clust_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_domCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_dom_limCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_oper_listCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_ref_seq_deletionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_ref_seq_insertionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_sheet_hbondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_special_symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_unobs_or_zero_occ_atomsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_unobs_or_zero_occ_residuesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_chiralCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_close_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_main_chain_planeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_nmr_chem_shiftCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_peptide_omegaCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_planesCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_planes_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_polymer_linkageCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_angleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_bondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_ringCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_rings_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_torsionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_rmsd_torsions_atomCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_symm_contactCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validate_torsionCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validation_softwareCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MADCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MAD_clustCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MAD_exptCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MAD_ratioCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MAD_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIRCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIR_derCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIR_der_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIR_der_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIR_der_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_MIR_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_averagingCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_isomorphousCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_setCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:phasing_set_reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refineCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_B_isoCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_analyzeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_funct_minimizedCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_histCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_ls_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_ls_restrCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_ls_restr_ncsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_ls_restr_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_ls_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refine_occupancyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:reflnCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:refln_sys_absCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:reflnsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:reflns_classCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:reflns_scaleCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:reflns_shellCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:space_groupCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:space_group_symopCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:structCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_asymCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_biolCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_biol_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_confCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_conf_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_connCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_conn_typeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_mon_detailsCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_mon_nuclCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_mon_protCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_mon_prot_cisCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ncs_domCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ncs_dom_limCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ncs_ensCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ncs_ens_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ncs_operCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_refCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ref_seqCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ref_seq_difCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_sheetCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_sheet_hbondCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_sheet_orderCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_sheet_rangeCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_sheet_topologyCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_siteCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_site_genCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:struct_site_viewCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:symmetryCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:symmetry_equivCategory">
    <xsl:element name="{name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBxv:*" mode="category-element">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()" mode="data-item"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*" mode="category-element">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="PDBxv:*" mode="data-item">
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

  <xsl:template name="merge_pdbx_validate_rmsd_angle">
    <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_angleCategory or $alt_datablock/PDBxv:pdbx_validate_rmsd_angleCategory">
      <xsl:element name="PDBxv:pdbx_validate_rmsd_angleCategory">
        <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_angleCategory">
          <xsl:apply-templates select="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_angleCategory/*" mode="category-element"/>
        </xsl:if>
        <xsl:if test="$alt_datablock/PDBxv:pdbx_validate_rmsd_angleCategory">
          <xsl:apply-templates select="$alt_datablock/PDBxv:pdbx_validate_rmsd_angleCategory/*" mode="category-element"/>
        </xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="merge_pdbx_validate_rmsd_bond">
    <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_bondCategory or $alt_datablock/PDBxv:pdbx_validate_rmsd_bondCategory">
      <xsl:element name="PDBxv:pdbx_validate_rmsd_bondCategory">
        <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_bondCategory">
          <xsl:apply-templates select="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_bondCategory/*" mode="category-element"/>
        </xsl:if>
        <xsl:if test="$alt_datablock/PDBxv:pdbx_validate_rmsd_bondCategory">
          <xsl:apply-templates select="$alt_datablock/PDBxv:pdbx_validate_rmsd_bondCategory/*" mode="category-element"/>
        </xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="merge_pdbx_validate_close_contact">
    <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_close_contactCategory or $alt_datablock/PDBxv:pdbx_validate_close_contactCategory">
      <xsl:element name="PDBxv:pdbx_validate_close_contactCategory">
        <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_close_contactCategory">
          <xsl:apply-templates select="PDBxv:datablock/PDBxv:pdbx_validate_close_contactCategory/*" mode="category-element"/>
        </xsl:if>
        <xsl:if test="$alt_datablock/PDBxv:pdbx_validate_close_contactCategory">
          <xsl:apply-templates select="$alt_datablock/PDBxv:pdbx_validate_close_contactCategory/*" mode="category-element"/>
        </xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template name="merge_pdbx_validate_symm_contact">
    <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_symm_contactCategory or $alt_datablock/PDBxv:pdbx_validate_symm_contactCategory">
      <xsl:element name="PDBxv:pdbx_validate_symm_contactCategory">
        <xsl:if test="PDBxv:datablock/PDBxv:pdbx_validate_symm_contactCategory">
          <xsl:apply-templates select="PDBxv:datablock/PDBxv:pdbx_validate_symm_contactCategory/*" mode="category-element"/>
        </xsl:if>
        <xsl:if test="$alt_datablock/PDBxv:pdbx_validate_symm_contactCategory">
          <xsl:apply-templates select="$alt_datablock/PDBxv:pdbx_validate_symm_contactCategory/*" mode="category-element"/>
        </xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

</xsl:stylesheet>