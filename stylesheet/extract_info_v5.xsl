<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd">

  <xsl:param name="pdbml_ext_file" required="yes"/>
  <xsl:variable name="ext_datablock" select="document($pdbml_ext_file)/VRPTx:datablock"/>

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="pdb_id"><xsl:value-of select="/wwPDB-validation-information/Entry/@pdbid"/></xsl:variable>

  <xsl:variable name="entry_id"><xsl:value-of select="$ext_datablock/VRPTx:entryCategory/VRPTx:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat($entry_id,'-validation-alt')"/></xsl:variable>

  <!-- experimental method -->

  <xsl:variable name="exptl_method"><xsl:value-of select="$ext_datablock/VRPTx:exptlCategory/VRPTx:exptl/@method"/></xsl:variable>

  <xsl:variable name="x-ray"><xsl:value-of select="contains($exptl_method,'DIFFRACTION') and not(contains($exptl_method,'NEUTRON'))"/></xsl:variable>
  <xsl:variable name="nmr"><xsl:value-of select="contains($exptl_method,'NMR')"/></xsl:variable>
  <xsl:variable name="em"><xsl:value-of select="$exptl_method='ELECTRON MICROSCOPY'"/></xsl:variable>
  <xsl:variable name="other"><xsl:value-of select="$x-ray=false() and $nmr=false() and $em=false()"/></xsl:variable>

  <!-- percentile conditions id -->

  <xsl:variable name="last_cond_abs_rna">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-RNAsuiteness">1</xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rna">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-RNAsuiteness"><xsl:value-of select="$last_cond_abs_rna+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rna"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_clash">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-clashscore"><xsl:value-of select="$last_cond_rel_rna+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rna"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_clash">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-clashscore"><xsl:value-of select="$last_cond_abs_clash+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_clash"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_rama">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-percent-rama-outliers"><xsl:value-of select="$last_cond_rel_clash+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_rama_percentile and @absolute_rama_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_rel_clash+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_clash"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rama">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-rama-outliers"><xsl:value-of select="$last_cond_abs_rama+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_rama_percentile and @relative_rama_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_abs_rama+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rama"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_rota">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-percent-rota-outliers"><xsl:value-of select="$last_cond_rel_rama+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_sidechain_percentile and @absolute_sidechain_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_rel_rama+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rama"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rota">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-rota-outliers"><xsl:value-of select="$last_cond_abs_rota+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_sidechain_percentile and @relative_sidechain_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_abs_rota+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rota"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_rfree">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-DCC_Rfree"><xsl:value-of select="$last_cond_rel_rota+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rota"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rfree">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-DCC_Rfree"><xsl:value-of select="$last_cond_abs_rfree+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rfree"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_rsrz">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-percent-RSRZ-outliers"><xsl:value-of select="$last_cond_rel_rfree+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_rel_rfree+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rfree"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rsrz">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$last_cond_abs_rsrz+1"/></xsl:when>
      <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_RSRZ_percentile and @relative_RSRZ_percentile!='NotAvailable']"><xsl:value-of select="$last_cond_abs_rsrz+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rsrz"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="nmr_models">
    <xsl:value-of select="/wwPDB-validation-information/Entry/@nmrclust_number_of_models"/>
  </xsl:variable>

  <xsl:variable name="count_programs">
    <xsl:value-of select="count(/wwPDB-validation-information/programs/program)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_angle">
    <xsl:value-of select="count($ext_datablock/VRPTx:pdbx_validate_rmsd_angleCategory/VRPTx:pdbx_validate_rmsd_angle)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_bond">
    <xsl:value-of select="count($ext_datablock/VRPTx:pdbx_validate_rmsd_bondCategory/VRPTx:pdbx_validate_rmsd_bond)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_close_contact">
    <xsl:value-of select="count($ext_datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_symm_contact">
    <xsl:value-of select="count($ext_datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact)"/>
  </xsl:variable>

  <xsl:variable name="count_angle_outlier">
    <xsl:value-of select="count(/wwPDB-validation-information/ModelledSubgroup/angle-outlier)"/>
  </xsl:variable>

  <xsl:variable name="count_bond_outlier">
    <xsl:value-of select="count(/wwPDB-validation-information/ModelledSubgroup/bond-outlier)"/>
  </xsl:variable>

  <!-- DCC version -->

  <xsl:variable name="dcc_version">
    <xsl:value-of select="/wwPDB-validation-information/programs/program[@name='dcc']/@version"/>
  </xsl:variable>

  <!-- Level 1 -->

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
      <VRPTx:entryCategory>
	<VRPTx:entry id="{$entry_id}"/>
      </VRPTx:entryCategory>
      <xsl:apply-templates select="wwPDB-validation-information/*"/>
    </VRPTx:datablock>

  </xsl:template>

  <!-- Level 2 -->

  <xsl:template match="Entry">

    <xsl:if test="chemical_shift_list">
      <xsl:if test="chemical_shift_list/missing_nmrstar_tag">
	<VRPTx:pdbx_missing_nmr_star_itemCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_missing_nmr_star_item">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_missing_nmr_star_itemCategory>
      </xsl:if>

      <VRPTx:pdbx_nmr_assigned_chem_shift_listCategory>
	<xsl:for-each select="chemical_shift_list">
	  <xsl:call-template name="pdbx_nmr_assigned_chem_shift_list">
	     <xsl:with-param name="id"><xsl:value-of select="position()"/></xsl:with-param>
	  </xsl:call-template>
	</xsl:for-each>
      </VRPTx:pdbx_nmr_assigned_chem_shift_listCategory>

      <xsl:if test="chemical_shift_list/random_coil_index">
	<VRPTx:pdbx_nmr_chem_shift_annotationCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_nmr_chem_shift_annotation">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_chem_shift_annotationCategory>
      </xsl:if>

      <xsl:choose>
	<xsl:when test="chemical_shift_list/assignment_completeness_well_defined">
	  <VRPTx:pdbx_nmr_chem_shift_completenessCategory>
	    <xsl:for-each select="chemical_shift_list">
	      <xsl:call-template name="pdbx_nmr_chem_shift_completeness_well_defined">
		<xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	      </xsl:call-template>
	    </xsl:for-each>
	  </VRPTx:pdbx_nmr_chem_shift_completenessCategory>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:if test="chemical_shift_list/assignment_completeness_full_length">
	    <VRPTx:pdbx_nmr_chem_shift_completenessCategory>
	      <xsl:for-each select="chemical_shift_list">
		<xsl:call-template name="pdbx_nmr_chem_shift_completeness_full_length">
		  <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
		</xsl:call-template>
	      </xsl:for-each>
	    </VRPTx:pdbx_nmr_chem_shift_completenessCategory>
	  </xsl:if>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:if test="chemical_shift_list/referencing_offset">
	<VRPTx:pdbx_nmr_chem_shift_re_offsetCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_nmr_chem_shift_re_offset">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_chem_shift_re_offsetCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unmapped_chemical_shift">
	<VRPTx:pdbx_nmr_unmapped_chem_shiftCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_nmr_unmapped_chem_shift">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_unmapped_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unparsed_chemical_shift">
	<VRPTx:pdbx_nmr_unparsed_chem_shiftCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_nmr_unparsed_chem_shift">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_unparsed_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/chemical_shift_outlier">
	<VRPTx:pdbx_validate_nmr_chem_shiftCategory>
	  <xsl:for-each select="chemical_shift_list">
	    <xsl:call-template name="pdbx_validate_nmr_chem_shift">
	      <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:for-each>
	</VRPTx:pdbx_validate_nmr_chem_shiftCategory>
      </xsl:if>
    </xsl:if>

    <xsl:call-template name="pdbx_percentile_list"/>

    <xsl:if test="@absolute-percentile-RNAsuiteness or @relative-percentile-RNAsuiteness or @absolute-percentile-clashscore or @relative-percentile-clashscore or @absolute-percentile-percent-rama-outliers or @relative-percentile-percent-rama-outliers or @absolute-percentile-percent-rota-outliers or @relative-percentile-percent-rota-outliers or @absolute-percentile-DCC_Rfree or @relative-percentile-DCC_Rfree or @absolute-percentile-percent-RSRZ-outliers or @relative-percentile-percent-RSRZ-outliers">
      <xsl:call-template name="pdbx_percentile_view"/>
    </xsl:if>

    <xsl:if test="@absolute-percentile-RNAsuiteness or @relative-percentile-RNAsuiteness or @absolute-percentile-clashscore or @relative-percentile-clashscore or @absolute-percentile-percent-rama-outliers or /wwPDB-validation-information/ModelledEntityInstance/@absolute_rama_percentile or @relative-percentile-percent-rama-outliers or /wwPDB-validation-information/ModelledEntityInstance/@relative_rama_percentile or @absolute-percentile-percent-rota-outliers or /wwPDB-validation-information/ModelledEntityInstance/@absolute_sidechain_percentile or @relative-percentile-percent-rota-outliers or /wwPDB-validation-information/ModelledEntityInstance/@relative_sidechain_percentile or @absolute-percentile-DCC_Rfree or @relative-percentile-DCC_Rfree or @absolute-percentile-percent-RSRZ-outliers or /wwPDB-validation-information/ModelledEntityInstance/@absolute_RSRZ_percentile or @relative-percentile-percent-RSRZ-outliers or /wwPDB-validation-information/ModelledEntityInstance/@absolute_RSRZ_percentile">
      <xsl:call-template name="pdbx_percentile_conditions"/>
    </xsl:if>

    <xsl:if test="(../ModelledEntityInstance/@absolute_RSRZ_percentile and ../ModelledEntityInstance/@absolute_RSRZ_percentile!='NotAvailable') or (../ModelledEntityInstance/@relative_RSRZ_percentile and ../ModelledEntityInstance/@relative_RSRZ_percentile!='NotAvailable') or (../ModelledEntityInstance/@absolute_rama_percentile and ../ModelledEntityInstance/@absolute_rama_percentile!='NotAvailable') or (../ModelledEntityInstance/@relative_rama_percentile and ../ModelledEntityInstance/@relative_rama_percentile!='NotAvailable') or (../ModelledEntityInstance/@absolute_sidechain_percentile and ../ModelledEntityInstance/@absolute_sidechain_percentile!='NotAvailable') or (../ModelledEntityInstance/@relative_sidechain_percentile and ../ModelledEntityInstance/@relative_sidechain_percentile!='NotAvailable')">
      <VRPTx:pdbx_percentile_entity_viewCategory>
	<xsl:for-each select="../ModelledEntityInstance">
	  <xsl:call-template name="pdbx_percentile_entity_view"/>
	</xsl:for-each>
      </VRPTx:pdbx_percentile_entity_viewCategory>
    </xsl:if>

    <xsl:call-template name="pdbx_dcc_density"/>
    <xsl:call-template name="pdbx_dcc_density_corr"/>
    <xsl:call-template name="pdbx_dcc_geometry"/>

    <xsl:if test="../ModelledEntityInstance/@angles_rmsz or ../ModelledEntityInstance/@bonds_rmsz">
      <VRPTx:pdbx_dcc_entity_geometryCategory>
	<xsl:for-each select="../ModelledEntityInstance">
	  <xsl:call-template name="pdbx_dcc_entity_geometry"/>
	</xsl:for-each>
      </VRPTx:pdbx_dcc_entity_geometryCategory>
    </xsl:if>

    <xsl:call-template name="pdbx_dcc_map_overall"/>

    <!-- EM validation: Entry, ModelledEntityInstance -->

    <xsl:if test="$em=true()">

      <xsl:if test="@emdb_id">
	<VRPTx:em_adminCategory>
	  <VRPTx:em_admin>
	    <xsl:attribute name="entry_id"><xsl:value-of select="@emdb_id"/></xsl:attribute>
	    <xsl:if test="@EMDB-deposition-date and @EMDB-deposition-date!='unknown'">
	      <xsl:element name="VRPTx:deposition_date"><xsl:value-of select="@EMDB-deposition-date"/></xsl:element>
	    </xsl:if>
	  </VRPTx:em_admin>
	</VRPTx:em_adminCategory>
      </xsl:if>

      <xsl:if test="../ModelledEntityInstance/@average_residue_inclusion">
	<VRPTx:pdbx_em_validate_map_model_entityCategory>
	  <xsl:for-each select="../ModelledEntityInstance">
	    <xsl:call-template name="pdbx_em_validate_map_model_entity"/>
	  </xsl:for-each>
	</VRPTx:pdbx_em_validate_map_model_entityCategory>
      </xsl:if>

      <xsl:call-template name="pdbx_em_validate_map_model_overall"/>

    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@rsr or ../ModelledSubgroup/@rsrz or ../ModelledSubgroup/@rscc">
      <VRPTx:pdbx_dcc_mapCategory>
	<xsl:for-each select="../ModelledSubgroup">
	  <xsl:call-template name="pdbx_dcc_map"/>
	</xsl:for-each>
      </VRPTx:pdbx_dcc_mapCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@mogul_angles_rmsz or ../ModelledSubgroup/@mogul_bonds_rmsz">
      <VRPTx:pdbx_dcc_mon_geometryCategory>
	<xsl:for-each select="../ModelledSubgroup">
	  <xsl:call-template name="pdbx_dcc_mon_geometry"/>
	</xsl:for-each>
      </VRPTx:pdbx_dcc_mon_geometryCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@phi or ../ModelledSubgroup/@psi or ../ModelledSubgroup/@rama or ../ModelledSubgroup/@rota">
      <VRPTx:struct_mon_protCategory>
	<xsl:for-each select="../ModelledSubgroup">
	  <xsl:call-template name="struct_mon_prot"/>
	</xsl:for-each>
      </VRPTx:struct_mon_protCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@RNApucker or ../ModelledSubgroup/@RNAsuite or ../ModelledSubgroup/@RNAscore">
      <VRPTx:struct_mon_nuclCategory>
	<xsl:for-each select="../ModelledSubgroup">
	  <xsl:call-template name="struct_mon_nucl"/>
	</xsl:for-each>
      </VRPTx:struct_mon_nuclCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/angle-outlier or ../ModelledSubgroup/mog-angle-outlier">
      <VRPTx:pdbx_validate_rmsd_angleCategory>
	<xsl:for-each select="../ModelledSubgroup/angle-outlier">
	  <xsl:call-template name="append_angle_outlier_to_pdbx_validate_rmsd_angle"/>
	</xsl:for-each>
	<xsl:for-each select="../ModelledSubgroup/mog-angle-outlier">
	  <xsl:call-template name="append_mog_angle_outlier_to_pdbx_validate_rmsd_angle"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_angleCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/bond-outlier or ../ModelledSubgroup/mog-bond-outlier">
      <VRPTx:pdbx_validate_rmsd_bondCategory>
	<xsl:for-each select="../ModelledSubgroup/bond-outlier">
	  <xsl:call-template name="append_bond_outlier_to_pdbx_validate_rmsd_bond"/>
	</xsl:for-each>
	<xsl:for-each select="../ModelledSubgroup/mog-bond-outlier">
	  <xsl:call-template name="append_mog_bond_outlier_to_pdbx_validate_rmsd_bond"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_bondCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/clash[not(@cid=../preceding::ModelledSubgroup/clash/@cid) and not(@cid=preceding::clash/@cid)]">
      <VRPTx:pdbx_validate_close_contactCategory>
	<xsl:for-each select="../ModelledSubgroup/clash[not(@cid=../preceding::ModelledSubgroup/clash/@cid) and not(@cid=preceding::clash/@cid)]">
	  <xsl:call-template name="append_clash_to_pdbx_validate_close_contact"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_close_contactCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/symm-clash">
      <VRPTx:pdbx_validate_symm_contactCategory>
	<xsl:for-each select="../ModelledSubgroup/symm-clash[not(@scid=../preceding::ModelledSubgroup/symm-clash/@scid) and not(@scid=preceding::symm-clash/@scid)]">
	  <xsl:call-template name="append_symm_clash_to_pdbx_validate_symm_contact"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_symm_contactCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/mog-ring-outlier">
      <VRPTx:pdbx_validate_rmsd_ringCategory>
	<xsl:for-each select="../ModelledSubgroup/mog-ring-outlier">
	  <xsl:call-template name="pdbx_validate_rmsd_ring"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_ringCategory>

      <VRPTx:pdbx_validate_rmsd_rings_atomCategory>
	<xsl:for-each select="../ModelledSubgroup/mog-ring-outlier">
	  <xsl:call-template name="pdbx_validate_rmsd_rings_atom"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_rings_atomCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/mog-torsion-outlier">
      <VRPTx:pdbx_validate_rmsd_torsionCategory>
	<xsl:for-each select="../ModelledSubgroup/mog-torsion-outlier">
	  <xsl:call-template name="pdbx_validate_rmsd_torsion"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_torsionCategory>

      <VRPTx:pdbx_validate_rmsd_torsions_atomCategory>
	<xsl:for-each select="../ModelledSubgroup/mog-torsion-outlier">
	  <xsl:call-template name="pdbx_validate_rmsd_torsions_atom"/>
	</xsl:for-each>
      </VRPTx:pdbx_validate_rmsd_torsions_atomCategory>
    </xsl:if>

    <xsl:if test="$nmr=true()">

      <xsl:if test="@nmrclust_version">

	<VRPTx:pdbx_struct_nmr_ens_clustCategory>
	  <VRPTx:pdbx_struct_nmr_ens_clust entry_id="{$entry_id}">
	    <xsl:if test="@nmrclust_number_of_clusters">
	      <xsl:element name="VRPTx:clusters_total_number"><xsl:value-of select="@nmrclust_number_of_clusters"/></xsl:element>
	    </xsl:if>
	    <xsl:choose>
	      <xsl:when test="@nmrclust_number_of_models">
		<xsl:element name="VRPTx:conformers_total_number"><xsl:value-of select="@nmrclust_number_of_models"/></xsl:element>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:element name="VRPTx:conformers_total_number"><xsl:value-of select="$ext_datablock/VRPTx:pdbx_nmr_ensembleCategory/VRPTx:pdbx_nmr_ensemble/VRPTx:conformers_submitted_total_number"/></xsl:element>
	      </xsl:otherwise>
	    </xsl:choose>
	    <xsl:if test="@nmrclust_number_of_outliers">
	      <xsl:element name="VRPTx:outliers_total_number"><xsl:value-of select="@nmrclust_number_of_outliers"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="@nmrclust_error and @nmrclust_error!='success'">
	      <xsl:element name="VRPTx:error"><xsl:value-of select="@nmrclust_error"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_struct_nmr_ens_clust>
	</VRPTx:pdbx_struct_nmr_ens_clustCategory>

	<xsl:if test="../Model">
	  <VRPTx:pdbx_struct_nmr_ens_clust_genCategory>
	    <xsl:for-each select="../Model">
	      <xsl:call-template name="pdbx_struct_nmr_ens_clust_gen"/>
	    </xsl:for-each>
	  </VRPTx:pdbx_struct_nmr_ens_clust_genCategory>
	</xsl:if>

      </xsl:if>

      <xsl:if test="@cyrange_version">

	<xsl:if test="../cyrange_domain">
	  <VRPTx:pdbx_struct_nmr_ens_domCategory>
	    <xsl:for-each select="../cyrange_domain">
	      <xsl:call-template name="pdbx_struct_nmr_ens_dom"/>
	    </xsl:for-each>
	  </VRPTx:pdbx_struct_nmr_ens_domCategory>

	  <VRPTx:pdbx_struct_nmr_ens_dom_limCategory>
	    <xsl:for-each select="../cyrange_domain">
	      <xsl:call-template name="pdbx_struct_nmr_ens_dom_lim"/>
	    </xsl:for-each>
	  </VRPTx:pdbx_struct_nmr_ens_dom_limCategory>
	</xsl:if>

      </xsl:if>

    </xsl:if>

    <!-- EM validation: ModelledSubgroup -->

    <xsl:if test="$em=true()">

      <xsl:if test="../ModelledSubgroup/@residue_inclusion">
	<VRPTx:pdbx_em_validate_map_modelCategory>
	  <xsl:for-each select="../ModelledSubgroup">
	    <xsl:call-template name="pdbx_em_validate_map_model"/>
	  </xsl:for-each>
	</VRPTx:pdbx_em_validate_map_modelCategory>
      </xsl:if>

    </xsl:if>

  </xsl:template>
<!--
  <xsl:template match="Model">
  </xsl:template>

  <xsl:template match="cyrange_domain">
  </xsl:template>

  <xsl:template match="ModelledSubgroup">
  </xsl:template>
