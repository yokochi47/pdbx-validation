<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v0.xsd">

  <xsl:param name="pdbml_ext_file" required="yes"/>
  <xsl:param name="pdbml_ext" select="document($pdbml_ext_file)"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="entry_id"><xsl:value-of select="$pdbml_ext/PDBxv:datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat($entry_id,'-validation')"/></xsl:variable>

  <!-- experimental method -->

  <xsl:variable name="exptl_method"><xsl:value-of select="$pdbml_ext/PDBxv:datablock/PDBxv:exptlCategory/PDBxv:exptl/@method"/></xsl:variable>

  <xsl:variable name="x-ray"><xsl:value-of select="contains($exptl_method,'X-RAY')"/></xsl:variable>
  <xsl:variable name="nmr"><xsl:value-of select="contains($exptl_method,'NMR')"/></xsl:variable>
  <xsl:variable name="em"><xsl:value-of select="$exptl_method='ELECTRON MICROSCOPY'"/></xsl:variable>

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
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_clash"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rama">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-rama-outliers"><xsl:value-of select="$last_cond_abs_rama+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rama"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_abs_rota">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@absolute-percentile-percent-rota-outliers"><xsl:value-of select="$last_cond_rel_rama+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rama"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rota">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-rota-outliers"><xsl:value-of select="$last_cond_abs_rota+1"/></xsl:when>
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
      <xsl:otherwise><xsl:value-of select="$last_cond_rel_rfree"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="last_cond_rel_rsrz">
    <xsl:choose>
      <xsl:when test="/wwPDB-validation-information/Entry/@relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$last_cond_abs_rsrz+1"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$last_cond_abs_rsrz"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="count_programs">
    <xsl:value-of select="count(/wwPDB-validation-information/programs/program)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_angle">
    <xsl:value-of select="count($pdbml_ext/PDBxv:datablock/PDBxv:pdbx_validate_rmsd_angleCategory/PDBxv:pdbx_validate_rmsd_angle)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_bond">
    <xsl:value-of select="count($pdbml_ext/PDBxv:datablock/PDBxv:pdbx_validate_rmsd_bondCategory/PDBxv:pdbx_validate_rmsd_bond)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_close_contact">
    <xsl:value-of select="count($pdbml_ext/PDBxv:datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_symm_contact">
    <xsl:value-of select="count($pdbml_ext/PDBxv:datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact)"/>
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

    <xsl:if test="$x-ray=false() and $nmr=false() and $em=false()">
      <xsl:call-template name="error_handler">
        <xsl:with-param name="terminate">yes</xsl:with-param>
        <xsl:with-param name="error_message">
