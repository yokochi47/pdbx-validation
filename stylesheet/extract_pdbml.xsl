<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
  exclude-result-prefixes="PDBx">

  <xsl:param name="info_file" required="yes"/>
  <xsl:param name="info" select="document($info_file)"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="entry_id"><xsl:value-of select="/PDBx:datablock/PDBx:entryCategory/PDBx:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat(/PDBx:datablock/@datablockName,'-ext')"/></xsl:variable>

  <xsl:variable name="pdb_id"><xsl:value-of select="$info/wwPDB-validation-information/Entry/@pdbid"/></xsl:variable>
  <xsl:variable name="xml_creation_date"><xsl:value-of select="$info/wwPDB-validation-information/Entry/@XMLcreationDate"/></xsl:variable>

  <xsl:variable name="validation_created_year"><xsl:value-of select="substring($xml_creation_date,9,4)"/></xsl:variable>
  <xsl:variable name="validation_created_day"><xsl:value-of select="translate(substring($xml_creation_date,5,2),' ','0')"/></xsl:variable>
  <xsl:variable name="validation_created_month">
    <xsl:variable name="month_name"><xsl:value-of select="upper-case(substring($xml_creation_date,1,3))"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="$month_name='JAN'">01</xsl:when>
      <xsl:when test="$month_name='FEB'">02</xsl:when>
      <xsl:when test="$month_name='MAR'">03</xsl:when>
      <xsl:when test="$month_name='APR'">04</xsl:when>
      <xsl:when test="$month_name='MAY'">05</xsl:when>
      <xsl:when test="$month_name='JUN'">06</xsl:when>
      <xsl:when test="$month_name='JUL'">07</xsl:when>
      <xsl:when test="$month_name='AUG'">08</xsl:when>
      <xsl:when test="$month_name='SEP'">09</xsl:when>
      <xsl:when test="$month_name='OCT'">10</xsl:when>
      <xsl:when test="$month_name='NOV'">11</xsl:when>
      <xsl:when test="$month_name='DEC'">12</xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="error_handler">
          <xsl:with-param name="terminate">yes</xsl:with-param>
          <xsl:with-param name="error_message">
Month name, <xsl:value-of select="$month_name"/>, is not listed in XSLT code.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="validation_created_date"><xsl:value-of select="concat($validation_created_year,'-',$validation_created_month,'-',$validation_created_day)"/></xsl:variable>

  <xsl:variable name="nmr_models_consistency_flag"><xsl:value-of select="$info/wwPDB-validation-information/Entry/@nmr_models_consistency_flag"/></xsl:variable>

  <xsl:template match="/">

    <xsl:if test="$entry_id!=$pdb_id">
      <xsl:call-template name="error_handler">
        <xsl:with-param name="terminate">yes</xsl:with-param>
        <xsl:with-param name="error_message">