-->
  <!-- EM validation: EM_validation -->

  <xsl:template match="EM_validation">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="map_value_distribution">
    <VRPTx:pdbx_em_density_distributionCategory>
      <VRPTx:pdbx_em_density_distribution id="1">
	<VRPTx:map_value_title><xsl:value-of select="@xTitle"/></VRPTx:map_value_title>
	<VRPTx:voxel_count_title><xsl:value-of select="@yTitle"/></VRPTx:voxel_count_title>
	<xsl:if test="@yScale">
	  <VRPTx:voxel_count_scale><xsl:value-of select="@yScale"/></VRPTx:voxel_count_scale>
	</xsl:if>
      </VRPTx:pdbx_em_density_distribution>
    </VRPTx:pdbx_em_density_distributionCategory>
    <VRPTx:pdbx_em_density_distribution_markerCategory>
      <xsl:for-each select="coordinate">
	<xsl:sort select="number(@x)" data-type="number"/>
	<VRPTx:pdbx_em_density_distribution_marker plot_id="1" ordinal="{position()}">
	  <VRPTx:map_value><xsl:value-of select="number(@x)"/></VRPTx:map_value>
	  <VRPTx:voxel_count><xsl:value-of select="number(@y)"/></VRPTx:voxel_count>
	</VRPTx:pdbx_em_density_distribution_marker>
      </xsl:for-each>
    </VRPTx:pdbx_em_density_distribution_markerCategory>
  </xsl:template>

  <xsl:template match="volume_estimate">
    <VRPTx:pdbx_em_volume_estimateCategory>
      <VRPTx:pdbx_em_volume_estimate id="1">
	<VRPTx:contour_level_title><xsl:value-of select="@xTitle"/></VRPTx:contour_level_title>
	<VRPTx:enclosed_volume_title><xsl:value-of select="@yTitle"/></VRPTx:enclosed_volume_title>
	<xsl:if test="@yUnit">
	  <VRPTx:enclosed_volume_unit><xsl:value-of select="@yUnit"/></VRPTx:enclosed_volume_unit>
	</xsl:if>
      </VRPTx:pdbx_em_volume_estimate>
    </VRPTx:pdbx_em_volume_estimateCategory>
    <VRPTx:pdbx_em_volume_estimate_markerCategory>
      <xsl:for-each select="coordinate">
	<xsl:sort select="number(@x)" data-type="number"/>
	<VRPTx:pdbx_em_volume_estimate_marker plot_id="1" ordinal="{position()}">
	  <VRPTx:contour_level><xsl:value-of select="number(@x)"/></VRPTx:contour_level>
	  <VRPTx:enclosed_volume><xsl:value-of select="number(@y)"/></VRPTx:enclosed_volume>
	</VRPTx:pdbx_em_volume_estimate_marker>
      </xsl:for-each>
    </VRPTx:pdbx_em_volume_estimate_markerCategory>
  </xsl:template>

  <xsl:template match="rotationally_averaged_power_spectrum">
    <VRPTx:pdbx_em_rapsCategory>
      <VRPTx:pdbx_em_raps id="1">
	<VRPTx:spatial_frequency_title><xsl:value-of select="@xTitle"/></VRPTx:spatial_frequency_title>
	<VRPTx:power_title><xsl:value-of select="@yTitle"/></VRPTx:power_title>
	<xsl:if test="@xUnit">
	  <VRPTx:spatial_frequency_unit><xsl:value-of select="@xUnit"/></VRPTx:spatial_frequency_unit>
	</xsl:if>
	<xsl:if test="@yScale">
	  <VRPTx:power_scale><xsl:value-of select="@yScale"/></VRPTx:power_scale>
	</xsl:if>
      </VRPTx:pdbx_em_raps>
    </VRPTx:pdbx_em_rapsCategory>
    <VRPTx:pdbx_em_raps_markerCategory>
      <xsl:for-each select="coordinate">
	<xsl:sort select="number(@x)" data-type="number"/>
	<VRPTx:pdbx_em_raps_marker plot_id="1" ordinal="{position()}">
	  <VRPTx:spatial_frequency><xsl:value-of select="number(@x)"/></VRPTx:spatial_frequency>
	  <VRPTx:power><xsl:value-of select="number(@y)"/></VRPTx:power>
	</VRPTx:pdbx_em_raps_marker>
      </xsl:for-each>
    </VRPTx:pdbx_em_raps_markerCategory>
  </xsl:template>

  <xsl:template match="raw_map_rotationally_averaged_power_spectrum">
    <VRPTx:pdbx_em_raw_rapsCategory>
      <VRPTx:pdbx_em_raw_raps id="1">
	<VRPTx:spatial_frequency_title><xsl:value-of select="@xTitle"/></VRPTx:spatial_frequency_title>
	<VRPTx:power_title><xsl:value-of select="@yTitle"/></VRPTx:power_title>
	<xsl:if test="@xUnit">
	  <VRPTx:spatial_frequency_unit><xsl:value-of select="@xUnit"/></VRPTx:spatial_frequency_unit>
	</xsl:if>
	<xsl:if test="@yScale">
	  <VRPTx:power_scale><xsl:value-of select="@yScale"/></VRPTx:power_scale>
	</xsl:if>
      </VRPTx:pdbx_em_raw_raps>
    </VRPTx:pdbx_em_raw_rapsCategory>
    <VRPTx:pdbx_em_raw_raps_markerCategory>
      <xsl:for-each select="coordinate">
	<xsl:sort select="number(@x)" data-type="number"/>
	<VRPTx:pdbx_em_raw_raps_marker plot_id="1" ordinal="{position()}">
	  <VRPTx:spatial_frequency><xsl:value-of select="number(@x)"/></VRPTx:spatial_frequency>
	  <VRPTx:power><xsl:value-of select="number(@y)"/></VRPTx:power>
	</VRPTx:pdbx_em_raw_raps_marker>
      </xsl:for-each>
    </VRPTx:pdbx_em_raw_raps_markerCategory>
  </xsl:template>

  <xsl:template match="fsc">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="resolution_intersections">
    <xsl:variable name="spatial_frequency_unit"><xsl:value-of select="@spatial_frequency_unit"/></xsl:variable>
    <xsl:variable name="resolution_unit"><xsl:value-of select="@resolution_unit"/></xsl:variable>
    <VRPTx:pdbx_em_fsc_resolutionCategory>
      <xsl:for-each select="intersection">
	<VRPTx:pdbx_em_fsc_resolution>
	  <xsl:variable name="fsc_curve"><xsl:value-of select="@curve"/></xsl:variable>
	  <xsl:variable name="fsc_cutoff_curve">
	    <xsl:choose>
	      <xsl:when test="@type='threesig'"><xsl:value-of select="concat(@curve,'_threesigma')"/></xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="concat(@curve,'_',@type)"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	  <xsl:attribute name="source"><xsl:value-of select="$fsc_curve"/></xsl:attribute>
	  <xsl:choose>
	    <xsl:when test="@type='0.143' or @type='0.333' or @type='0.5'"><xsl:attribute name="criterion"><xsl:value-of select="@type"/></xsl:attribute></xsl:when>
	    <xsl:when test="@type='halfbit'"><xsl:attribute name="criterion">half-bit</xsl:attribute></xsl:when>
	    <xsl:when test="@type='onebit'"><xsl:attribute name="criterion">one-bit</xsl:attribute></xsl:when>
	    <xsl:when test="starts-with(@type,'threesig')"><xsl:attribute name="criterion">3sigma</xsl:attribute></xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Criteria for FSC resolution estimation, <xsl:value-of select="@type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:correlation_coef><xsl:value-of select="@correlation"/></VRPTx:correlation_coef>
	  <VRPTx:spatial_frequency><xsl:value-of select="@spatial_frequency"/></VRPTx:spatial_frequency>
	  <VRPTx:resolution><xsl:value-of select="@resolution"/></VRPTx:resolution>
	  <VRPTx:spatial_frequency_unit><xsl:value-of select="$spatial_frequency_unit"/></VRPTx:spatial_frequency_unit>
	  <VRPTx:resolution_unit><xsl:value-of select="$resolution_unit"/></VRPTx:resolution_unit>
	  <VRPTx:fsc_curve_id>
	    <xsl:for-each select="../../fsc_curves/fsc_curve">
	      <xsl:if test="@Title=$fsc_curve or @curve_name=$fsc_curve">
		<xsl:value-of select="position()"/>
	      </xsl:if>
	    </xsl:for-each>
	  </VRPTx:fsc_curve_id>
	  <VRPTx:fsc_cutoff_curve_id>
	    <xsl:for-each select="../../fsc_indicator_curves/fsc_indicator_curve">
	      <xsl:if test="@Title=$fsc_cutoff_curve or @curve_name=$fsc_cutoff_curve">
		<xsl:value-of select="position()"/>
	      </xsl:if>
	    </xsl:for-each>
	  </VRPTx:fsc_cutoff_curve_id>
	</VRPTx:pdbx_em_fsc_resolution>
      </xsl:for-each>
    </VRPTx:pdbx_em_fsc_resolutionCategory>
  </xsl:template>

  <xsl:template match="fsc_curves">
    <VRPTx:pdbx_em_fsc_curveCategory>
      <xsl:for-each select="fsc_curve">
	<VRPTx:pdbx_em_fsc_curve>
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <VRPTx:title><xsl:value-of select="@Title"/></VRPTx:title>
	  <xsl:if test="@curve_name">
	    <VRPTx:name><xsl:value-of select="@curve_name"/></VRPTx:name>
	  </xsl:if>
	  <xsl:if test="@type">
	    <VRPTx:type><xsl:value-of select="@type"/></VRPTx:type>
	  </xsl:if>
	  <VRPTx:spatial_frequency_title><xsl:value-of select="@xTitle"/></VRPTx:spatial_frequency_title>
	  <VRPTx:correlation_coef_title><xsl:value-of select="@yTitle"/></VRPTx:correlation_coef_title>
	  <VRPTx:spatial_frequency_unit><xsl:value-of select="@xUnit"/></VRPTx:spatial_frequency_unit>
	</VRPTx:pdbx_em_fsc_curve>
      </xsl:for-each>
    </VRPTx:pdbx_em_fsc_curveCategory>
    <VRPTx:pdbx_em_fsc_curve_markerCategory>
      <xsl:for-each select="fsc_curve">
	<xsl:variable name="plot_id"><xsl:value-of select="position()"/></xsl:variable>
	<xsl:for-each select="coordinate">
	  <xsl:sort select="number(@x)" data-type="number"/>
	  <VRPTx:pdbx_em_fsc_curve_marker plot_id="{$plot_id}" ordinal="{position()}">
	    <VRPTx:spatial_frequency><xsl:value-of select="number(@x)"/></VRPTx:spatial_frequency>
	    <VRPTx:correlation_coef><xsl:value-of select="number(@y)"/></VRPTx:correlation_coef>
	  </VRPTx:pdbx_em_fsc_curve_marker>
	</xsl:for-each>
      </xsl:for-each>
    </VRPTx:pdbx_em_fsc_curve_markerCategory>
  </xsl:template>

  <xsl:template match="fsc_indicator_curves">
    <VRPTx:pdbx_em_fsc_cutoff_curveCategory>
      <xsl:for-each select="fsc_indicator_curve">
	<VRPTx:pdbx_em_fsc_cutoff_curve>
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:variable name="source">
	    <xsl:choose>
	      <xsl:when test="starts-with(@Title,'calculated_fsc') or @data_curve='calculated_fsc'">calculated_fsc</xsl:when>
	      <xsl:when test="starts-with(@Title,'author_provided_fsc') or @data_curve='author_provided_fsc'">author_provided_fsc</xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Source for FSC curve, <xsl:value-of select="@Title"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	  <xsl:variable name="criterion">
	    <xsl:choose>
	      <xsl:when test="ends-with(@Title,'0.143') or @type='0.143'">0.143</xsl:when>
	      <xsl:when test="ends-with(@Title,'0.333') or @type='0.333'">0.333</xsl:when>
	      <xsl:when test="ends-with(@Title,'0.5') or @type='0.5'">0.5</xsl:when>
	      <xsl:when test="ends-with(@Title,'halfbit') or @type='halfbit'">half-bit</xsl:when>
	      <xsl:when test="ends-with(@Title,'onebit') or @type='onebit'">one-bit</xsl:when>
	      <xsl:when test="ends-with(@Title,'threesigma') or @type='threesigma'">3sigma</xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Criteria for FSC curve, <xsl:value-of select="@Title"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	  <xsl:choose>
	    <xsl:when test="@data_curve">
	      <VRPTx:title><xsl:value-of select="@Title"/></VRPTx:title>
	      <VRPTx:name><xsl:value-of select="@curve_name"/></VRPTx:name>
	      <VRPTx:type><xsl:value-of select="@type"/></VRPTx:type>
	      <VRPTx:target_name><xsl:value-of select="@data_curve"/></VRPTx:target_name>
	    </xsl:when>
	    <xsl:otherwise>
	      <VRPTx:title><xsl:value-of select="concat($source,'_',$criterion)"/></VRPTx:title>
	    </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:spatial_frequency_title><xsl:value-of select="@xTitle"/></VRPTx:spatial_frequency_title>
	  <VRPTx:correlation_coef_title><xsl:value-of select="@yTitle"/></VRPTx:correlation_coef_title>
	  <VRPTx:spatial_frequency_unit><xsl:value-of select="@xUnit"/></VRPTx:spatial_frequency_unit>
	</VRPTx:pdbx_em_fsc_cutoff_curve>
      </xsl:for-each>
    </VRPTx:pdbx_em_fsc_cutoff_curveCategory>
    <VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory>
      <xsl:for-each select="fsc_indicator_curve">
	<xsl:variable name="plot_id"><xsl:value-of select="position()"/></xsl:variable>
	<xsl:variable name="criterion">
	  <xsl:choose>
	    <xsl:when test="ends-with(@Title,'0.143') or @type='0.143'">0.143</xsl:when>
	    <xsl:when test="ends-with(@Title,'0.333') or @type='0.333'">0.333</xsl:when>
	    <xsl:when test="ends-with(@Title,'0.5') or @type='0.5'">0.5</xsl:when>
	    <xsl:when test="ends-with(@Title,'halfbit') or @type='halfbit'">half-bit</xsl:when>
	    <xsl:when test="ends-with(@Title,'onebit') or @type='onebit'">one-bit</xsl:when>
	    <xsl:when test="ends-with(@Title,'threesigma') or @type='threesigma'">3sigma</xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Criteria for FSC offset curve, <xsl:value-of select="@Title"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<xsl:choose>
	  <xsl:when test="$criterion='half-bit' or $criterion='one-bit' or $criterion='3sigma'">
	    <xsl:for-each select="coordinate">
	      <xsl:sort select="number(@x)" data-type="number"/>
	      <VRPTx:pdbx_em_fsc_cutoff_curve_marker plot_id="{$plot_id}" ordinal="{position()}">
		<VRPTx:spatial_frequency><xsl:value-of select="number(@x)"/></VRPTx:spatial_frequency>
		<VRPTx:correlation_coef><xsl:value-of select="number(@y)"/></VRPTx:correlation_coef>
	      </VRPTx:pdbx_em_fsc_cutoff_curve_marker>
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:otherwise>
	    <VRPTx:pdbx_em_fsc_cutoff_curve_marker plot_id="{$plot_id}" ordinal="1">
	      <VRPTx:correlation_coef><xsl:value-of select="$criterion"/></VRPTx:correlation_coef>
	    </VRPTx:pdbx_em_fsc_cutoff_curve_marker>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory>
  </xsl:template>

  <xsl:template match="atom_inclusion">
    <VRPTx:pdbx_em_atom_inclusionCategory>
      <xsl:for-each select="*">
	<VRPTx:pdbx_em_atom_inclusion>
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:choose>
	    <xsl:when test="name()='all_atoms'">
	      <VRPTx:atom_type>all non-hydrogen atoms</VRPTx:atom_type>
	    </xsl:when>
	    <xsl:when test="name()='backbone'">
	      <VRPTx:atom_type>backbone atoms</VRPTx:atom_type>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Atom type of atom inclusion plot, <xsl:value-of select="name()"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:contour_level_title><xsl:value-of select="@xTitle"/></VRPTx:contour_level_title>
	  <VRPTx:atom_inclusion_title><xsl:value-of select="@yTitle"/></VRPTx:atom_inclusion_title>
	</VRPTx:pdbx_em_atom_inclusion>
      </xsl:for-each>
    </VRPTx:pdbx_em_atom_inclusionCategory>
    <VRPTx:pdbx_em_atom_inclusion_markerCategory>
      <xsl:for-each select="*">
	<xsl:variable name="plot_id"><xsl:value-of select="position()"/></xsl:variable>
	<xsl:for-each select="coordinate">
	  <xsl:sort select="number(@x)" data-type="number"/>
	  <VRPTx:pdbx_em_atom_inclusion_marker plot_id="{$plot_id}" ordinal="{position()}">
	    <VRPTx:contour_level><xsl:value-of select="number(@x)"/></VRPTx:contour_level>
	    <VRPTx:atom_inclusion><xsl:value-of select="number(@y)"/></VRPTx:atom_inclusion>
	  </VRPTx:pdbx_em_atom_inclusion_marker>
	</xsl:for-each>
      </xsl:for-each>
    </VRPTx:pdbx_em_atom_inclusion_markerCategory>
  </xsl:template>

  <!-- NMR restraint validation: NMR_restraints_analysis -->

  <xsl:template match="NMR_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="conformationally_restricting_restraints">
    <VRPTx:pdbx_nmr_restraint_listCategory>
      <xsl:if test="../../distance_restraints_analysis">
	<VRPTx:pdbx_nmr_restraint_list id="1" type="distance"/>
	<xsl:for-each select="distinct-values(../../distance_restraints_analysis/violated_distance_restraints/violated_distance_restraint/@rlist_id)">
	  <xsl:sort select="."/>
	  <xsl:variable name="list_id"><xsl:value-of select="."/></xsl:variable>
	  <xsl:if test="$list_id!='1'">
	    <VRPTx:pdbx_nmr_restraint_list id="{$list_id}" type="distance"/>
	  </xsl:if>
	</xsl:for-each>
      </xsl:if>
      <xsl:if test="../../dihedralangle_restraints_analysis">
	<VRPTx:pdbx_nmr_restraint_list id="1" type="dihedral_angle"/>
	<xsl:for-each select="distinct-values(../../dihedralangle_restraints_analysis/violated_dihedralangle_restraints/violated_dihedralangle_restraint/@rlist_id)">
	  <xsl:sort select="."/>
	  <xsl:variable name="list_id"><xsl:value-of select="."/></xsl:variable>
	  <xsl:if test="$list_id!='1'">
	    <VRPTx:pdbx_nmr_restraint_list id="{$list_id}" type="dihedral_angle"/>
	  </xsl:if>
	</xsl:for-each>
      </xsl:if>
    </VRPTx:pdbx_nmr_restraint_listCategory>
    <VRPTx:pdbx_nmr_restraint_summaryCategory>
      <VRPTx:pdbx_nmr_restraint_summary entry_id="{$entry_id}">
	<xsl:for-each select="restraint_summary">
	  <xsl:choose>
	    <xsl:when test="@description='Total distance restraints'">
	      <VRPTx:distance_restraints_total><xsl:value-of select="@value"/></VRPTx:distance_restraints_total>
	    </xsl:when>
	    <xsl:when test="@description='Intra-residue (|i-j|=0)'">
	      <VRPTx:intraresidue_total_count><xsl:value-of select="@value"/></VRPTx:intraresidue_total_count>
	    </xsl:when>
	    <xsl:when test="@description='Inter-chain'">
	      <VRPTx:interchain_total_count><xsl:value-of select="@value"/></VRPTx:interchain_total_count>
	    </xsl:when>
	    <xsl:when test="@description='Sequential (|i-j|=1)'">
	      <VRPTx:sequential_total_count><xsl:value-of select="@value"/></VRPTx:sequential_total_count>
	    </xsl:when>
	    <xsl:when test="@description='Medium range (|i-j|&gt;1 and |i-j|&lt;5)'">
	      <VRPTx:medium_range_total_count><xsl:value-of select="@value"/></VRPTx:medium_range_total_count>
	    </xsl:when>
	    <xsl:when test="@description='Long range (|i-j|&gt;=5)' or @description='Long range (|i-j|$\geq$5)'"> <!-- v005 -->
	      <VRPTx:long_range_total_count><xsl:value-of select="@value"/></VRPTx:long_range_total_count>
	    </xsl:when>
	    <xsl:when test="@description='Total dihedral-angle restraints'">
	      <VRPTx:dihedral_angle_restraints_total><xsl:value-of select="@value"/></VRPTx:dihedral_angle_restraints_total>
	    </xsl:when>
	    <xsl:when test="@description='Total hydrogen bond restraints'">
	      <VRPTx:hydrogen_bond_restraints_total><xsl:value-of select="@value"/></VRPTx:hydrogen_bond_restraints_total>
	    </xsl:when>
	    <xsl:when test="@description='Total disulfide bond restraints'">
	      <VRPTx:disulfide_bond_restraints_total><xsl:value-of select="@value"/></VRPTx:disulfide_bond_restraints_total>
	    </xsl:when>
	    <xsl:when test="@description='Number of unmapped restraints'">
	      <VRPTx:unmapped_restraints_total><xsl:value-of select="@value"/></VRPTx:unmapped_restraints_total>
	    </xsl:when>
	    <xsl:when test="@description='Number of restraints per residue'">
	      <VRPTx:restraints_per_residue><xsl:value-of select="@value"/></VRPTx:restraints_per_residue>
	    </xsl:when>
	    <xsl:when test="@description='Number of long range restraints per residue'">
	      <VRPTx:long_range_restraints_per_residue><xsl:value-of select="@value"/></VRPTx:long_range_restraints_per_residue>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Restraint summary, <xsl:value-of select="@description"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:for-each>
      </VRPTx:pdbx_nmr_restraint_summary>
    </VRPTx:pdbx_nmr_restraint_summaryCategory>
    <xsl:if test="../residual_distance_violations or ../residual_angle_violations">
      <VRPTx:pdbx_nmr_restraint_violationCategory>
	<xsl:for-each select="../residual_distance_violations/residual_distance_violation">
	  <VRPTx:pdbx_nmr_restraint_violation type="distance" ordinal="{position()}">
	    <xsl:choose>
	      <xsl:when test="@bins='0.1-0.2'">
		<VRPTx:limit_bin_max>0.2</VRPTx:limit_bin_max>
		<VRPTx:limit_bin_min>0.1</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:when test="@bins='0.2-0.5'">
		<VRPTx:limit_bin_max>0.5</VRPTx:limit_bin_max>
		<VRPTx:limit_bin_min>0.2</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:when test="@bins='&gt;0.5'">
		<VRPTx:limit_bin_min>0.5</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Restraint residual violation bins, <xsl:value-of select="@bins"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	    <VRPTx:maximum_violation_in_bin><xsl:value-of select="@max_violation"/></VRPTx:maximum_violation_in_bin>
	    <VRPTx:bin_units>A</VRPTx:bin_units>
	    <VRPTx:violations_per_model><xsl:value-of select="@violations_per_model"/></VRPTx:violations_per_model>
	  </VRPTx:pdbx_nmr_restraint_violation>
	</xsl:for-each>
	<xsl:for-each select="../residual_angle_violations/residual_angle_violation">
	  <VRPTx:pdbx_nmr_restraint_violation type="dihedral_angle" ordinal="{position()}">
	    <xsl:choose>
	      <xsl:when test="@bins='1.0-10.0'">
		<VRPTx:limit_bin_max>10.0</VRPTx:limit_bin_max>
		<VRPTx:limit_bin_min>1.0</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:when test="@bins='10.0-20.0'">
		<VRPTx:limit_bin_max>20.0</VRPTx:limit_bin_max>
		<VRPTx:limit_bin_min>10.0</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:when test="@bins='&gt;20.0'">
		<VRPTx:limit_bin_min>20.0</VRPTx:limit_bin_min>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Restraint residual violation bins, <xsl:value-of select="@bins"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	    <VRPTx:maximum_violation_in_bin><xsl:value-of select="@max_violation"/></VRPTx:maximum_violation_in_bin>
	    <VRPTx:bin_units>degrees</VRPTx:bin_units>
	    <VRPTx:violations_per_model><xsl:value-of select="@violations_per_model"/></VRPTx:violations_per_model>
	  </VRPTx:pdbx_nmr_restraint_violation>
	</xsl:for-each>
      </VRPTx:pdbx_nmr_restraint_violationCategory>
    </xsl:if>
  </xsl:template>

  <!-- NMR restraint validation: distance_restraints_analysis -->

  <xsl:template match="distance_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="distance_violations_summary">
    <VRPTx:pdbx_nmr_distance_violation_summaryCategory>
      <xsl:for-each select="distance_violation_summary">
	<VRPTx:pdbx_nmr_distance_violation_summary>
	  <xsl:choose>
	  <xsl:when test="@restraint_sub_type"> <!-- v5.01 or later -->
	  <xsl:choose>
	    <xsl:when test="@restraint_type='Intra-residue'">
	      <xsl:attribute name="type">intraresidue</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='Sequential'">
	      <xsl:attribute name="type">sequential</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='MediumRange'">
	      <xsl:attribute name="type">medium_range</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='LongRange'">
	      <xsl:attribute name="type">long_range</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='InterChain'">
	      <xsl:attribute name="type">interchain</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='HydrogenBond'">
	      <xsl:attribute name="type">hydrogen_bond</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='DisulfideBond'">
	      <xsl:attribute name="type">disulfide_bond</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='Total'">
	      <xsl:attribute name="type">all</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Restraint type, <xsl:value-of select="@restraint_type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:choose>
	    <xsl:when test="@restraint_sub_type='BackboneBackbone'">
	      <xsl:attribute name="subtype">backbone_backbone</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_sub_type='BackboneSidechain'">
	      <xsl:attribute name="subtype">backbone_sidechain</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_sub_type='SidechainSidechain'">
	      <xsl:attribute name="subtype">sidechain_sidechain</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_sub_type='all'">
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Restraint sub type, <xsl:value-of select="@restraint_sub_type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	  <xsl:choose>
	    <xsl:when test="@restraint_type='Intra-residue'">
	      <xsl:attribute name="type">intraresidue</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='Sequential'">
	      <xsl:attribute name="type">sequential</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='MediumRange'">
	      <xsl:attribute name="type">medium_range</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='LongRange'">
	      <xsl:attribute name="type">long_range</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='InterChain'">
	      <xsl:attribute name="type">interchain</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='Total'">
	      <xsl:attribute name="type">all</xsl:attribute>
	      <xsl:attribute name="subtype">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='BackboneBackbone'">
	      <xsl:for-each select="preceding-sibling::distance_violation_summary[@restraint_type!='BackboneBackbone' and @restraint_type!='BackboneSidechain' and @restraint_type!='SidechainSidechain']">
		<xsl:choose>
		  <xsl:when test="@restraint_type='Intra-residue'">
		    <xsl:attribute name="type">intraresidue</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Sequential'">
		    <xsl:attribute name="type">sequential</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='MediumRange'">
		    <xsl:attribute name="type">medium_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='LongRange'">
		    <xsl:attribute name="type">long_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='InterChain'">
		    <xsl:attribute name="type">interchain</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Total'">
		    <xsl:attribute name="type">all</xsl:attribute>
		  </xsl:when>
		</xsl:choose>
	      </xsl:for-each>
	      <xsl:attribute name="subtype">backbone_backbone</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='BackboneSidechain'">
	      <xsl:for-each select="preceding-sibling::distance_violation_summary[@restraint_type!='BackboneBackbone' and @restraint_type!='BackboneSidechain' and @restraint_type!='SidechainSidechain']">
		<xsl:choose>
		  <xsl:when test="@restraint_type='Intra-residue'">
		    <xsl:attribute name="type">intraresidue</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Sequential'">
		    <xsl:attribute name="type">sequential</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='MediumRange'">
		    <xsl:attribute name="type">medium_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='LongRange'">
		    <xsl:attribute name="type">long_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='InterChain'">
		    <xsl:attribute name="type">interchain</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Total'">
		    <xsl:attribute name="type">all</xsl:attribute>
		  </xsl:when>
		</xsl:choose>
	      </xsl:for-each>
	      <xsl:attribute name="subtype">backbone_sidechain</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='SidechainSidechain'">
	      <xsl:for-each select="preceding-sibling::distance_violation_summary[@restraint_type!='BackboneBackbone' and @restraint_type!='BackboneSidechain' and @restraint_type!='SidechainSidechain']">
		<xsl:choose>
		  <xsl:when test="@restraint_type='Intra-residue'">
		    <xsl:attribute name="type">intraresidue</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Sequential'">
		    <xsl:attribute name="type">sequential</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='MediumRange'">
		    <xsl:attribute name="type">medium_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='LongRange'">
		    <xsl:attribute name="type">long_range</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='InterChain'">
		    <xsl:attribute name="type">interchain</xsl:attribute>
		  </xsl:when>
		  <xsl:when test="@restraint_type='Total'">
		    <xsl:attribute name="type">all</xsl:attribute>
		  </xsl:when>
		</xsl:choose>
	      </xsl:for-each>
	      <xsl:attribute name="subtype">sidechain_sidechain</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Restraint type, <xsl:value-of select="@restraint_type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:restraints_count><xsl:value-of select="@restraints_count"/></VRPTx:restraints_count>
	  <VRPTx:restraints_percent><xsl:value-of select="@percent_total"/></VRPTx:restraints_percent>
	  <VRPTx:violations_count><xsl:value-of select="@violated_count"/></VRPTx:violations_count>
	  <VRPTx:violations_percent><xsl:value-of select="@violated_percent_total"/></VRPTx:violations_percent>
	  <VRPTx:violations_percent_type><xsl:value-of select="@violated_percent_type"/></VRPTx:violations_percent_type>
	  <VRPTx:consistent_violations_count><xsl:value-of select="@consistently_violated_count"/></VRPTx:consistent_violations_count>
	  <VRPTx:consistent_violations_percent><xsl:value-of select="@consistently_violated_percent_total"/></VRPTx:consistent_violations_percent>
	  <VRPTx:consistent_violations_percent_type><xsl:value-of select="@consistently_violated_percent_type"/></VRPTx:consistent_violations_percent_type>
	</VRPTx:pdbx_nmr_distance_violation_summary>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_distance_violation_summaryCategory>
  </xsl:template>

  <xsl:template match="distance_violations_in_models">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_distance_violation_modelCategory>
      <xsl:for-each select="distance_violations_in_model">
	<VRPTx:pdbx_nmr_distance_violation_model PDB_model_num="{@model}">
	  <VRPTx:maximum_violation><xsl:value-of select="@max_violation"/></VRPTx:maximum_violation>
	  <VRPTx:average_violation><xsl:value-of select="@mean_violation"/></VRPTx:average_violation>
	  <VRPTx:median_violation><xsl:value-of select="@median_violation"/></VRPTx:median_violation>
	  <VRPTx:standard_deviation><xsl:value-of select="@standard_deviation"/></VRPTx:standard_deviation>
	  <xsl:for-each select="dist_rest_types">
	    <xsl:choose>
	      <xsl:when test="@dist_rest_type='Total'">
		<VRPTx:violations_count><xsl:value-of select="@violations_count"/></VRPTx:violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='Intra-residue'">
		<VRPTx:intraresidue_violations_count><xsl:value-of select="@violations_count"/></VRPTx:intraresidue_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='Sequential'">
		<VRPTx:sequential_violations_count><xsl:value-of select="@violations_count"/></VRPTx:sequential_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='MediumRange'">
		<VRPTx:medium_range_violations_count><xsl:value-of select="@violations_count"/></VRPTx:medium_range_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='LongRange'">
		<VRPTx:long_range_violations_count><xsl:value-of select="@violations_count"/></VRPTx:long_range_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='InterChain'">
		<VRPTx:interchain_violations_count><xsl:value-of select="@violations_count"/></VRPTx:interchain_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='HydrogenBond'">
		<VRPTx:hydrogen_bond_violations_count><xsl:value-of select="@violations_count"/></VRPTx:hydrogen_bond_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='DisulfideBond'">
		<VRPTx:disulfide_bond_violations_count><xsl:value-of select="@violations_count"/></VRPTx:disulfide_bond_violations_count>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Distance restraint type, <xsl:value-of select="@dist_rest_type"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_distance_violation_model>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_distance_violation_modelCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="distance_violations_in_ensemble">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_distance_violation_ensembleCategory>
      <xsl:for-each select="distance_violation_in_ensemble">
	<VRPTx:pdbx_nmr_distance_violation_ensemble fraction_ensemble_size="{@fraction_of_ensemble_count}">
	  <xsl:choose>
	  <xsl:when test="@fraction_of_ensemble_percent"> <!-- v5.01 or later -->
	    <VRPTx:fraction_ensemble_percent><xsl:value-of select="@fraction_of_ensemble_percent"/></VRPTx:fraction_ensemble_percent>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	    <VRPTx:fraction_ensemble_percent><xsl:value-of select="format-number(number(@fraction_of_ensemble_count) div number($nmr_models) * 100.0,'0.0')"/></VRPTx:fraction_ensemble_percent>
	  </xsl:otherwise>
	  </xsl:choose>
	  <xsl:for-each select="dist_rest_types">
	    <xsl:choose>
	      <xsl:when test="@dist_rest_type='Total'">
		<VRPTx:violations_count><xsl:value-of select="@violations_count"/></VRPTx:violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='Intra-residue'">
		<VRPTx:intraresidue_violations_count><xsl:value-of select="@violations_count"/></VRPTx:intraresidue_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='Sequential'">
		<VRPTx:sequential_violations_count><xsl:value-of select="@violations_count"/></VRPTx:sequential_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='MediumRange'">
		<VRPTx:medium_range_violations_count><xsl:value-of select="@violations_count"/></VRPTx:medium_range_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='LongRange'">
		<VRPTx:long_range_violations_count><xsl:value-of select="@violations_count"/></VRPTx:long_range_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='InterChain'">
		<VRPTx:interchain_violations_count><xsl:value-of select="@violations_count"/></VRPTx:interchain_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='HydrogenBond'">
		<VRPTx:hydrogen_bond_violations_count><xsl:value-of select="@violations_count"/></VRPTx:hydrogen_bond_violations_count>
	      </xsl:when>
	      <xsl:when test="@dist_rest_type='DisulfideBond'">
		<VRPTx:disulfide_bond_violations_count><xsl:value-of select="@violations_count"/></VRPTx:disulfide_bond_violations_count>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Distance restraint type, <xsl:value-of select="@dist_rest_type"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_distance_violation_ensemble>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_distance_violation_ensembleCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="most_violated_distance_restraints">
    <xsl:if test="node()">
    <xsl:variable name="violated_distance_restraints"><xsl:value-of select="../violated_distance_restraints"/></xsl:variable>
    <VRPTx:pdbx_nmr_distance_violation_pluralCategory>
      <xsl:for-each select="most_violated_distance_restraint">
	<VRPTx:pdbx_nmr_distance_violation_plural ordinal="{position()}">
	  <VRPTx:list_id><xsl:value-of select="@rlist_id"/></VRPTx:list_id>
	  <VRPTx:restraint_id><xsl:value-of select="@rest_id"/></VRPTx:restraint_id>
	  <VRPTx:violation_models_count><xsl:value-of select="@violated_models"/></VRPTx:violation_models_count>
	  <VRPTx:average_violation><xsl:value-of select="@mean_distance_violation"/></VRPTx:average_violation>
	  <VRPTx:median_violation><xsl:value-of select="@median_violation"/></VRPTx:median_violation>
	  <VRPTx:standard_deviation><xsl:value-of select="@standard_deviation"/></VRPTx:standard_deviation>
	  <VRPTx:entity_id_1><xsl:value-of select="@ent_1"/></VRPTx:entity_id_1>
	  <VRPTx:entity_id_2><xsl:value-of select="@ent_2"/></VRPTx:entity_id_2>
	  <VRPTx:auth_asym_id_1><xsl:value-of select="@chain_1"/></VRPTx:auth_asym_id_1>
	  <VRPTx:auth_asym_id_2><xsl:value-of select="@chain_2"/></VRPTx:auth_asym_id_2>
	  <VRPTx:auth_seq_id_1><xsl:value-of select="@resnum_1"/></VRPTx:auth_seq_id_1>
	  <VRPTx:auth_seq_id_2><xsl:value-of select="@resnum_2"/></VRPTx:auth_seq_id_2>
	  <VRPTx:auth_comp_id_1><xsl:value-of select="@resname_1"/></VRPTx:auth_comp_id_1>
	  <VRPTx:auth_comp_id_2><xsl:value-of select="@resname_2"/></VRPTx:auth_comp_id_2>
	  <xsl:variable name="icode_1"><xsl:value-of select="translate(@icode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_2"><xsl:value-of select="translate(@icode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_1"><xsl:value-of select="translate(@altcode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_2"><xsl:value-of select="translate(@altcode_2,'?.','  ')"/></xsl:variable>
	  <xsl:choose>
	  <xsl:when test="@atom_1"> <!-- v5.01 or later -->
	  <VRPTx:auth_atom_id_1><xsl:value-of select="@atom_1"/></VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2><xsl:value-of select="@atom_2"/></VRPTx:auth_atom_id_2>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	  <xsl:variable name="rlist_id"><xsl:value-of select="@rlist_id"/></xsl:variable>
	  <xsl:variable name="rest_id"><xsl:value-of select="@rest_id"/></xsl:variable>
	  <xsl:variable name="models">
	    <xsl:for-each select="1 to $nmr_models">
	      <xsl:variable name="_model"><xsl:value-of select="."/></xsl:variable>
	      <xsl:if test="$violated_distance_restraints/violated_distance_restraint[@rlist_id=$rlist_id and @rest_id=$rest_id and @model=$_model]">
		<xsl:value-of select="concat($_model,',')"/>
	      </xsl:if>
	    </xsl:for-each>
	  </xsl:variable>
	  <xsl:variable name="rep_model"><xsl:value-of select="substring-before($models,',')"/></xsl:variable>
	  <xsl:variable name="chain_1"><xsl:value-of select="@chain_1"/></xsl:variable>
	  <xsl:variable name="chain_2"><xsl:value-of select="@chain_2"/></xsl:variable>
	  <xsl:variable name="resnum_1"><xsl:value-of select="@resnum_1"/></xsl:variable>
	  <xsl:variable name="resnum_2"><xsl:value-of select="@resnum_2"/></xsl:variable>
	  <xsl:variable name="uniq"><xsl:value-of select="count(//violated_distance_restraints/violated_distance_restraint[@rlist_id=$rlist_id and @rest_id=$rest_id and @model=$rep_model])"/></xsl:variable>
	  <xsl:variable name="intrares"><xsl:value-of select="$chain_1=$chain_2 and $resnum_1=$resnum_2"/></xsl:variable>
	  <xsl:choose>
	    <xsl:when test="$uniq=1 and $intrares=false()">
	      <xsl:variable name="atom_1">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$rep_model and @resnum=$resnum_1 and @icode=$icode_1]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="@atom"/>
		</xsl:for-each>
	      </xsl:variable>
	      <xsl:variable name="atom_2">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$rep_model and @resnum=$resnum_2 and @icode=$icode_2]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="@atom"/>
		</xsl:for-each>
	      </xsl:variable>
	      <VRPTx:auth_atom_id_1><xsl:value-of select="$atom_1"/></VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2><xsl:value-of select="$atom_2"/></VRPTx:auth_atom_id_2>
	    </xsl:when>
	    <xsl:when test="$uniq=1 and $intrares=true()">
	      <xsl:variable name="_atoms">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$rep_model and @resnum=$resnum_1 and @icode=$icode_1]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="concat(@atom,',')"/>
		</xsl:for-each>
	      </xsl:variable>
	      <xsl:variable name="atoms"><xsl:value-of select="substring($_atoms,1,string-length($_atoms)-1)"/></xsl:variable>
	      <VRPTx:auth_atom_id_1><xsl:value-of select="substring-before($atoms,',')"/></VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2><xsl:value-of select="substring-after($atoms,',')"/></VRPTx:auth_atom_id_2>
	    </xsl:when>
	    <xsl:otherwise>
	      <VRPTx:auth_atom_id_1>?</VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2>?</VRPTx:auth_atom_id_2>
	    </xsl:otherwise>
	  </xsl:choose>
	  </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:label_asym_id_1><xsl:value-of select="@said_1"/></VRPTx:label_asym_id_1>
	  <VRPTx:label_asym_id_2><xsl:value-of select="@said_2"/></VRPTx:label_asym_id_2>
	  <VRPTx:label_seq_id_1><xsl:value-of select="@seq_1"/></VRPTx:label_seq_id_1>
	  <VRPTx:label_seq_id_2><xsl:value-of select="@seq_2"/></VRPTx:label_seq_id_2>
	  <VRPTx:PDB_ins_code_1><xsl:value-of select="translate($icode_1,' ','?')"/></VRPTx:PDB_ins_code_1>
	  <VRPTx:PDB_ins_code_2><xsl:value-of select="translate($icode_2,' ','?')"/></VRPTx:PDB_ins_code_2>
	  <VRPTx:label_alt_id_1><xsl:value-of select="translate($altcode_1,' ','.')"/></VRPTx:label_alt_id_1>
	  <VRPTx:label_alt_id_2><xsl:value-of select="translate($altcode_2,' ','.')"/></VRPTx:label_alt_id_2>
	</VRPTx:pdbx_nmr_distance_violation_plural>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_distance_violation_pluralCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="violated_distance_restraints">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_distance_violationCategory>
      <xsl:for-each select="violated_distance_restraint">
	<VRPTx:pdbx_nmr_distance_violation ordinal="{position()}">
	  <VRPTx:list_id><xsl:value-of select="@rlist_id"/></VRPTx:list_id>
	  <VRPTx:restraint_id><xsl:value-of select="@rest_id"/></VRPTx:restraint_id>
	  <VRPTx:PDB_model_num><xsl:value-of select="@model"/></VRPTx:PDB_model_num>
	  <VRPTx:violation><xsl:value-of select="@violation"/></VRPTx:violation>
	  <VRPTx:entity_id_1><xsl:value-of select="@ent_1"/></VRPTx:entity_id_1>
	  <VRPTx:entity_id_2><xsl:value-of select="@ent_2"/></VRPTx:entity_id_2>
	  <VRPTx:auth_asym_id_1><xsl:value-of select="@chain_1"/></VRPTx:auth_asym_id_1>
	  <VRPTx:auth_asym_id_2><xsl:value-of select="@chain_2"/></VRPTx:auth_asym_id_2>
	  <VRPTx:auth_seq_id_1><xsl:value-of select="@resnum_1"/></VRPTx:auth_seq_id_1>
	  <VRPTx:auth_seq_id_2><xsl:value-of select="@resnum_2"/></VRPTx:auth_seq_id_2>
	  <VRPTx:auth_comp_id_1><xsl:value-of select="@resname_1"/></VRPTx:auth_comp_id_1>
	  <VRPTx:auth_comp_id_2><xsl:value-of select="@resname_2"/></VRPTx:auth_comp_id_2>
	  <xsl:variable name="icode_1"><xsl:value-of select="translate(@icode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_2"><xsl:value-of select="translate(@icode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_1"><xsl:value-of select="translate(@altcode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_2"><xsl:value-of select="translate(@altcode_2,'?.','  ')"/></xsl:variable>
	  <xsl:choose>
	  <xsl:when test="@atom_1"> <!-- v5.01 or later -->
	  <VRPTx:auth_atom_id_1><xsl:value-of select="@atom_1"/></VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2><xsl:value-of select="@atom_2"/></VRPTx:auth_atom_id_2>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	  <xsl:variable name="rlist_id"><xsl:value-of select="@rlist_id"/></xsl:variable>
	  <xsl:variable name="rest_id"><xsl:value-of select="@rest_id"/></xsl:variable>
	  <xsl:variable name="model"><xsl:value-of select="@model"/></xsl:variable>
	  <xsl:variable name="chain_1"><xsl:value-of select="@chain_1"/></xsl:variable>
	  <xsl:variable name="chain_2"><xsl:value-of select="@chain_2"/></xsl:variable>
	  <xsl:variable name="resnum_1"><xsl:value-of select="@resnum_1"/></xsl:variable>
	  <xsl:variable name="resnum_2"><xsl:value-of select="@resnum_2"/></xsl:variable>
	  <xsl:variable name="uniq"><xsl:value-of select="count(//violated_distance_restraints/violated_distance_restraint[@rlist_id=$rlist_id and @rest_id=$rest_id and @model=$model])"/></xsl:variable>
	  <xsl:variable name="intrares"><xsl:value-of select="$chain_1=$chain_2 and $resnum_1=$resnum_2"/></xsl:variable>
	  <xsl:choose>
	    <xsl:when test="$uniq=1 and $intrares=false()">
	      <xsl:variable name="atom_1">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$model and @resnum=$resnum_1 and @icode=$icode_1]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="@atom"/>
		</xsl:for-each>
	      </xsl:variable>
	      <xsl:variable name="atom_2">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$model and @resnum=$resnum_2 and @icode=$icode_2]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="@atom"/>
		</xsl:for-each>
	      </xsl:variable>
	      <VRPTx:auth_atom_id_1><xsl:value-of select="$atom_1"/></VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2><xsl:value-of select="$atom_2"/></VRPTx:auth_atom_id_2>
	    </xsl:when>
	    <xsl:when test="$uniq=1 and $intrares=true()">
	      <xsl:variable name="_atoms">
		<xsl:for-each select="/wwPDB-validation-information/ModelledSubgroup[@model=$model and @resnum=$resnum_1 and @icode=$icode_1]/distance_violation[@rlist_id=$rlist_id and @rest_id=$rest_id]">
		  <xsl:value-of select="concat(@atom,',')"/>
		</xsl:for-each>
	      </xsl:variable>
	      <xsl:variable name="atoms"><xsl:value-of select="substring($_atoms,1,string-length($_atoms)-1)"/></xsl:variable>
	      <VRPTx:auth_atom_id_1><xsl:value-of select="substring-before($atoms,',')"/></VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2><xsl:value-of select="substring-after($atoms,',')"/></VRPTx:auth_atom_id_2>
	    </xsl:when>
	    <xsl:otherwise>
	      <VRPTx:auth_atom_id_1>?</VRPTx:auth_atom_id_1>
	      <VRPTx:auth_atom_id_2>?</VRPTx:auth_atom_id_2>
	    </xsl:otherwise>
	  </xsl:choose>
	  </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:label_asym_id_1><xsl:value-of select="@said_1"/></VRPTx:label_asym_id_1>
	  <VRPTx:label_asym_id_2><xsl:value-of select="@said_2"/></VRPTx:label_asym_id_2>
	  <VRPTx:label_seq_id_1><xsl:value-of select="@seq_1"/></VRPTx:label_seq_id_1>
	  <VRPTx:label_seq_id_2><xsl:value-of select="@seq_2"/></VRPTx:label_seq_id_2>
	  <VRPTx:PDB_ins_code_1><xsl:value-of select="translate($icode_1,' ','?')"/></VRPTx:PDB_ins_code_1>
	  <VRPTx:PDB_ins_code_2><xsl:value-of select="translate($icode_2,' ','?')"/></VRPTx:PDB_ins_code_2>
	  <VRPTx:label_alt_id_1><xsl:value-of select="translate($altcode_1,' ','.')"/></VRPTx:label_alt_id_1>
	  <VRPTx:label_alt_id_2><xsl:value-of select="translate($altcode_2,' ','.')"/></VRPTx:label_alt_id_2>
	</VRPTx:pdbx_nmr_distance_violation>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_distance_violationCategory>
    </xsl:if>
  </xsl:template>

  <!-- NMR restraint validation: dihedralangle_restraints_analysis -->

  <xsl:template match="dihedralangle_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_summary">
    <VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory>
      <xsl:for-each select="dihedralangle_violation_summary">
	<VRPTx:pdbx_nmr_dihedral_angle_violation_summary>
	  <xsl:choose>
	    <xsl:when test="@restraint_type='PHI'">
	      <xsl:attribute name="type">phi</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='PSI'">
	      <xsl:attribute name="type">psi</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='OMEGA'">
	      <xsl:attribute name="type">omega</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI1'">
	      <xsl:attribute name="type">chi1</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI2'">
	      <xsl:attribute name="type">chi2</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI3'">
	      <xsl:attribute name="type">chi3</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI4'">
	      <xsl:attribute name="type">chi4</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI5'">
	      <xsl:attribute name="type">chi5</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='ALPHA'">
	      <xsl:attribute name="type">alpha</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='BETA'">
	      <xsl:attribute name="type">beta</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='GAMMA'">
	      <xsl:attribute name="type">gamma</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='DELTA'">
	      <xsl:attribute name="type">delta</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='EPSILON'">
	      <xsl:attribute name="type">epsilon</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='ZETA'">
	      <xsl:attribute name="type">zeta</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='NU0' or @restraint_type='TAU0'">
	      <xsl:attribute name="type">nu0</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='NU1' or @restraint_type='TAU1'">
	      <xsl:attribute name="type">nu1</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='NU2' or @restraint_type='TAU2'">
	      <xsl:attribute name="type">nu2</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='NU3' or @restraint_type='TAU3'">
	      <xsl:attribute name="type">nu3</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='NU4' or @restraint_type='TAU4'">
	      <xsl:attribute name="type">nu4</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI21'">
	      <xsl:attribute name="type">chi21</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI22'">
	      <xsl:attribute name="type">chi22</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI31'">
	      <xsl:attribute name="type">chi31</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI32'">
	      <xsl:attribute name="type">chi32</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI42'">
	      <xsl:attribute name="type">chi42</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='Total'">
	      <xsl:attribute name="type">all</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='CHI'">
	      <xsl:attribute name="type">chi</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='ETA'">
	      <xsl:attribute name="type">eta</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='THETA'">
	      <xsl:attribute name="type">theta</xsl:attribute>
	    </xsl:when>
	    <xsl:when test='@restraint_type="ETA&apos;"'>
	      <xsl:attribute name="type">eta'</xsl:attribute>
	    </xsl:when>
	    <xsl:when test='@restraint_type="THETA&apos;"'>
	      <xsl:attribute name="type">theta'</xsl:attribute>
	    </xsl:when>
	    <xsl:when test="@restraint_type='.' or @restraint_type='PPA' or @restraint_type='VEANgle'">
	      <xsl:attribute name="type">other</xsl:attribute>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Restraint type, <xsl:value-of select="@restraint_type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:restraints_count><xsl:value-of select="@restraints_count"/></VRPTx:restraints_count>
	  <VRPTx:restraints_percent><xsl:value-of select="@percent_total"/></VRPTx:restraints_percent>
	  <VRPTx:violations_count><xsl:value-of select="@violated_count"/></VRPTx:violations_count>
	  <VRPTx:violations_percent><xsl:value-of select="@violated_percent_total"/></VRPTx:violations_percent>
	  <VRPTx:violations_percent_type><xsl:value-of select="@violated_percent_type"/></VRPTx:violations_percent_type>
	  <VRPTx:consistent_violations_count><xsl:value-of select="@consistently_violated_count"/></VRPTx:consistent_violations_count>
	  <VRPTx:consistent_violations_percent><xsl:value-of select="@consistently_violated_percent_total"/></VRPTx:consistent_violations_percent>
	  <VRPTx:consistent_violations_percent_type><xsl:value-of select="@consistently_violated_percent_type"/></VRPTx:consistent_violations_percent_type>
	</VRPTx:pdbx_nmr_dihedral_angle_violation_summary>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_in_models">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory>
      <xsl:for-each select="dihedralangle_violations_in_model">
	<VRPTx:pdbx_nmr_dihedral_angle_violation_model PDB_model_num="{@model}">
	  <VRPTx:maximum_violation><xsl:value-of select="@max_violation"/></VRPTx:maximum_violation>
	  <VRPTx:average_violation><xsl:value-of select="@mean_violation"/></VRPTx:average_violation>
	  <VRPTx:median_violation><xsl:value-of select="@median_violation"/></VRPTx:median_violation>
	  <VRPTx:standard_deviation><xsl:value-of select="@standard_deviation"/></VRPTx:standard_deviation>
	  <xsl:for-each select="ang_rest_types">
	    <xsl:choose>
	      <xsl:when test="@ang_rest_type='Total'">
		<VRPTx:violations_count><xsl:value-of select="@violations_count"/></VRPTx:violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='PHI'">
		<VRPTx:phi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:phi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='PSI'">
		<VRPTx:psi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:psi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='OMEGA'">
		<VRPTx:omega_violations_count><xsl:value-of select="@violations_count"/></VRPTx:omega_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI1'">
		<VRPTx:chi1_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi1_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI2'">
		<VRPTx:chi2_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi2_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI3'">
		<VRPTx:chi3_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi3_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI4'">
		<VRPTx:chi4_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi4_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI5'">
		<VRPTx:chi5_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi5_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ALPHA'">
		<VRPTx:alpha_violations_count><xsl:value-of select="@violations_count"/></VRPTx:alpha_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='BETA'">
		<VRPTx:beta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:beta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='GAMMA'">
		<VRPTx:gamma_violations_count><xsl:value-of select="@violations_count"/></VRPTx:gamma_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='DELTA'">
		<VRPTx:delta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:delta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='EPSILON'">
		<VRPTx:epsilon_violations_count><xsl:value-of select="@violations_count"/></VRPTx:epsilon_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ZETA'">
		<VRPTx:zeta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:zeta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU0' or @ang_rest_type='TAU0'">
		<VRPTx:nu0_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu0_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU1' or @ang_rest_type='TAU1'">
		<VRPTx:nu1_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu1_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU2' or @ang_rest_type='TAU2'">
		<VRPTx:nu2_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu2_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU3' or @ang_rest_type='TAU3'">
		<VRPTx:nu3_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu3_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU4' or @ang_rest_type='TAU4'">
		<VRPTx:nu4_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu4_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI21'">
		<VRPTx:chi21_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi21_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI22'">
		<VRPTx:chi22_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi22_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI31'">
		<VRPTx:chi31_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi31_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI32'">
		<VRPTx:chi32_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi32_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI42'">
		<VRPTx:chi42_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi42_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI'">
		<VRPTx:chi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ETA'">
		<VRPTx:eta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:eta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='THETA'">
		<VRPTx:theta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:theta_violations_count>
	      </xsl:when>
	      <xsl:when test='@ang_rest_type="ETA&apos;"'>
		<VRPTx:eta_prime_violations_count><xsl:value-of select="@violations_count"/></VRPTx:eta_prime_violations_count>
	      </xsl:when>
	      <xsl:when test='@ang_rest_type="THETA&apos;"'>
		<VRPTx:theta_prime_violations_count><xsl:value-of select="@violations_count"/></VRPTx:theta_prime_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='.' or @ang_rest_type='PPA' or @ang_rest_type='VEANgle'">
		<VRPTx:other_violations_count><xsl:value-of select="@violations_count"/></VRPTx:other_violations_count>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Dihedral angle restraint type, <xsl:value-of select="@ang_rest_type"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_dihedral_angle_violation_model>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_in_ensemble">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory>
      <xsl:for-each select="dihedralangle_violation_in_ensemble">
	<VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble fraction_ensemble_size="{@fraction_of_ensemble_count}">
	  <xsl:choose>
	  <xsl:when test="@fraction_of_ensemble_percent"> <!-- v5.01 or later -->
	    <VRPTx:fraction_ensemble_percent><xsl:value-of select="@fraction_of_ensemble_percent"/></VRPTx:fraction_ensemble_percent>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	    <VRPTx:fraction_ensemble_percent><xsl:value-of select="format-number(number(@fraction_of_ensemble_count) div number($nmr_models) * 100.0,'0.0')"/></VRPTx:fraction_ensemble_percent>
	  </xsl:otherwise>
	  </xsl:choose>
	  <xsl:for-each select="ang_rest_types">
	    <xsl:choose>
	      <xsl:when test="@ang_rest_type='Total'">
		<VRPTx:violations_count><xsl:value-of select="@violations_count"/></VRPTx:violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='PHI'">
		<VRPTx:phi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:phi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='PSI'">
		<VRPTx:psi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:psi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='OMEGA'">
		<VRPTx:omega_violations_count><xsl:value-of select="@violations_count"/></VRPTx:omega_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI1'">
		<VRPTx:chi1_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi1_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI2'">
		<VRPTx:chi2_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi2_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI3'">
		<VRPTx:chi3_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi3_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI4'">
		<VRPTx:chi4_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi4_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI5'">
		<VRPTx:chi5_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi5_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ALPHA'">
		<VRPTx:alpha_violations_count><xsl:value-of select="@violations_count"/></VRPTx:alpha_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='BETA'">
		<VRPTx:beta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:beta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='GAMMA'">
		<VRPTx:gamma_violations_count><xsl:value-of select="@violations_count"/></VRPTx:gamma_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='DELTA'">
		<VRPTx:delta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:delta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='EPSILON'">
		<VRPTx:epsilon_violations_count><xsl:value-of select="@violations_count"/></VRPTx:epsilon_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ZETA'">
		<VRPTx:zeta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:zeta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU0' or @ang_rest_type='TAU0'">
		<VRPTx:nu0_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu0_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU1' or @ang_rest_type='TAU1'">
		<VRPTx:nu1_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu1_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU2' or @ang_rest_type='TAU2'">
		<VRPTx:nu2_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu2_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU3' or @ang_rest_type='TAU3'">
		<VRPTx:nu3_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu3_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='NU4' or @ang_rest_type='TAU4'">
		<VRPTx:nu4_violations_count><xsl:value-of select="@violations_count"/></VRPTx:nu4_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI21'">
		<VRPTx:chi21_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi21_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI22'">
		<VRPTx:chi22_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi22_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI31'">
		<VRPTx:chi31_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi31_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI32'">
		<VRPTx:chi32_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi32_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI42'">
		<VRPTx:chi42_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi42_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='CHI'">
		<VRPTx:chi_violations_count><xsl:value-of select="@violations_count"/></VRPTx:chi_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='ETA'">
		<VRPTx:eta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:eta_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='THETA'">
		<VRPTx:theta_violations_count><xsl:value-of select="@violations_count"/></VRPTx:theta_violations_count>
	      </xsl:when>
	      <xsl:when test='@ang_rest_type="ETA&apos;"'>
		<VRPTx:eta_prime_violations_count><xsl:value-of select="@violations_count"/></VRPTx:eta_prime_violations_count>
	      </xsl:when>
	      <xsl:when test='@ang_rest_type="THETA&apos;"'>
		<VRPTx:theta_prime_violations_count><xsl:value-of select="@violations_count"/></VRPTx:theta_prime_violations_count>
	      </xsl:when>
	      <xsl:when test="@ang_rest_type='.' or @ang_rest_type='PPA' or @ang_rest_type='VEANgle'">
		<VRPTx:other_violations_count><xsl:value-of select="@violations_count"/></VRPTx:other_violations_count>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Dihedral angle restraint type, <xsl:value-of select="@ang_rest_type"/>, is not listed in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="most_violated_dihedralangle_restraints">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory>
      <xsl:for-each select="most_violated_dihedralangle_restraint">
	<VRPTx:pdbx_nmr_dihedral_angle_violation_plural ordinal="{position()}">
	  <VRPTx:list_id><xsl:value-of select="@rlist_id"/></VRPTx:list_id>
	  <VRPTx:restraint_id><xsl:value-of select="@rest_id"/></VRPTx:restraint_id>
	  <VRPTx:violation_models_count><xsl:value-of select="@violated_models"/></VRPTx:violation_models_count>
	  <VRPTx:average_violation><xsl:value-of select="@mean_angle_violation"/></VRPTx:average_violation>
	  <VRPTx:median_violation><xsl:value-of select="@median_violation"/></VRPTx:median_violation>
	  <VRPTx:standard_deviation><xsl:value-of select="@standard_deviation"/></VRPTx:standard_deviation>
	  <VRPTx:entity_id><xsl:value-of select="@ent_1"/></VRPTx:entity_id>
	  <VRPTx:auth_asym_id><xsl:value-of select="@chain_1"/></VRPTx:auth_asym_id>
	  <VRPTx:auth_seq_id_1><xsl:value-of select="@resnum_1"/></VRPTx:auth_seq_id_1>
	  <VRPTx:auth_seq_id_2><xsl:value-of select="@resnum_2"/></VRPTx:auth_seq_id_2>
	  <VRPTx:auth_seq_id_3><xsl:value-of select="@resnum_3"/></VRPTx:auth_seq_id_3>
	  <VRPTx:auth_seq_id_4><xsl:value-of select="@resnum_4"/></VRPTx:auth_seq_id_4>
	  <VRPTx:auth_comp_id_1><xsl:value-of select="@resname_1"/></VRPTx:auth_comp_id_1>
	  <VRPTx:auth_comp_id_2><xsl:value-of select="@resname_2"/></VRPTx:auth_comp_id_2>
	  <VRPTx:auth_comp_id_3><xsl:value-of select="@resname_3"/></VRPTx:auth_comp_id_3>
	  <VRPTx:auth_comp_id_4><xsl:value-of select="@resname_4"/></VRPTx:auth_comp_id_4>
	  <xsl:variable name="icode_1"><xsl:value-of select="translate(@icode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_2"><xsl:value-of select="translate(@icode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_3"><xsl:value-of select="translate(@icode_3,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_4"><xsl:value-of select="translate(@icode_4,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_1"><xsl:value-of select="translate(@altcode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_2"><xsl:value-of select="translate(@altcode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_3"><xsl:value-of select="translate(@altcode_3,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_4"><xsl:value-of select="translate(@altcode_4,'?.','  ')"/></xsl:variable>
	  <xsl:choose>
	  <xsl:when test="@atom_1"> <!-- v5.01 or later -->
	  <VRPTx:auth_atom_id_1><xsl:value-of select="@atom_1"/></VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2><xsl:value-of select="@atom_2"/></VRPTx:auth_atom_id_2>
	  <VRPTx:auth_atom_id_3><xsl:value-of select="@atom_3"/></VRPTx:auth_atom_id_3>
	  <VRPTx:auth_atom_id_4><xsl:value-of select="@atom_4"/></VRPTx:auth_atom_id_4>
	  </xsl:when>
	  <xsl:otherwise>
	  <VRPTx:auth_atom_id_1>?</VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2>?</VRPTx:auth_atom_id_2>
	  <VRPTx:auth_atom_id_3>?</VRPTx:auth_atom_id_3>
	  <VRPTx:auth_atom_id_4>?</VRPTx:auth_atom_id_4>
	  </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:label_asym_id><xsl:value-of select="@said_1"/></VRPTx:label_asym_id>
	  <VRPTx:label_seq_id_1><xsl:value-of select="@seq_1"/></VRPTx:label_seq_id_1>
	  <VRPTx:label_seq_id_2><xsl:value-of select="@seq_2"/></VRPTx:label_seq_id_2>
	  <VRPTx:label_seq_id_3><xsl:value-of select="@seq_3"/></VRPTx:label_seq_id_3>
	  <VRPTx:label_seq_id_4><xsl:value-of select="@seq_4"/></VRPTx:label_seq_id_4>
	  <VRPTx:PDB_ins_code_1><xsl:value-of select="translate($icode_1,' ','?')"/></VRPTx:PDB_ins_code_1>
	  <VRPTx:PDB_ins_code_2><xsl:value-of select="translate($icode_2,' ','?')"/></VRPTx:PDB_ins_code_2>
	  <VRPTx:PDB_ins_code_3><xsl:value-of select="translate($icode_3,' ','?')"/></VRPTx:PDB_ins_code_3>
	  <VRPTx:PDB_ins_code_4><xsl:value-of select="translate($icode_4,' ','?')"/></VRPTx:PDB_ins_code_4>
	  <VRPTx:label_alt_id_1><xsl:value-of select="translate($altcode_1,' ','.')"/></VRPTx:label_alt_id_1>
	  <VRPTx:label_alt_id_2><xsl:value-of select="translate($altcode_2,' ','.')"/></VRPTx:label_alt_id_2>
	  <VRPTx:label_alt_id_3><xsl:value-of select="translate($altcode_3,' ','.')"/></VRPTx:label_alt_id_3>
	  <VRPTx:label_alt_id_4><xsl:value-of select="translate($altcode_4,' ','.')"/></VRPTx:label_alt_id_4>
	</VRPTx:pdbx_nmr_dihedral_angle_violation_plural>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="violated_dihedralangle_restraints">
    <xsl:if test="node()">
    <VRPTx:pdbx_nmr_dihedral_angle_violationCategory>
      <xsl:for-each select="violated_dihedralangle_restraint">
	<VRPTx:pdbx_nmr_dihedral_angle_violation ordinal="{position()}">
	  <VRPTx:list_id><xsl:value-of select="@rlist_id"/></VRPTx:list_id>
	  <VRPTx:restraint_id><xsl:value-of select="@rest_id"/></VRPTx:restraint_id>
	  <VRPTx:PDB_model_num><xsl:value-of select="@model"/></VRPTx:PDB_model_num>
	  <VRPTx:violation><xsl:value-of select="@violation"/></VRPTx:violation>
	  <VRPTx:entity_id><xsl:value-of select="@ent_1"/></VRPTx:entity_id>
	  <VRPTx:auth_asym_id><xsl:value-of select="@chain_1"/></VRPTx:auth_asym_id>
	  <VRPTx:auth_seq_id_1><xsl:value-of select="@resnum_1"/></VRPTx:auth_seq_id_1>
	  <VRPTx:auth_seq_id_2><xsl:value-of select="@resnum_2"/></VRPTx:auth_seq_id_2>
	  <VRPTx:auth_seq_id_3><xsl:value-of select="@resnum_3"/></VRPTx:auth_seq_id_3>
	  <VRPTx:auth_seq_id_4><xsl:value-of select="@resnum_4"/></VRPTx:auth_seq_id_4>
	  <VRPTx:auth_comp_id_1><xsl:value-of select="@resname_1"/></VRPTx:auth_comp_id_1>
	  <VRPTx:auth_comp_id_2><xsl:value-of select="@resname_2"/></VRPTx:auth_comp_id_2>
	  <VRPTx:auth_comp_id_3><xsl:value-of select="@resname_3"/></VRPTx:auth_comp_id_3>
	  <VRPTx:auth_comp_id_4><xsl:value-of select="@resname_4"/></VRPTx:auth_comp_id_4>
	  <xsl:variable name="icode_1"><xsl:value-of select="translate(@icode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_2"><xsl:value-of select="translate(@icode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_3"><xsl:value-of select="translate(@icode_3,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="icode_4"><xsl:value-of select="translate(@icode_4,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_1"><xsl:value-of select="translate(@altcode_1,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_2"><xsl:value-of select="translate(@altcode_2,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_3"><xsl:value-of select="translate(@altcode_3,'?.','  ')"/></xsl:variable>
	  <xsl:variable name="altcode_4"><xsl:value-of select="translate(@altcode_4,'?.','  ')"/></xsl:variable>
	  <xsl:choose>
	  <xsl:when test="@atom_1"> <!-- v5.01 or later -->
	  <VRPTx:auth_atom_id_1><xsl:value-of select="@atom_1"/></VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2><xsl:value-of select="@atom_2"/></VRPTx:auth_atom_id_2>
	  <VRPTx:auth_atom_id_3><xsl:value-of select="@atom_3"/></VRPTx:auth_atom_id_3>
	  <VRPTx:auth_atom_id_4><xsl:value-of select="@atom_4"/></VRPTx:auth_atom_id_4>
	  </xsl:when>
	  <xsl:otherwise> <!-- v005 -->
	  <VRPTx:auth_atom_id_1>?</VRPTx:auth_atom_id_1>
	  <VRPTx:auth_atom_id_2>?</VRPTx:auth_atom_id_2>
	  <VRPTx:auth_atom_id_3>?</VRPTx:auth_atom_id_3>
	  <VRPTx:auth_atom_id_4>?</VRPTx:auth_atom_id_4>
	  </xsl:otherwise>
	  </xsl:choose>
	  <VRPTx:label_asym_id><xsl:value-of select="@said_1"/></VRPTx:label_asym_id>
	  <VRPTx:label_seq_id_1><xsl:value-of select="@seq_1"/></VRPTx:label_seq_id_1>
	  <VRPTx:label_seq_id_2><xsl:value-of select="@seq_2"/></VRPTx:label_seq_id_2>
	  <VRPTx:label_seq_id_3><xsl:value-of select="@seq_3"/></VRPTx:label_seq_id_3>
	  <VRPTx:label_seq_id_4><xsl:value-of select="@seq_4"/></VRPTx:label_seq_id_4>
	  <VRPTx:PDB_ins_code_1><xsl:value-of select="translate($icode_1,' ','?')"/></VRPTx:PDB_ins_code_1>
	  <VRPTx:PDB_ins_code_2><xsl:value-of select="translate($icode_2,' ','?')"/></VRPTx:PDB_ins_code_2>
	  <VRPTx:PDB_ins_code_3><xsl:value-of select="translate($icode_3,' ','?')"/></VRPTx:PDB_ins_code_3>
	  <VRPTx:PDB_ins_code_4><xsl:value-of select="translate($icode_4,' ','?')"/></VRPTx:PDB_ins_code_4>
	  <VRPTx:label_alt_id_1><xsl:value-of select="translate($altcode_1,' ','.')"/></VRPTx:label_alt_id_1>
	  <VRPTx:label_alt_id_2><xsl:value-of select="translate($altcode_2,' ','.')"/></VRPTx:label_alt_id_2>
	  <VRPTx:label_alt_id_3><xsl:value-of select="translate($altcode_3,' ','.')"/></VRPTx:label_alt_id_3>
	  <VRPTx:label_alt_id_4><xsl:value-of select="translate($altcode_4,' ','.')"/></VRPTx:label_alt_id_4>
	</VRPTx:pdbx_nmr_dihedral_angle_violation>
      </xsl:for-each>
    </VRPTx:pdbx_nmr_dihedral_angle_violationCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template match="programs">
    <VRPTx:pdbx_validation_softwareCategory>
      <xsl:for-each select="program">
      <VRPTx:pdbx_validation_software>
	<xsl:attribute name="ordinal"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:name"><xsl:value-of select="@name"/></xsl:element>
	<xsl:element name="VRPTx:version"><xsl:value-of select="@version"/></xsl:element>
	<xsl:element name="VRPTx:classification">
	  <xsl:choose>
	    <xsl:when test="@name='chemicalshifts'">assessment of nmr assigned chemical shifts</xsl:when>
	    <xsl:when test="@name='chemicalshiftanalysis'">assessment of nmr assigned chemical shifts</xsl:when>
	    <xsl:when test="@name='coreclust'">assessment of nmr ensemble structure</xsl:when>
	    <xsl:when test="@name='dcc'">structure factor analysis and validation</xsl:when>
	    <xsl:when test="@name='eds'">refinement and validation package</xsl:when>
	    <xsl:when test="@name='mogul'">geometric validation</xsl:when>
	    <xsl:when test="@name='molprobity'">geometric validation</xsl:when>
	    <xsl:when test="@name='nmrwriter'">geometric validation of nmr ensemble structure</xsl:when>
	    <xsl:when test="@name='percentiles'">percentile rank calculation</xsl:when>
	    <xsl:when test="@name='validation-pack'">geometric validation</xsl:when>
	    <xsl:when test="@name='validation-pipeline'">mmcif data extractor</xsl:when>
	    <xsl:when test="@name='xtriage'">x-ray data assessment</xsl:when>
	    <xsl:when test="@name='buster-report'">geometric validation package for ligand chemistry in protein x-ray structures</xsl:when>
	    <xsl:when test="@name='visualanalysis'">em map-model validation package</xsl:when>
	    <xsl:when test="@name='chimera'">em map-model validation package</xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
Program name, <xsl:value-of select="@name"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:element>
	<xsl:element name="VRPTx:details"><xsl:value-of select="@properties"/></xsl:element>
      </VRPTx:pdbx_validation_software>
      </xsl:for-each>

      <xsl:variable name="last_dcc_refine">
	<xsl:choose>
	  <xsl:when test="../Entry/@DCC_refinement_program"><xsl:value-of select="$count_programs+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$count_programs"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_ccp4">
	<xsl:choose>
	  <xsl:when test="../Entry/@CCP4version"><xsl:value-of select="$last_dcc_refine+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_dcc_refine"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_refmac">
	<xsl:choose>
	  <xsl:when test="../Entry/@RefmacVersion"><xsl:value-of select="$last_ccp4+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_ccp4"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_cyrange">
	<xsl:choose>
	  <xsl:when test="../Entry/@cyrange_version"><xsl:value-of select="$last_refmac+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_refmac"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_nmrclust">
	<xsl:choose>
	  <xsl:when test="../Entry/@nmrclust_version"><xsl:value-of select="$last_cyrange+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_cyrange"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_panav">
	<xsl:choose>
	  <xsl:when test="../Entry/@panav_version"><xsl:value-of select="$last_nmrclust+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_nmrclust"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_rci">
	<xsl:choose>
	  <xsl:when test="../Entry/@rci_version"><xsl:value-of select="$last_panav+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_panav"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_shiftchecker">
	<xsl:choose>
	  <xsl:when test="../Entry/@shiftchecker_version"><xsl:value-of select="$last_rci+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_rci"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:if test="$last_dcc_refine!=$count_programs">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_dcc_refine"/></xsl:attribute>
	  <xsl:element name="VRPTx:name"><xsl:value-of select="../Entry/@DCC_refinement_program"/></xsl:element>
	  <xsl:element name="VRPTx:version">unknown (associated with DCC package)</xsl:element>
	  <xsl:element name="VRPTx:classification">refinement</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_ccp4!=$last_dcc_refine">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_ccp4"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">CCP4</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@CCP4version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">data scaling and phasing</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_refmac!=$last_ccp4">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_refmac"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">Refmac</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@RefmacVersion"/></xsl:element>
	  <xsl:element name="VRPTx:classification">refinement</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_cyrange!=$last_refmac">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_cyrange"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">cyrange</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@cyrange_version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">domain identification of nmr ensemble structure</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_nmrclust!=$last_cyrange">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_nmrclust"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">nmrclust</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@nmrclust_version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">classification of nmr ensemble structure</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_panav!=$last_nmrclust">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_panav"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">panav</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@panav_version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">nmr chemical shift validation and reference correction</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_rci!=$last_panav">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_rci"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">rci</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@rci_version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">random coil index prediction from nmr chemical shifts</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_shiftchecker!=$last_rci">
	<VRPTx:pdbx_validation_software>
	  <xsl:attribute name="ordinal"><xsl:value-of select="$last_shiftchecker"/></xsl:attribute>
	  <xsl:element name="VRPTx:name">shiftchecker</xsl:element>
	  <xsl:element name="VRPTx:version"><xsl:value-of select="../Entry/@shiftchecker_version"/></xsl:element>
	  <xsl:element name="VRPTx:classification">nmr chemical shift validation</xsl:element>
	</VRPTx:pdbx_validation_software>
      </xsl:if>

    </VRPTx:pdbx_validation_softwareCategory>
  </xsl:template>

  <!-- Level 3 -->

  <!-- chemical_shift_list starts -->

  <xsl:template name="pdbx_missing_nmr_star_item">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="missing_nmrstar_tag">
	<VRPTx:pdbx_missing_nmr_star_item list_id="{$list_id}">
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:name"><xsl:value-of select="@nmrstar_tag"/></xsl:element>
	  <xsl:element name="VRPTx:description"><xsl:value-of select="@nmrstar_tag_description"/></xsl:element>
	</VRPTx:pdbx_missing_nmr_star_item>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_assigned_chem_shift_list">
    <xsl:param name="id"/>
    <xsl:for-each select="current()">
    <VRPTx:pdbx_nmr_assigned_chem_shift_list id="{$id}">
<!-- unmapped data items
<VRPTx:chem_shift_13C_err> xsd:decimal </VRPTx:chem_shift_13C_err> [0..1]
<VRPTx:chem_shift_15N_err> xsd:decimal </VRPTx:chem_shift_15N_err> [0..1]
<VRPTx:chem_shift_19F_err> xsd:decimal </VRPTx:chem_shift_19F_err> [0..1]
<VRPTx:chem_shift_1H_err> xsd:decimal </VRPTx:chem_shift_1H_err> [0..1]
<VRPTx:chem_shift_2H_err> xsd:decimal </VRPTx:chem_shift_2H_err> [0..1]
<VRPTx:chem_shift_31P_err> xsd:decimal </VRPTx:chem_shift_31P_err> [0..1]
-->
      <xsl:element name="VRPTx:data_file_name"><xsl:value-of select="@file_name"/></xsl:element>
      <xsl:element name="VRPTx:label"><xsl:value-of select="@block_name"/></xsl:element>
      <xsl:element name="VRPTx:nmr_star_consistency_flag">
	  <xsl:choose>
	    <xsl:when test="@type='full'">Y</xsl:when>
	    <xsl:when test="@name='partial'">N</xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="error_handler">
		<xsl:with-param name="terminate">yes</xsl:with-param>
		<xsl:with-param name="error_message">
chemical shift list type, <xsl:value-of select="@type"/>, is not listed in XSLT code.
		</xsl:with-param>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
      </xsl:element>
      <xsl:element name="VRPTx:number_chem_shifts"><xsl:value-of select="@total_number_of_shifts"/></xsl:element>
      <xsl:element name="VRPTx:number_map_errors"><xsl:value-of select="@number_of_errors_while_mapping"/></xsl:element>
      <xsl:element name="VRPTx:number_map_warnings"><xsl:value-of select="@number_of_warnings_while_mapping"/></xsl:element>
      <xsl:element name="VRPTx:number_mapped_chem_shifts"><xsl:value-of select="@number_of_mapped_shifts"/></xsl:element>
      <xsl:element name="VRPTx:number_parsed_chem_shifts"><xsl:value-of select="@number_of_parsed_shifts"/></xsl:element>
      <xsl:element name="VRPTx:number_unparsed_chem_shifts"><xsl:value-of select="@number_of_unparsed_shifts"/></xsl:element>
    </VRPTx:pdbx_nmr_assigned_chem_shift_list>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_annotation">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="random_coil_index">
	<VRPTx:pdbx_nmr_chem_shift_annotation list_id="{$list_id}">
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	  <xsl:element name="VRPTx:random_coil_index"><xsl:value-of select="@value"/></xsl:element>
	</VRPTx:pdbx_nmr_chem_shift_annotation>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_well_defined">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="assignment_completeness_well_defined">
	<xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
	<xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
	<VRPTx:pdbx_nmr_chem_shift_completeness list_id="{$list_id}">
	  <xsl:attribute name="atom_group"><xsl:value-of select="$atom_group"/></xsl:attribute>
	  <xsl:attribute name="atom_type"><xsl:value-of select="$atom_type"/></xsl:attribute>
	  <xsl:element name="VRPTx:number_assigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
	  <xsl:element name="VRPTx:number_target_shifts_well_formed"><xsl:value-of select="@number_of_shifts"/></xsl:element>
	  <xsl:element name="VRPTx:number_unassigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
	  <xsl:for-each select="../assignment_completeness_full_length[@type=$atom_group and @element=$atom_type]">
	    <xsl:element name="VRPTx:number_assigned_chem_shifts"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
	    <xsl:element name="VRPTx:number_target_shifts"><xsl:value-of select="@number_of_shifts"/></xsl:element>
	    <xsl:element name="VRPTx:number_unassigned_chem_shifts"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_chem_shift_completeness>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_full_length">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="assignment_completeness_full_length">
	<xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
	<xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
	<VRPTx:pdbx_nmr_chem_shift_completeness list_id="{$list_id}">
	  <xsl:attribute name="atom_group"><xsl:value-of select="$atom_group"/></xsl:attribute>
	  <xsl:attribute name="atom_type"><xsl:value-of select="$atom_type"/></xsl:attribute>
	  <xsl:element name="VRPTx:number_assigned_chem_shifts"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
	  <xsl:element name="VRPTx:number_target_shifts"><xsl:value-of select="@number_of_shifts"/></xsl:element>
	  <xsl:element name="VRPTx:number_unassigned_chem_shifts"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
	  <xsl:for-each select="../assignment_completeness_well_defined[@type=$atom_group and @element=$atom_type]">
	    <xsl:element name="VRPTx:number_assigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
	    <xsl:element name="VRPTx:number_target_shifts_well_formed"><xsl:value-of select="@number_of_shifts"/></xsl:element>
	    <xsl:element name="VRPTx:number_unassigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
	  </xsl:for-each>
	</VRPTx:pdbx_nmr_chem_shift_completeness>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_re_offset">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="referencing_offset">
	<VRPTx:pdbx_nmr_chem_shift_re_offset list_id="{$list_id}">
	  <xsl:attribute name="atom_type"><xsl:value-of select="@atom"/></xsl:attribute>
	  <xsl:element name="VRPTx:correction_val"><xsl:value-of select="@value"/></xsl:element>
	  <xsl:element name="VRPTx:correction_val_err"><xsl:value-of select="@uncertainty"/></xsl:element>
	  <xsl:element name="VRPTx:correction_val_esd"><xsl:value-of select="@precision"/></xsl:element>
	  <xsl:element name="VRPTx:number_chem_shifts"><xsl:value-of select="@number_of_measurements"/></xsl:element>
	</VRPTx:pdbx_nmr_chem_shift_re_offset>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_unmapped_chem_shift">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="unmapped_chemical_shift">
	<VRPTx:pdbx_nmr_unmapped_chem_shift list_id="{$list_id}">
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	  <xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
	  <xsl:element name="VRPTx:val"><xsl:value-of select="@value"/></xsl:element>
	  <xsl:if test="@error and @error!='?' and @error!='.'">
	    <xsl:element name="VRPTx:val_err"><xsl:value-of select="@error"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@ambiguity and @ambiguity=('1','2','3','4','5','6','9')">
	    <xsl:element name="VRPTx:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:details"><xsl:value-of select="@diagnostic"/></xsl:element>
	</VRPTx:pdbx_nmr_unmapped_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_unparsed_chem_shift">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="unparsed_chemical_shift">
	<VRPTx:pdbx_nmr_unparsed_chem_shift list_id="{$list_id}">
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:if test="@id and @id!='?' and @id!='.'">
	    <xsl:element name="VRPTx:chem_shift_id"><xsl:value-of select="@id"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	  <xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
	  <xsl:element name="VRPTx:val"><xsl:value-of select="@value"/></xsl:element>
	  <xsl:if test="@error and @error!='?' and @error!='.'">
	    <xsl:element name="VRPTx:val_err"><xsl:value-of select="@error"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@ambiguity and @ambiguity=('1','2','3','4','5','6','9')">
	    <xsl:element name="VRPTx:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:details"><xsl:value-of select="@diagnostic"/></xsl:element>
	</VRPTx:pdbx_nmr_unparsed_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_validate_nmr_chem_shift">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="chemical_shift_outlier">
	<VRPTx:pdbx_validate_nmr_chem_shift list_id="{$list_id}">
	  <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	  <xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
	  <xsl:element name="VRPTx:val"><xsl:value-of select="@value"/></xsl:element>
	  <xsl:element name="VRPTx:target_val"><xsl:value-of select="@prediction"/></xsl:element>
	  <xsl:element name="VRPTx:Zscore"><xsl:value-of select="@zscore"/></xsl:element>
	  <xsl:element name="VRPTx:method"><xsl:value-of select="@method"/></xsl:element>
	</VRPTx:pdbx_validate_nmr_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- chemical_shift_list ends -->

  <xsl:template name="pdbx_percentile_list">
    <VRPTx:pdbx_percentile_listCategory>
      <VRPTx:pdbx_percentile_list entry_id="{$entry_id}">
	<xsl:element name="VRPTx:name"><xsl:value-of select="current()/@percentilebins"/></xsl:element>
      </VRPTx:pdbx_percentile_list>
    </VRPTx:pdbx_percentile_listCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_view">
    <VRPTx:pdbx_percentile_viewCategory>

      <xsl:variable name="last_view_abs_rna">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-RNAsuiteness">1</xsl:when>
	  <xsl:otherwise>0</xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_rna">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-RNAsuiteness"><xsl:value-of select="$last_view_abs_rna+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_rna"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_abs_clash">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-clashscore"><xsl:value-of select="$last_view_rel_rna+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_rel_rna"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_clash">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-clashscore"><xsl:value-of select="$last_view_abs_clash+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_clash"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_abs_rama">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-percent-rama-outliers"><xsl:value-of select="$last_view_rel_clash+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_rel_clash"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_rama">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-percent-rama-outliers"><xsl:value-of select="$last_view_abs_rama+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_rama"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_abs_rota">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-percent-rota-outliers"><xsl:value-of select="$last_view_rel_rama+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_rel_rama"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_rota">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-percent-rota-outliers"><xsl:value-of select="$last_view_abs_rota+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_rota"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_abs_rfree">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-DCC_Rfree"><xsl:value-of select="$last_view_rel_rota+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_rel_rota"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_rfree">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-DCC_Rfree"><xsl:value-of select="$last_view_abs_rfree+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_rfree"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_abs_rsrz">
	<xsl:choose>
	  <xsl:when test="@absolute-percentile-percent-RSRZ-outliers"><xsl:value-of select="$last_view_rel_rfree+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_rel_rfree"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:variable name="last_view_rel_rsrz">
	<xsl:choose>
	  <xsl:when test="@relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$last_view_abs_rsrz+1"/></xsl:when>
	  <xsl:otherwise><xsl:value-of select="$last_view_abs_rsrz"/></xsl:otherwise>
	</xsl:choose>
      </xsl:variable>

      <xsl:if test="@absolute-percentile-RNAsuiteness">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rna}" type="RNA_suiteness_score">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-RNAsuiteness"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-RNAsuiteness">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rna}" type="RNA_suiteness_score">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-RNAsuiteness"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-clashscore">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_clash}" type="all_atom_clashscore">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-clashscore"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-clashscore">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_clash}" type="all_atom_clashscore">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-clashscore"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rama-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rama}" type="Ramachandran_outlier_percent">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-percent-rama-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rama-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rama}" type="Ramachandran_outlier_percent">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-percent-rama-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rota-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rota}" type="rotamer_outliers_percent">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-percent-rota-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rota-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rota}" type="rotamer_outliers_percent">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-percent-rota-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rfree}" type="R_value_R_free">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-DCC_Rfree"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rfree}" type="R_value_R_free">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-DCC_Rfree"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-RSRZ-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rsrz}" type="RSRZ_outliers_percent">
	  <xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-RSRZ-outliers">
	<VRPTx:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rsrz}" type="RSRZ_outliers_percent">
	  <xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	  <xsl:element name="VRPTx:rank"><xsl:value-of select="@relative-percentile-percent-RSRZ-outliers"/></xsl:element>
	</VRPTx:pdbx_percentile_view>
      </xsl:if>

    </VRPTx:pdbx_percentile_viewCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_conditions">
    <VRPTx:pdbx_percentile_conditionsCategory>

      <xsl:if test="@absolute-percentile-RNAsuiteness">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rna}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-RNAsuiteness"/></xsl:element>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-RNAsuiteness">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rna}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-RNAsuiteness"/></xsl:element>
	  <xsl:if test="@high-resol-relative-percentile-RNAsuiteness">
	    <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-RNAsuiteness"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@low-resol-relative-percentile-RNAsuiteness">
	    <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-RNAsuiteness"/></xsl:element>
	  </xsl:if>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-clashscore">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_clash}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-clashscore"/></xsl:element>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-clashscore">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_clash}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-clashscore"/></xsl:element>
	  <xsl:if test="@high-resol-relative-percentile-clashscore">
	    <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-clashscore"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@low-resol-relative-percentile-clashscore">
	    <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-clashscore"/></xsl:element>
	  </xsl:if>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:choose>
	<xsl:when test="@absolute-percentile-percent-rama-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rama}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rama-outliers"/></xsl:element>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_rama_percentile and @absolute_rama_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rama}"/>
	</xsl:when>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="@relative-percentile-percent-rama-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rama}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rama-outliers"/></xsl:element>
	    <xsl:if test="@high-resol-relative-percentile-percent-rama-outliers">
	      <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="@low-resol-relative-percentile-percent-rama-outliers">
	      <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_rama_percentile and @relative_rama_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rama}"/>
	</xsl:when>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="@absolute-percentile-percent-rota-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rota}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rota-outliers"/></xsl:element>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_sidechain_percentile and @absolute_sidechain_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rota}"/>
	</xsl:when>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="@relative-percentile-percent-rota-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rota}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rota-outliers"/></xsl:element>
	    <xsl:if test="@high-resol-relative-percentile-percent-rota-outliers">
	      <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="@low-resol-relative-percentile-percent-rota-outliers">
	      <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_sidechain_percentile and @relative_sidechain_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rota}"/>
	</xsl:when>
      </xsl:choose>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rfree}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-DCC_Rfree"/></xsl:element>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
	<VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rfree}">
	  <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-DCC_Rfree"/></xsl:element>
	  <xsl:if test="@high-resol-relative-percentile-DCC_Rfree">
	    <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-DCC_Rfree"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@low-resol-relative-percentile-DCC_Rfree">
	    <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-DCC_Rfree"/></xsl:element>
	  </xsl:if>
	</VRPTx:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:choose>
	<xsl:when test="@absolute-percentile-percent-RSRZ-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rsrz}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_abs_rsrz}"/>
	</xsl:when>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="@relative-percentile-percent-RSRZ-outliers">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rsrz}">
	    <xsl:element name="VRPTx:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
	    <xsl:if test="@high-resol-relative-percentile-percent-RSRZ-outliers">
	      <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="@low-resol-relative-percentile-percent-RSRZ-outliers">
	      <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_percentile_conditions>
	</xsl:when>
	<xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable']">
	  <VRPTx:pdbx_percentile_conditions id="{$last_cond_rel_rsrz}"/>
	</xsl:when>
      </xsl:choose>

    </VRPTx:pdbx_percentile_conditionsCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_entity_view">

    <xsl:if test="@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rsrz}" type="RSRZ_outliers_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute_RSRZ_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_RSRZ_percentile and @relative_RSRZ_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rsrz}" type="RSRZ_outliers_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@relative_RSRZ_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_rama_percentile and @absolute_rama_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rama}" type="Ramachandran_outlier_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute_rama_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_rama_percentile and @relative_rama_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rama}" type="Ramachandran_outlier_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@relative_rama_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_sidechain_percentile and @absolute_sidechain_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rota}" type="rotamer_outliers_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">absolute</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@absolute_sidechain_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_sidechain_percentile and @relative_sidechain_percentile!='NotAvailable'">
      <VRPTx:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rota}" type="rotamer_outliers_percent">
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:conditions_label">relative</xsl:element>
	<xsl:element name="VRPTx:rank"><xsl:value-of select="@relative_sidechain_percentile"/></xsl:element>
      </VRPTx:pdbx_percentile_entity_view>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pdbx_dcc_density">
    <xsl:if test="$dcc_version!=''">
      <VRPTx:pdbx_dcc_densityCategory>
	<VRPTx:pdbx_dcc_density entry_id="{$entry_id}">
	  <xsl:if test="@babinet_b">
	    <xsl:element name="VRPTx:B_babinet"><xsl:value-of select="@babinet_b"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@bulk_solvent_b">
	    <xsl:element name="VRPTx:B_solvent"><xsl:value-of select="@bulk_solvent_b"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@WilsonBestimate">
	    <xsl:element name="VRPTx:B_wilson"><xsl:value-of select="@WilsonBestimate"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:DCC_version"><xsl:value-of select="$dcc_version"/></xsl:element>
	  <xsl:if test="@IoverSigma">
	    <xsl:element name="VRPTx:I_over_sigI_resh"><xsl:value-of select="substring-before(@IoverSigma,'(')"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@numMillerIndices">
	    <xsl:element name="VRPTx:reflns_number_obs"><xsl:value-of select="@numMillerIndices"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@babinet_k">
	    <xsl:element name="VRPTx:K_babinet"><xsl:value-of select="@babinet_k"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@bulk_solvent_k">
	    <xsl:element name="VRPTx:K_solvent"><xsl:value-of select="@bulk_solvent_k"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@TwinL">
	    <xsl:element name="VRPTx:Padilla-Yeates_L_mean"><xsl:value-of select="@TwinL"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@TwinL2">
	    <xsl:element name="VRPTx:Padilla-Yeates_L2_mean"><xsl:value-of select="@TwinL2"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@DCC_R and @DCC_R!='NotAvailable'">
	    <xsl:element name="VRPTx:R_value_R_work"><xsl:value-of select="@DCC_R"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@DCC_Rfree and @DCC_Rfree!='NotAvailable'">
	    <xsl:element name="VRPTx:R_value_R_free"><xsl:value-of select="@DCC_Rfree"/></xsl:element>
	    <xsl:element name="VRPTx:Rfree-Rwork"><xsl:value-of select="format-number(number(@DCC_Rfree)-number(@DCC_R),'0.00')"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@WilsonBaniso">
	    <xsl:for-each select="tokenize(replace(normalize-space(@WilsonBaniso),'[\[\]]',''),',')">
	      <xsl:choose>
		<xsl:when test="position()=1">
		  <xsl:element name="VRPTx:aniso_B11"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:when test="position()=2">
		  <xsl:element name="VRPTx:aniso_B22"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:when test="position()=3">
		  <xsl:element name="VRPTx:aniso_B33"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:when test="position()=4">
		  <xsl:element name="VRPTx:aniso_B12"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:when test="position()=5">
		  <xsl:element name="VRPTx:aniso_B13"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:when test="position()=6">
		  <xsl:element name="VRPTx:aniso_B23"><xsl:value-of select="."/></xsl:element>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:call-template name="error_handler">
		    <xsl:with-param name="terminate">yes</xsl:with-param>
		    <xsl:with-param name="error_message">