Experimental method, <xsl:value-of select="$exptl_method"/>, is not listed in XSLT code.
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <PDBxv:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-validation-v0.xsd pdbx-validation-v0.xsd">
      <PDBxv:entryCategory>
        <PDBxv:entry id="{$entry_id}"/>
      </PDBxv:entryCategory>
      <xsl:apply-templates select="wwPDB-validation-information/*"/>
    </PDBxv:datablock>

  </xsl:template>

  <!-- Level 2 -->

  <xsl:template match="Entry">

    <xsl:if test="chemical_shift_list">
      <xsl:if test="chemical_shift_list/missing_nmrstar_tag">
        <PDBxv:pdbx_missing_nmr_star_itemCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_missing_nmr_star_item"/>
          </xsl:for-each>
        </PDBxv:pdbx_missing_nmr_star_itemCategory>
      </xsl:if>

      <PDBxv:pdbx_nmr_assigned_chem_shift_listCategory>
        <xsl:for-each select="chemical_shift_list">
          <xsl:call-template name="pdbx_nmr_assigned_chem_shift_list"/>
        </xsl:for-each>
      </PDBxv:pdbx_nmr_assigned_chem_shift_listCategory>

      <xsl:if test="chemical_shift_list/random_coil_index">
        <PDBxv:pdbx_nmr_chem_shift_annotationCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_chem_shift_annotation"/>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_annotationCategory>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="chemical_shift_list/assignment_completeness_well_defined">
          <PDBxv:pdbx_nmr_chem_shift_completenessCategory>
            <xsl:for-each select="chemical_shift_list">
              <xsl:call-template name="pdbx_nmr_chem_shift_completeness_well_defined"/>
            </xsl:for-each>
          </PDBxv:pdbx_nmr_chem_shift_completenessCategory>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="chemical_shift_list/assignment_completeness_full_length">
            <PDBxv:pdbx_nmr_chem_shift_completenessCategory>
              <xsl:for-each select="chemical_shift_list">
                <xsl:call-template name="pdbx_nmr_chem_shift_completeness_full_length"/>
              </xsl:for-each>
            </PDBxv:pdbx_nmr_chem_shift_completenessCategory>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="chemical_shift_list/referencing_offset">
        <PDBxv:pdbx_nmr_chem_shift_re_offsetCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_chem_shift_re_offset"/>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_re_offsetCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unmapped_chemical_shift">
        <PDBxv:pdbx_nmr_unmapped_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_unmapped_chem_shift"/>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_unmapped_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unparsed_chemical_shift">
        <PDBxv:pdbx_nmr_unparsed_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_unparsed_chem_shift"/>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_unparsed_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/chemical_shift_outlier">
        <PDBxv:pdbx_validate_nmr_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_validate_nmr_chem_shift"/>
          </xsl:for-each>
        </PDBxv:pdbx_validate_nmr_chem_shiftCategory>
      </xsl:if>
    </xsl:if>

    <xsl:call-template name="pdbx_percentile_list"/>
    <xsl:call-template name="pdbx_percentile_view"/>
    <xsl:call-template name="pdbx_percentile_conditions"/>

    <PDBxv:pdbx_percentile_entity_viewCategory>
      <xsl:for-each select="../ModelledEntityInstance">
        <xsl:call-template name="pdbx_percentile_entity_view"/>
      </xsl:for-each>
    </PDBxv:pdbx_percentile_entity_viewCategory>

    <xsl:call-template name="pdbx_dcc_density"/>
    <xsl:call-template name="pdbx_dcc_geometry"/>

    <PDBxv:pdbx_dcc_entity_geometryCategory>
      <xsl:for-each select="../ModelledEntityInstance">
        <xsl:call-template name="pdbx_dcc_entity_geometry"/>
      </xsl:for-each>
    </PDBxv:pdbx_dcc_entity_geometryCategory>

    <xsl:call-template name="pdbx_dcc_map_overall"/>

    <xsl:if test="../ModelledSubgroup/@rsr or ../ModelledSubgroup/@rsrz or ../ModelledSubgroup/@rscc">
      <PDBxv:pdbx_dcc_mapCategory>
        <xsl:for-each select="../ModelledSubgroup">
          <xsl:call-template name="pdbx_dcc_map"/>
        </xsl:for-each>
      </PDBxv:pdbx_dcc_mapCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@mogul_angles_rmsz or ../ModelledSubgroup/@mogul_bonds_rmsz">
      <PDBxv:pdbx_dcc_mon_geometryCategory>
        <xsl:for-each select="../ModelledSubgroup">
          <xsl:call-template name="pdbx_dcc_mon_geometry"/>
        </xsl:for-each>
      </PDBxv:pdbx_dcc_mon_geometryCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@phi or ../ModelledSubgroup/@psi">
      <PDBxv:struct_mon_protCategory>
        <xsl:for-each select="../ModelledSubgroup">
          <xsl:call-template name="struct_mon_prot"/>
        </xsl:for-each>
      </PDBxv:struct_mon_protCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/@RNApucker or ../ModelledSubgroup/@RNAsuite or ../ModelledSubgroup/@RNAscore">
      <PDBxv:struct_mon_nuclCategory>
        <xsl:for-each select="../ModelledSubgroup">
          <xsl:call-template name="struct_mon_nucl"/>
        </xsl:for-each>
      </PDBxv:struct_mon_nuclCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/angle-outlier or ../ModelledSubgroup/mog-angle-outlier">
      <PDBxv:pdbx_validate_rmsd_angleCategory>
        <xsl:for-each select="../ModelledSubgroup/angle-outlier">
          <xsl:call-template name="append_angle_outlier_to_pdbx_validate_rmsd_angle"/>
        </xsl:for-each>
        <xsl:for-each select="../ModelledSubgroup/mog-angle-outlier">
          <xsl:call-template name="append_mog_angle_outlier_to_pdbx_validate_rmsd_angle"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_angleCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/bond-outlier or ../ModelledSubgroup/mog-bond-outlier">
      <PDBxv:pdbx_validate_rmsd_bondCategory>
        <xsl:for-each select="../ModelledSubgroup/bond-outlier">
          <xsl:call-template name="append_bond_outlier_to_pdbx_validate_rmsd_bond"/>
        </xsl:for-each>
        <xsl:for-each select="../ModelledSubgroup/mog-bond-outlier">
          <xsl:call-template name="append_mog_bond_outlier_to_pdbx_validate_rmsd_bond"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_bondCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/clash">
      <PDBxv:pdbx_validate_close_contactCategory>
        <xsl:for-each select="../ModelledSubgroup/clash[not(@cid=../preceding::ModelledSubgroup/clash/@cid) and not(@cid=preceding::clash/@cid)]">
          <xsl:call-template name="append_clash_to_pdbx_validate_close_contact"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_close_contactCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/symm-clash">
      <PDBxv:pdbx_validate_symm_contactCategory>
        <xsl:for-each select="../ModelledSubgroup/symm-clash[not(@scid=../preceding::ModelledSubgroup/symm-clash/@scid)]">
          <xsl:call-template name="append_symm_clash_to_pdbx_validate_symm_contact"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_symm_contactCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/mog-ring-outlier">
      <PDBxv:pdbx_validate_rmsd_ringCategory>
        <xsl:for-each select="../ModelledSubgroup/mog-ring-outlier">
          <xsl:call-template name="pdbx_validate_rmsd_ring"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_ringCategory>

      <PDBxv:pdbx_validate_rmsd_rings_atomCategory>
        <xsl:for-each select="../ModelledSubgroup/mog-ring-outlier">
          <xsl:call-template name="pdbx_validate_rmsd_rings_atom"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_rings_atomCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/mog-torsion-outlier">
      <PDBxv:pdbx_validate_rmsd_torsionCategory>
        <xsl:for-each select="../ModelledSubgroup/mog-torsion-outlier">
          <xsl:call-template name="pdbx_validate_rmsd_torsion"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_torsionCategory>

      <PDBxv:pdbx_validate_rmsd_torsions_atomCategory>
        <xsl:for-each select="../ModelledSubgroup/mog-torsion-outlier">
          <xsl:call-template name="pdbx_validate_rmsd_torsions_atom"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_rmsd_torsions_atomCategory>
    </xsl:if>

    <xsl:if test="$nmr=true()">

      <xsl:if test="@nmrclust_version">

        <PDBxv:pdbx_struct_nmr_ens_clustCategory>
          <PDBxv:pdbx_struct_nmr_ens_clust entry_id="{$entry_id}">
            <xsl:element name="PDBxv:clusters_total_number"><xsl:value-of select="@nmrclust_number_of_clusters"/></xsl:element>
            <xsl:element name="PDBxv:conformers_total_number"><xsl:value-of select="@nmrclust_number_of_models"/></xsl:element>
            <xsl:element name="PDBxv:outliers_total_number"><xsl:value-of select="@nmrclust_number_of_outliers"/></xsl:element>
            <xsl:if test="@nmrclust_error and @nmrclust_error!='success'">
              <xsl:element name="PDBxv:error"><xsl:value-of select="@nmrclust_error"/></xsl:element>
            </xsl:if>
          </PDBxv:pdbx_struct_nmr_ens_clust>
        </PDBxv:pdbx_struct_nmr_ens_clustCategory>

        <xsl:if test="../Model">
          <PDBxv:pdbx_struct_nmr_ens_clust_genCategory>
            <xsl:for-each select="../Model">
              <xsl:call-template name="pdbx_struct_nmr_ens_clust_gen"/>
            </xsl:for-each>
          </PDBxv:pdbx_struct_nmr_ens_clust_genCategory>
        </xsl:if>

      </xsl:if>

      <xsl:if test="@cyrange_version">

        <xsl:if test="../cyrange_domain">
          <PDBxv:pdbx_struct_nmr_ens_domCategory>
            <xsl:for-each select="../cyrange_domain">
              <xsl:call-template name="pdbx_struct_nmr_ens_dom"/>
            </xsl:for-each>
          </PDBxv:pdbx_struct_nmr_ens_domCategory>

          <PDBxv:pdbx_struct_nmr_ens_dom_limCategory>
            <xsl:for-each select="../cyrange_domain">
              <xsl:call-template name="pdbx_struct_nmr_ens_dom_lim"/>
            </xsl:for-each>
          </PDBxv:pdbx_struct_nmr_ens_dom_limCategory>
        </xsl:if>

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
  <xsl:template match="programs">
    <PDBxv:pdbx_validation_softwareCategory>
      <xsl:for-each select="program">
      <PDBxv:pdbx_validation_software>
        <xsl:attribute name="ordinal"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:name"><xsl:value-of select="@name"/></xsl:element>
        <xsl:element name="PDBxv:version"><xsl:value-of select="@version"/></xsl:element>
        <xsl:element name="PDBxv:classification">
          <xsl:choose>
            <xsl:when test="@name='chemicalshifts'">assessment of nmr assigned chemical shifts</xsl:when>
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
        <xsl:element name="PDBxv:details"><xsl:value-of select="@properties"/></xsl:element>
      </PDBxv:pdbx_validation_software>
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
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_dcc_refine"/></xsl:attribute>
          <xsl:element name="PDBxv:name"><xsl:value-of select="../Entry/@DCC_refinement_program"/></xsl:element>
          <xsl:element name="PDBxv:version">unknown (associated with DCC package)</xsl:element>
          <xsl:element name="PDBxv:classification">refinement</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_ccp4!=$last_dcc_refine">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_ccp4"/></xsl:attribute>
          <xsl:element name="PDBxv:name">CCP4</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@CCP4version"/></xsl:element>
          <xsl:element name="PDBxv:classification">data scaling and phasing</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_refmac!=$last_ccp4">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_refmac"/></xsl:attribute>
          <xsl:element name="PDBxv:name">Refmac</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@RefmacVersion"/></xsl:element>
          <xsl:element name="PDBxv:classification">refinement</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_cyrange!=$last_refmac">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_cyrange"/></xsl:attribute>
          <xsl:element name="PDBxv:name">cyrange</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@cyrange_version"/></xsl:element>
          <xsl:element name="PDBxv:classification">domain identification of nmr ensemble structure</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_nmrclust!=$last_cyrange">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_nmrclust"/></xsl:attribute>
          <xsl:element name="PDBxv:name">nmrclust</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@nmrclust_version"/></xsl:element>
          <xsl:element name="PDBxv:classification">classification of nmr ensemble structure</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_panav!=$last_nmrclust">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_panav"/></xsl:attribute>
          <xsl:element name="PDBxv:name">panav</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@panav_version"/></xsl:element>
          <xsl:element name="PDBxv:classification">nmr chemical shift validation and reference correction</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_rci!=$last_panav">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_rci"/></xsl:attribute>
          <xsl:element name="PDBxv:name">rci</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@rci_version"/></xsl:element>
          <xsl:element name="PDBxv:classification">random coil index prediction from nmr chemical shifts</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

      <xsl:if test="$last_shiftchecker!=$last_rci">
        <PDBxv:pdbx_validation_software>
          <xsl:attribute name="ordinal"><xsl:value-of select="$last_shiftchecker"/></xsl:attribute>
          <xsl:element name="PDBxv:name">shiftchecker</xsl:element>
          <xsl:element name="PDBxv:version"><xsl:value-of select="../Entry/@shiftchecker_version"/></xsl:element>
          <xsl:element name="PDBxv:classification">nmr chemical shift validation</xsl:element>
        </PDBxv:pdbx_validation_software>
      </xsl:if>

    </PDBxv:pdbx_validation_softwareCategory>
  </xsl:template>

  <!-- Level 3 -->

  <!-- chemical_shift_list starts -->

  <xsl:template name="pdbx_missing_nmr_star_item">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="missing_nmrstar_tag">
        <PDBxv:pdbx_missing_nmr_star_item>
          <xsl:element name="PDBxv:list_id"><xsl:value-of select="$list_id"/></xsl:element>
          <xsl:element name="PDBxv:name"><xsl:value-of select="@nmrstar_tag"/></xsl:element>
          <xsl:element name="PDBxv:description"><xsl:value-of select="@nmrstar_tag_description"/></xsl:element>
        </PDBxv:pdbx_missing_nmr_star_item>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_assigned_chem_shift_list">
    <xsl:for-each select="current()/chemical_shift_list">
    <PDBxv:pdbx_nmr_assigned_chem_shift_list>
      <xsl:attribute name="id"><xsl:value-of select="@list_id"/></xsl:attribute>