Unmatched entry ID in both documents (<xsl:value-of select="$entry_id"/> and <xsl:value-of select="$pdb_id"/>).
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <VRPTx:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd pdbx-validation-v4.xsd">
      <xsl:apply-templates select="PDBx:datablock/*"/>
    </VRPTx:datablock>
  </xsl:template>

  <xsl:template match="PDBx:diffrnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_attenuatorCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_detectorCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_measurementCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_orient_matrixCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_orient_reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_radiationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_radiation_wavelengthCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflnsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_reflns_classCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_scale_groupCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_sourceCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_standard_reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:diffrn_standardsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_2d_crystal_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_crystal_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_fittingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_fitting_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_3d_reconstructionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_adminCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_bufferCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_buffer_componentCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_crystal_formationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_ctf_correctionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffractionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffraction_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_diffraction_statsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_embeddingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assemblyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_molwtCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_naturalsourceCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_recombinantCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_entity_assembly_syntheticCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_experimentCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_helical_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_processingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_recordingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_image_scansCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_imagingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_imaging_opticsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_particle_selectionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_single_particle_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_softwareCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_specimenCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_stainingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_natural_hostCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_virus_syntheticCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_vitrificationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:em_volume_selectionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_name_comCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_name_sysCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_polyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entity_poly_seqCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:entry_linkCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:exptlCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_conf_naCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_na_base_pairCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:ndb_struct_na_base_pair_stepCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_authorCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_categoryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_detailsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_groupCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_historyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_itemCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_bond_distance_limitsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_branch_schemeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_coordinate_modelCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_relatedCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_statusCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_densityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_density_corrCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_entity_geometryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_geometryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_mapCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_map_overallCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_mapmanCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_mon_geometryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_rscc_mapmanCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_dcc_rscc_mapman_overallCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_diffrn_reflns_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_distant_solvent_atomsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_domainCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_domain_rangeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_atom_inclusionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_atom_inclusion_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_density_distributionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_density_distribution_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_fsc_curveCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_fsc_curve_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_fsc_cutoff_curveCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_fsc_cutoff_curve_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_fsc_resolutionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_rapsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_raps_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_raw_rapsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_raw_raps_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_validate_map_modelCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_validate_map_model_entityCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_validate_map_model_overallCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_volume_estimateCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_em_volume_estimate_markerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_assemblyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branchCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_descriptorCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_linkCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_branch_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_descriptorCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_nonpolyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entity_poly_comp_link_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_entry_detailsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_helical_symmetryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_missing_nmr_star_itemCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_assigned_chem_shift_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_annotationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_completenessCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_chem_shift_re_offsetCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_constraintsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_detailsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_dihedral_angle_violationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_dihedral_angle_violation_ensembleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_dihedral_angle_violation_modelCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_dihedral_angle_violation_pluralCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_dihedral_angle_violation_summaryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_distance_violationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_distance_violation_ensembleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_distance_violation_modelCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_distance_violation_pluralCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_distance_violation_summaryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_ensembleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_ensemble_rmsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptlCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptl_sampleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_exptl_sample_conditionsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_force_constantsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_refineCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_representativeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_restraint_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_restraint_summaryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_restraint_violationCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_softwareCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_spectrometerCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_unmapped_chem_shiftCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nmr_unparsed_chem_shiftCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_nonpoly_schemeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_percentile_conditionsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_percentile_entity_viewCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_percentile_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_percentile_viewCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_setCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_set_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_set_siteCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MAD_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_MRCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_dmCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_phasing_dm_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_point_symmetryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_poly_seq_schemeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_re_refinementCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refineCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_componentCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_tlsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refine_tls_groupCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_refln_signal_binningCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_reflns_twinCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sequence_rangeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_unp_segmentsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_xref_dbCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_sifts_xref_db_segmentsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_soln_scatterCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_soln_scatter_modelCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assemblyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_assembly_propCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_asym_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_chem_comp_diagnosticsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_conn_angleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_entity_instCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_component_rangeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_componentsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_group_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_infoCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_legacy_oper_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_mod_residueCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_msym_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_nmr_ens_clustCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_nmr_ens_clust_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_nmr_ens_domCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_nmr_ens_dom_limCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_oper_listCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_deletionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_ref_seq_insertionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_sheet_hbondCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_struct_special_symmetryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_unobs_or_zero_occ_atomsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_unobs_or_zero_occ_residuesCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_chiralCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_close_contactCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_main_chain_planeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_nmr_chem_shiftCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_peptide_omegaCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_planesCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_planes_atomCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_polymer_linkageCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_angleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_bondCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_ringCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_rings_atomCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_torsionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_rmsd_torsions_atomCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_symm_contactCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validate_torsionCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_validation_softwareCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MADCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_clustCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_exptCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_ratioCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MAD_setCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIRCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_derCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_der_siteCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_MIR_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_averagingCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_isomorphousCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_setCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:phasing_set_reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refineCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_B_isoCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_analyzeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_funct_minimizedCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_histCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_classCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restrCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restr_ncsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_restr_typeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_ls_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refine_occupancyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflnCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:refln_sys_absCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflnsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_classCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_scaleCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:reflns_shellCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:space_groupCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:space_group_symopCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:structCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_asymCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biolCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_biol_viewCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_confCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_conf_typeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_connCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_conn_typeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_detailsCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_nuclCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_protCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_mon_prot_cisCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_domCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_dom_limCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_ensCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_ens_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ncs_operCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_refCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ref_seqCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_ref_seq_difCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheetCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_hbondCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_orderCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_rangeCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_sheet_topologyCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_siteCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_site_genCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:struct_site_viewCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:symmetryCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:symmetry_equivCategory">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates mode="category-element"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="PDBx:*" mode="category-element">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates select="@*|node()" mode="data-item"/>
      <xsl:choose>
        <xsl:when test="local-name()='pdbx_database_status'">
          <xsl:element name="VRPTx:validation_created_date"><xsl:value-of select="$validation_created_date"/></xsl:element>
        </xsl:when>
        <xsl:when test="local-name()='pdbx_nmr_ensemble'">
          <xsl:element name="VRPTx:atom_consistency_flag">
            <xsl:choose>
              <xsl:when test="$nmr_models_consistency_flag='True'">Y</xsl:when>
              <xsl:otherwise>N</xsl:otherwise>
            </xsl:choose>
          </xsl:element>
        </xsl:when>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*" mode="category-element">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="PDBx:*" mode="data-item">
    <xsl:element name="VRPTx:{local-name()}">
      <xsl:apply-templates select="@*|node()" mode="data-item"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="node()" mode="data-item">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="@*" mode="data-item">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
        <xsl:message terminate="yes">
          <xsl:text>ERROR in extract_pdbml.xsl: </xsl:text>
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

</xsl:stylesheet>