Unmatched components exist in WilsonBaniso, <xsl:value-of select="position()"/>, found in XSLT code.
		    </xsl:with-param>
		  </xsl:call-template>
		</xsl:otherwise>
	      </xsl:choose>
	    </xsl:for-each>
	  </xsl:if>
	  <xsl:if test="@DataAnisotropy">
	    <xsl:element name="VRPTx:anisotropy"><xsl:value-of select="@DataAnisotropy"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@TransNCS">
	    <xsl:element name="VRPTx:error"><xsl:value-of select="@TransNCS"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:iso_B_value_type"><xsl:value-of select="lower-case(@B_factor_type)"/></xsl:element>
	  <xsl:if test="@PDB-resolution and @PDB-resolution!='NotAvailable'">
	    <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@PDB-resolution"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@PDB-resolution-low and @PDB-resolution-low!='NotAvailable'">
	    <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@PDB-resolution-low"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@acentric_outliers">
	    <xsl:element name="VRPTx:reflns_outlier_acentric"><xsl:value-of select="@acentric_outliers"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@centric_outliers">
	    <xsl:element name="VRPTx:reflns_outlier_centric"><xsl:value-of select="@centric_outliers"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@TwinFraction">
	    <xsl:variable name="twin_operator">
	      <xsl:for-each select="tokenize(normalize-space(@TwinFraction),';')">
		<xsl:value-of select="concat(substring-before(.,':'),' ')"/>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:variable name="twin_fraction">
	      <xsl:for-each select="tokenize(normalize-space(@TwinFraction),';')">
		<xsl:value-of select="concat(substring-after(.,':'),' ')"/>
	      </xsl:for-each>
	    </xsl:variable>
	    <xsl:element name="VRPTx:twin_fraction_xtriage"><xsl:value-of select="normalize-space($twin_fraction)"/></xsl:element>
	    <xsl:element name="VRPTx:twin_operator_xtriage"><xsl:value-of select="normalize-space($twin_operator)"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@DataCompleteness">
	    <xsl:element name="VRPTx:ls_percent_reflns_obs"><xsl:value-of select="@DataCompleteness"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@num-free-reflections">
	    <xsl:element name="VRPTx:ls_number_reflns_R_free"><xsl:value-of select="@num-free-reflections"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@percent-free-reflections">
	    <xsl:element name="VRPTx:ls_percent_reflns_R_free"><xsl:value-of select="@percent-free-reflections"/></xsl:element>
	  </xsl:if>
	  <xsl:variable name="wavelength"><xsl:value-of select="$ext_datablock/VRPTx:diffrn_radiation_wavelengthCategory/VRPTx:diffrn_radiation_wavelength[1]/VRPTx:wavelength"/></xsl:variable>
	  <xsl:if test="$wavelength!=''">
	    <xsl:element name="VRPTx:wavelength"><xsl:value-of select="$wavelength"/></xsl:element>
	  </xsl:if>