<!-- unmapped data items
<PDBxv:chem_shift_13C_err> xsd:decimal </PDBxv:chem_shift_13C_err> [0..1]
<PDBxv:chem_shift_15N_err> xsd:decimal </PDBxv:chem_shift_15N_err> [0..1]
<PDBxv:chem_shift_19F_err> xsd:decimal </PDBxv:chem_shift_19F_err> [0..1]
<PDBxv:chem_shift_1H_err> xsd:decimal </PDBxv:chem_shift_1H_err> [0..1]
<PDBxv:chem_shift_2H_err> xsd:decimal </PDBxv:chem_shift_2H_err> [0..1]
<PDBxv:chem_shift_31P_err> xsd:decimal </PDBxv:chem_shift_31P_err> [0..1]
-->
      <xsl:element name="PDBxv:data_file_name"><xsl:value-of select="@file_name"/></xsl:element>
      <xsl:element name="PDBxv:label"><xsl:value-of select="@block_name"/></xsl:element>
      <xsl:element name="PDBxv:nmr_star_consistency_flag">
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
      <xsl:element name="PDBxv:number_chem_shifts"><xsl:value-of select="@total_number_of_shifts"/></xsl:element>
      <xsl:element name="PDBxv:number_map_errors"><xsl:value-of select="@number_of_errors_while_mapping"/></xsl:element>
      <xsl:element name="PDBxv:number_map_warnings"><xsl:value-of select="@number_of_warnings_while_mapping"/></xsl:element>
      <xsl:element name="PDBxv:number_mapped_chem_shifts"><xsl:value-of select="@number_of_mapped_shifts"/></xsl:element>
      <xsl:element name="PDBxv:number_parsed_chem_shifts"><xsl:value-of select="@number_of_parsed_shifts"/></xsl:element>
      <xsl:element name="PDBxv:number_unparsed_chem_shifts"><xsl:value-of select="@number_of_unparsed_shifts"/></xsl:element>
    </PDBxv:pdbx_nmr_assigned_chem_shift_list>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_annotation">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="random_coil_index">
        <PDBxv:pdbx_nmr_chem_shift_annotation>
          <xsl:element name="PDBxv:list_id"><xsl:value-of select="$list_id"/></xsl:element>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:random_coil_index"><xsl:value-of select="@value"/></xsl:element>
        </PDBxv:pdbx_nmr_chem_shift_annotation>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_well_defined">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="assignment_completeness_well_defined">
        <xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
        <xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
        <PDBxv:pdbx_nmr_chem_shift_completeness>
          <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
          <xsl:attribute name="atom_group"><xsl:value-of select="$atom_group"/></xsl:attribute>
          <xsl:attribute name="atom_type"><xsl:value-of select="$atom_type"/></xsl:attribute>
          <xsl:element name="PDBxv:number_assigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
          <xsl:element name="PDBxv:number_target_shifts_well_formed"><xsl:value-of select="@number_of_shifts"/></xsl:element>
          <xsl:element name="PDBxv:number_unassigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
          <xsl:for-each select="../assignment_completeness_full_length[@type=$atom_group and @element=$atom_type]">
            <xsl:element name="PDBxv:number_assigned_chem_shifts"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
            <xsl:element name="PDBxv:number_target_shifts"><xsl:value-of select="@number_of_shifts"/></xsl:element>
            <xsl:element name="PDBxv:number_unassigned_chem_shifts"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_completeness>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_full_length">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="assignment_completeness_full_length">
        <xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
        <xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
        <PDBxv:pdbx_nmr_chem_shift_completeness>
          <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
          <xsl:attribute name="atom_group"><xsl:value-of select="$atom_group"/></xsl:attribute>
          <xsl:attribute name="atom_type"><xsl:value-of select="$atom_type"/></xsl:attribute>
          <xsl:element name="PDBxv:number_assigned_chem_shifts"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
          <xsl:element name="PDBxv:number_target_shifts"><xsl:value-of select="@number_of_shifts"/></xsl:element>
          <xsl:element name="PDBxv:number_unassigned_chem_shifts"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
          <xsl:for-each select="../assignment_completeness_well_defined[@type=$atom_group and @element=$atom_type]">
            <xsl:element name="PDBxv:number_assigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_assigned_shifts"/></xsl:element>
            <xsl:element name="PDBxv:number_target_shifts_well_formed"><xsl:value-of select="@number_of_shifts"/></xsl:element>
            <xsl:element name="PDBxv:number_unassigned_chem_shifts_well_formed"><xsl:value-of select="@number_of_unassigned_shifts"/></xsl:element>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_completeness>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_re_offset">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="referencing_offset">
        <PDBxv:pdbx_nmr_chem_shift_re_offset>
          <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
          <xsl:attribute name="atom_type"><xsl:value-of select="@atom"/></xsl:attribute>
          <xsl:element name="PDBxv:correction_val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:element name="PDBxv:correction_val_err"><xsl:value-of select="@uncertainty"/></xsl:element>
          <xsl:element name="PDBxv:correction_val_esd"><xsl:value-of select="@precision"/></xsl:element>
          <xsl:element name="PDBxv:number_chem_shifts"><xsl:value-of select="@number_of_measurements"/></xsl:element>
        </PDBxv:pdbx_nmr_chem_shift_re_offset>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_unmapped_chem_shift">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="unmapped_chemical_shift">
        <PDBxv:pdbx_nmr_unmapped_chem_shift>
          <xsl:element name="PDBxv:list_id"><xsl:value-of select="$list_id"/></xsl:element>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
          <xsl:element name="PDBxv:val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:element name="PDBxv:val_err"><xsl:value-of select="@error"/></xsl:element>
          <xsl:element name="PDBxv:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
          <xsl:element name="PDBxv:details"><xsl:value-of select="@diagnostic"/></xsl:element>
        </PDBxv:pdbx_nmr_unmapped_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_unparsed_chem_shift">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="unparsed_chemical_shift">
        <PDBxv:pdbx_nmr_unparsed_chem_shift>
          <xsl:element name="PDBxv:list_id"><xsl:value-of select="$list_id"/></xsl:element>
          <xsl:element name="PDBxv:chem_shift_id"><xsl:value-of select="@id"/></xsl:element>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
          <xsl:element name="PDBxv:val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:element name="PDBxv:val_err"><xsl:value-of select="@error"/></xsl:element>
          <xsl:element name="PDBxv:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
          <xsl:element name="PDBxv:details"><xsl:value-of select="@diagnostic"/></xsl:element>
        </PDBxv:pdbx_nmr_unparsed_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_validate_nmr_chem_shift">
    <xsl:for-each select="current()/chemical_shift_list">
      <xsl:variable name="list_id"><xsl:value-of select="@list_id"/></xsl:variable>
      <xsl:for-each select="chemical_shift_outlier">
        <PDBxv:pdbx_validate_nmr_chem_shift>
          <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
          <xsl:element name="PDBxv:val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:element name="PDBxv:target_val"><xsl:value-of select="@prediction"/></xsl:element>
          <xsl:element name="PDBxv:Zscore"><xsl:value-of select="@zscore"/></xsl:element>
          <xsl:element name="PDBxv:method"><xsl:value-of select="@method"/></xsl:element>
        </PDBxv:pdbx_validate_nmr_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <!-- chemical_shift_list ends -->

  <xsl:template name="pdbx_percentile_list">
    <PDBxv:pdbx_percentile_listCategory>
      <PDBxv:pdbx_percentile_list entry_id="{$entry_id}">
        <xsl:element name="PDBxv:name"><xsl:value-of select="current()/@percentilebins"/></xsl:element>
      </PDBxv:pdbx_percentile_list>
    </PDBxv:pdbx_percentile_listCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_view">
    <PDBxv:pdbx_percentile_viewCategory>

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
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rna}" type="RNA_suiteness_score">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-RNAsuiteness"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-RNAsuiteness">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rna}" type="RNA_suiteness_score">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-RNAsuiteness"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-clashscore">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_clash}" type="all_atom_clashscore">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-clashscore"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-clashscore">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_clash}" type="all_atom_clashscore">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-clashscore"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rama}" type="Ramachandran_outlier_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-rama-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rama}" type="Ramachandran_outlier_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-percent-rama-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rota}" type="rotamer_outliers_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-rota-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rota}" type="rotamer_outliers_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-percent-rota-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rfree}" type="R_value_R_free">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rfree}" type="R_value_R_free">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rsrz}" type="RSRZ_outliers_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rsrz}" type="RSRZ_outliers_percent">
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-percent-RSRZ-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

    </PDBxv:pdbx_percentile_viewCategory>

  </xsl:template>

  <xsl:template name="pdbx_percentile_conditions">
    <PDBxv:pdbx_percentile_conditionsCategory>

      <xsl:if test="@absolute-percentile-RNAsuiteness">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rna}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-RNAsuiteness"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-RNAsuiteness">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rna}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-RNAsuiteness"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-RNAsuiteness"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-RNAsuiteness"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-RNAsuiteness">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-RNAsuiteness"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-clashscore">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_clash}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-clashscore"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-clashscore">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_clash}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-clashscore"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-clashscore"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-clashscore"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-clashscore">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-clashscore"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rama}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rama-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rama}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rama-outliers"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-percent-rama-outliers">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rota}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rota-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rota}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rota-outliers"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-percent-rota-outliers">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rfree}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rfree}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-DCC_Rfree"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-DCC_Rfree"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-DCC_Rfree"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-DCC_Rfree">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-DCC_Rfree"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rsrz}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rsrz}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
          <xsl:if test="$x-ray=true()">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
          </xsl:if>
          <xsl:if test="$em=true() and @high-resol-relative-percentile-percent-RSRZ-outliers">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

    </PDBxv:pdbx_percentile_conditionsCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_entity_view">

    <xsl:if test="@absolute_RSRZ_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rsrz}" type="RSRZ_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_RSRZ_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_RSRZ_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rsrz}" type="RSRZ_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_RSRZ_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_rama_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rama}" type="Ramachandran_outlier_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_rama_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_rama_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rama}" type="Ramachandran_outlier_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_rama_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_sidechain_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rota}" type="rotamer_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_sidechain_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_sidechain_percentile">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rota}" type="rotamer_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_sidechain_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pdbx_dcc_density">
    <xsl:if test="$dcc_version!=''">
      <PDBxv:pdbx_dcc_densityCategory>
        <PDBxv:pdbx_dcc_density entry_id="{$entry_id}">
          <xsl:element name="PDBxv:B_babinet"><xsl:value-of select="@babinet_b"/></xsl:element>
          <xsl:element name="PDBxv:B_solvent"><xsl:value-of select="@bulk_solvent_b"/></xsl:element>
          <xsl:element name="PDBxv:B_wilson"><xsl:value-of select="@WilsonBestimate"/></xsl:element>
          <xsl:element name="PDBxv:DCC_version"><xsl:value-of select="$dcc_version"/></xsl:element>
          <xsl:element name="PDBxv:I_over_sigI_resh"><xsl:value-of select="substring-before(@IoverSigma,'(')"/></xsl:element>
          <xsl:element name="PDBxv:K_babinet"><xsl:value-of select="@babinet_k"/></xsl:element>
          <xsl:element name="PDBxv:K_solvent"><xsl:value-of select="@bulk_solvent_k"/></xsl:element>
          <xsl:element name="PDBxv:Padilla-Yeates_L2_mean"><xsl:value-of select="@TwinL"/></xsl:element>
          <xsl:element name="PDBxv:Padilla-Yeates_L_mean"><xsl:value-of select="@TwinL2"/></xsl:element>
          <xsl:element name="PDBxv:R_value_R_free"><xsl:value-of select="@DCC_R"/></xsl:element>
          <xsl:element name="PDBxv:R_value_R_work"><xsl:value-of select="@DCC_Rfree"/></xsl:element>
          <xsl:element name="PDBxv:Rfree-Rwork"><xsl:value-of select="format-number(number(@DCC_Rfree)-number(@DCC_R),'0.00')"/></xsl:element>
          <xsl:if test="@WilsonBaniso">
            <xsl:for-each select="tokenize(replace(normalize-space(@WilsonBaniso),'[\[\]]',''),',')">
              <xsl:choose>
                <xsl:when test="position()=1">
                  <xsl:element name="PDBxv:aniso_B11"><xsl:value-of select="."/></xsl:element>
                </xsl:when>
                <xsl:when test="position()=2">
                  <xsl:element name="PDBxv:aniso_B22"><xsl:value-of select="."/></xsl:element>
                </xsl:when>
                <xsl:when test="position()=3">
                  <xsl:element name="PDBxv:aniso_B33"><xsl:value-of select="."/></xsl:element>
                </xsl:when>
                <xsl:when test="position()=4">
                  <xsl:element name="PDBxv:aniso_B12"><xsl:value-of select="."/></xsl:element>
                </xsl:when>
                <xsl:when test="position()=5">
                  <xsl:element name="PDBxv:aniso_B13"><xsl:value-of select="."/></xsl:element>
                </xsl:when>
                <xsl:when test="position()=6">
                  <xsl:element name="PDBxv:aniso_B23"><xsl:value-of select="."/></xsl:element>
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
          <xsl:element name="PDBxv:anisotropy"><xsl:value-of select="@DataAnisotropy"/></xsl:element>
          <xsl:element name="PDBxv:error"><xsl:value-of select="@TransNCS"/></xsl:element>
          <xsl:element name="PDBxv:iso_B_value_type"><xsl:value-of select="lower-case(@B_factor_type)"/></xsl:element>
          <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@PDB-resolution"/></xsl:element>
          <xsl:if test="@EDS_resolution">
            <xsl:element name="PDBxv:ls_d_res_high_sf"><xsl:value-of select="@EDS_resolution"/></xsl:element>
          </xsl:if>
          <xsl:if test="@EDS_resolution_low">
            <xsl:element name="PDBxv:ls_d_res_low_sf"><xsl:value-of select="@EDS_resolution_low"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:reflns_outlier_acentric"><xsl:value-of select="@acentric_outliers"/></xsl:element>
          <xsl:element name="PDBxv:reflns_outlier_centric"><xsl:value-of select="@centric_outliers"/></xsl:element>
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
            <xsl:element name="PDBxv:twin_fraction_xtriage"><xsl:value-of select="normalize-space($twin_fraction)"/></xsl:element>
            <xsl:element name="PDBxv:twin_operator_xtriage"><xsl:value-of select="normalize-space($twin_operator)"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:wavelength"><xsl:value-of select="$pdbml_ext/PDBxv:datablock/PDBxv:diffrn_radiation_wavelengthCategory/PDBxv:diffrn_radiation_wavelength/PDBxv:wavelength"/></xsl:element>
<!-- unmapped data items
<PDBxv:B_wilson_scale> xsd:decimal </PDBxv:B_wilson_scale> [0..1]
<PDBxv:Biso_max> xsd:decimal </PDBxv:Biso_max> [0..1]
<PDBxv:Biso_mean> xsd:decimal </PDBxv:Biso_mean> [0..1]
<PDBxv:Biso_min> xsd:decimal </PDBxv:Biso_min> [0..1]
<PDBxv:Bmean-Bwilson> xsd:decimal </PDBxv:Bmean-Bwilson> [0..1]
<PDBxv:Cruickshank_dpi_xyz> xsd:decimal </PDBxv:Cruickshank_dpi_xyz> [0..1]
<PDBxv:I_over_sigI_diff> xsd:decimal </PDBxv:I_over_sigI_diff> [0..1]
<PDBxv:I_over_sigI_mean> xsd:decimal </PDBxv:I_over_sigI_mean> [0..1]
<PDBxv:Matthew_coeff> xsd:decimal </PDBxv:Matthew_coeff> [0..1]
<PDBxv:Padilla-Yeates_L2_mean_pointless> xsd:decimal </PDBxv:Padilla-Yeates_L2_mean_pointless> [0..1]
<PDBxv:TLS_refinement_reported> xsd:string </PDBxv:TLS_refinement_reported> [0..1]
<PDBxv:Z-score> xsd:decimal </PDBxv:Z-score> [0..1]
<PDBxv:Z_score_L_test> xsd:decimal </PDBxv:Z_score_L_test> [0..1]
<PDBxv:correlation_overall> xsd:decimal </PDBxv:correlation_overall> [0..1]
<PDBxv:dpi_free_R> xsd:decimal </PDBxv:dpi_free_R> [0..1]
<PDBxv:fom> xsd:decimal </PDBxv:fom> [0..1]
<PDBxv:free_set_count> xsd:integer </PDBxv:free_set_count> [0..1]
<PDBxv:ice_ring> xsd:string </PDBxv:ice_ring> [0..1]
<PDBxv:mFo-DFc-3sigma_negative> xsd:integer </PDBxv:mFo-DFc-3sigma_negative> [0..1]
<PDBxv:mFo-DFc-3sigma_positive> xsd:integer </PDBxv:mFo-DFc-3sigma_positive> [0..1]
<PDBxv:mFo-DFc-6sigma_negative> xsd:integer </PDBxv:mFo-DFc-6sigma_negative> [0..1]
<PDBxv:mFo-DFc-6sigma_positive> xsd:integer </PDBxv:mFo-DFc-6sigma_positive> [0..1]
<PDBxv:mean_E2_1_abs> xsd:decimal </PDBxv:mean_E2_1_abs> [0..1]
<PDBxv:mean_F_square_over_mean_F2> xsd:decimal </PDBxv:mean_F_square_over_mean_F2> [0..1]
<PDBxv:mean_I2_over_mean_I_square> xsd:decimal </PDBxv:mean_I2_over_mean_I_square> [0..1]
<PDBxv:mtrix_number> xsd:integer </PDBxv:mtrix_number> [0..1]
<PDBxv:ncs_group_number> xsd:integer </PDBxv:ncs_group_number> [0..1]
<PDBxv:occupancy_max> xsd:decimal </PDBxv:occupancy_max> [0..1]
<PDBxv:occupancy_mean> xsd:decimal </PDBxv:occupancy_mean> [0..1]
<PDBxv:occupancy_min> xsd:decimal </PDBxv:occupancy_min> [0..1]
<PDBxv:partial_B_value_correction_attempted> xsd:string </PDBxv:partial_B_value_correction_attempted> [0..1]
<PDBxv:partial_B_value_correction_success> xsd:string </PDBxv:partial_B_value_correction_success> [0..1]
<PDBxv:pdbtype> xsd:string </PDBxv:pdbtype> [0..1]
<PDBxv:prob_peak_value> xsd:decimal </PDBxv:prob_peak_value> [0..1]
<PDBxv:real_space_R_overall> xsd:decimal </PDBxv:real_space_R_overall> [0..1]
<PDBxv:reflection_status_archived> xsd:string </PDBxv:reflection_status_archived> [0..1]
<PDBxv:reflection_status_used> xsd:string </PDBxv:reflection_status_used> [0..1]
<PDBxv:reflns_twin> xsd:string </PDBxv:reflns_twin> [0..1]
<PDBxv:solvent_content> xsd:decimal </PDBxv:solvent_content> [0..1]
<PDBxv:space_group_name_H-M> xsd:string </PDBxv:space_group_name_H-M> [0..1]
<PDBxv:space_group_pointless> xsd:string </PDBxv:space_group_pointless> [0..1]
<PDBxv:tls_group_number> xsd:integer </PDBxv:tls_group_number> [0..1]
<PDBxv:translational_pseudo_symmetry> xsd:string </PDBxv:translational_pseudo_symmetry> [0..1]
<PDBxv:twin_Rfactor> xsd:decimal </PDBxv:twin_Rfactor> [0..1]
<PDBxv:twin_by_xtriage> xsd:string </PDBxv:twin_by_xtriage> [0..1]
<PDBxv:twin_fraction> xsd:string </PDBxv:twin_fraction> [0..1]
<PDBxv:twin_operator> xsd:string </PDBxv:twin_operator> [0..1]
<PDBxv:twin_type> xsd:string </PDBxv:twin_type> [0..1]
<PDBxv:unit_cell> xsd:string </PDBxv:unit_cell> [0..1]
<PDBxv:working_set_count> xsd:integer </PDBxv:working_set_count> [0..1]
-->
        </PDBxv:pdbx_dcc_density>
      </PDBxv:pdbx_dcc_densityCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_geometry">
    <PDBxv:pdbx_dcc_geometryCategory>
      <PDBxv:pdbx_dcc_geometry entry_id="{$entry_id}">
        <xsl:if test="@RNAsuiteness">
          <xsl:element name="PDBxv:RNA_suiteness_score"><xsl:value-of select="@RNAsuiteness"/></xsl:element>
        </xsl:if>
        <xsl:if test="@percent-rama-outliers">
          <xsl:element name="PDBxv:Ramachandran_outlier_percent">
            <xsl:choose>
              <xsl:when test="$nmr=true()">
                <xsl:value-of select="@percent-rama-outliers-full-length"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@percent-rama-outliers"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
          <xsl:if test="$nmr=true()">
            <xsl:element name="PDBxv:Ramachandran_outlier_percent_nmr_well_formed"><xsl:value-of select="@percent-rama-outliers"/></xsl:element>
          </xsl:if>
        </xsl:if>
        <xsl:element name="PDBxv:all_atom_clashscore">
          <xsl:choose>
            <xsl:when test="$nmr=true()">
              <xsl:value-of select="@clashscore-full-length"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@clashscore"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
        <xsl:if test="$nmr=true()">
          <xsl:element name="PDBxv:all_atom_clashscore_nmr_well_formed"><xsl:value-of select="@clashscore"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:angle_overall_rmsz"><xsl:value-of select="@angles_rmsz"/></xsl:element>
        <xsl:element name="PDBxv:bond_overall_rmsz"><xsl:value-of select="@bonds_rmsz"/></xsl:element>
        <xsl:if test="@percent-rota-outliers">
          <xsl:element name="PDBxv:rotamer_outliers_percent">
            <xsl:choose>
              <xsl:when test="$nmr=true()">
                <xsl:value-of select="@percent-rota-outliers-full-length"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@percent-rota-outliers"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:element>
          <xsl:if test="$nmr=true()">
            <xsl:element name="PDBxv:rotamer_outliers_percent_nmr_well_formed"><xsl:value-of select="@percent-rota-outliers"/></xsl:element>
          </xsl:if>
        </xsl:if>
        <xsl:if test="@ligand_geometry_outlier='yes'">
          <xsl:element name="PDBxv:LLDFZ_outlier_flag">Y</xsl:element>
        </xsl:if>