<!-- unmapped data items
<VRPTx:B_wilson_scale> xsd:decimal </VRPTx:B_wilson_scale> [0..1]
<VRPTx:Biso_max> xsd:decimal </VRPTx:Biso_max> [0..1]
<VRPTx:Biso_mean> xsd:decimal </VRPTx:Biso_mean> [0..1]
<VRPTx:Biso_min> xsd:decimal </VRPTx:Biso_min> [0..1]
<VRPTx:Bmean-Bwilson> xsd:decimal </VRPTx:Bmean-Bwilson> [0..1]
<VRPTx:Cruickshank_dpi_xyz> xsd:decimal </VRPTx:Cruickshank_dpi_xyz> [0..1]
<VRPTx:I_over_sigI_diff> xsd:decimal </VRPTx:I_over_sigI_diff> [0..1]
<VRPTx:I_over_sigI_mean> xsd:decimal </VRPTx:I_over_sigI_mean> [0..1]
<VRPTx:Matthew_coeff> xsd:decimal </VRPTx:Matthew_coeff> [0..1]
<VRPTx:Padilla-Yeates_L2_mean_pointless> xsd:decimal </VRPTx:Padilla-Yeates_L2_mean_pointless> [0..1]
<VRPTx:TLS_refinement_reported> xsd:string </VRPTx:TLS_refinement_reported> [0..1]
<VRPTx:Z-score> xsd:decimal </VRPTx:Z-score> [0..1]
<VRPTx:Z_score_L_test> xsd:decimal </VRPTx:Z_score_L_test> [0..1]
<VRPTx:correlation_overall> xsd:decimal </VRPTx:correlation_overall> [0..1]
<VRPTx:dpi_free_R> xsd:decimal </VRPTx:dpi_free_R> [0..1]
<VRPTx:fom> xsd:decimal </VRPTx:fom> [0..1]
<VRPTx:free_set_count> xsd:integer </VRPTx:free_set_count> [0..1]
<VRPTx:ice_ring> xsd:string </VRPTx:ice_ring> [0..1]
<VRPTx:mFo-DFc-3sigma_negative> xsd:integer </VRPTx:mFo-DFc-3sigma_negative> [0..1]
<VRPTx:mFo-DFc-3sigma_positive> xsd:integer </VRPTx:mFo-DFc-3sigma_positive> [0..1]
<VRPTx:mFo-DFc-6sigma_negative> xsd:integer </VRPTx:mFo-DFc-6sigma_negative> [0..1]
<VRPTx:mFo-DFc-6sigma_positive> xsd:integer </VRPTx:mFo-DFc-6sigma_positive> [0..1]
<VRPTx:mean_E2_1_abs> xsd:decimal </VRPTx:mean_E2_1_abs> [0..1]
<VRPTx:mean_F_square_over_mean_F2> xsd:decimal </VRPTx:mean_F_square_over_mean_F2> [0..1]
<VRPTx:mean_I2_over_mean_I_square> xsd:decimal </VRPTx:mean_I2_over_mean_I_square> [0..1]
<VRPTx:mtrix_number> xsd:integer </VRPTx:mtrix_number> [0..1]
<VRPTx:ncs_group_number> xsd:integer </VRPTx:ncs_group_number> [0..1]
<VRPTx:occupancy_max> xsd:decimal </VRPTx:occupancy_max> [0..1]
<VRPTx:occupancy_mean> xsd:decimal </VRPTx:occupancy_mean> [0..1]
<VRPTx:occupancy_min> xsd:decimal </VRPTx:occupancy_min> [0..1]
<VRPTx:partial_B_value_correction_attempted> xsd:string </VRPTx:partial_B_value_correction_attempted> [0..1]
<VRPTx:partial_B_value_correction_success> xsd:string </VRPTx:partial_B_value_correction_success> [0..1]
<VRPTx:pdbtype> xsd:string </VRPTx:pdbtype> [0..1]
<VRPTx:prob_peak_value> xsd:decimal </VRPTx:prob_peak_value> [0..1]
<VRPTx:real_space_R_overall> xsd:decimal </VRPTx:real_space_R_overall> [0..1]
<VRPTx:reflection_status_archived> xsd:string </VRPTx:reflection_status_archived> [0..1]
<VRPTx:reflection_status_used> xsd:string </VRPTx:reflection_status_used> [0..1]
<VRPTx:reflns_twin> xsd:string </VRPTx:reflns_twin> [0..1]
<VRPTx:solvent_content> xsd:decimal </VRPTx:solvent_content> [0..1]
<VRPTx:space_group_name_H-M> xsd:string </VRPTx:space_group_name_H-M> [0..1]
<VRPTx:space_group_pointless> xsd:string </VRPTx:space_group_pointless> [0..1]
<VRPTx:tls_group_number> xsd:integer </VRPTx:tls_group_number> [0..1]
<VRPTx:translational_pseudo_symmetry> xsd:string </VRPTx:translational_pseudo_symmetry> [0..1]
<VRPTx:twin_Rfactor> xsd:decimal </VRPTx:twin_Rfactor> [0..1]
<VRPTx:twin_by_xtriage> xsd:string </VRPTx:twin_by_xtriage> [0..1]
<VRPTx:twin_fraction> xsd:string </VRPTx:twin_fraction> [0..1]
<VRPTx:twin_operator> xsd:string </VRPTx:twin_operator> [0..1]
<VRPTx:twin_type> xsd:string </VRPTx:twin_type> [0..1]
<VRPTx:unit_cell> xsd:string </VRPTx:unit_cell> [0..1]
<VRPTx:working_set_count> xsd:integer </VRPTx:working_set_count> [0..1]
-->
	</VRPTx:pdbx_dcc_density>
      </VRPTx:pdbx_dcc_densityCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_density_corr">
    <xsl:if test="$dcc_version!=''">
      <VRPTx:pdbx_dcc_density_corrCategory>
	<VRPTx:pdbx_dcc_density_corr ordinal="1">
	  <VRPTx:program>EDS</VRPTx:program>
	  <xsl:if test="@EDS_resolution and @EDS_resolution!='NotAvailable'">
	    <xsl:element name="VRPTx:ls_d_res_high"><xsl:value-of select="@EDS_resolution"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@EDS_resolution_low and @EDS_resolution_low!='NotAvailable'">
	    <xsl:element name="VRPTx:ls_d_res_low"><xsl:value-of select="@EDS_resolution_low"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@EDS_R and @EDS_R!='NotAvailable'">
	    <xsl:element name="VRPTx:ls_R_factor_R_work"><xsl:value-of select="@EDS_R"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@numMillerIndices">
	    <xsl:element name="VRPTx:ls_number_reflns_obs"><xsl:value-of select="@numMillerIndices"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@DataCompleteness">
	    <xsl:element name="VRPTx:ls_percent_reflns_obs"><xsl:value-of select="@DataCompleteness"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@num-free-reflections">
	    <xsl:element name="VRPTx:ls_number_reflns_R_free"><xsl:value-of select="@num-free-reflections"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@percent-free-reflections">
	    <xsl:element name="VRPTx:ls_percent_reflns_R_free"><xsl:value-of select="@percent-free-reflections"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@Fo_Fc_correlation">
	    <xsl:element name="VRPTx:correlation_coeff_Fo_to_Fc"><xsl:value-of select="@Fo_Fc_correlation"/></xsl:element>
	  </xsl:if>
	</VRPTx:pdbx_dcc_density_corr>
      </VRPTx:pdbx_dcc_density_corrCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_geometry">
    <VRPTx:pdbx_dcc_geometryCategory>
      <VRPTx:pdbx_dcc_geometry entry_id="{$entry_id}">
	<xsl:if test="@RNAsuiteness">
	  <xsl:element name="VRPTx:RNA_suiteness_score"><xsl:value-of select="@RNAsuiteness"/></xsl:element>
	</xsl:if>
	<xsl:if test="@percent-rama-outliers">
	  <xsl:element name="VRPTx:Ramachandran_outlier_percent">
	    <xsl:choose>
	      <xsl:when test="$nmr=true()">
		<xsl:value-of select="@percent-rama-outliers-full-length"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="@percent-rama-outliers"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:element>
	  <xsl:if test="@percent-rama-outliers and $nmr=true()">
	    <xsl:element name="VRPTx:Ramachandran_outlier_percent_nmr_well_formed"><xsl:value-of select="@percent-rama-outliers"/></xsl:element>
	  </xsl:if>
	</xsl:if>
	<xsl:if test="@clashscore or ($nmr=true() and @clashscore-full-length)">
	  <xsl:element name="VRPTx:all_atom_clashscore">
	    <xsl:choose>
	      <xsl:when test="$nmr=true()">
		<xsl:value-of select="@clashscore-full-length"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="@clashscore"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:element>
	</xsl:if>
	<xsl:if test="@clashscore and $nmr=true()">
	  <xsl:element name="VRPTx:all_atom_clashscore_nmr_well_formed"><xsl:value-of select="@clashscore"/></xsl:element>
	</xsl:if>
	<xsl:if test="@angles_rmsz">
	  <xsl:element name="VRPTx:angle_overall_rmsz"><xsl:value-of select="@angles_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@bonds_rmsz">
	  <xsl:element name="VRPTx:bond_overall_rmsz"><xsl:value-of select="@bonds_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@num_angles_rmsz">
	  <xsl:element name="VRPTx:number_angles"><xsl:value-of select="@num_angles_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@num_bonds_rmsz">
	  <xsl:element name="VRPTx:number_bonds"><xsl:value-of select="@num_bonds_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@percent-rota-outliers">
	  <xsl:element name="VRPTx:rotamer_outliers_percent">
	    <xsl:choose>
	      <xsl:when test="$nmr=true()">
		<xsl:value-of select="@percent-rota-outliers-full-length"/>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:value-of select="@percent-rota-outliers"/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:element>
	  <xsl:if test="@percent-rota-outliers and $nmr=true()">
	    <xsl:element name="VRPTx:rotamer_outliers_percent_nmr_well_formed"><xsl:value-of select="@percent-rota-outliers"/></xsl:element>
	  </xsl:if>
	</xsl:if>