<!-- unmapped data items
<PDBxv:Ramachandran_allowed_number> xsd:integer </PDBxv:Ramachandran_allowed_number> [0..1]
<PDBxv:Ramachandran_allowed_percent> xsd:decimal </PDBxv:Ramachandran_allowed_percent> [0..1]
<PDBxv:Ramachandran_favored_number> xsd:integer </PDBxv:Ramachandran_favored_number> [0..1]
<PDBxv:Ramachandran_favored_percent> xsd:decimal </PDBxv:Ramachandran_favored_percent> [0..1]
<PDBxv:Ramachandran_outlier_number> xsd:integer </PDBxv:Ramachandran_outlier_number> [0..1]
<PDBxv:angle_ligand_max> xsd:decimal </PDBxv:angle_ligand_max> [0..1]
<PDBxv:angle_ligand_rms> xsd:decimal </PDBxv:angle_ligand_rms> [0..1]
<PDBxv:angle_overall_max> xsd:decimal </PDBxv:angle_overall_max> [0..1]
<PDBxv:angle_overall_rms> xsd:decimal </PDBxv:angle_overall_rms> [0..1]
<PDBxv:bond_ligand_max> xsd:decimal </PDBxv:bond_ligand_max> [0..1]
<PDBxv:bond_ligand_rms> xsd:decimal </PDBxv:bond_ligand_rms> [0..1]
<PDBxv:bond_overall_max> xsd:decimal </PDBxv:bond_overall_max> [0..1]
<PDBxv:bond_overall_rms> xsd:decimal </PDBxv:bond_overall_rms> [0..1]
<PDBxv:cbeta_deviations> xsd:integer </PDBxv:cbeta_deviations> [0..1]
<PDBxv:chirality_overall_max> xsd:decimal </PDBxv:chirality_overall_max> [0..1]
<PDBxv:chirality_overall_rms> xsd:decimal </PDBxv:chirality_overall_rms> [0..1]
<PDBxv:dihedral_overall_max> xsd:decimal </PDBxv:dihedral_overall_max> [0..1]
<PDBxv:dihedral_overall_rms> xsd:decimal </PDBxv:dihedral_overall_rms> [0..1]
<PDBxv:non-bonded_rms> xsd:decimal </PDBxv:non-bonded_rms> [0..1]
<PDBxv:overall_score> xsd:decimal </PDBxv:overall_score> [0..1]
<PDBxv:planarity_overall_max> xsd:decimal </PDBxv:planarity_overall_max> [0..1]
<PDBxv:planarity_overall_rms> xsd:decimal </PDBxv:planarity_overall_rms> [0..1]
<PDBxv:rotamer_outliers_number> xsd:integer </PDBxv:rotamer_outliers_number> [0..1]
-->
      </PDBxv:pdbx_dcc_geometry>
    </PDBxv:pdbx_dcc_geometryCategory>
  </xsl:template>

  <xsl:template name="pdbx_dcc_map_overall">
    <xsl:if test="@percent-RSRZ-outliers">
      <PDBxv:pdbx_dcc_map_overallCategory>
        <PDBxv:pdbx_dcc_map_overall entry_id="{$entry_id}">
          <xsl:element name="PDBxv:RSRZ_outliers_percent"><xsl:value-of select="@percent-RSRZ-outliers"/></xsl:element>
        </PDBxv:pdbx_dcc_map_overall>
      </PDBxv:pdbx_dcc_map_overallCategory>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_map">
    <xsl:if test="@rsr or @rsrz or @rscc">
      <PDBxv:pdbx_dcc_map>
        <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
        <xsl:if test="@altcode and @altcode!=' '">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
        </xsl:if>
        <xsl:if test="@icode and @icode!=' '">
          <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="@icode"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:Biso_mean"><xsl:value-of select="@owab"/></xsl:element>
        <xsl:if test="@libRSRZ">
          <xsl:element name="PDBxv:LLDF"><xsl:value-of select="@ligRSRZ"/></xsl:element>
        </xsl:if>
        <xsl:if test="@ligand_density_outlier='yes'">
          <xsl:element name="PDBxv:LLDFZ_outlier_flag">Y</xsl:element>
        </xsl:if>
        <xsl:if test="@lig_rsrz_nbr_id">
          <xsl:element name="PDBxv:LLDF_name"><xsl:value-of select="@lig_rsrz_nbr_id"/></xsl:element>
        </xsl:if>
        <xsl:if test="@ligRSRnumnbrs">
          <xsl:element name="PDBxv:LLDF_number_residues_total"><xsl:value-of select="@ligRSRnumnbrs"/></xsl:element>
        </xsl:if>
        <xsl:if test="@ligRSRnbrStdev">
          <xsl:element name="PDBxv:LLDF_sigma"><xsl:value-of select="@ligRSRnbrStdev"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:RSCC"><xsl:value-of select="@rscc"/></xsl:element>
        <xsl:element name="PDBxv:RSR"><xsl:value-of select="@rsr"/></xsl:element>
        <xsl:if test="@rsrz">
          <xsl:element name="PDBxv:RSRZ"><xsl:value-of select="@rsrz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@avgoccu">
          <xsl:element name="PDBxv:occupancy_mean"><xsl:value-of select="@avgoccu"/></xsl:element>
        </xsl:if>
<!-- unmapped data items
<PDBxv:Biso_mean_main_chain> xsd:decimal </PDBxv:Biso_mean_main_chain> [0..1]
<PDBxv:Biso_mean_phosphate_group> xsd:decimal </PDBxv:Biso_mean_phosphate_group> [0..1]
<PDBxv:Biso_mean_side_chain> xsd:decimal </PDBxv:Biso_mean_side_chain> [0..1]
<PDBxv:LLDFZ> xsd:decimal </PDBxv:LLDFZ> [0..1]
<PDBxv:RSCC_main_chain> xsd:decimal </PDBxv:RSCC_main_chain> [0..1]
<PDBxv:RSCC_phosphate_group> xsd:decimal </PDBxv:RSCC_phosphate_group> [0..1]
<PDBxv:RSCC_side_chain> xsd:decimal </PDBxv:RSCC_side_chain> [0..1]
<PDBxv:RSRZ_main_chain> xsd:decimal </PDBxv:RSRZ_main_chain> [0..1]
<PDBxv:RSRZ_phosphate_group> xsd:decimal </PDBxv:RSRZ_phosphate_group> [0..1]
<PDBxv:RSRZ_side_chain> xsd:decimal </PDBxv:RSRZ_side_chain> [0..1]
<PDBxv:RSR_main_chain> xsd:decimal </PDBxv:RSR_main_chain> [0..1]
<PDBxv:RSR_phosphate_group> xsd:decimal </PDBxv:RSR_phosphate_group> [0..1]
<PDBxv:RSR_side_chain> xsd:decimal </PDBxv:RSR_side_chain> [0..1]
<PDBxv:RSZD> xsd:decimal </PDBxv:RSZD> [0..1]
<PDBxv:RSZD_main_chain> xsd:decimal </PDBxv:RSZD_main_chain> [0..1]
<PDBxv:RSZD_phosphate_group> xsd:decimal </PDBxv:RSZD_phosphate_group> [0..1]
<PDBxv:RSZD_side_chain> xsd:decimal </PDBxv:RSZD_side_chain> [0..1]
<PDBxv:RSZO> xsd:decimal </PDBxv:RSZO> [0..1]
<PDBxv:RSZO_Zscore> xsd:decimal </PDBxv:RSZO_Zscore> [0..1]
<PDBxv:RSZO_main_chain> xsd:decimal </PDBxv:RSZO_main_chain> [0..1]
<PDBxv:RSZO_phosphate_group> xsd:decimal </PDBxv:RSZO_phosphate_group> [0..1]
<PDBxv:RSZO_side_chain> xsd:decimal </PDBxv:RSZO_side_chain> [0..1]
<PDBxv:density_connectivity> xsd:decimal </PDBxv:density_connectivity> [0..1]
<PDBxv:density_index_main_chain> xsd:decimal </PDBxv:density_index_main_chain> [0..1]
<PDBxv:density_index_side_chain> xsd:decimal </PDBxv:density_index_side_chain> [0..1]
<PDBxv:occupancy_mean_main_chain> xsd:decimal </PDBxv:occupancy_mean_main_chain> [0..1]
<PDBxv:occupancy_mean_phosphate_group> xsd:decimal </PDBxv:occupancy_mean_phosphate_group> [0..1]
<PDBxv:occupancy_mean_side_chain> xsd:decimal </PDBxv:occupancy_mean_side_chain> [0..1]
<PDBxv:quality_indicator> xsd:string </PDBxv:quality_indicator> [0..1]
<PDBxv:shift> xsd:decimal </PDBxv:shift> [0..1]
<PDBxv:shift_main_chain> xsd:decimal </PDBxv:shift_main_chain> [0..1]
<PDBxv:shift_side_chain> xsd:decimal </PDBxv:shift_side_chain> [0..1]
<PDBxv:wRSRZ_main_chain> xsd:decimal </PDBxv:wRSRZ_main_chain> [0..1]
<PDBxv:wRSRZ_phosphate_group> xsd:decimal </PDBxv:wRSRZ_phosphate_group> [0..1]
<PDBxv:wRSRZ_side_chain> xsd:decimal </PDBxv:wRSRZ_side_chain> [0..1]
<PDBxv:wRSR_main_chain> xsd:decimal </PDBxv:wRSR_main_chain> [0..1]
<PDBxv:wRSR_phosphate_group> xsd:decimal </PDBxv:wRSR_phosphate_group> [0..1]
<PDBxv:wRSR_side_chain> xsd:decimal </PDBxv:wRSR_side_chain> [0..1]
<PDBxv:weighted_RSR> xsd:decimal </PDBxv:weighted_RSR> [0..1]
<PDBxv:weighted_RSRZ> xsd:decimal </PDBxv:weighted_RSRZ> [0..1]
-->
    </PDBxv:pdbx_dcc_map>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_entity_geometry">
    <xsl:if test="@angles_rmsz or @bonds_rmsz">
      <PDBxv:pdbx_dcc_entity_geometry>
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:angle_overall_rmsz"><xsl:value-of select="@angles_rmsz"/></xsl:element>
        <xsl:element name="PDBxv:bond_overall_rmsz"><xsl:value-of select="@bonds_rmsz"/></xsl:element>
      </PDBxv:pdbx_dcc_entity_geometry>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_dcc_mon_geometry">
    <xsl:if test="@mogul_angles_rmsz or @mogul_bonds_rmsz">
      <PDBxv:pdbx_dcc_mon_geometry>
        <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
        <xsl:if test="@altcode and @altcode!=' '">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
        </xsl:if>
        <xsl:if test="@icode and @icode!=' '">
          <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="@icode"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:angle_overall_rmsz"><xsl:value-of select="@mogul_angles_rmsz"/></xsl:element>
        <xsl:element name="PDBxv:bond_overall_rmsz"><xsl:value-of select="@mogul_bonds_rmsz"/></xsl:element>
      </PDBxv:pdbx_dcc_mon_geometry>
    </xsl:if>
  </xsl:template>

  <xsl:template name="struct_mon_prot">
    <xsl:if test="@phi or @psi">
      <PDBxv:struct_mon_prot>
        <xsl:attribute name="pdbx_id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
        <xsl:if test="@altcode and @altcode!=' '">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rscc">
          <xsl:element name="PDBxv:RSCC_all"><xsl:value-of select="@rscc"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rsr">
          <xsl:element name="PDBxv:RSR_all"><xsl:value-of select="@rsr"/></xsl:element>
        </xsl:if>
        <xsl:if test="@owab">
          <xsl:element name="PDBxv:mean_B_all"><xsl:value-of select="@owab"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:phi"><xsl:value-of select="@phi"/></xsl:element>
        <xsl:element name="PDBxv:psi"><xsl:value-of select="@psi"/></xsl:element>
        <xsl:if test="plane-outlier/@omega">
          <xsl:element name="PDBxv:omega"><xsl:value-of select="plane-outlier/@omega"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rama">
          <xsl:element name="PDBxv:pdbx_Ramachandran_region"><xsl:value-of select="@rama"/></xsl:element>
        </xsl:if>
        <xsl:if test="@flippable-sidechain='1'">
          <xsl:element name="PDBxv:pdbx_flippable_side_chain">Y</xsl:element>
        </xsl:if>
        <xsl:if test="@rota">
          <xsl:element name="PDBxv:pdbx_rotamer"><xsl:value-of select="@rota"/></xsl:element>
        </xsl:if>