<!-- unmapped data items
<VRPTx:Ramachandran_allowed_number> xsd:integer </VRPTx:Ramachandran_allowed_number> [0..1]
<VRPTx:Ramachandran_allowed_percent> xsd:decimal </VRPTx:Ramachandran_allowed_percent> [0..1]
<VRPTx:Ramachandran_favored_number> xsd:integer </VRPTx:Ramachandran_favored_number> [0..1]
<VRPTx:Ramachandran_favored_percent> xsd:decimal </VRPTx:Ramachandran_favored_percent> [0..1]
<VRPTx:Ramachandran_outlier_number> xsd:integer </VRPTx:Ramachandran_outlier_number> [0..1]
<VRPTx:angle_ligand_max> xsd:decimal </VRPTx:angle_ligand_max> [0..1]
<VRPTx:angle_ligand_rms> xsd:decimal </VRPTx:angle_ligand_rms> [0..1]
<VRPTx:angle_overall_max> xsd:decimal </VRPTx:angle_overall_max> [0..1]
<VRPTx:angle_overall_rms> xsd:decimal </VRPTx:angle_overall_rms> [0..1]
<VRPTx:bond_ligand_max> xsd:decimal </VRPTx:bond_ligand_max> [0..1]
<VRPTx:bond_ligand_rms> xsd:decimal </VRPTx:bond_ligand_rms> [0..1]
<VRPTx:bond_overall_max> xsd:decimal </VRPTx:bond_overall_max> [0..1]
<VRPTx:bond_overall_rms> xsd:decimal </VRPTx:bond_overall_rms> [0..1]
<VRPTx:cbeta_deviations> xsd:integer </VRPTx:cbeta_deviations> [0..1]
<VRPTx:chirality_overall_max> xsd:decimal </VRPTx:chirality_overall_max> [0..1]
<VRPTx:chirality_overall_rms> xsd:decimal </VRPTx:chirality_overall_rms> [0..1]
<VRPTx:dihedral_overall_max> xsd:decimal </VRPTx:dihedral_overall_max> [0..1]
<VRPTx:dihedral_overall_rms> xsd:decimal </VRPTx:dihedral_overall_rms> [0..1]
<VRPTx:non-bonded_rms> xsd:decimal </VRPTx:non-bonded_rms> [0..1]
<VRPTx:overall_score> xsd:decimal </VRPTx:overall_score> [0..1]
<VRPTx:planarity_overall_max> xsd:decimal </VRPTx:planarity_overall_max> [0..1]
<VRPTx:planarity_overall_rms> xsd:decimal </VRPTx:planarity_overall_rms> [0..1]
<VRPTx:rotamer_outliers_number> xsd:integer </VRPTx:rotamer_outliers_number> [0..1]
-->
      </VRPTx:pdbx_dcc_geometry>
    </VRPTx:pdbx_dcc_geometryCategory>
  </xsl:template>

  <xsl:template name="pdbx_dcc_map_overall">
    <xsl:if test="@percent-RSRZ-outliers">
      <VRPTx:pdbx_dcc_map_overallCategory>
	<VRPTx:pdbx_dcc_map_overall entry_id="{$entry_id}">
	  <xsl:element name="VRPTx:RSRZ_outliers_percent"><xsl:value-of select="@percent-RSRZ-outliers"/></xsl:element>
	</VRPTx:pdbx_dcc_map_overall>
      </VRPTx:pdbx_dcc_map_overallCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_map">
    <xsl:if test="@rsr or @rsrz or @rscc">
      <VRPTx:pdbx_dcc_map>
	<xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	<xsl:if test="@altcode and @altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@icode and @icode!=' '">
	  <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="@icode"/></xsl:element>
	</xsl:if>
	<xsl:element name="VRPTx:Biso_mean"><xsl:value-of select="@owab"/></xsl:element>
	<xsl:if test="@ligRSRZ">
	  <xsl:element name="VRPTx:LLDFZ"><xsl:value-of select="@ligRSRZ"/></xsl:element>
	</xsl:if>
	<xsl:if test="@ligand_density_outlier='yes'">
	  <xsl:element name="VRPTx:LLDFZ_outlier_flag">Y</xsl:element>
	</xsl:if>
	<xsl:if test="@lig_rsrz_nbr_id">
	  <xsl:element name="VRPTx:LLDF_name"><xsl:value-of select="@lig_rsrz_nbr_id"/></xsl:element>
	</xsl:if>
	<xsl:if test="@ligRSRnumnbrs">
	  <xsl:element name="VRPTx:LLDF_number_residues_total"><xsl:value-of select="@ligRSRnumnbrs"/></xsl:element>
	</xsl:if>
	<xsl:if test="@ligRSRnbrMean">
	  <xsl:element name="VRPTx:LLDF"><xsl:value-of select="@ligRSRnbrMean"/></xsl:element>
	</xsl:if>
	<xsl:if test="@ligRSRnbrStdev">
	  <xsl:element name="VRPTx:LLDF_sigma"><xsl:value-of select="@ligRSRnbrStdev"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rscc">
	  <xsl:element name="VRPTx:RSCC"><xsl:value-of select="@rscc"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rsr">
	  <xsl:element name="VRPTx:RSR"><xsl:value-of select="@rsr"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rsrz">
	  <xsl:element name="VRPTx:RSRZ"><xsl:value-of select="@rsrz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@avgoccu">
	  <xsl:element name="VRPTx:occupancy_mean"><xsl:value-of select="@avgoccu"/></xsl:element>
	</xsl:if>