<!-- unmapped data items
<PDBxv:RSCC_main> xsd:decimal </PDBxv:RSCC_main> [0..1]
<PDBxv:RSCC_side> xsd:decimal </PDBxv:RSCC_side> [0..1]
<PDBxv:RSR_main> xsd:decimal </PDBxv:RSR_main> [0..1]
<PDBxv:RSR_side> xsd:decimal </PDBxv:RSR_side> [0..1]
<PDBxv:chi1
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi1>
<PDBxv:chi2
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi2>
<PDBxv:chi3
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi3>
<PDBxv:chi4
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi4>
<PDBxv:chi5
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi5>
<PDBxv:details> xsd:decimal </PDBxv:details> [0..1]
<PDBxv:label_asym_id> xsd:string </PDBxv:label_asym_id> [0..1]
<PDBxv:label_comp_id> xsd:string </PDBxv:label_comp_id> [0..1]
<PDBxv:label_seq_id> xsd:string </PDBxv:label_seq_id> [0..1]
<PDBxv:mean_B_main> xsd:decimal </PDBxv:mean_B_main> [0..1]
<PDBxv:mean_B_side> xsd:decimal </PDBxv:mean_B_side> [0..1]
-->
      </PDBxv:struct_mon_prot>
    </xsl:if>
  </xsl:template>

  <xsl:template name="struct_mon_nucl">
    <xsl:if test="@RNApucker or @RNAsuite or @RNAscore">
      <PDBxv:struct_mon_nucl>
        <xsl:attribute name="pdbx_id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@resname"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
        <xsl:if test="@altcode and @altcode!=' '">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="@altcode"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rscc">
          <xsl:element name="PDBxv:RSCC_all"><xsl:value-of select="@rscc"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rsr">
          <xsl:element name="PDBxv:RSR_all"><xsl:value-of select="@rsr"/></xsl:element>
        </xsl:if>
        <xsl:if test="@owab">
          <xsl:element name="PDBxv:mean_B_all"><xsl:value-of select="@owab"/></xsl:element>
        </xsl:if>
        <xsl:if test="@RNApucker='outlier'">
          <xsl:element name="PDBxv:pdbx_RNA_pucker_outlier_flag">Y</xsl:element>
        </xsl:if>
        <xsl:if test="@RNAsuite and @RNAsuite!='NotAvailable'">
          <xsl:element name="PDBxv:pdbx_RNA_suite"><xsl:value-of select="@RNAsuite"/></xsl:element>
        </xsl:if>
        <xsl:if test="@RNAscore">
          <xsl:element name="PDBxv:pdbx_RNA_suiteness_score"><xsl:value-of select="@RNAscore"/></xsl:element>
        </xsl:if>
<!-- unmapped data items
<PDBxv:P
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:P>
<PDBxv:RSCC_base> xsd:decimal </PDBxv:RSCC_base> [0..1]
<PDBxv:RSCC_phos> xsd:decimal </PDBxv:RSCC_phos> [0..1]
<PDBxv:RSCC_sugar> xsd:decimal </PDBxv:RSCC_sugar> [0..1]
<PDBxv:RSR_base> xsd:decimal </PDBxv:RSR_base> [0..1]
<PDBxv:RSR_phos> xsd:decimal </PDBxv:RSR_phos> [0..1]
<PDBxv:RSR_sugar> xsd:decimal </PDBxv:RSR_sugar> [0..1]
<PDBxv:alpha
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:alpha>
<PDBxv:beta
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:beta>
<PDBxv:chi1
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi1>
<PDBxv:chi2
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:chi2>
<PDBxv:delta
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:delta>
<PDBxv:details> xsd:string </PDBxv:details> [0..1]
<PDBxv:epsilon
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:epsilon>
<PDBxv:gamma
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:gamma>
<PDBxv:label_asym_id> xsd:string </PDBxv:label_asym_id> [0..1]
<PDBxv:label_comp_id> xsd:string </PDBxv:label_comp_id> [0..1]
<PDBxv:label_seq_id> xsd:string </PDBxv:label_seq_id> [0..1]
<PDBxv:mean_B_base> xsd:decimal </PDBxv:mean_B_base> [0..1]
<PDBxv:mean_B_phos> xsd:decimal </PDBxv:mean_B_phos> [0..1]
<PDBxv:mean_B_sugar> xsd:decimal </PDBxv:mean_B_sugar> [0..1]
<PDBxv:nu0
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:nu0>
<PDBxv:nu1
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:nu1>
<PDBxv:nu2
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:nu2>
<PDBxv:nu3
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:nu3>
<PDBxv:nu4
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:nu4>
<PDBxv:tau0
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:tau0>
<PDBxv:tau1
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:tau1>
<PDBxv:tau2
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:tau2>
<PDBxv:tau3
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:tau3>
<PDBxv:tau4
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:tau4>
<PDBxv:taum
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:taum>
<PDBxv:zeta
units="degrees [0..1]"> [0..1]
xsd:decimal
</PDBxv:zeta>
-->
      </PDBxv:struct_mon_nucl>
    </xsl:if>
  </xsl:template>

  <xsl:template name="append_angle_outlier_to_pdbx_validate_rmsd_angle">
    <PDBxv:pdbx_validate_rmsd_angle>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_angle+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_3"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_3"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_3"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_3"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_3"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="@atom0"/></xsl:element>
      <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="@atom1"/></xsl:element>
      <xsl:element name="PDBxv:auth_atom_id_3"><xsl:value-of select="@atom2"/></xsl:element>
      <xsl:element name="PDBxv:angle_deviation"><xsl:value-of select="@z"/></xsl:element>
      <xsl:element name="PDBxv:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:angle_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:choose>
        <xsl:when test="@link='yes'">
          <xsl:element name="PDBxv:linker_flag">Y</xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="PDBxv:linker_flag">N</xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </PDBxv:pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template name="append_bond_outlier_to_pdbx_validate_rmsd_bond">
    <PDBxv:pdbx_validate_rmsd_bond>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_bond+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="@atom0"/></xsl:element>
      <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="@atom1"/></xsl:element>
      <xsl:element name="PDBxv:bond_deviation"><xsl:value-of select="@z"/></xsl:element>
      <xsl:element name="PDBxv:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:bond_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:choose>
        <xsl:when test="@link='yes'">
          <xsl:element name="PDBxv:linker_flag">Y</xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="PDBxv:linker_flag">N</xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </PDBxv:pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template name="append_clash_to_pdbx_validate_close_contact">
    <xsl:variable name="cid"><xsl:value-of select="@cid"/></xsl:variable>
    <PDBxv:pdbx_validate_close_contact>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_close_contact+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="@atom"/></xsl:element>
      <xsl:choose>
        <xsl:when test="following::clash/@cid=$cid">
          <xsl:for-each select="following::clash[@cid=$cid]">
            <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
            <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
            <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
            <xsl:if test="../@altcode and ../@altcode!=' '">
              <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
            </xsl:if>
            <xsl:if test="../@icode and ../@icode!=' '">
              <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
            </xsl:if>
            <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="../following::ModelledSubgroup/clash[@cid=$cid]">
            <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
            <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
            <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
            <xsl:if test="../@altcode and ../@altcode!=' '">
              <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
            </xsl:if>
            <xsl:if test="../@icode and ../@icode!=' '">
              <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
            </xsl:if>
            <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:element name="PDBxv:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
      <xsl:element name="PDBxv:dist"><xsl:value-of select="@dist"/></xsl:element>