<!-- unmapped data items
<VRPTx:Biso_mean_main_chain> xsd:decimal </VRPTx:Biso_mean_main_chain> [0..1]
<VRPTx:Biso_mean_phosphate_group> xsd:decimal </VRPTx:Biso_mean_phosphate_group> [0..1]
<VRPTx:Biso_mean_side_chain> xsd:decimal </VRPTx:Biso_mean_side_chain> [0..1]
<VRPTx:RSCC_main_chain> xsd:decimal </VRPTx:RSCC_main_chain> [0..1]
<VRPTx:RSCC_phosphate_group> xsd:decimal </VRPTx:RSCC_phosphate_group> [0..1]
<VRPTx:RSCC_side_chain> xsd:decimal </VRPTx:RSCC_side_chain> [0..1]
<VRPTx:RSRZ_main_chain> xsd:decimal </VRPTx:RSRZ_main_chain> [0..1]
<VRPTx:RSRZ_phosphate_group> xsd:decimal </VRPTx:RSRZ_phosphate_group> [0..1]
<VRPTx:RSRZ_side_chain> xsd:decimal </VRPTx:RSRZ_side_chain> [0..1]
<VRPTx:RSR_main_chain> xsd:decimal </VRPTx:RSR_main_chain> [0..1]
<VRPTx:RSR_phosphate_group> xsd:decimal </VRPTx:RSR_phosphate_group> [0..1]
<VRPTx:RSR_side_chain> xsd:decimal </VRPTx:RSR_side_chain> [0..1]
<VRPTx:RSZD> xsd:decimal </VRPTx:RSZD> [0..1]
<VRPTx:RSZD_main_chain> xsd:decimal </VRPTx:RSZD_main_chain> [0..1]
<VRPTx:RSZD_phosphate_group> xsd:decimal </VRPTx:RSZD_phosphate_group> [0..1]
<VRPTx:RSZD_side_chain> xsd:decimal </VRPTx:RSZD_side_chain> [0..1]
<VRPTx:RSZO> xsd:decimal </VRPTx:RSZO> [0..1]
<VRPTx:RSZO_Zscore> xsd:decimal </VRPTx:RSZO_Zscore> [0..1]
<VRPTx:RSZO_main_chain> xsd:decimal </VRPTx:RSZO_main_chain> [0..1]
<VRPTx:RSZO_phosphate_group> xsd:decimal </VRPTx:RSZO_phosphate_group> [0..1]
<VRPTx:RSZO_side_chain> xsd:decimal </VRPTx:RSZO_side_chain> [0..1]
<VRPTx:density_connectivity> xsd:decimal </VRPTx:density_connectivity> [0..1]
<VRPTx:density_index_main_chain> xsd:decimal </VRPTx:density_index_main_chain> [0..1]
<VRPTx:density_index_side_chain> xsd:decimal </VRPTx:density_index_side_chain> [0..1]
<VRPTx:occupancy_mean_main_chain> xsd:decimal </VRPTx:occupancy_mean_main_chain> [0..1]
<VRPTx:occupancy_mean_phosphate_group> xsd:decimal </VRPTx:occupancy_mean_phosphate_group> [0..1]
<VRPTx:occupancy_mean_side_chain> xsd:decimal </VRPTx:occupancy_mean_side_chain> [0..1]
<VRPTx:quality_indicator> xsd:string </VRPTx:quality_indicator> [0..1]
<VRPTx:shift> xsd:decimal </VRPTx:shift> [0..1]
<VRPTx:shift_main_chain> xsd:decimal </VRPTx:shift_main_chain> [0..1]
<VRPTx:shift_side_chain> xsd:decimal </VRPTx:shift_side_chain> [0..1]
<VRPTx:wRSRZ_main_chain> xsd:decimal </VRPTx:wRSRZ_main_chain> [0..1]
<VRPTx:wRSRZ_phosphate_group> xsd:decimal </VRPTx:wRSRZ_phosphate_group> [0..1]
<VRPTx:wRSRZ_side_chain> xsd:decimal </VRPTx:wRSRZ_side_chain> [0..1]
<VRPTx:wRSR_main_chain> xsd:decimal </VRPTx:wRSR_main_chain> [0..1]
<VRPTx:wRSR_phosphate_group> xsd:decimal </VRPTx:wRSR_phosphate_group> [0..1]
<VRPTx:wRSR_side_chain> xsd:decimal </VRPTx:wRSR_side_chain> [0..1]
<VRPTx:weighted_RSR> xsd:decimal </VRPTx:weighted_RSR> [0..1]
<VRPTx:weighted_RSRZ> xsd:decimal </VRPTx:weighted_RSRZ> [0..1]
-->
    </VRPTx:pdbx_dcc_map>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_entity_geometry">
    <xsl:if test="@angles_rmsz or @bonds_rmsz">
      <VRPTx:pdbx_dcc_entity_geometry>
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:angle_overall_rmsz"><xsl:value-of select="@angles_rmsz"/></xsl:element>
	<xsl:element name="VRPTx:bond_overall_rmsz"><xsl:value-of select="@bonds_rmsz"/></xsl:element>
	<xsl:element name="VRPTx:number_angles"><xsl:value-of select="@num_angles_rmsz"/></xsl:element>
	<xsl:element name="VRPTx:number_bonds"><xsl:value-of select="@num_bonds_rmsz"/></xsl:element>
      </VRPTx:pdbx_dcc_entity_geometry>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_mon_geometry">
    <xsl:if test="@mogul_angles_rmsz or @mogul_bonds_rmsz">
      <VRPTx:pdbx_dcc_mon_geometry>
	<xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	<xsl:if test="@altcode and @altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@icode and @icode!=' '">
	  <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="@icode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@mogul_angles_rmsz">
	  <xsl:element name="VRPTx:angle_overall_rmsz"><xsl:value-of select="@mogul_angles_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@mogul_bonds_rmsz">
	  <xsl:element name="VRPTx:bond_overall_rmsz"><xsl:value-of select="@mogul_bonds_rmsz"/></xsl:element>
	</xsl:if>
	<xsl:if test="@mogul_rmsz_numangles">
	  <xsl:element name="VRPTx:number_angles"><xsl:value-of select="@mogul_rmsz_numangles"/></xsl:element>
	</xsl:if>
	<xsl:if test="@mogul_rmsz_numbonds">
	  <xsl:element name="VRPTx:number_bonds"><xsl:value-of select="@mogul_rmsz_numbonds"/></xsl:element>
	</xsl:if>
	<xsl:if test="@ligand_geometry_outlier='yes'">
	  <xsl:element name="VRPTx:LLDFZ_outlier_flag">Y</xsl:element>
	</xsl:if>
      </VRPTx:pdbx_dcc_mon_geometry>
    </xsl:if>
  </xsl:template>

  <xsl:template name="struct_mon_prot">
    <xsl:if test="@phi or @psi or @rama or @rota">
      <VRPTx:struct_mon_prot>
	<xsl:attribute name="pdbx_id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	<xsl:if test="@altcode and @altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rscc">
	  <xsl:element name="VRPTx:RSCC_all"><xsl:value-of select="@rscc"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rsr">
	  <xsl:element name="VRPTx:RSR_all"><xsl:value-of select="@rsr"/></xsl:element>
	</xsl:if>
	<xsl:if test="@owab">
	  <xsl:element name="VRPTx:mean_B_all"><xsl:value-of select="@owab"/></xsl:element>
	</xsl:if>
	<xsl:if test="@phi">
	  <xsl:element name="VRPTx:phi"><xsl:value-of select="@phi"/></xsl:element>
	</xsl:if>
	<xsl:if test="@psi">
	  <xsl:element name="VRPTx:psi"><xsl:value-of select="@psi"/></xsl:element>
	</xsl:if>
	<xsl:if test="count(plane-outlier/@omega)=1">
	  <xsl:element name="VRPTx:omega"><xsl:value-of select="plane-outlier/@omega"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rama">
	  <xsl:element name="VRPTx:pdbx_Ramachandran_region"><xsl:value-of select="@rama"/></xsl:element>
	</xsl:if>
	<xsl:if test="@flippable-sidechain='1'">
	  <xsl:element name="VRPTx:pdbx_flippable_side_chain">Y</xsl:element>
	</xsl:if>
	<xsl:if test="@rota">
	  <xsl:element name="VRPTx:pdbx_rotamer"><xsl:value-of select="@rota"/></xsl:element>
	</xsl:if>
<!-- unmapped data items
<VRPTx:RSCC_main> xsd:decimal </VRPTx:RSCC_main> [0..1]
<VRPTx:RSCC_side> xsd:decimal </VRPTx:RSCC_side> [0..1]
<VRPTx:RSR_main> xsd:decimal </VRPTx:RSR_main> [0..1]
<VRPTx:RSR_side> xsd:decimal </VRPTx:RSR_side> [0..1]
<VRPTx:chi1
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi1>
<VRPTx:chi2
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi2>
<VRPTx:chi3
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi3>
<VRPTx:chi4
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi4>
<VRPTx:chi5
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi5>
<VRPTx:details> xsd:decimal </VRPTx:details> [0..1]
<VRPTx:label_asym_id> xsd:string </VRPTx:label_asym_id> [0..1]
<VRPTx:label_comp_id> xsd:string </VRPTx:label_comp_id> [0..1]
<VRPTx:label_seq_id> xsd:string </VRPTx:label_seq_id> [0..1]
<VRPTx:mean_B_main> xsd:decimal </VRPTx:mean_B_main> [0..1]
<VRPTx:mean_B_side> xsd:decimal </VRPTx:mean_B_side> [0..1]
-->
      </VRPTx:struct_mon_prot>
    </xsl:if>
  </xsl:template>

  <xsl:template name="struct_mon_nucl">
    <xsl:if test="@RNApucker or @RNAsuite or @RNAscore">
      <VRPTx:struct_mon_nucl>
	<xsl:attribute name="pdbx_id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	<xsl:if test="@altcode and @altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rscc">
	  <xsl:element name="VRPTx:RSCC_all"><xsl:value-of select="@rscc"/></xsl:element>
	</xsl:if>
	<xsl:if test="@rsr">
	  <xsl:element name="VRPTx:RSR_all"><xsl:value-of select="@rsr"/></xsl:element>
	</xsl:if>
	<xsl:if test="@owab">
	  <xsl:element name="VRPTx:mean_B_all"><xsl:value-of select="@owab"/></xsl:element>
	</xsl:if>
	<xsl:if test="@RNApucker='outlier'">
	  <xsl:element name="VRPTx:pdbx_RNA_pucker_outlier_flag">Y</xsl:element>
	</xsl:if>
	<xsl:if test="@RNAsuite and @RNAsuite!='NotAvailable'">
	  <xsl:element name="VRPTx:pdbx_RNA_suite"><xsl:value-of select="@RNAsuite"/></xsl:element>
	</xsl:if>
	<xsl:if test="@RNAscore">
	  <xsl:element name="VRPTx:pdbx_RNA_suiteness_score"><xsl:value-of select="@RNAscore"/></xsl:element>
	</xsl:if>
<!-- unmapped data items
<VRPTx:P
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:P>
<VRPTx:RSCC_base> xsd:decimal </VRPTx:RSCC_base> [0..1]
<VRPTx:RSCC_phos> xsd:decimal </VRPTx:RSCC_phos> [0..1]
<VRPTx:RSCC_sugar> xsd:decimal </VRPTx:RSCC_sugar> [0..1]
<VRPTx:RSR_base> xsd:decimal </VRPTx:RSR_base> [0..1]
<VRPTx:RSR_phos> xsd:decimal </VRPTx:RSR_phos> [0..1]
<VRPTx:RSR_sugar> xsd:decimal </VRPTx:RSR_sugar> [0..1]
<VRPTx:alpha
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:alpha>
<VRPTx:beta
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:beta>
<VRPTx:chi1
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi1>
<VRPTx:chi2
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:chi2>
<VRPTx:delta
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:delta>
<VRPTx:details> xsd:string </VRPTx:details> [0..1]
<VRPTx:epsilon
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:epsilon>
<VRPTx:gamma
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:gamma>
<VRPTx:label_asym_id> xsd:string </VRPTx:label_asym_id> [0..1]
<VRPTx:label_comp_id> xsd:string </VRPTx:label_comp_id> [0..1]
<VRPTx:label_seq_id> xsd:string </VRPTx:label_seq_id> [0..1]
<VRPTx:mean_B_base> xsd:decimal </VRPTx:mean_B_base> [0..1]
<VRPTx:mean_B_phos> xsd:decimal </VRPTx:mean_B_phos> [0..1]
<VRPTx:mean_B_sugar> xsd:decimal </VRPTx:mean_B_sugar> [0..1]
<VRPTx:nu0
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:nu0>
<VRPTx:nu1
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:nu1>
<VRPTx:nu2
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:nu2>
<VRPTx:nu3
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:nu3>
<VRPTx:nu4
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:nu4>
<VRPTx:tau0
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:tau0>
<VRPTx:tau1
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:tau1>
<VRPTx:tau2
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:tau2>
<VRPTx:tau3
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:tau3>
<VRPTx:tau4
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:tau4>
<VRPTx:taum
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:taum>
<VRPTx:zeta
units="degrees [0..1]"> [0..1]
xsd:decimal
</VRPTx:zeta>
-->
      </VRPTx:struct_mon_nucl>
    </xsl:if>
  </xsl:template>

  <xsl:template name="append_angle_outlier_to_pdbx_validate_rmsd_angle">
    <VRPTx:pdbx_validate_rmsd_angle>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_angle+position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_3"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_3"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_3"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_3"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_3"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="@atom0"/></xsl:element>
      <xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom1"/></xsl:element>
      <xsl:element name="VRPTx:auth_atom_id_3"><xsl:value-of select="@atom2"/></xsl:element>
      <xsl:element name="VRPTx:angle_deviation"><xsl:value-of select="format-number(number(@obs)-number(@mean),'0.00')"/></xsl:element>
      <xsl:element name="VRPTx:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:angle_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:element name="VRPTx:Zscore"><xsl:value-of select="@z"/></xsl:element>
      <xsl:choose>
	<xsl:when test="@link='yes'">
	  <xsl:element name="VRPTx:linker_flag">Y</xsl:element>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:element name="VRPTx:linker_flag">N</xsl:element>
	</xsl:otherwise>
      </xsl:choose>
    </VRPTx:pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template name="append_bond_outlier_to_pdbx_validate_rmsd_bond">
    <VRPTx:pdbx_validate_rmsd_bond>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_bond+position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="@atom0"/></xsl:element>
      <xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom1"/></xsl:element>
      <xsl:element name="VRPTx:bond_deviation"><xsl:value-of select="format-number(number(@obs)-number(@mean),'0.000')"/></xsl:element>
      <xsl:element name="VRPTx:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:bond_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:element name="VRPTx:Zscore"><xsl:value-of select="@z"/></xsl:element>
      <xsl:choose>
	<xsl:when test="@link='yes'">
	  <xsl:element name="VRPTx:linker_flag">Y</xsl:element>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:element name="VRPTx:linker_flag">N</xsl:element>
	</xsl:otherwise>
      </xsl:choose>
    </VRPTx:pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template name="append_clash_to_pdbx_validate_close_contact">
    <xsl:variable name="cid"><xsl:value-of select="@cid"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="following::clash/@cid=$cid or ../following::ModelledSubgroup/clash[@cid=$cid]">
	<VRPTx:pdbx_validate_close_contact>
	  <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_close_contact+position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
	  <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
	  <xsl:if test="../@altcode and ../@altcode!=' '">
	    <xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="../@icode and ../@icode!=' '">
	    <xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="@atom"/></xsl:element>
	  <xsl:choose>
	    <xsl:when test="following::clash/@cid=$cid">
	      <xsl:for-each select="following::clash[@cid=$cid]">
		<xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
		<xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
		<xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
		<xsl:if test="../@altcode and ../@altcode!=' '">
		  <xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
		</xsl:if>
		<xsl:if test="../@icode and ../@icode!=' '">
		  <xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
		</xsl:if>
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
	      </xsl:for-each>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:for-each select="../following::ModelledSubgroup/clash[@cid=$cid]">
		<xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
		<xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
		<xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
		<xsl:if test="../@altcode and ../@altcode!=' '">
		  <xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
		</xsl:if>
		<xsl:if test="../@icode and ../@icode!=' '">
		  <xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
		</xsl:if>
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
	      </xsl:for-each>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:element name="VRPTx:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
	  <xsl:element name="VRPTx:dist"><xsl:value-of select="@dist"/></xsl:element>