<!-- unmapped data items
<PDBxv:symm_as_xyz_1> xsd:string </PDBxv:symm_as_xyz_1> [0..1]
<PDBxv:symm_as_xyz_2> xsd:string </PDBxv:symm_as_xyz_2> [0..1]
-->
    </PDBxv:pdbx_validate_close_contact>
  </xsl:template>

  <xsl:template name="append_symm_clash_to_pdbx_validate_symm_contact">
    <xsl:variable name="scid"><xsl:value-of select="@scid"/></xsl:variable>
    <PDBxv:pdbx_validate_symm_contact>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_symm_contact+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="@atom"/></xsl:element>
      <xsl:element name="PDBxv:site_symmetry_1"><xsl:value-of select="@symop"/></xsl:element>
      <xsl:for-each select="../following::ModelledSubgroup/symm-clash[@scid=$scid]">
        <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
        <xsl:if test="../@altcode and ../@altcode!=' '">
          <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
        </xsl:if>
        <xsl:if test="../@icode and ../@icode!=' '">
          <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
        </xsl:if>
        <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="@atom"/></xsl:element>
        <xsl:element name="PDBxv:site_symmetry_2"><xsl:value-of select="@symop"/></xsl:element>
      </xsl:for-each>
      <xsl:element name="PDBxv:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
      <xsl:element name="PDBxv:dist"><xsl:value-of select="@dist"/></xsl:element>
    </PDBxv:pdbx_validate_symm_contact>
  </xsl:template>

  <xsl:template name="append_mog_angle_outlier_to_pdbx_validate_rmsd_angle">
    <PDBxv:pdbx_validate_rmsd_angle>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_angle+$count_angle_outlier+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_3"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_3"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_3"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_3"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_3"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:for-each select="tokenize(normalize-space(@atoms),',')">
        <xsl:choose>
          <xsl:when test="position()=1">
            <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
          </xsl:when>
          <xsl:when test="position()=2">
            <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
          </xsl:when>
          <xsl:when test="position()=3">
            <xsl:element name="PDBxv:auth_atom_id_3"><xsl:value-of select="."/></xsl:element>
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
      <xsl:element name="PDBxv:angle_deviation"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="PDBxv:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:angle_value"><xsl:value-of select="@obsval"/></xsl:element>
    </PDBxv:pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template name="append_mog_bond_outlier_to_pdbx_validate_rmsd_bond">
    <PDBxv:pdbx_validate_rmsd_bond>
      <xsl:attribute name="id"><xsl:value-of select="$count_pdbx_validate_rmsd_bond+$count_bond_outlier+position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_1"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id_2"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_1"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id_2"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_1"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id_2"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id_1"><xsl:value-of select="../@altcode"/></xsl:element>
        <xsl:element name="PDBxv:label_alt_id_2"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code_1"><xsl:value-of select="../@icode"/></xsl:element>
        <xsl:element name="PDBxv:PDB_ins_code_2"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:for-each select="tokenize(normalize-space(@atoms),',')">
        <xsl:choose>
          <xsl:when test="position()=1">
            <xsl:element name="PDBxv:auth_atom_id_1"><xsl:value-of select="."/></xsl:element>
          </xsl:when>
          <xsl:when test="position()=2">
            <xsl:element name="PDBxv:auth_atom_id_2"><xsl:value-of select="."/></xsl:element>
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
      <xsl:element name="PDBxv:bond_deviation"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="PDBxv:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:bond_value"><xsl:value-of select="@obsval"/></xsl:element>
    </PDBxv:pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_ring">
    <PDBxv:pdbx_validate_rmsd_ring>
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:dihedral_angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:dihedral_angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
    </PDBxv:pdbx_validate_rmsd_ring>
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
    <xsl:for-each select="tokenize(normalize-space(@atoms),',')">
      <PDBxv:pdbx_validate_rmsd_rings_atom ring_id="{$ring_id}">
        <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="$PDB_model_num"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="$auth_asym_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="$auth_comp_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="$auth_seq_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="."/></xsl:element>
        <xsl:if test="$label_alt_id!=''">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="$label_alt_id"/></xsl:element>
        </xsl:if>
        <xsl:if test="$PDB_ins_code!=''">
          <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="$PDB_ins_code"/></xsl:element>
        </xsl:if>
      </PDBxv:pdbx_validate_rmsd_rings_atom>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_validate_rmsd_torsion">
    <PDBxv:pdbx_validate_rmsd_torsion>
      <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
      <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="../@model"/></xsl:element>
      <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="../@chain"/></xsl:element>
      <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="../@resname"/></xsl:element>
      <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="../@resnum"/></xsl:element>
      <xsl:if test="../@altcode and ../@altcode!=' '">
        <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="../@altcode"/></xsl:element>
      </xsl:if>
      <xsl:if test="../@icode and ../@icode!=' '">
        <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="../@icode"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:dihedral_angle_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="PDBxv:dihedral_angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:dihedral_angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
    </PDBxv:pdbx_validate_rmsd_torsion>
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
    <xsl:for-each select="tokenize(normalize-space(@atoms),',')">
      <PDBxv:pdbx_validate_rmsd_torsions_atom torsion_id="{$torsion_id}">
        <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="$PDB_model_num"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="$auth_asym_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="$auth_comp_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="$auth_seq_id"/></xsl:element>
        <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="."/></xsl:element>
        <xsl:if test="$label_alt_id!=''">
          <xsl:element name="PDBxv:label_alt_id"><xsl:value-of select="$label_alt_id"/></xsl:element>
        </xsl:if>
        <xsl:if test="$PDB_ins_code!=''">
          <xsl:element name="PDBxv:PDB_ins_code"><xsl:value-of select="$PDB_ins_code"/></xsl:element>
        </xsl:if>
      </PDBxv:pdbx_validate_rmsd_torsions_atom>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_clust_gen">
    <PDBxv:pdbx_struct_nmr_ens_clust_gen>
      <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
      <xsl:element name="PDBxv:cluster_id"><xsl:value-of select="@nmrclust_cluster_id"/></xsl:element>
      <xsl:element name="PDBxv:medoid_conformer">
        <xsl:choose>
          <xsl:when test="@nmrclust_representative='True'">Y</xsl:when>
          <xsl:otherwise>N</xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </PDBxv:pdbx_struct_nmr_ens_clust_gen>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_dom">
    <PDBxv:pdbx_struct_nmr_ens_dom>
      <xsl:attribute name="id"><xsl:value-of select="@domain"/></xsl:attribute>
      <xsl:element name="PDBxv:medoid_model_number"><xsl:value-of select="@medoid_model"/></xsl:element>
      <xsl:element name="PDBxv:distance_rms_dev"><xsl:value-of select="@rmsd"/></xsl:element>
      <xsl:element name="PDBxv:distance_rms_dev_medoid"><xsl:value-of select="@medoid_rmsd"/></xsl:element>
      <xsl:element name="PDBxv:number_of_gaps"><xsl:value-of select="@number_of_gaps"/></xsl:element>
      <xsl:element name="PDBxv:number_of_monomers"><xsl:value-of select="@number_of_residues"/></xsl:element>
      <xsl:if test="../Entry/@cyrange_error and ../Entry/@cyrange_error!='success'">
        <xsl:element name="PDBxv:error"><xsl:value-of select="../Entry/@cyrange_error"/></xsl:element>
      </xsl:if>
    </PDBxv:pdbx_struct_nmr_ens_dom>
  </xsl:template>

  <xsl:template name="pdbx_struct_nmr_ens_dom_lim">
    <xsl:variable name="dom_id"><xsl:value-of select="@domain"/></xsl:variable>
    <xsl:for-each select="tokenize(normalize-space(@residue_string),',')">
    <PDBxv:pdbx_struct_nmr_ens_dom_lim>
      <xsl:attribute name="dom_id"><xsl:value-of select="$dom_id"/></xsl:attribute>
      <xsl:attribute name="component_id"><xsl:value-of select="position()"/></xsl:attribute>

      <xsl:for-each select="tokenize(normalize-space(.),'-')">
        <xsl:choose>
          <xsl:when test="position()=1">
            <xsl:variable name="beg_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
            <xsl:variable name="beg_auth_seq_id"><xsl:value-of select="substring-after(.,':')"/></xsl:variable>
            <xsl:element name="PDBxv:beg_auth_asym_id"><xsl:value-of select="$beg_auth_asym_id"/></xsl:element>
            <xsl:element name="PDBxv:beg_auth_seq_id"><xsl:value-of select="$beg_auth_seq_id"/></xsl:element>
            <xsl:element name="PDBxv:beg_auth_comp_id">
              <xsl:value-of select="$pdbml_ext/PDBxv:datablock/PDBxv:pdbx_poly_seq_schemeCategory/PDBxv:pdbx_poly_seq_scheme[@asym_id=$beg_auth_asym_id and PDBxv:auth_seq_num=$beg_auth_seq_id]/@mon_id"/>
            </xsl:element>
          </xsl:when>
          <xsl:when test="position()=2">
            <xsl:variable name="end_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
            <xsl:variable name="end_auth_seq_id"><xsl:value-of select="substring-after(.,':')"/></xsl:variable>
            <xsl:element name="PDBxv:end_auth_asym_id"><xsl:value-of select="$end_auth_asym_id"/></xsl:element>
            <xsl:element name="PDBxv:end_auth_seq_id"><xsl:value-of select="$end_auth_seq_id"/></xsl:element>
            <xsl:element name="PDBxv:end_auth_comp_id">
              <xsl:value-of select="$pdbml_ext/PDBxv:datablock/PDBxv:pdbx_poly_seq_schemeCategory/PDBxv:pdbx_poly_seq_scheme[@asym_id=$end_auth_asym_id and PDBxv:auth_seq_num=$end_auth_seq_id]/@mon_id"/>
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
    </PDBxv:pdbx_struct_nmr_ens_dom_lim>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
        <xsl:message terminate="yes">
          <xsl:text>ERROR in extract_validation.xsl: </xsl:text>
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