<!-- unmapped data items
<VRPTx:symm_as_xyz_1> xsd:string </VRPTx:symm_as_xyz_1> [0..1]
<VRPTx:symm_as_xyz_2> xsd:string </VRPTx:symm_as_xyz_2> [0..1]
-->
	</VRPTx:pdbx_validate_close_contact>
      </xsl:when>
      <xsl:otherwise>
	<VRPTx:pdbx_validate_close_contact>
	  <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_close_contact+position()"/></xsl:attribute>
	  <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
	  <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
	  <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
	  <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
	  <xsl:if test="../@altcode and ../@altcode!=' '">
	    <xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="../@icode and ../@icode!=' '">
	    <xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	  </xsl:if>
	  <xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="@atom"/></xsl:element>
	  <xsl:element name="VRPTx:auth_asym_id_2"/>
	  <xsl:element name="VRPTx:auth_comp_id_2"/>
	  <xsl:element name="VRPTx:auth_seq_id_2"/>
	  <xsl:element name="VRPTx:auth_atom_id_2"/>
	  <xsl:element name="VRPTx:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
	  <xsl:element name="VRPTx:dist"><xsl:value-of select="@dist"/></xsl:element>
<!-- unmapped data items
<VRPTx:symm_as_xyz_1> xsd:string </VRPTx:symm_as_xyz_1> [0..1]
<VRPTx:symm_as_xyz_2> xsd:string </VRPTx:symm_as_xyz_2> [0..1]
-->
	</VRPTx:pdbx_validate_close_contact>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="append_symm_clash_to_pdbx_validate_symm_contact">
    <xsl:variable name="scid"><xsl:value-of select="@scid"/></xsl:variable>
    <xsl:if test="following::symm-clash/@scid=$scid or ../following::ModelledSubgroup/symm-clash[@scid=$scid]">
      <VRPTx:pdbx_validate_symm_contact>
	<xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_symm_contact+position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
	<xsl:if test="../@altcode and ../@altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="../@icode and ../@icode!=' '">
	  <xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	</xsl:if>
	<xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="@atom"/></xsl:element>
	<xsl:element name="VRPTx:site_symmetry_1"><xsl:value-of select="@symop"/></xsl:element>
	<xsl:choose>
	  <xsl:when test="following::symm-clash/@scid=$scid">
	    <xsl:for-each select="following::symm-clash[@scid=$scid]">
	      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
	      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
	      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
	      <xsl:if test="../@altcode and ../@altcode!=' '">
		<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
	      </xsl:if>
	      <xsl:if test="../@icode and ../@icode!=' '">
		<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
	      </xsl:if>
	      <xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
	      <xsl:element name="VRPTx:site_symmetry_2"><xsl:value-of select="@symop"/></xsl:element>
	    </xsl:for-each>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:for-each select="../following::ModelledSubgroup/symm-clash[@scid=$scid]">
	      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
	      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
	      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
	      <xsl:if test="../@altcode and ../@altcode!=' '">
		<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
	      </xsl:if>
	      <xsl:if test="../@icode and ../@icode!=' '">
		<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
	      </xsl:if>
	      <xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
	      <xsl:element name="VRPTx:site_symmetry_2"><xsl:value-of select="@symop"/></xsl:element>
	    </xsl:for-each>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:element name="VRPTx:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
	<xsl:element name="VRPTx:dist"><xsl:value-of select="@dist"/></xsl:element>
      </VRPTx:pdbx_validate_symm_contact>
    </xsl:if>
  </xsl:template>

  <xsl:template name="append_mog_angle_outlier_to_pdbx_validate_rmsd_angle">
    <VRPTx:pdbx_validate_rmsd_angle>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_angle+$count_angle_outlier+position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_3"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_3"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_3"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_3"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_3"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:variable name="atoms"><xsl:value-of select="replace(replace(normalize-space(@atoms),',,',','),',$','')"/></xsl:variable>
      <xsl:choose>
	<xsl:when test="string-length($atoms)-string-length(translate($atoms,',',''))=2">
	  <xsl:for-each select="tokenize($atoms,',')">
	    <xsl:choose>
	      <xsl:when test="position()=1">
		<xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=2">
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=3">
		<xsl:element name="VRPTx:auth_atom_id_3"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Unmatched components exist in atoms, <xsl:value-of select="position()"/>, found in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:variable name="atoms_corrected"><xsl:call-template name="correct_atoms"><xsl:with-param name="atoms"><xsl:value-of select="$atoms"/></xsl:with-param></xsl:call-template></xsl:variable>
	  <xsl:for-each select="tokenize($atoms_corrected,',')">
	    <xsl:choose>
	      <xsl:when test="position()=1">
		<xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=2">
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=3">
		<xsl:element name="VRPTx:auth_atom_id_3"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Unmatched components exist in atoms, <xsl:value-of select="position()"/>, found in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:element name="VRPTx:angle_deviation"><xsl:value-of select="format-number(number(@obsval)-number(@mean),'0.00')"/></xsl:element>
      <xsl:element name="VRPTx:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:angle_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="VRPTx:Zscore"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="VRPTx:angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="VRPTx:number_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
    </VRPTx:pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template name="append_mog_bond_outlier_to_pdbx_validate_rmsd_bond">
    <VRPTx:pdbx_validate_rmsd_bond>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_bond+$count_bond_outlier+position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
	<xsl:element name="VRPTx:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
	<xsl:element name="VRPTx:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:variable name="atoms"><xsl:value-of select="replace(replace(normalize-space(@atoms),',,',','),',$','')"/></xsl:variable>
      <xsl:choose>
	<xsl:when test="string-length($atoms)-string-length(translate($atoms,',',''))=1">
	  <xsl:for-each select="tokenize($atoms,',')">
	    <xsl:choose>
	      <xsl:when test="position()=1">
		<xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=2">
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Unmatched components exist in atoms, <xsl:value-of select="position()"/>, found in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:variable name="atoms_corrected"><xsl:call-template name="correct_atoms"><xsl:with-param name="atoms"><xsl:value-of select="$atoms"/></xsl:with-param></xsl:call-template></xsl:variable>
	  <xsl:for-each select="tokenize($atoms_corrected,',')">
	    <xsl:choose>
	      <xsl:when test="position()=1">
		<xsl:element name="VRPTx:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:when test="position()=2">
		<xsl:element name="VRPTx:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:call-template name="error_handler">
		  <xsl:with-param name="terminate">yes</xsl:with-param>
		  <xsl:with-param name="error_message">
Unmatched components exist in atoms, <xsl:value-of select="position()"/>, found in XSLT code.
		  </xsl:with-param>
		</xsl:call-template>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:for-each>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:element name="VRPTx:bond_deviation"><xsl:value-of select="format-number(number(@obsval)-number(@mean),'0.000')"/></xsl:element>
      <xsl:element name="VRPTx:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:bond_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="VRPTx:Zscore"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="VRPTx:bond_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="VRPTx:number_bonds_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
    </VRPTx:pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_ring">
    <VRPTx:pdbx_validate_rmsd_ring>
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:dihedral_angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:dihedral_angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:dihedral_angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="VRPTx:number_dihedral_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
    </VRPTx:pdbx_validate_rmsd_ring>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_rings_atom">
    <xsl:variable name="ring_id"><xsl:value-of select="position()"/></xsl:variable>
    <xsl:variable name="PDB_model_num"><xsl:value-of select="../@model"/></xsl:variable>
    <xsl:variable name="auth_asym_id"><xsl:value-of select="../@chain"/></xsl:variable>
    <xsl:variable name="auth_comp_id"><xsl:value-of select="../@resname"/></xsl:variable>
    <xsl:variable name="auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:variable>
    <xsl:variable name="label_alt_id">
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:value-of select="../@altcode"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="PDB_ins_code">
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:value-of select="../@icode"/>
      </xsl:if>
    </xsl:variable>
    <xsl:for-each select="tokenize(replace(replace(normalize-space(@atoms),',,',','),',$',''),',')">
      <VRPTx:pdbx_validate_rmsd_rings_atom ring_id="{$ring_id}">
	<xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="$PDB_model_num"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="$auth_asym_id"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="$auth_comp_id"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="$auth_seq_id"/></xsl:element>
	<xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="."/></xsl:element>
	<xsl:if test="$label_alt_id!=''">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="$label_alt_id"/></xsl:element>
	</xsl:if>
	<xsl:if test="$PDB_ins_code!=''">
	  <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="$PDB_ins_code"/></xsl:element>
	</xsl:if>
      </VRPTx:pdbx_validate_rmsd_rings_atom>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_torsion">
    <VRPTx:pdbx_validate_rmsd_torsion>
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:dihedral_angle_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="VRPTx:dihedral_angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="VRPTx:dihedral_angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="VRPTx:dihedral_angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="VRPTx:number_dihedral_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
      <xsl:if test="../@local_density">
	<xsl:element name="VRPTx:percent_dihedral_angles_fitted_to_kb"><xsl:value-of select="../@local_density"/></xsl:element>
      </xsl:if>
    </VRPTx:pdbx_validate_rmsd_torsion>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_torsions_atom">
    <xsl:variable name="torsion_id"><xsl:value-of select="position()"/></xsl:variable>
    <xsl:variable name="PDB_model_num"><xsl:value-of select="../@model"/></xsl:variable>
    <xsl:variable name="auth_asym_id"><xsl:value-of select="../@chain"/></xsl:variable>
    <xsl:variable name="auth_comp_id"><xsl:value-of select="../@resname"/></xsl:variable>
    <xsl:variable name="auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:variable>
    <xsl:variable name="label_alt_id">
      <xsl:if test="../@altcode and ../@altcode!=' '">
	<xsl:value-of select="../@altcode"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="PDB_ins_code">
      <xsl:if test="../@icode and ../@icode!=' '">
	<xsl:value-of select="../@icode"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="atoms"><xsl:value-of select="replace(replace(normalize-space(@atoms),',,',','),',$','')"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="string-length($atoms)-string-length(translate($atoms,',',''))=3">
	<xsl:for-each select="tokenize($atoms,',')">
	  <VRPTx:pdbx_validate_rmsd_torsions_atom torsion_id="{$torsion_id}">
	    <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	    <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="$PDB_model_num"/></xsl:element>
	    <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="$auth_asym_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="$auth_comp_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="$auth_seq_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="."/></xsl:element>
	    <xsl:if test="$label_alt_id!=''">
	      <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="$label_alt_id"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="$PDB_ins_code!=''">
	      <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="$PDB_ins_code"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_validate_rmsd_torsions_atom>
	</xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
	<xsl:variable name="atoms_corrected"><xsl:call-template name="correct_atoms"><xsl:with-param name="atoms"><xsl:value-of select="$atoms"/></xsl:with-param></xsl:call-template></xsl:variable>
	<xsl:for-each select="tokenize($atoms_corrected,',')">
	  <VRPTx:pdbx_validate_rmsd_torsions_atom torsion_id="{$torsion_id}">
	    <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	    <xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="$PDB_model_num"/></xsl:element>
	    <xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="$auth_asym_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="$auth_comp_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="$auth_seq_id"/></xsl:element>
	    <xsl:element name="VRPTx:auth_atom_id"><xsl:value-of select="."/></xsl:element>
	    <xsl:if test="$label_alt_id!=''">
	      <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="$label_alt_id"/></xsl:element>
	    </xsl:if>
	    <xsl:if test="$PDB_ins_code!=''">
	      <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="$PDB_ins_code"/></xsl:element>
	    </xsl:if>
	  </VRPTx:pdbx_validate_rmsd_torsions_atom>
	</xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_clust_gen">
    <VRPTx:pdbx_struct_nmr_ens_clust_gen>
      <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
      <xsl:element name="VRPTx:cluster_id"><xsl:value-of select="@nmrclust_cluster_id"/></xsl:element>
      <xsl:element name="VRPTx:medoid_conformer">
	<xsl:choose>
	  <xsl:when test="@nmrclust_representative='True'">Y</xsl:when>
	  <xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
      </xsl:element>
    </VRPTx:pdbx_struct_nmr_ens_clust_gen>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_dom">
    <VRPTx:pdbx_struct_nmr_ens_dom>
      <xsl:attribute name="id"><xsl:value-of select="@domain"/></xsl:attribute>
      <xsl:if test="@medoid_model">
	<xsl:element name="VRPTx:medoid_model_number"><xsl:value-of select="@medoid_model"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:distance_rms_dev"><xsl:value-of select="@rmsd"/></xsl:element>
      <xsl:if test="@medoid_rmsd">
	<xsl:element name="VRPTx:distance_rms_dev_medoid"><xsl:value-of select="@medoid_rmsd"/></xsl:element>
      </xsl:if>
      <xsl:element name="VRPTx:number_of_gaps"><xsl:value-of select="@number_of_gaps"/></xsl:element>
      <xsl:element name="VRPTx:number_of_monomers"><xsl:value-of select="@number_of_residues"/></xsl:element>
      <xsl:element name="VRPTx:percent_of_core"><xsl:value-of select="@percentage_of_core"/></xsl:element>
      <xsl:if test="../Entry/@cyrange_error and ../Entry/@cyrange_error!='success'">
	<xsl:element name="VRPTx:error"><xsl:value-of select="../Entry/@cyrange_error"/></xsl:element>
      </xsl:if>
    </VRPTx:pdbx_struct_nmr_ens_dom>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_dom_lim">
    <xsl:variable name="dom_id"><xsl:value-of select="@domain"/></xsl:variable>
    <xsl:for-each select="tokenize(normalize-space(@residue_string),',')">
    <VRPTx:pdbx_struct_nmr_ens_dom_lim>
      <xsl:attribute name="dom_id"><xsl:value-of select="$dom_id"/></xsl:attribute>
      <xsl:attribute name="component_id"><xsl:value-of select="position()"/></xsl:attribute>

      <xsl:for-each select="tokenize(replace(normalize-space(.),':-',':_'),'-')"> <!-- rescue A:-1-A:-1 case -->
	<xsl:choose>
	  <xsl:when test="position()=1">
	    <xsl:variable name="beg_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
	    <xsl:variable name="beg_auth_seq_id"><xsl:value-of select="translate(substring-after(.,':'),'_','-')"/></xsl:variable> <!-- retrieve A:-1 from A:_1 -->
	    <xsl:element name="VRPTx:beg_auth_asym_id"><xsl:value-of select="$beg_auth_asym_id"/></xsl:element>
	    <xsl:element name="VRPTx:beg_auth_seq_id"><xsl:value-of select="$beg_auth_seq_id"/></xsl:element>
	    <xsl:element name="VRPTx:beg_auth_comp_id">
	      <xsl:value-of select="$ext_datablock/VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme[@asym_id=$beg_auth_asym_id and VRPTx:auth_seq_num=$beg_auth_seq_id]/@mon_id"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:when test="position()=2">
	    <xsl:variable name="end_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
	    <xsl:variable name="end_auth_seq_id"><xsl:value-of select="translate(substring-after(.,':'),'_','-')"/></xsl:variable>
	    <xsl:element name="VRPTx:end_auth_asym_id"><xsl:value-of select="$end_auth_asym_id"/></xsl:element>
	    <xsl:element name="VRPTx:end_auth_seq_id"><xsl:value-of select="$end_auth_seq_id"/></xsl:element>
	    <xsl:element name="VRPTx:end_auth_comp_id">
	      <xsl:value-of select="$ext_datablock/VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme[@asym_id=$end_auth_asym_id and VRPTx:auth_seq_num=$end_auth_seq_id]/@mon_id"/>
	    </xsl:element>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:call-template name="error_handler">
	      <xsl:with-param name="terminate">yes</xsl:with-param>
	      <xsl:with-param name="error_message">
Unmatched components exist in residue_string, <xsl:value-of select="position()"/>, found in XSLT code.
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>
    </VRPTx:pdbx_struct_nmr_ens_dom_lim>
    </xsl:for-each>
  </xsl:template>

  <!-- EM validation: Entry, ModelledEntityInstance -->

  <xsl:template name="pdbx_em_validate_map_model_entity">
    <xsl:if test="@average_residue_inclusion">
      <VRPTx:pdbx_em_validate_map_model_entity>
	<xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
	<xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
	<xsl:element name="VRPTx:entity_id"><xsl:value-of select="@ent"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:average_atom_inclusion_all"><xsl:value-of select="@average_residue_inclusion"/></xsl:element>
	<xsl:if test="@Q_score">
	  <xsl:element name="VRPTx:average_Q_score"><xsl:value-of select="@Q_score"/></xsl:element>
	</xsl:if>
      </VRPTx:pdbx_em_validate_map_model_entity>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_em_validate_map_model_overall">
    <xsl:if test="@contour_level_primary_map">
      <VRPTx:pdbx_em_validate_map_model_overallCategory>
	<VRPTx:pdbx_em_validate_map_model_overall entry_id="{$entry_id}">
	  <xsl:element name="VRPTx:recommended_contour_level"><xsl:value-of select="@contour_level_primary_map"/></xsl:element>
	  <xsl:if test="@atom_inclusion_all">
	    <xsl:element name="VRPTx:atom_inclusion_all"><xsl:value-of select="@atom_inclusion_all"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@atom_inclusion_backbone">
	    <xsl:element name="VRPTx:atom_inclusion_main"><xsl:value-of select="@atom_inclusion_backbone"/></xsl:element>
	  </xsl:if>
	  <xsl:if test="@Q_score">
	    <xsl:element name="VRPTx:Q_score"><xsl:value-of select="@Q_score"/></xsl:element>
	  </xsl:if>
	</VRPTx:pdbx_em_validate_map_model_overall>
      </VRPTx:pdbx_em_validate_map_model_overallCategory>
    </xsl:if>
  </xsl:template>

  <!-- EM validation: ModelledSubgroup -->

  <xsl:template name="pdbx_em_validate_map_model">
    <xsl:if test="@residue_inclusion">
      <VRPTx:pdbx_em_validate_map_model>
	<xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
	<xsl:element name="VRPTx:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
	<xsl:element name="VRPTx:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
	<xsl:element name="VRPTx:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
	<xsl:element name="VRPTx:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
	<xsl:if test="@altcode and @altcode!=' '">
	  <xsl:element name="VRPTx:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
	</xsl:if>
	<xsl:if test="@icode and @icode!=' '">
	  <xsl:element name="VRPTx:PDB_ins_code"><xsl:value-of select="@icode"/></xsl:element>
	</xsl:if>
	<xsl:element name="VRPTx:atom_inclusion_all"><xsl:value-of select="@residue_inclusion"/></xsl:element>
	<xsl:if test="@Q_score">
	  <xsl:element name="VRPTx:Q_score"><xsl:value-of select="@Q_score"/></xsl:element>
	</xsl:if>
      </VRPTx:pdbx_em_validate_map_model>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="correct_atoms">
    <xsl:param name="atoms"/>
    <xsl:choose>
      <xsl:when test="matches($atoms,'^[0-9A-Z],[0-9A-Z],.*')">
	<xsl:analyze-string select="$atoms" regex="([0-9A-Z]),([0-9A-Z]),(.*)">
	  <xsl:matching-substring>
	    <xsl:call-template name="correct_atoms">
	      <xsl:with-param name="atoms"><xsl:value-of select="concat(regex-group(1),'_',regex-group(2),',',regex-group(3))"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:matching-substring>
	</xsl:analyze-string>
      </xsl:when>
      <xsl:when test="matches($atoms,',[0-9A-Z],[0-9A-Z]$')">
	<xsl:analyze-string select="$atoms" regex="(.*),([0-9A-Z]),([0-9A-Z])$">
	  <xsl:matching-substring>
	    <xsl:call-template name="correct_atoms">
	      <xsl:with-param name="atoms"><xsl:value-of select="concat(regex-group(1),',',regex-group(2),'_',regex-group(3))"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:matching-substring>
	</xsl:analyze-string>
      </xsl:when>
      <xsl:when test="matches($atoms,',[0-9A-Z],[0-9A-Z],')">
	<xsl:analyze-string select="$atoms" regex="(.*),([0-9A-Z]),([0-9A-Z]),(.*)">
	  <xsl:matching-substring>
	    <xsl:call-template name="correct_atoms">
	      <xsl:with-param name="atoms"><xsl:value-of select="concat(regex-group(1),',',regex-group(2),'_',regex-group(3),',',regex-group(4))"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:matching-substring>
	</xsl:analyze-string>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$atoms"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
	<xsl:message terminate="yes">
	  <xsl:text>ERROR in extract_info.xsl: </xsl:text>
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
