<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v3.xsd">

  <xsl:param name="pdbml_ext_file" required="yes"/>
  <xsl:param name="pdbml_ext" select="document($pdbml_ext_file)"/>

  <xsl:variable name="ext_datablock" select="$pdbml_ext/PDBxv:datablock"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="pdb_id"><xsl:value-of select="/wwPDB-validation-information/Entry/@pdbid"/></xsl:variable>

  <xsl:variable name="entry_id"><xsl:value-of select="$ext_datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>
  <xsl:variable name="datablock_name"><xsl:value-of select="concat($entry_id,'-validation-alt')"/></xsl:variable>

  <!-- experimental method -->

  <xsl:variable name="exptl_method"><xsl:value-of select="$ext_datablock/PDBxv:exptlCategory/PDBxv:exptl/@method"/></xsl:variable>

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

  <xsl:variable name="count_programs">
    <xsl:value-of select="count(/wwPDB-validation-information/programs/program)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_angle">
    <xsl:value-of select="count($ext_datablock/PDBxv:pdbx_validate_rmsd_angleCategory/PDBxv:pdbx_validate_rmsd_angle)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_rmsd_bond">
    <xsl:value-of select="count($ext_datablock/PDBxv:pdbx_validate_rmsd_bondCategory/PDBxv:pdbx_validate_rmsd_bond)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_close_contact">
    <xsl:value-of select="count($ext_datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact)"/>
  </xsl:variable>

  <xsl:variable name="count_pdbx_validate_symm_contact">
    <xsl:value-of select="count($ext_datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact)"/>
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

    <PDBxv:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-validation-v3.xsd pdbx-validation-v3.xsd">
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
            <xsl:call-template name="pdbx_missing_nmr_star_item">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_missing_nmr_star_itemCategory>
      </xsl:if>

      <PDBxv:pdbx_nmr_assigned_chem_shift_listCategory>
        <xsl:for-each select="chemical_shift_list">
          <xsl:call-template name="pdbx_nmr_assigned_chem_shift_list">
             <xsl:with-param name="id"><xsl:value-of select="position()"/></xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </PDBxv:pdbx_nmr_assigned_chem_shift_listCategory>

      <xsl:if test="chemical_shift_list/random_coil_index">
        <PDBxv:pdbx_nmr_chem_shift_annotationCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_chem_shift_annotation">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_annotationCategory>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="chemical_shift_list/assignment_completeness_well_defined">
          <PDBxv:pdbx_nmr_chem_shift_completenessCategory>
            <xsl:for-each select="chemical_shift_list">
              <xsl:call-template name="pdbx_nmr_chem_shift_completeness_well_defined">
                <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
          </PDBxv:pdbx_nmr_chem_shift_completenessCategory>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="chemical_shift_list/assignment_completeness_full_length">
            <PDBxv:pdbx_nmr_chem_shift_completenessCategory>
              <xsl:for-each select="chemical_shift_list">
                <xsl:call-template name="pdbx_nmr_chem_shift_completeness_full_length">
                  <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
            </PDBxv:pdbx_nmr_chem_shift_completenessCategory>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="chemical_shift_list/referencing_offset">
        <PDBxv:pdbx_nmr_chem_shift_re_offsetCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_chem_shift_re_offset">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_chem_shift_re_offsetCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unmapped_chemical_shift">
        <PDBxv:pdbx_nmr_unmapped_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_unmapped_chem_shift">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_unmapped_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/unparsed_chemical_shift">
        <PDBxv:pdbx_nmr_unparsed_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_nmr_unparsed_chem_shift">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_nmr_unparsed_chem_shiftCategory>
      </xsl:if>

      <xsl:if test="chemical_shift_list/chemical_shift_outlier">
        <PDBxv:pdbx_validate_nmr_chem_shiftCategory>
          <xsl:for-each select="chemical_shift_list">
            <xsl:call-template name="pdbx_validate_nmr_chem_shift">
              <xsl:with-param name="list_id"><xsl:value-of select="position()"/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </PDBxv:pdbx_validate_nmr_chem_shiftCategory>
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
      <PDBxv:pdbx_percentile_entity_viewCategory>
        <xsl:for-each select="../ModelledEntityInstance">
          <xsl:call-template name="pdbx_percentile_entity_view"/>
        </xsl:for-each>
      </PDBxv:pdbx_percentile_entity_viewCategory>
    </xsl:if>

    <xsl:call-template name="pdbx_dcc_density"/>
    <xsl:call-template name="pdbx_dcc_density_corr"/>
    <xsl:call-template name="pdbx_dcc_geometry"/>

    <xsl:if test="../ModelledEntityInstance/@angles_rmsz or ../ModelledEntityInstance/@bonds_rmsz">
      <PDBxv:pdbx_dcc_entity_geometryCategory>
        <xsl:for-each select="../ModelledEntityInstance">
          <xsl:call-template name="pdbx_dcc_entity_geometry"/>
        </xsl:for-each>
      </PDBxv:pdbx_dcc_entity_geometryCategory>
    </xsl:if>

    <xsl:call-template name="pdbx_dcc_map_overall"/>

    <!-- EM validation: Entry, ModelledEntityInstance -->

    <xsl:if test="$em=true()">

      <xsl:if test="@emdb_id">
        <PDBxv:em_adminCategory>
          <PDBxv:em_admin>
            <xsl:attribute name="entry_id"><xsl:value-of select="@emdb_id"/></xsl:attribute>
            <xsl:if test="@EMDB-deposition-date and @EMDB-deposition-date!='unknown'">
              <xsl:element name="PDBxv:deposition_date"><xsl:value-of select="@EMDB-deposition-date"/></xsl:element>
            </xsl:if>
          </PDBxv:em_admin>
        </PDBxv:em_adminCategory>
      </xsl:if>

      <xsl:if test="../ModelledEntityInstance/@average_residue_inclusion">
        <PDBxv:pdbx_em_validate_map_model_entityCategory>
          <xsl:for-each select="../ModelledEntityInstance">
            <xsl:call-template name="pdbx_em_validate_map_model_entity"/>
          </xsl:for-each>
        </PDBxv:pdbx_em_validate_map_model_entityCategory>
      </xsl:if>

      <xsl:call-template name="pdbx_em_validate_map_model_overall"/>

    </xsl:if>

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

    <xsl:if test="../ModelledSubgroup/@phi or ../ModelledSubgroup/@psi or ../ModelledSubgroup/@rama or ../ModelledSubgroup/@rota">
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

    <xsl:if test="../ModelledSubgroup/clash[not(@cid=../preceding::ModelledSubgroup/clash/@cid) and not(@cid=preceding::clash/@cid)]">
      <PDBxv:pdbx_validate_close_contactCategory>
        <xsl:for-each select="../ModelledSubgroup/clash[not(@cid=../preceding::ModelledSubgroup/clash/@cid) and not(@cid=preceding::clash/@cid)]">
          <xsl:call-template name="append_clash_to_pdbx_validate_close_contact"/>
        </xsl:for-each>
      </PDBxv:pdbx_validate_close_contactCategory>
    </xsl:if>

    <xsl:if test="../ModelledSubgroup/symm-clash">
      <PDBxv:pdbx_validate_symm_contactCategory>
        <xsl:for-each select="../ModelledSubgroup/symm-clash[not(@scid=../preceding::ModelledSubgroup/symm-clash/@scid) and not(@scid=preceding::symm-clash/@scid)]">
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
            <xsl:if test="@nmrclust_number_of_clusters">
              <xsl:element name="PDBxv:clusters_total_number"><xsl:value-of select="@nmrclust_number_of_clusters"/></xsl:element>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="@nmrclust_number_of_models">
                <xsl:element name="PDBxv:conformers_total_number"><xsl:value-of select="@nmrclust_number_of_models"/></xsl:element>
              </xsl:when>
              <xsl:otherwise>
                <xsl:element name="PDBxv:conformers_total_number"><xsl:value-of select="$ext_datablock/PDBxv:pdbx_nmr_ensembleCategory/PDBxv:pdbx_nmr_ensemble/PDBxv:conformers_submitted_total_number"/></xsl:element>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="@nmrclust_number_of_outliers">
              <xsl:element name="PDBxv:outliers_total_number"><xsl:value-of select="@nmrclust_number_of_outliers"/></xsl:element>
            </xsl:if>
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

    <!-- EM validation: ModelledSubgroup -->

    <xsl:if test="$em=true()">

      <xsl:if test="../ModelledSubgroup/@residue_inclusion">
        <PDBxv:pdbx_em_validate_map_modelCategory>
          <xsl:for-each select="../ModelledSubgroup">
            <xsl:call-template name="pdbx_em_validate_map_model"/>
          </xsl:for-each>
        </PDBxv:pdbx_em_validate_map_modelCategory>
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
    <PDBxv:pdbx_em_density_distributionCategory>
      <PDBxv:pdbx_em_density_distribution id="1">
        <PDBxv:map_value_title><xsl:value-of select="@xTitle"/></PDBxv:map_value_title>
        <PDBxv:voxel_count_title><xsl:value-of select="@yTitle"/></PDBxv:voxel_count_title>
        <xsl:if test="@yScale">
          <PDBxv:voxel_count_scale><xsl:value-of select="@yScale"/></PDBxv:voxel_count_scale>
        </xsl:if>
      </PDBxv:pdbx_em_density_distribution>
    </PDBxv:pdbx_em_density_distributionCategory>
    <PDBxv:pdbx_em_density_distribution_markerCategory>
      <xsl:for-each select="coordinate">
        <xsl:sort select="number(@x)" data-type="number"/>
        <PDBxv:pdbx_em_density_distribution_marker plot_id="1" ordinal="{position()}">
          <PDBxv:map_value><xsl:value-of select="number(@x)"/></PDBxv:map_value>
          <PDBxv:voxel_count><xsl:value-of select="number(@y)"/></PDBxv:voxel_count>
        </PDBxv:pdbx_em_density_distribution_marker>
      </xsl:for-each>
    </PDBxv:pdbx_em_density_distribution_markerCategory>
  </xsl:template>

  <xsl:template match="volume_estimate">
    <PDBxv:pdbx_em_volume_estimateCategory>
      <PDBxv:pdbx_em_volume_estimate id="1">
        <PDBxv:contour_level_title><xsl:value-of select="@xTitle"/></PDBxv:contour_level_title>
        <PDBxv:enclosed_volume_title><xsl:value-of select="@yTitle"/></PDBxv:enclosed_volume_title>
        <xsl:if test="@yUnit">
          <PDBxv:enclosed_volume_unit><xsl:value-of select="@yUnit"/></PDBxv:enclosed_volume_unit>
        </xsl:if>
      </PDBxv:pdbx_em_volume_estimate>
    </PDBxv:pdbx_em_volume_estimateCategory>
    <PDBxv:pdbx_em_volume_estimate_markerCategory>
      <xsl:for-each select="coordinate">
        <xsl:sort select="number(@x)" data-type="number"/>
        <PDBxv:pdbx_em_volume_estimate_marker plot_id="1" ordinal="{position()}">
          <PDBxv:contour_level><xsl:value-of select="number(@x)"/></PDBxv:contour_level>
          <PDBxv:enclosed_volume><xsl:value-of select="number(@y)"/></PDBxv:enclosed_volume>
        </PDBxv:pdbx_em_volume_estimate_marker>
      </xsl:for-each>
    </PDBxv:pdbx_em_volume_estimate_markerCategory>
  </xsl:template>

  <xsl:template match="rotationally_averaged_power_spectrum">
    <PDBxv:pdbx_em_rapsCategory>
      <PDBxv:pdbx_em_raps id="1">
        <PDBxv:spatial_frequency_title><xsl:value-of select="@xTitle"/></PDBxv:spatial_frequency_title>
        <PDBxv:power_title><xsl:value-of select="@yTitle"/></PDBxv:power_title>
        <xsl:if test="@xUnit">
          <PDBxv:spatial_frequency_unit><xsl:value-of select="@xUnit"/></PDBxv:spatial_frequency_unit>
        </xsl:if>
        <xsl:if test="@yScale">
          <PDBxv:power_scale><xsl:value-of select="@yScale"/></PDBxv:power_scale>
        </xsl:if>
      </PDBxv:pdbx_em_raps>
    </PDBxv:pdbx_em_rapsCategory>
    <PDBxv:pdbx_em_raps_markerCategory>
      <xsl:for-each select="coordinate">
        <xsl:sort select="number(@x)" data-type="number"/>
        <PDBxv:pdbx_em_raps_marker plot_id="1" ordinal="{position()}">
          <PDBxv:spatial_frequency><xsl:value-of select="number(@x)"/></PDBxv:spatial_frequency>
          <PDBxv:power><xsl:value-of select="number(@y)"/></PDBxv:power>
        </PDBxv:pdbx_em_raps_marker>
      </xsl:for-each>
    </PDBxv:pdbx_em_raps_markerCategory>
  </xsl:template>

  <xsl:template match="raw_map_rotationally_averaged_power_spectrum">
    <PDBxv:pdbx_em_raw_rapsCategory>
      <PDBxv:pdbx_em_raw_raps id="1">
        <PDBxv:spatial_frequency_title><xsl:value-of select="@xTitle"/></PDBxv:spatial_frequency_title>
        <PDBxv:power_title><xsl:value-of select="@yTitle"/></PDBxv:power_title>
        <xsl:if test="@xUnit">
          <PDBxv:spatial_frequency_unit><xsl:value-of select="@xUnit"/></PDBxv:spatial_frequency_unit>
        </xsl:if>
        <xsl:if test="@yScale">
          <PDBxv:power_scale><xsl:value-of select="@yScale"/></PDBxv:power_scale>
        </xsl:if>
      </PDBxv:pdbx_em_raw_raps>
    </PDBxv:pdbx_em_raw_rapsCategory>
    <PDBxv:pdbx_em_raw_raps_markerCategory>
      <xsl:for-each select="coordinate">
        <xsl:sort select="number(@x)" data-type="number"/>
        <PDBxv:pdbx_em_raw_raps_marker plot_id="1" ordinal="{position()}">
          <PDBxv:spatial_frequency><xsl:value-of select="number(@x)"/></PDBxv:spatial_frequency>
          <PDBxv:power><xsl:value-of select="number(@y)"/></PDBxv:power>
        </PDBxv:pdbx_em_raw_raps_marker>
      </xsl:for-each>
    </PDBxv:pdbx_em_raw_raps_markerCategory>
  </xsl:template>

  <xsl:template match="fsc">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="resolution_intersections">
    <xsl:variable name="spatial_frequency_unit"><xsl:value-of select="@spatial_frequency_unit"/></xsl:variable>
    <xsl:variable name="resolution_unit"><xsl:value-of select="@resolution_unit"/></xsl:variable>
    <PDBxv:pdbx_em_fsc_resolutionCategory>
      <xsl:for-each select="intersection">
        <PDBxv:pdbx_em_fsc_resolution>
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
          <PDBxv:correlation_coef><xsl:value-of select="@correlation"/></PDBxv:correlation_coef>
          <PDBxv:spatial_frequency><xsl:value-of select="@spatial_frequency"/></PDBxv:spatial_frequency>
          <PDBxv:resolution><xsl:value-of select="@resolution"/></PDBxv:resolution>
          <PDBxv:spatial_frequency_unit><xsl:value-of select="$spatial_frequency_unit"/></PDBxv:spatial_frequency_unit>
          <PDBxv:resolution_unit><xsl:value-of select="$resolution_unit"/></PDBxv:resolution_unit>
          <PDBxv:fsc_curve_id>
            <xsl:for-each select="../../fsc_curves/fsc_curve">
              <xsl:if test="@Title=$fsc_curve or @curve_name=$fsc_curve">
                <xsl:value-of select="position()"/>
              </xsl:if>
            </xsl:for-each>
          </PDBxv:fsc_curve_id>
          <PDBxv:fsc_cutoff_curve_id>
            <xsl:for-each select="../../fsc_indicator_curves/fsc_indicator_curve">
              <xsl:if test="@Title=$fsc_cutoff_curve or @curve_name=$fsc_cutoff_curve">
                <xsl:value-of select="position()"/>
              </xsl:if>
            </xsl:for-each>
          </PDBxv:fsc_cutoff_curve_id>
        </PDBxv:pdbx_em_fsc_resolution>
      </xsl:for-each>
    </PDBxv:pdbx_em_fsc_resolutionCategory>
  </xsl:template>

  <xsl:template match="fsc_curves">
    <PDBxv:pdbx_em_fsc_curveCategory>
      <xsl:for-each select="fsc_curve">
        <PDBxv:pdbx_em_fsc_curve>
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <PDBxv:title><xsl:value-of select="@Title"/></PDBxv:title>
          <xsl:if test="@curve_name">
            <PDBxv:name><xsl:value-of select="@curve_name"/></PDBxv:name>
          </xsl:if>
          <xsl:if test="@type">
            <PDBxv:type><xsl:value-of select="@type"/></PDBxv:type>
          </xsl:if>
          <PDBxv:spatial_frequency_title><xsl:value-of select="@xTitle"/></PDBxv:spatial_frequency_title>
          <PDBxv:correlation_coef_title><xsl:value-of select="@yTitle"/></PDBxv:correlation_coef_title>
          <PDBxv:spatial_frequency_unit><xsl:value-of select="@xUnit"/></PDBxv:spatial_frequency_unit>
        </PDBxv:pdbx_em_fsc_curve>
      </xsl:for-each>
    </PDBxv:pdbx_em_fsc_curveCategory>
    <PDBxv:pdbx_em_fsc_curve_markerCategory>
      <xsl:for-each select="fsc_curve">
        <xsl:variable name="plot_id"><xsl:value-of select="position()"/></xsl:variable>
        <xsl:for-each select="coordinate">
          <xsl:sort select="number(@x)" data-type="number"/>
          <PDBxv:pdbx_em_fsc_curve_marker plot_id="{$plot_id}" ordinal="{position()}">
            <PDBxv:spatial_frequency><xsl:value-of select="number(@x)"/></PDBxv:spatial_frequency>
            <PDBxv:correlation_coef><xsl:value-of select="number(@y)"/></PDBxv:correlation_coef>
          </PDBxv:pdbx_em_fsc_curve_marker>
        </xsl:for-each>
      </xsl:for-each>
    </PDBxv:pdbx_em_fsc_curve_markerCategory>
  </xsl:template>

  <xsl:template match="fsc_indicator_curves">
    <PDBxv:pdbx_em_fsc_cutoff_curveCategory>
      <xsl:for-each select="fsc_indicator_curve">
        <PDBxv:pdbx_em_fsc_cutoff_curve>
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
              <PDBxv:title><xsl:value-of select="@Title"/></PDBxv:title>
              <PDBxv:name><xsl:value-of select="@curve_name"/></PDBxv:name>
              <PDBxv:type><xsl:value-of select="@type"/></PDBxv:type>
              <PDBxv:target_name><xsl:value-of select="@data_curve"/></PDBxv:target_name>
            </xsl:when>
            <xsl:otherwise>
              <PDBxv:title><xsl:value-of select="concat($source,'_',$criterion)"/></PDBxv:title>
            </xsl:otherwise>
          </xsl:choose>
          <PDBxv:spatial_frequency_title><xsl:value-of select="@xTitle"/></PDBxv:spatial_frequency_title>
          <PDBxv:correlation_coef_title><xsl:value-of select="@yTitle"/></PDBxv:correlation_coef_title>
          <PDBxv:spatial_frequency_unit><xsl:value-of select="@xUnit"/></PDBxv:spatial_frequency_unit>
        </PDBxv:pdbx_em_fsc_cutoff_curve>
      </xsl:for-each>
    </PDBxv:pdbx_em_fsc_cutoff_curveCategory>
    <PDBxv:pdbx_em_fsc_cutoff_curve_markerCategory>
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
              <PDBxv:pdbx_em_fsc_cutoff_curve_marker plot_id="{$plot_id}" ordinal="{position()}">
                <PDBxv:spatial_frequency><xsl:value-of select="number(@x)"/></PDBxv:spatial_frequency>
                <PDBxv:correlation_coef><xsl:value-of select="number(@y)"/></PDBxv:correlation_coef>
              </PDBxv:pdbx_em_fsc_cutoff_curve_marker>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <PDBxv:pdbx_em_fsc_cutoff_curve_marker plot_id="{$plot_id}" ordinal="1">
              <PDBxv:correlation_coef><xsl:value-of select="$criterion"/></PDBxv:correlation_coef>
            </PDBxv:pdbx_em_fsc_cutoff_curve_marker>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </PDBxv:pdbx_em_fsc_cutoff_curve_markerCategory>
  </xsl:template>

  <xsl:template match="atom_inclusion">
    <PDBxv:pdbx_em_atom_inclusionCategory>
      <xsl:for-each select="*">
        <PDBxv:pdbx_em_atom_inclusion>
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:choose>
            <xsl:when test="name()='all_atoms'">
              <PDBxv:atom_type>all non-hydrogen atoms</PDBxv:atom_type>
            </xsl:when>
            <xsl:when test="name()='backbone'">
              <PDBxv:atom_type>backbone atoms</PDBxv:atom_type>
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
          <PDBxv:contour_level_title><xsl:value-of select="@xTitle"/></PDBxv:contour_level_title>
          <PDBxv:atom_inclusion_title><xsl:value-of select="@yTitle"/></PDBxv:atom_inclusion_title>
        </PDBxv:pdbx_em_atom_inclusion>
      </xsl:for-each>
    </PDBxv:pdbx_em_atom_inclusionCategory>
    <PDBxv:pdbx_em_atom_inclusion_markerCategory>
      <xsl:for-each select="*">
        <xsl:variable name="plot_id"><xsl:value-of select="position()"/></xsl:variable>
        <xsl:for-each select="coordinate">
          <xsl:sort select="number(@x)" data-type="number"/>
          <PDBxv:pdbx_em_atom_inclusion_marker plot_id="{$plot_id}" ordinal="{position()}">
            <PDBxv:contour_level><xsl:value-of select="number(@x)"/></PDBxv:contour_level>
            <PDBxv:atom_inclusion><xsl:value-of select="number(@y)"/></PDBxv:atom_inclusion>
          </PDBxv:pdbx_em_atom_inclusion_marker>
        </xsl:for-each>
      </xsl:for-each>
    </PDBxv:pdbx_em_atom_inclusion_markerCategory>
  </xsl:template>

  <!-- NMR restraint validation: NMR_restraints_analysis -->

  <xsl:template match="NMR_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="conformationally_restricting_restraints">
    <PDBxv:pdbx_nmr_restraint_listCategory>
      <xsl:if test="../../distance_restraints_analysis">
        <PDBxv:pdbx_nmr_restraint_list id="1" type="distance"/>
        <xsl:for-each select="distinct-values(../../distance_restraints_analysis/violated_distance_restraints/violated_distance_restraint/@rlist_id)">
          <xsl:sort select="."/>
          <xsl:variable name="list_id"><xsl:value-of select="."/></xsl:variable>
          <xsl:if test="$list_id!='1'">
            <PDBxv:pdbx_nmr_restraint_list id="{$list_id}" type="distance"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
      <xsl:if test="../../dihedralangle_restraints_analysis">
        <PDBxv:pdbx_nmr_restraint_list id="1" type="dihedral_angle"/>
        <xsl:for-each select="distinct-values(../../dihedralangle_restraints_analysis/violated_dihedralangle_restraints/violated_dihedralangle_restraint/@rlist_id)">
          <xsl:sort select="."/>
          <xsl:variable name="list_id"><xsl:value-of select="."/></xsl:variable>
          <xsl:if test="$list_id!='1'">
            <PDBxv:pdbx_nmr_restraint_list id="{$list_id}" type="dihedral_angle"/>
          </xsl:if>
        </xsl:for-each>
      </xsl:if>
    </PDBxv:pdbx_nmr_restraint_listCategory>
    <PDBxv:pdbx_nmr_restraint_summaryCategory>
      <PDBxv:pdbx_nmr_restraint_summary entry_id="{$entry_id}">
        <xsl:for-each select="restraint_summary">
          <xsl:choose>
            <xsl:when test="@description='Total distance restraints'">
              <PDBxv:distance_restraints_total><xsl:value-of select="@value"/></PDBxv:distance_restraints_total>
            </xsl:when>
            <xsl:when test="@description='Intra-residue (|i-j|=0)'">
              <PDBxv:intraresidue_total_count><xsl:value-of select="@value"/></PDBxv:intraresidue_total_count>
            </xsl:when>
            <xsl:when test="@description='Inter-chain'">
              <PDBxv:interchain_total_count><xsl:value-of select="@value"/></PDBxv:interchain_total_count>
            </xsl:when>
            <xsl:when test="@description='Sequential (|i-j|=1)'">
              <PDBxv:sequential_total_count><xsl:value-of select="@value"/></PDBxv:sequential_total_count>
            </xsl:when>
            <xsl:when test="@description='Medium range (|i-j|&gt;1 and |i-j|&lt;5)'">
              <PDBxv:medium_range_total_count><xsl:value-of select="@value"/></PDBxv:medium_range_total_count>
            </xsl:when>
            <xsl:when test="@description='Long range (|i-j|&gt;=5)'">
              <PDBxv:long_range_total_count><xsl:value-of select="@value"/></PDBxv:long_range_total_count>
            </xsl:when>
            <xsl:when test="@description='Total dihedral-angle restraints'">
              <PDBxv:dihedral_angle_restraints_total><xsl:value-of select="@value"/></PDBxv:dihedral_angle_restraints_total>
            </xsl:when>
            <xsl:when test="@description='Total hydrogen bond restraints'">
              <PDBxv:hydrogen_bond_restraints_total><xsl:value-of select="@value"/></PDBxv:hydrogen_bond_restraints_total>
            </xsl:when>
            <xsl:when test="@description='Total disulfide bond restraints'">
              <PDBxv:disulfide_bond_restraints_total><xsl:value-of select="@value"/></PDBxv:disulfide_bond_restraints_total>
            </xsl:when>
            <xsl:when test="@description='Number of unmapped restraints'">
              <PDBxv:unmapped_restraints_total><xsl:value-of select="@value"/></PDBxv:unmapped_restraints_total>
            </xsl:when>
            <xsl:when test="@description='Number of restraints per residue'">
              <PDBxv:restraints_per_residue><xsl:value-of select="@value"/></PDBxv:restraints_per_residue>
            </xsl:when>
            <xsl:when test="@description='Number of long range restraints per residue'">
              <PDBxv:long_range_restraints_per_residue><xsl:value-of select="@value"/></PDBxv:long_range_restraints_per_residue>
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
      </PDBxv:pdbx_nmr_restraint_summary>
    </PDBxv:pdbx_nmr_restraint_summaryCategory>
    <xsl:if test="../residual_distance_violations or ../residual_angle_violations">
      <PDBxv:pdbx_nmr_restraint_violationCategory>
        <xsl:for-each select="../residual_distance_violations/residual_distance_violation">
          <PDBxv:pdbx_nmr_restraint_violation type="distance" ordinal="{position()}">
            <xsl:choose>
              <xsl:when test="@bins='0.1-0.2'">
                <PDBxv:limit_bin_max>0.2</PDBxv:limit_bin_max>
                <PDBxv:limit_bin_min>0.1</PDBxv:limit_bin_min>
              </xsl:when>
              <xsl:when test="@bins='0.2-0.5'">
                <PDBxv:limit_bin_max>0.5</PDBxv:limit_bin_max>
                <PDBxv:limit_bin_min>0.2</PDBxv:limit_bin_min>
              </xsl:when>
              <xsl:when test="@bins='&gt;0.5'">
                <PDBxv:limit_bin_min>0.5</PDBxv:limit_bin_min>
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
            <PDBxv:maximum_violation_in_bin><xsl:value-of select="@max_violation"/></PDBxv:maximum_violation_in_bin>
            <PDBxv:bin_units>A</PDBxv:bin_units>
            <PDBxv:violations_per_model><xsl:value-of select="@violations_per_model"/></PDBxv:violations_per_model>
          </PDBxv:pdbx_nmr_restraint_violation>
        </xsl:for-each>
        <xsl:for-each select="../residual_angle_violations/residual_angle_violation">
          <PDBxv:pdbx_nmr_restraint_violation type="dihedral_angle" ordinal="{position()}">
            <xsl:choose>
              <xsl:when test="@bins='1.0-10.0'">
                <PDBxv:limit_bin_max>10.0</PDBxv:limit_bin_max>
                <PDBxv:limit_bin_min>1.0</PDBxv:limit_bin_min>
              </xsl:when>
              <xsl:when test="@bins='10.0-20.0'">
                <PDBxv:limit_bin_max>20.0</PDBxv:limit_bin_max>
                <PDBxv:limit_bin_min>10.0</PDBxv:limit_bin_min>
              </xsl:when>
              <xsl:when test="@bins='&gt;20.0'">
                <PDBxv:limit_bin_min>20.0</PDBxv:limit_bin_min>
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
            <PDBxv:maximum_violation_in_bin><xsl:value-of select="@max_violation"/></PDBxv:maximum_violation_in_bin>
            <PDBxv:bin_units>degrees</PDBxv:bin_units>
            <PDBxv:violations_per_model><xsl:value-of select="@violations_per_model"/></PDBxv:violations_per_model>
          </PDBxv:pdbx_nmr_restraint_violation>
        </xsl:for-each>
      </PDBxv:pdbx_nmr_restraint_violationCategory>
    </xsl:if>
  </xsl:template>

  <!-- NMR restraint validation: distance_restraints_analysis -->

  <xsl:template match="distance_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="distance_violations_summary">
    <PDBxv:pdbx_nmr_distance_violation_summaryCategory>
      <xsl:for-each select="distance_violation_summary">
        <PDBxv:pdbx_nmr_distance_violation_summary>
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
Restraint type, <xsl:value-of select="@restraint_sub_type"/>, is not listed in XSLT code.
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
          <PDBxv:restraints_count><xsl:value-of select="@restraints_count"/></PDBxv:restraints_count>
          <PDBxv:restraints_percent><xsl:value-of select="@percent_total"/></PDBxv:restraints_percent>
          <PDBxv:violations_count><xsl:value-of select="@violated_count"/></PDBxv:violations_count>
          <PDBxv:violations_percent><xsl:value-of select="@violated_percent_total"/></PDBxv:violations_percent>
          <PDBxv:violations_percent_type><xsl:value-of select="@violated_percent_type"/></PDBxv:violations_percent_type>
          <PDBxv:consistent_violations_count><xsl:value-of select="@consistently_violated_count"/></PDBxv:consistent_violations_count>
          <PDBxv:consistent_violations_percent><xsl:value-of select="@consistently_violated_percent_total"/></PDBxv:consistent_violations_percent>
          <PDBxv:consistent_violations_percent_type><xsl:value-of select="@consistently_violated_percent_type"/></PDBxv:consistent_violations_percent_type>
        </PDBxv:pdbx_nmr_distance_violation_summary>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_distance_violation_summaryCategory>
  </xsl:template>

  <xsl:template match="distance_violations_in_models">
    <PDBxv:pdbx_nmr_distance_violation_modelCategory>
      <xsl:for-each select="distance_violations_in_model">
        <PDBxv:pdbx_nmr_distance_violation_model PDB_model_num="{@model}">
          <PDBxv:maximum_violation><xsl:value-of select="@max_violation"/></PDBxv:maximum_violation>
          <PDBxv:average_violation><xsl:value-of select="@mean_violation"/></PDBxv:average_violation>
          <PDBxv:median_violation><xsl:value-of select="@median_violation"/></PDBxv:median_violation>
          <PDBxv:standard_deviation><xsl:value-of select="@standard_deviation"/></PDBxv:standard_deviation>
          <xsl:for-each select="dist_rest_types">
            <xsl:choose>
              <xsl:when test="@dist_rest_type='Total'">
                <PDBxv:violations_count><xsl:value-of select="@violations_count"/></PDBxv:violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='Intra-residue'">
                <PDBxv:intraresidue_violations_count><xsl:value-of select="@violations_count"/></PDBxv:intraresidue_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='Sequential'">
                <PDBxv:sequential_violations_count><xsl:value-of select="@violations_count"/></PDBxv:sequential_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='MediumRange'">
                <PDBxv:medium_range_violations_count><xsl:value-of select="@violations_count"/></PDBxv:medium_range_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='LongRange'">
                <PDBxv:long_range_violations_count><xsl:value-of select="@violations_count"/></PDBxv:long_range_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='InterChain'">
                <PDBxv:interchain_violations_count><xsl:value-of select="@violations_count"/></PDBxv:interchain_violations_count>
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
        </PDBxv:pdbx_nmr_distance_violation_model>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_distance_violation_modelCategory>
  </xsl:template>

  <xsl:template match="distance_violations_in_ensemble">
    <PDBxv:pdbx_nmr_distance_violation_ensembleCategory>
      <xsl:for-each select="distance_violation_in_ensemble">
        <PDBxv:pdbx_nmr_distance_violation_ensemble fraction_ensemble_size="{@fraction_of_ensemble_count}">
          <PDBxv:fraction_ensemble_percent><xsl:value-of select="@fraction_of_ensemble_percent"/></PDBxv:fraction_ensemble_percent>
          <xsl:for-each select="dist_rest_types">
            <xsl:choose>
              <xsl:when test="@dist_rest_type='Total'">
                <PDBxv:violations_count><xsl:value-of select="@violations_count"/></PDBxv:violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='Intra-residue'">
                <PDBxv:intraresidue_violations_count><xsl:value-of select="@violations_count"/></PDBxv:intraresidue_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='Sequential'">
                <PDBxv:sequential_violations_count><xsl:value-of select="@violations_count"/></PDBxv:sequential_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='MediumRange'">
                <PDBxv:medium_range_violations_count><xsl:value-of select="@violations_count"/></PDBxv:medium_range_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='LongRange'">
                <PDBxv:long_range_violations_count><xsl:value-of select="@violations_count"/></PDBxv:long_range_violations_count>
              </xsl:when>
              <xsl:when test="@dist_rest_type='InterChain'">
                <PDBxv:interchain_violations_count><xsl:value-of select="@violations_count"/></PDBxv:interchain_violations_count>
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
        </PDBxv:pdbx_nmr_distance_violation_ensemble>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_distance_violation_ensembleCategory>
  </xsl:template>

  <xsl:template match="most_violated_distance_restraints">
    <PDBxv:pdbx_nmr_distance_violation_pluralCategory>
      <xsl:for-each select="most_violated_distance_restraint">
        <PDBxv:pdbx_nmr_distance_violation_plural ordinal="{position()}">
          <PDBxv:list_id><xsl:value-of select="@rlist_id"/></PDBxv:list_id>
          <PDBxv:restraint_id><xsl:value-of select="@rest_id"/></PDBxv:restraint_id>
          <PDBxv:violation_models_count><xsl:value-of select="@violated_models"/></PDBxv:violation_models_count>
          <PDBxv:average_violation><xsl:value-of select="@mean_distance_violation"/></PDBxv:average_violation>
          <PDBxv:median_violation><xsl:value-of select="@median_violation"/></PDBxv:median_violation>
          <PDBxv:standard_deviation><xsl:value-of select="@standard_deviation"/></PDBxv:standard_deviation>
          <PDBxv:entity_id_1><xsl:value-of select="@ent_1"/></PDBxv:entity_id_1>
          <PDBxv:entity_id_2><xsl:value-of select="@ent_2"/></PDBxv:entity_id_2>
          <PDBxv:auth_asym_id_1><xsl:value-of select="@chain_1"/></PDBxv:auth_asym_id_1>
          <PDBxv:auth_asym_id_2><xsl:value-of select="@chain_2"/></PDBxv:auth_asym_id_2>
          <PDBxv:auth_seq_id_1><xsl:value-of select="@resnum_1"/></PDBxv:auth_seq_id_1>
          <PDBxv:auth_seq_id_2><xsl:value-of select="@resnum_2"/></PDBxv:auth_seq_id_2>
          <PDBxv:auth_comp_id_1><xsl:value-of select="@resname_1"/></PDBxv:auth_comp_id_1>
          <PDBxv:auth_comp_id_2><xsl:value-of select="@resname_2"/></PDBxv:auth_comp_id_2>
          <PDBxv:auth_atom_id_1><xsl:value-of select="@atom_1"/></PDBxv:auth_atom_id_1>
          <PDBxv:auth_atom_id_2><xsl:value-of select="@atom_2"/></PDBxv:auth_atom_id_2>
          <PDBxv:label_asym_id_1><xsl:value-of select="@said_1"/></PDBxv:label_asym_id_1>
          <PDBxv:label_asym_id_2><xsl:value-of select="@said_2"/></PDBxv:label_asym_id_2>
          <PDBxv:label_seq_id_1><xsl:value-of select="@seq_1"/></PDBxv:label_seq_id_1>
          <PDBxv:label_seq_id_2><xsl:value-of select="@seq_2"/></PDBxv:label_seq_id_2>
          <PDBxv:PDB_ins_code_1><xsl:value-of select="@icode_1"/></PDBxv:PDB_ins_code_1>
          <PDBxv:PDB_ins_code_2><xsl:value-of select="@icode_2"/></PDBxv:PDB_ins_code_2>
          <PDBxv:label_alt_id_1><xsl:value-of select="@altcode_1"/></PDBxv:label_alt_id_1>
          <PDBxv:label_alt_id_2><xsl:value-of select="@altcode_2"/></PDBxv:label_alt_id_2>
        </PDBxv:pdbx_nmr_distance_violation_plural>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_distance_violation_pluralCategory>
  </xsl:template>

  <xsl:template match="violated_distance_restraints">
    <PDBxv:pdbx_nmr_distance_violationCategory>
      <xsl:for-each select="violated_distance_restraint">
        <PDBxv:pdbx_nmr_distance_violation ordinal="{position()}">
          <PDBxv:list_id><xsl:value-of select="@rlist_id"/></PDBxv:list_id>
          <PDBxv:restraint_id><xsl:value-of select="@rest_id"/></PDBxv:restraint_id>
          <PDBxv:PDB_model_num><xsl:value-of select="@model"/></PDBxv:PDB_model_num>
          <PDBxv:violation><xsl:value-of select="@violation"/></PDBxv:violation>
          <PDBxv:entity_id_1><xsl:value-of select="@ent_1"/></PDBxv:entity_id_1>
          <PDBxv:entity_id_2><xsl:value-of select="@ent_2"/></PDBxv:entity_id_2>
          <PDBxv:auth_asym_id_1><xsl:value-of select="@chain_1"/></PDBxv:auth_asym_id_1>
          <PDBxv:auth_asym_id_2><xsl:value-of select="@chain_2"/></PDBxv:auth_asym_id_2>
          <PDBxv:auth_seq_id_1><xsl:value-of select="@resnum_1"/></PDBxv:auth_seq_id_1>
          <PDBxv:auth_seq_id_2><xsl:value-of select="@resnum_2"/></PDBxv:auth_seq_id_2>
          <PDBxv:auth_comp_id_1><xsl:value-of select="@resname_1"/></PDBxv:auth_comp_id_1>
          <PDBxv:auth_comp_id_2><xsl:value-of select="@resname_2"/></PDBxv:auth_comp_id_2>
          <PDBxv:auth_atom_id_1><xsl:value-of select="@atom_1"/></PDBxv:auth_atom_id_1>
          <PDBxv:auth_atom_id_2><xsl:value-of select="@atom_2"/></PDBxv:auth_atom_id_2>
          <PDBxv:label_asym_id_1><xsl:value-of select="@said_1"/></PDBxv:label_asym_id_1>
          <PDBxv:label_asym_id_2><xsl:value-of select="@said_2"/></PDBxv:label_asym_id_2>
          <PDBxv:label_seq_id_1><xsl:value-of select="@seq_1"/></PDBxv:label_seq_id_1>
          <PDBxv:label_seq_id_2><xsl:value-of select="@seq_2"/></PDBxv:label_seq_id_2>
          <PDBxv:PDB_ins_code_1><xsl:value-of select="@icode_1"/></PDBxv:PDB_ins_code_1>
          <PDBxv:PDB_ins_code_2><xsl:value-of select="@icode_2"/></PDBxv:PDB_ins_code_2>
          <PDBxv:label_alt_id_1><xsl:value-of select="@altcode_1"/></PDBxv:label_alt_id_1>
          <PDBxv:label_alt_id_2><xsl:value-of select="@altcode_2"/></PDBxv:label_alt_id_2>
        </PDBxv:pdbx_nmr_distance_violation>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_distance_violationCategory>
  </xsl:template>

  <!-- NMR restraint validation: dihedralangle_restraints_analysis -->

  <xsl:template match="dihedralangle_restraints_analysis">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_summary">
    <PDBxv:pdbx_nmr_dihedral_angle_violation_summaryCategory>
      <xsl:for-each select="dihedralangle_violation_summary">
        <PDBxv:pdbx_nmr_dihedral_angle_violation_summary>
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
            <xsl:otherwise>
              <xsl:call-template name="error_handler">
                <xsl:with-param name="terminate">yes</xsl:with-param>
                <xsl:with-param name="error_message">
Restraint type, <xsl:value-of select="@restraint_type"/>, is not listed in XSLT code.
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
          <PDBxv:restraints_count><xsl:value-of select="@restraints_count"/></PDBxv:restraints_count>
          <PDBxv:restraints_percent><xsl:value-of select="@percent_total"/></PDBxv:restraints_percent>
          <PDBxv:violations_count><xsl:value-of select="@violated_count"/></PDBxv:violations_count>
          <PDBxv:violations_percent><xsl:value-of select="@violated_percent_total"/></PDBxv:violations_percent>
          <PDBxv:violations_percent_type><xsl:value-of select="@violated_percent_type"/></PDBxv:violations_percent_type>
          <PDBxv:consistent_violations_count><xsl:value-of select="@consistently_violated_count"/></PDBxv:consistent_violations_count>
          <PDBxv:consistent_violations_percent><xsl:value-of select="@consistently_violated_percent_total"/></PDBxv:consistent_violations_percent>
          <PDBxv:consistent_violations_percent_type><xsl:value-of select="@consistently_violated_percent_type"/></PDBxv:consistent_violations_percent_type>
        </PDBxv:pdbx_nmr_dihedral_angle_violation_summary>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_dihedral_angle_violation_summaryCategory>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_in_models">
    <PDBxv:pdbx_nmr_dihedral_angle_violation_modelCategory>
      <xsl:for-each select="dihedralangle_violations_in_model">
        <PDBxv:pdbx_nmr_dihedral_angle_violation_model PDB_model_num="{@model}">
          <PDBxv:maximum_violation><xsl:value-of select="@max_violation"/></PDBxv:maximum_violation>
          <PDBxv:average_violation><xsl:value-of select="@mean_violation"/></PDBxv:average_violation>
          <PDBxv:median_violation><xsl:value-of select="@median_violation"/></PDBxv:median_violation>
          <PDBxv:standard_deviation><xsl:value-of select="@standard_deviation"/></PDBxv:standard_deviation>
          <xsl:for-each select="ang_rest_types">
            <xsl:choose>
              <xsl:when test="@ang_rest_type='Total'">
                <PDBxv:violations_count><xsl:value-of select="@violations_count"/></PDBxv:violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='PHI'">
                <PDBxv:phi_violations_count><xsl:value-of select="@violations_count"/></PDBxv:phi_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='PSI'">
                <PDBxv:psi_violations_count><xsl:value-of select="@violations_count"/></PDBxv:psi_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='OMEGA'">
                <PDBxv:omega_violations_count><xsl:value-of select="@violations_count"/></PDBxv:omega_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI1'">
                <PDBxv:chi1_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi1_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI2'">
                <PDBxv:chi2_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi2_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI3'">
                <PDBxv:chi3_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi3_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI4'">
                <PDBxv:chi4_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi4_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI5'">
                <PDBxv:chi5_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi5_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='ALPHA'">
                <PDBxv:alpha_violations_count><xsl:value-of select="@violations_count"/></PDBxv:alpha_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='BETA'">
                <PDBxv:beta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:beta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='GAMMA'">
                <PDBxv:gamma_violations_count><xsl:value-of select="@violations_count"/></PDBxv:gamma_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='DELTA'">
                <PDBxv:delta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:delta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='EPSILON'">
                <PDBxv:epsilon_violations_count><xsl:value-of select="@violations_count"/></PDBxv:epsilon_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='ZETA'">
                <PDBxv:zeta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:zeta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU0' or @ang_rest_type='TAU0'">
                <PDBxv:nu0_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu0_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU1' or @ang_rest_type='TAU1'">
                <PDBxv:nu1_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu1_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU2' or @ang_rest_type='TAU2'">
                <PDBxv:nu2_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu2_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU3' or @ang_rest_type='TAU3'">
                <PDBxv:nu3_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu3_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU4' or @ang_rest_type='TAU4'">
                <PDBxv:nu4_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu4_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI21'">
                <PDBxv:chi21_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi21_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI22'">
                <PDBxv:chi22_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi22_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI31'">
                <PDBxv:chi31_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi31_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI32'">
                <PDBxv:chi32_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi32_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI42'">
                <PDBxv:chi42_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi42_violations_count>
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
        </PDBxv:pdbx_nmr_dihedral_angle_violation_model>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_dihedral_angle_violation_modelCategory>
  </xsl:template>

  <xsl:template match="dihedralangle_violations_in_ensemble">
    <PDBxv:pdbx_nmr_dihedral_angle_violation_ensembleCategory>
      <xsl:for-each select="dihedralangle_violation_in_ensemble">
        <PDBxv:pdbx_nmr_dihedral_angle_violation_ensemble fraction_ensemble_size="{@fraction_of_ensemble_count}">
          <PDBxv:fraction_ensemble_percent><xsl:value-of select="@fraction_of_ensemble_percent"/></PDBxv:fraction_ensemble_percent>
          <xsl:for-each select="ang_rest_types">
            <xsl:choose>
              <xsl:when test="@ang_rest_type='Total'">
                <PDBxv:violations_count><xsl:value-of select="@violations_count"/></PDBxv:violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='PHI'">
                <PDBxv:phi_violations_count><xsl:value-of select="@violations_count"/></PDBxv:phi_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='PSI'">
                <PDBxv:psi_violations_count><xsl:value-of select="@violations_count"/></PDBxv:psi_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='OMEGA'">
                <PDBxv:omega_violations_count><xsl:value-of select="@violations_count"/></PDBxv:omega_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI1'">
                <PDBxv:chi1_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi1_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI2'">
                <PDBxv:chi2_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi2_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI3'">
                <PDBxv:chi3_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi3_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI4'">
                <PDBxv:chi4_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi4_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI5'">
                <PDBxv:chi5_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi5_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='ALPHA'">
                <PDBxv:alpha_violations_count><xsl:value-of select="@violations_count"/></PDBxv:alpha_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='BETA'">
                <PDBxv:beta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:beta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='GAMMA'">
                <PDBxv:gamma_violations_count><xsl:value-of select="@violations_count"/></PDBxv:gamma_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='DELTA'">
                <PDBxv:delta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:delta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='EPSILON'">
                <PDBxv:epsilon_violations_count><xsl:value-of select="@violations_count"/></PDBxv:epsilon_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='ZETA'">
                <PDBxv:zeta_violations_count><xsl:value-of select="@violations_count"/></PDBxv:zeta_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU0' or @ang_rest_type='TAU0'">
                <PDBxv:nu0_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu0_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU1' or @ang_rest_type='TAU1'">
                <PDBxv:nu1_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu1_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU2' or @ang_rest_type='TAU2'">
                <PDBxv:nu2_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu2_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU3' or @ang_rest_type='TAU3'">
                <PDBxv:nu3_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu3_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='NU4' or @ang_rest_type='TAU4'">
                <PDBxv:nu4_violations_count><xsl:value-of select="@violations_count"/></PDBxv:nu4_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI21'">
                <PDBxv:chi21_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi21_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI22'">
                <PDBxv:chi22_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi22_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI31'">
                <PDBxv:chi31_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi31_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI32'">
                <PDBxv:chi32_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi32_violations_count>
              </xsl:when>
              <xsl:when test="@ang_rest_type='CHI42'">
                <PDBxv:chi42_violations_count><xsl:value-of select="@violations_count"/></PDBxv:chi42_violations_count>
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
        </PDBxv:pdbx_nmr_dihedral_angle_violation_ensemble>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_dihedral_angle_violation_ensembleCategory>
  </xsl:template>

  <xsl:template match="most_violated_dihedralangle_restraints">
    <PDBxv:pdbx_nmr_dihedral_angle_violation_pluralCategory>
      <xsl:for-each select="most_violated_dihedralangle_restraint">
        <PDBxv:pdbx_nmr_dihedral_angle_violation_plural ordinal="{position()}">
          <PDBxv:list_id><xsl:value-of select="@rlist_id"/></PDBxv:list_id>
          <PDBxv:restraint_id><xsl:value-of select="@rest_id"/></PDBxv:restraint_id>
          <PDBxv:violation_models_count><xsl:value-of select="@violations_count"/></PDBxv:violation_models_count>
          <PDBxv:average_violation><xsl:value-of select="@MeanAngleViolation"/></PDBxv:average_violation>
          <PDBxv:median_violation><xsl:value-of select="@median_violation"/></PDBxv:median_violation>
          <PDBxv:standard_deviation><xsl:value-of select="@standard_deviation"/></PDBxv:standard_deviation>
          <PDBxv:entity_id><xsl:value-of select="@ent_1"/></PDBxv:entity_id>
          <PDBxv:auth_asym_id><xsl:value-of select="@chain_1"/></PDBxv:auth_asym_id>
          <PDBxv:auth_seq_id_1><xsl:value-of select="@resnum_1"/></PDBxv:auth_seq_id_1>
          <PDBxv:auth_seq_id_2><xsl:value-of select="@resnum_2"/></PDBxv:auth_seq_id_2>
          <PDBxv:auth_seq_id_3><xsl:value-of select="@resnum_3"/></PDBxv:auth_seq_id_3>
          <PDBxv:auth_seq_id_4><xsl:value-of select="@resnum_4"/></PDBxv:auth_seq_id_4>
          <PDBxv:auth_comp_id_1><xsl:value-of select="@resname_1"/></PDBxv:auth_comp_id_1>
          <PDBxv:auth_comp_id_2><xsl:value-of select="@resname_2"/></PDBxv:auth_comp_id_2>
          <PDBxv:auth_comp_id_3><xsl:value-of select="@resname_3"/></PDBxv:auth_comp_id_3>
          <PDBxv:auth_comp_id_4><xsl:value-of select="@resname_4"/></PDBxv:auth_comp_id_4>
          <PDBxv:auth_atom_id_1><xsl:value-of select="@atom_1"/></PDBxv:auth_atom_id_1>
          <PDBxv:auth_atom_id_2><xsl:value-of select="@atom_2"/></PDBxv:auth_atom_id_2>
          <PDBxv:auth_atom_id_3><xsl:value-of select="@atom_3"/></PDBxv:auth_atom_id_3>
          <PDBxv:auth_atom_id_4><xsl:value-of select="@atom_4"/></PDBxv:auth_atom_id_4>
          <PDBxv:label_asym_id><xsl:value-of select="@said_1"/></PDBxv:label_asym_id>
          <PDBxv:label_seq_id_1><xsl:value-of select="@seq_1"/></PDBxv:label_seq_id_1>
          <PDBxv:label_seq_id_2><xsl:value-of select="@seq_2"/></PDBxv:label_seq_id_2>
          <PDBxv:label_seq_id_3><xsl:value-of select="@seq_3"/></PDBxv:label_seq_id_3>
          <PDBxv:label_seq_id_4><xsl:value-of select="@seq_4"/></PDBxv:label_seq_id_4>
          <PDBxv:PDB_ins_code_1><xsl:value-of select="@icode_1"/></PDBxv:PDB_ins_code_1>
          <PDBxv:PDB_ins_code_2><xsl:value-of select="@icode_2"/></PDBxv:PDB_ins_code_2>
          <PDBxv:PDB_ins_code_3><xsl:value-of select="@icode_3"/></PDBxv:PDB_ins_code_3>
          <PDBxv:PDB_ins_code_4><xsl:value-of select="@icode_4"/></PDBxv:PDB_ins_code_4>
          <PDBxv:label_alt_id_1><xsl:value-of select="@altcode_1"/></PDBxv:label_alt_id_1>
          <PDBxv:label_alt_id_2><xsl:value-of select="@altcode_2"/></PDBxv:label_alt_id_2>
          <PDBxv:label_alt_id_3><xsl:value-of select="@altcode_3"/></PDBxv:label_alt_id_3>
          <PDBxv:label_alt_id_4><xsl:value-of select="@altcode_4"/></PDBxv:label_alt_id_4>
        </PDBxv:pdbx_nmr_dihedral_angle_violation_plural>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_dihedral_angle_violation_pluralCategory>
  </xsl:template>

  <xsl:template match="violated_dihedralangle_restraints">
    <PDBxv:pdbx_nmr_dihedral_angle_violationCategory>
      <xsl:for-each select="violated_dihedralangle_restraint">
        <PDBxv:pdbx_nmr_dihedral_angle_violation ordinal="{position()}">
          <PDBxv:list_id><xsl:value-of select="@rlist_id"/></PDBxv:list_id>
          <PDBxv:restraint_id><xsl:value-of select="@rest_id"/></PDBxv:restraint_id>
          <PDBxv:PDB_model_num><xsl:value-of select="@model"/></PDBxv:PDB_model_num>
          <PDBxv:violation><xsl:value-of select="@violation"/></PDBxv:violation>
          <PDBxv:entity_id><xsl:value-of select="@ent_1"/></PDBxv:entity_id>
          <PDBxv:auth_asym_id><xsl:value-of select="@chain_1"/></PDBxv:auth_asym_id>
          <PDBxv:auth_seq_id_1><xsl:value-of select="@resnum_1"/></PDBxv:auth_seq_id_1>
          <PDBxv:auth_seq_id_2><xsl:value-of select="@resnum_2"/></PDBxv:auth_seq_id_2>
          <PDBxv:auth_seq_id_3><xsl:value-of select="@resnum_3"/></PDBxv:auth_seq_id_3>
          <PDBxv:auth_seq_id_4><xsl:value-of select="@resnum_4"/></PDBxv:auth_seq_id_4>
          <PDBxv:auth_comp_id_1><xsl:value-of select="@resname_1"/></PDBxv:auth_comp_id_1>
          <PDBxv:auth_comp_id_2><xsl:value-of select="@resname_2"/></PDBxv:auth_comp_id_2>
          <PDBxv:auth_comp_id_3><xsl:value-of select="@resname_3"/></PDBxv:auth_comp_id_3>
          <PDBxv:auth_comp_id_4><xsl:value-of select="@resname_4"/></PDBxv:auth_comp_id_4>
          <PDBxv:auth_atom_id_1><xsl:value-of select="@atom_1"/></PDBxv:auth_atom_id_1>
          <PDBxv:auth_atom_id_2><xsl:value-of select="@atom_2"/></PDBxv:auth_atom_id_2>
          <PDBxv:auth_atom_id_3><xsl:value-of select="@atom_3"/></PDBxv:auth_atom_id_3>
          <PDBxv:auth_atom_id_4><xsl:value-of select="@atom_4"/></PDBxv:auth_atom_id_4>
          <PDBxv:label_asym_id><xsl:value-of select="@said_1"/></PDBxv:label_asym_id>
          <PDBxv:label_seq_id_1><xsl:value-of select="@seq_1"/></PDBxv:label_seq_id_1>
          <PDBxv:label_seq_id_2><xsl:value-of select="@seq_2"/></PDBxv:label_seq_id_2>
          <PDBxv:label_seq_id_3><xsl:value-of select="@seq_3"/></PDBxv:label_seq_id_3>
          <PDBxv:label_seq_id_4><xsl:value-of select="@seq_4"/></PDBxv:label_seq_id_4>
          <PDBxv:PDB_ins_code_1><xsl:value-of select="@icode_1"/></PDBxv:PDB_ins_code_1>
          <PDBxv:PDB_ins_code_2><xsl:value-of select="@icode_2"/></PDBxv:PDB_ins_code_2>
          <PDBxv:PDB_ins_code_3><xsl:value-of select="@icode_3"/></PDBxv:PDB_ins_code_3>
          <PDBxv:PDB_ins_code_4><xsl:value-of select="@icode_4"/></PDBxv:PDB_ins_code_4>
          <PDBxv:label_alt_id_1><xsl:value-of select="@altcode_1"/></PDBxv:label_alt_id_1>
          <PDBxv:label_alt_id_2><xsl:value-of select="@altcode_2"/></PDBxv:label_alt_id_2>
          <PDBxv:label_alt_id_3><xsl:value-of select="@altcode_3"/></PDBxv:label_alt_id_3>
          <PDBxv:label_alt_id_4><xsl:value-of select="@altcode_4"/></PDBxv:label_alt_id_4>
        </PDBxv:pdbx_nmr_dihedral_angle_violation>
      </xsl:for-each>
    </PDBxv:pdbx_nmr_dihedral_angle_violationCategory>
  </xsl:template>

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
            <xsl:when test="@name='buster-report'">geometric validation package for ligand chemistry in protein x-ray structures</xsl:when>
            <xsl:when test="@name='visualanalysis'">em map-model validation package</xsl:when>
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
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="missing_nmrstar_tag">
        <PDBxv:pdbx_missing_nmr_star_item list_id="{$list_id}">
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:element name="PDBxv:name"><xsl:value-of select="@nmrstar_tag"/></xsl:element>
          <xsl:element name="PDBxv:description"><xsl:value-of select="@nmrstar_tag_description"/></xsl:element>
        </PDBxv:pdbx_missing_nmr_star_item>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_assigned_chem_shift_list">
    <xsl:param name="id"/>
    <xsl:for-each select="current()">
    <PDBxv:pdbx_nmr_assigned_chem_shift_list id="{$id}">
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
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="random_coil_index">
        <PDBxv:pdbx_nmr_chem_shift_annotation list_id="{$list_id}">
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:random_coil_index"><xsl:value-of select="@value"/></xsl:element>
        </PDBxv:pdbx_nmr_chem_shift_annotation>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_well_defined">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="assignment_completeness_well_defined">
        <xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
        <xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
        <PDBxv:pdbx_nmr_chem_shift_completeness list_id="{$list_id}">
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
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="assignment_completeness_full_length">
        <xsl:variable name="atom_group"><xsl:value-of select="@type"/></xsl:variable>
        <xsl:variable name="atom_type"><xsl:value-of select="@element"/></xsl:variable>
        <PDBxv:pdbx_nmr_chem_shift_completeness list_id="{$list_id}">
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
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="referencing_offset">
        <PDBxv:pdbx_nmr_chem_shift_re_offset list_id="{$list_id}">
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
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="unmapped_chemical_shift">
        <PDBxv:pdbx_nmr_unmapped_chem_shift list_id="{$list_id}">
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
          <xsl:element name="PDBxv:val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:if test="@error and @error!='?' and @error!='.'">
            <xsl:element name="PDBxv:val_err"><xsl:value-of select="@error"/></xsl:element>
          </xsl:if>
          <xsl:if test="@ambiguity and @ambiguity=('1','2','3','4','5','6','9')">
            <xsl:element name="PDBxv:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:details"><xsl:value-of select="@diagnostic"/></xsl:element>
        </PDBxv:pdbx_nmr_unmapped_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_nmr_unparsed_chem_shift">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="unparsed_chemical_shift">
        <PDBxv:pdbx_nmr_unparsed_chem_shift list_id="{$list_id}">
          <xsl:attribute name="id"><xsl:value-of select="position()"/></xsl:attribute>
          <xsl:if test="@id and @id!='?' and @id!='.'">
            <xsl:element name="PDBxv:chem_shift_id"><xsl:value-of select="@id"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
          <xsl:element name="PDBxv:auth_comp_id"><xsl:value-of select="@rescode"/></xsl:element>
          <xsl:element name="PDBxv:auth_seq_id"><xsl:value-of select="@resnum"/></xsl:element>
          <xsl:element name="PDBxv:auth_atom_id"><xsl:value-of select="@atom"/></xsl:element>
          <xsl:element name="PDBxv:val"><xsl:value-of select="@value"/></xsl:element>
          <xsl:if test="@error and @error!='?' and @error!='.'">
            <xsl:element name="PDBxv:val_err"><xsl:value-of select="@error"/></xsl:element>
          </xsl:if>
          <xsl:if test="@ambiguity and @ambiguity=('1','2','3','4','5','6','9')">
            <xsl:element name="PDBxv:ambiguity_code"><xsl:value-of select="@ambiguity"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:details"><xsl:value-of select="@diagnostic"/></xsl:element>
        </PDBxv:pdbx_nmr_unparsed_chem_shift>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="pdbx_validate_nmr_chem_shift">
    <xsl:param name="list_id"/>
    <xsl:for-each select="current()">
      <xsl:for-each select="chemical_shift_outlier">
        <PDBxv:pdbx_validate_nmr_chem_shift list_id="{$list_id}">
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
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-RNAsuiteness"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-RNAsuiteness">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rna}" type="RNA_suiteness_score">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-RNAsuiteness"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-clashscore">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_clash}" type="all_atom_clashscore">
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-clashscore"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-clashscore">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_clash}" type="all_atom_clashscore">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-clashscore"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rama}" type="Ramachandran_outlier_percent">
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-rama-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rama-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rama}" type="Ramachandran_outlier_percent">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-percent-rama-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rota}" type="rotamer_outliers_percent">
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-rota-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-rota-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rota}" type="rotamer_outliers_percent">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-percent-rota-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rfree}" type="R_value_R_free">
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rfree}" type="R_value_R_free">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@absolute-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_abs_rsrz}" type="RSRZ_outliers_percent">
          <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
          <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
        </PDBxv:pdbx_percentile_view>
      </xsl:if>

      <xsl:if test="@relative-percentile-percent-RSRZ-outliers">
        <PDBxv:pdbx_percentile_view entry_id="{$entry_id}" conditions_id="{$last_view_rel_rsrz}" type="RSRZ_outliers_percent">
          <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
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
          <xsl:if test="@high-resol-relative-percentile-RNAsuiteness">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-RNAsuiteness"/></xsl:element>
          </xsl:if>
          <xsl:if test="@low-resol-relative-percentile-RNAsuiteness">
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-RNAsuiteness"/></xsl:element>
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
          <xsl:if test="@high-resol-relative-percentile-clashscore">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-clashscore"/></xsl:element>
          </xsl:if>
          <xsl:if test="@low-resol-relative-percentile-clashscore">
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-clashscore"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="@absolute-percentile-percent-rama-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rama}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rama-outliers"/></xsl:element>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_rama_percentile and @absolute_rama_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rama}"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="@relative-percentile-percent-rama-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rama}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rama-outliers"/></xsl:element>
            <xsl:if test="@high-resol-relative-percentile-percent-rama-outliers">
              <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
            </xsl:if>
            <xsl:if test="@low-resol-relative-percentile-percent-rama-outliers">
              <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rama-outliers"/></xsl:element>
            </xsl:if>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_rama_percentile and @relative_rama_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rama}"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="@absolute-percentile-percent-rota-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rota}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-rota-outliers"/></xsl:element>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_sidechain_percentile and @absolute_sidechain_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rota}"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="@relative-percentile-percent-rota-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rota}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-rota-outliers"/></xsl:element>
            <xsl:if test="@high-resol-relative-percentile-percent-rota-outliers">
              <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
            </xsl:if>
            <xsl:if test="@low-resol-relative-percentile-percent-rota-outliers">
              <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-rota-outliers"/></xsl:element>
            </xsl:if>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@relative_sidechain_percentile and @relative_sidechain_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rota}"/>
        </xsl:when>
      </xsl:choose>

      <xsl:if test="@absolute-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rfree}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-DCC_Rfree"/></xsl:element>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:if test="@relative-percentile-DCC_Rfree">
        <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rfree}">
          <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-DCC_Rfree"/></xsl:element>
          <xsl:if test="@high-resol-relative-percentile-DCC_Rfree">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-DCC_Rfree"/></xsl:element>
          </xsl:if>
          <xsl:if test="@low-resol-relative-percentile-DCC_Rfree">
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-DCC_Rfree"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_percentile_conditions>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="@absolute-percentile-percent-RSRZ-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rsrz}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-absolute-percentile-percent-RSRZ-outliers"/></xsl:element>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_abs_rsrz}"/>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="@relative-percentile-percent-RSRZ-outliers">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rsrz}">
            <xsl:element name="PDBxv:number_entries_total"><xsl:value-of select="@numPDBids-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
            <xsl:if test="@high-resol-relative-percentile-percent-RSRZ-outliers">
              <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@high-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
            </xsl:if>
            <xsl:if test="@low-resol-relative-percentile-percent-RSRZ-outliers">
              <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@low-resol-relative-percentile-percent-RSRZ-outliers"/></xsl:element>
            </xsl:if>
          </PDBxv:pdbx_percentile_conditions>
        </xsl:when>
        <xsl:when test="/wwPDB-validation-information/ModelledEntityInstance[@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable']">
          <PDBxv:pdbx_percentile_conditions id="{$last_cond_rel_rsrz}"/>
        </xsl:when>
      </xsl:choose>

    </PDBxv:pdbx_percentile_conditionsCategory>
  </xsl:template>

  <xsl:template name="pdbx_percentile_entity_view">

    <xsl:if test="@absolute_RSRZ_percentile and @absolute_RSRZ_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rsrz}" type="RSRZ_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_RSRZ_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_RSRZ_percentile and @relative_RSRZ_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rsrz}" type="RSRZ_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_RSRZ_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_rama_percentile and @absolute_rama_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rama}" type="Ramachandran_outlier_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_rama_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_rama_percentile and @relative_rama_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rama}" type="Ramachandran_outlier_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_rama_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@absolute_sidechain_percentile and @absolute_sidechain_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_abs_rota}" type="rotamer_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">absolute</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@absolute_sidechain_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

    <xsl:if test="@relative_sidechain_percentile and @relative_sidechain_percentile!='NotAvailable'">
      <PDBxv:pdbx_percentile_entity_view conditions_id="{$last_cond_rel_rota}" type="rotamer_outliers_percent">
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:conditions_label">relative</xsl:element>
        <xsl:element name="PDBxv:rank"><xsl:value-of select="@relative_sidechain_percentile"/></xsl:element>
      </PDBxv:pdbx_percentile_entity_view>
    </xsl:if>

  </xsl:template>

  <xsl:template name="pdbx_dcc_density">
    <xsl:if test="$dcc_version!=''">
      <PDBxv:pdbx_dcc_densityCategory>
        <PDBxv:pdbx_dcc_density entry_id="{$entry_id}">
          <xsl:if test="@babinet_b">
            <xsl:element name="PDBxv:B_babinet"><xsl:value-of select="@babinet_b"/></xsl:element>
          </xsl:if>
          <xsl:if test="@bulk_solvent_b">
            <xsl:element name="PDBxv:B_solvent"><xsl:value-of select="@bulk_solvent_b"/></xsl:element>
          </xsl:if>
          <xsl:if test="@WilsonBestimate">
            <xsl:element name="PDBxv:B_wilson"><xsl:value-of select="@WilsonBestimate"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:DCC_version"><xsl:value-of select="$dcc_version"/></xsl:element>
          <xsl:if test="@IoverSigma">
            <xsl:element name="PDBxv:I_over_sigI_resh"><xsl:value-of select="substring-before(@IoverSigma,'(')"/></xsl:element>
          </xsl:if>
          <xsl:if test="@numMillerIndices">
            <xsl:element name="PDBxv:reflns_number_obs"><xsl:value-of select="@numMillerIndices"/></xsl:element>
          </xsl:if>
          <xsl:if test="@babinet_k">
            <xsl:element name="PDBxv:K_babinet"><xsl:value-of select="@babinet_k"/></xsl:element>
          </xsl:if>
          <xsl:if test="@bulk_solvent_k">
            <xsl:element name="PDBxv:K_solvent"><xsl:value-of select="@bulk_solvent_k"/></xsl:element>
          </xsl:if>
          <xsl:if test="@TwinL">
            <xsl:element name="PDBxv:Padilla-Yeates_L_mean"><xsl:value-of select="@TwinL"/></xsl:element>
          </xsl:if>
          <xsl:if test="@TwinL2">
            <xsl:element name="PDBxv:Padilla-Yeates_L2_mean"><xsl:value-of select="@TwinL2"/></xsl:element>
          </xsl:if>
          <xsl:if test="@DCC_R and @DCC_R!='NotAvailable'">
            <xsl:element name="PDBxv:R_value_R_work"><xsl:value-of select="@DCC_R"/></xsl:element>
          </xsl:if>
          <xsl:if test="@DCC_Rfree and @DCC_Rfree!='NotAvailable'">
            <xsl:element name="PDBxv:R_value_R_free"><xsl:value-of select="@DCC_Rfree"/></xsl:element>
            <xsl:element name="PDBxv:Rfree-Rwork"><xsl:value-of select="format-number(number(@DCC_Rfree)-number(@DCC_R),'0.00')"/></xsl:element>
          </xsl:if>
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
          <xsl:if test="@DataAnisotropy">
            <xsl:element name="PDBxv:anisotropy"><xsl:value-of select="@DataAnisotropy"/></xsl:element>
          </xsl:if>
          <xsl:if test="@TransNCS">
            <xsl:element name="PDBxv:error"><xsl:value-of select="@TransNCS"/></xsl:element>
          </xsl:if>
          <xsl:element name="PDBxv:iso_B_value_type"><xsl:value-of select="lower-case(@B_factor_type)"/></xsl:element>
          <xsl:if test="@PDB-resolution and @PDB-resolution!='NotAvailable'">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@PDB-resolution"/></xsl:element>
          </xsl:if>
          <xsl:if test="@PDB-resolution-low and @PDB-resolution-low!='NotAvailable'">
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@PDB-resolution-low"/></xsl:element>
          </xsl:if>
          <xsl:if test="@acentric_outliers">
            <xsl:element name="PDBxv:reflns_outlier_acentric"><xsl:value-of select="@acentric_outliers"/></xsl:element>
          </xsl:if>
          <xsl:if test="@centric_outliers">
            <xsl:element name="PDBxv:reflns_outlier_centric"><xsl:value-of select="@centric_outliers"/></xsl:element>
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
            <xsl:element name="PDBxv:twin_fraction_xtriage"><xsl:value-of select="normalize-space($twin_fraction)"/></xsl:element>
            <xsl:element name="PDBxv:twin_operator_xtriage"><xsl:value-of select="normalize-space($twin_operator)"/></xsl:element>
          </xsl:if>
          <xsl:if test="@DataCompleteness">
            <xsl:element name="PDBxv:ls_percent_reflns_obs"><xsl:value-of select="@DataCompleteness"/></xsl:element>
          </xsl:if>
          <xsl:if test="@num-free-reflections">
            <xsl:element name="PDBxv:ls_number_reflns_R_free"><xsl:value-of select="@num-free-reflections"/></xsl:element>
          </xsl:if>
          <xsl:if test="@percent-free-reflections">
            <xsl:element name="PDBxv:ls_percent_reflns_R_free"><xsl:value-of select="@percent-free-reflections"/></xsl:element>
          </xsl:if>
          <xsl:variable name="wavelength"><xsl:value-of select="$ext_datablock/PDBxv:diffrn_radiation_wavelengthCategory/PDBxv:diffrn_radiation_wavelength[1]/PDBxv:wavelength"/></xsl:variable>
          <xsl:if test="$wavelength!=''">
            <xsl:element name="PDBxv:wavelength"><xsl:value-of select="$wavelength"/></xsl:element>
          </xsl:if>
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

  <xsl:template name="pdbx_dcc_density_corr">
    <xsl:if test="$dcc_version!=''">
      <PDBxv:pdbx_dcc_density_corrCategory>
        <PDBxv:pdbx_dcc_density_corr ordinal="1">
          <PDBxv:program>EDS</PDBxv:program>
          <xsl:if test="@EDS_resolution and @EDS_resolution!='NotAvailable'">
            <xsl:element name="PDBxv:ls_d_res_high"><xsl:value-of select="@EDS_resolution"/></xsl:element>
          </xsl:if>
          <xsl:if test="@EDS_resolution_low and @EDS_resolution_low!='NotAvailable'">
            <xsl:element name="PDBxv:ls_d_res_low"><xsl:value-of select="@EDS_resolution_low"/></xsl:element>
          </xsl:if>
          <xsl:if test="@EDS_R and @EDS_R!='NotAvailable'">
            <xsl:element name="PDBxv:ls_R_factor_R_work"><xsl:value-of select="@EDS_R"/></xsl:element>
          </xsl:if>
          <xsl:if test="@numMillerIndices">
            <xsl:element name="PDBxv:ls_number_reflns_obs"><xsl:value-of select="@numMillerIndices"/></xsl:element>
          </xsl:if>
          <xsl:if test="@DataCompleteness">
            <xsl:element name="PDBxv:ls_percent_reflns_obs"><xsl:value-of select="@DataCompleteness"/></xsl:element>
          </xsl:if>
          <xsl:if test="@num-free-reflections">
            <xsl:element name="PDBxv:ls_number_reflns_R_free"><xsl:value-of select="@num-free-reflections"/></xsl:element>
          </xsl:if>
          <xsl:if test="@percent-free-reflections">
            <xsl:element name="PDBxv:ls_percent_reflns_R_free"><xsl:value-of select="@percent-free-reflections"/></xsl:element>
          </xsl:if>
          <xsl:if test="@Fo_Fc_correlation">
            <xsl:element name="PDBxv:correlation_coeff_Fo_to_Fc"><xsl:value-of select="@Fo_Fc_correlation"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_dcc_density_corr>
      </PDBxv:pdbx_dcc_density_corrCategory>
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
          <xsl:if test="@percent-rama-outliers and $nmr=true()">
            <xsl:element name="PDBxv:Ramachandran_outlier_percent_nmr_well_formed"><xsl:value-of select="@percent-rama-outliers"/></xsl:element>
          </xsl:if>
        </xsl:if>
        <xsl:if test="@clashscore or ($nmr=true() and @clashscore-full-length)">
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
        </xsl:if>
        <xsl:if test="@clashscore and $nmr=true()">
          <xsl:element name="PDBxv:all_atom_clashscore_nmr_well_formed"><xsl:value-of select="@clashscore"/></xsl:element>
        </xsl:if>
        <xsl:if test="@angles_rmsz">
          <xsl:element name="PDBxv:angle_overall_rmsz"><xsl:value-of select="@angles_rmsz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@bonds_rmsz">
          <xsl:element name="PDBxv:bond_overall_rmsz"><xsl:value-of select="@bonds_rmsz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@num_angles_rmsz">
          <xsl:element name="PDBxv:number_angles"><xsl:value-of select="@num_angles_rmsz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@num_bonds_rmsz">
          <xsl:element name="PDBxv:number_bonds"><xsl:value-of select="@num_bonds_rmsz"/></xsl:element>
        </xsl:if>
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
          <xsl:if test="@percent-rota-outliers and $nmr=true()">
            <xsl:element name="PDBxv:rotamer_outliers_percent_nmr_well_formed"><xsl:value-of select="@percent-rota-outliers"/></xsl:element>
          </xsl:if>
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
        <xsl:if test="@ligRSRZ">
          <xsl:element name="PDBxv:LLDFZ"><xsl:value-of select="@ligRSRZ"/></xsl:element>
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
        <xsl:if test="@ligRSRnbrMean">
          <xsl:element name="PDBxv:LLDF"><xsl:value-of select="@ligRSRnbrMean"/></xsl:element>
        </xsl:if>
        <xsl:if test="@ligRSRnbrStdev">
          <xsl:element name="PDBxv:LLDF_sigma"><xsl:value-of select="@ligRSRnbrStdev"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rscc">
          <xsl:element name="PDBxv:RSCC"><xsl:value-of select="@rscc"/></xsl:element>
        </xsl:if>
        <xsl:if test="@rsr">
          <xsl:element name="PDBxv:RSR"><xsl:value-of select="@rsr"/></xsl:element>
        </xsl:if>
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
        <xsl:element name="PDBxv:number_angles"><xsl:value-of select="@num_angles_rmsz"/></xsl:element>
        <xsl:element name="PDBxv:number_bonds"><xsl:value-of select="@num_bonds_rmsz"/></xsl:element>
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
        <xsl:if test="@mogul_angles_rmsz">
          <xsl:element name="PDBxv:angle_overall_rmsz"><xsl:value-of select="@mogul_angles_rmsz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@mogul_bonds_rmsz">
          <xsl:element name="PDBxv:bond_overall_rmsz"><xsl:value-of select="@mogul_bonds_rmsz"/></xsl:element>
        </xsl:if>
        <xsl:if test="@mogul_rmsz_numangles">
          <xsl:element name="PDBxv:number_angles"><xsl:value-of select="@mogul_rmsz_numangles"/></xsl:element>
        </xsl:if>
        <xsl:if test="@mogul_rmsz_numbonds">
          <xsl:element name="PDBxv:number_bonds"><xsl:value-of select="@mogul_rmsz_numbonds"/></xsl:element>
        </xsl:if>
        <xsl:if test="@ligand_geometry_outlier='yes'">
          <xsl:element name="PDBxv:LLDFZ_outlier_flag">Y</xsl:element>
        </xsl:if>
      </PDBxv:pdbx_dcc_mon_geometry>
    </xsl:if>
  </xsl:template>

  <xsl:template name="struct_mon_prot">
    <xsl:if test="@phi or @psi or @rama or @rota">
      <PDBxv:struct_mon_prot>
        <xsl:attribute name="pdbx_id"><xsl:value-of select="position()"/></xsl:attribute>
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
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
        <xsl:if test="@phi">
          <xsl:element name="PDBxv:phi"><xsl:value-of select="@phi"/></xsl:element>
        </xsl:if>
        <xsl:if test="@psi">
          <xsl:element name="PDBxv:psi"><xsl:value-of select="@psi"/></xsl:element>
        </xsl:if>
        <xsl:if test="count(plane-outlier/@omega)=1">
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
        <xsl:element name="PDBxv:PDB_model_num"><xsl:value-of select="@model"/></xsl:element>
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
      <xsl:element name="PDBxv:angle_deviation"><xsl:value-of select="format-number(number(@obs)-number(@mean),'0.00')"/></xsl:element>
      <xsl:element name="PDBxv:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:angle_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:element name="PDBxv:Zscore"><xsl:value-of select="@z"/></xsl:element>
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
      <xsl:element name="PDBxv:bond_deviation"><xsl:value-of select="format-number(number(@obs)-number(@mean),'0.000')"/></xsl:element>
      <xsl:element name="PDBxv:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:bond_value"><xsl:value-of select="@obs"/></xsl:element>
      <xsl:element name="PDBxv:Zscore"><xsl:value-of select="@z"/></xsl:element>
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
    <xsl:choose>
      <xsl:when test="following::clash/@cid=$cid or ../following::ModelledSubgroup/clash[@cid=$cid]">
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
      </xsl:when>
      <xsl:otherwise>
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
          <xsl:element name="PDBxv:auth_asym_id_2"/>
          <xsl:element name="PDBxv:auth_comp_id_2"/>
          <xsl:element name="PDBxv:auth_seq_id_2"/>
          <xsl:element name="PDBxv:auth_atom_id_2"/>
          <xsl:element name="PDBxv:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
          <xsl:element name="PDBxv:dist"><xsl:value-of select="@dist"/></xsl:element>
<!-- unmapped data items
<PDBxv:symm_as_xyz_1> xsd:string </PDBxv:symm_as_xyz_1> [0..1]
<PDBxv:symm_as_xyz_2> xsd:string </PDBxv:symm_as_xyz_2> [0..1]
-->
        </PDBxv:pdbx_validate_close_contact>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="append_symm_clash_to_pdbx_validate_symm_contact">
    <xsl:variable name="scid"><xsl:value-of select="@scid"/></xsl:variable>
    <xsl:if test="following::symm-clash/@scid=$scid or ../following::ModelledSubgroup/symm-clash[@scid=$scid]">
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
        <xsl:choose>
          <xsl:when test="following::symm-clash/@scid=$scid">
            <xsl:for-each select="following::symm-clash[@scid=$scid]">
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
          </xsl:when>
          <xsl:otherwise>
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
          </xsl:otherwise>
        </xsl:choose>
        <xsl:element name="PDBxv:clash_magnitude"><xsl:value-of select="@clashmag"/></xsl:element>
        <xsl:element name="PDBxv:dist"><xsl:value-of select="@dist"/></xsl:element>
      </PDBxv:pdbx_validate_symm_contact>
    </xsl:if>
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
      <xsl:for-each select="tokenize(replace(replace(normalize-space(@atoms),',,',','),',$',''),',')">
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
      <xsl:element name="PDBxv:angle_deviation"><xsl:value-of select="format-number(number(@obsval)-number(@mean),'0.00')"/></xsl:element>
      <xsl:element name="PDBxv:angle_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:angle_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:angle_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="PDBxv:Zscore"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="PDBxv:angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="PDBxv:number_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
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
      <xsl:for-each select="tokenize(replace(replace(normalize-space(@atoms),',,',','),',$',''),',')">
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
      <xsl:element name="PDBxv:bond_deviation"><xsl:value-of select="format-number(number(@obsval)-number(@mean),'0.000')"/></xsl:element>
      <xsl:element name="PDBxv:bond_standard_deviation"><xsl:value-of select="@stdev"/></xsl:element>
      <xsl:element name="PDBxv:bond_target_value"><xsl:value-of select="@mean"/></xsl:element>
      <xsl:element name="PDBxv:bond_value"><xsl:value-of select="@obsval"/></xsl:element>
      <xsl:element name="PDBxv:Zscore"><xsl:value-of select="@Zscore"/></xsl:element>
      <xsl:element name="PDBxv:bond_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="PDBxv:number_bonds_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
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
      <xsl:element name="PDBxv:dihedral_angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="PDBxv:number_dihedral_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
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
    <xsl:for-each select="tokenize(replace(replace(normalize-space(@atoms),',,',','),',$',''),',')">
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
      <xsl:element name="PDBxv:dihedral_angle_minimum_diff_to_kb"><xsl:value-of select="@mindiff"/></xsl:element>
      <xsl:element name="PDBxv:number_dihedral_angles_in_kb"><xsl:value-of select="@numobs"/></xsl:element>
      <xsl:if test="../@local_density">
        <xsl:element name="PDBxv:percent_dihedral_angles_fitted_to_kb"><xsl:value-of select="../@local_density"/></xsl:element>
      </xsl:if>
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
    <xsl:for-each select="tokenize(replace(replace(normalize-space(@atoms),',,',','),',$',''),',')">
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
      <xsl:if test="@medoid_model">
        <xsl:element name="PDBxv:medoid_model_number"><xsl:value-of select="@medoid_model"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:distance_rms_dev"><xsl:value-of select="@rmsd"/></xsl:element>
      <xsl:if test="@medoid_rmsd">
        <xsl:element name="PDBxv:distance_rms_dev_medoid"><xsl:value-of select="@medoid_rmsd"/></xsl:element>
      </xsl:if>
      <xsl:element name="PDBxv:number_of_gaps"><xsl:value-of select="@number_of_gaps"/></xsl:element>
      <xsl:element name="PDBxv:number_of_monomers"><xsl:value-of select="@number_of_residues"/></xsl:element>
      <xsl:element name="PDBxv:percent_of_core"><xsl:value-of select="@percentage_of_core"/></xsl:element>
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

      <xsl:for-each select="tokenize(replace(normalize-space(.),':-',':_'),'-')"> <!-- rescue A:-1-A:-1 case -->
        <xsl:choose>
          <xsl:when test="position()=1">
            <xsl:variable name="beg_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
            <xsl:variable name="beg_auth_seq_id"><xsl:value-of select="translate(substring-after(.,':'),'_','-')"/></xsl:variable> <!-- retrieve A:-1 from A:_1 -->
            <xsl:element name="PDBxv:beg_auth_asym_id"><xsl:value-of select="$beg_auth_asym_id"/></xsl:element>
            <xsl:element name="PDBxv:beg_auth_seq_id"><xsl:value-of select="$beg_auth_seq_id"/></xsl:element>
            <xsl:element name="PDBxv:beg_auth_comp_id">
              <xsl:value-of select="$ext_datablock/PDBxv:pdbx_poly_seq_schemeCategory/PDBxv:pdbx_poly_seq_scheme[@asym_id=$beg_auth_asym_id and PDBxv:auth_seq_num=$beg_auth_seq_id]/@mon_id"/>
            </xsl:element>
          </xsl:when>
          <xsl:when test="position()=2">
            <xsl:variable name="end_auth_asym_id"><xsl:value-of select="substring-before(.,':')"/></xsl:variable>
            <xsl:variable name="end_auth_seq_id"><xsl:value-of select="translate(substring-after(.,':'),'_','-')"/></xsl:variable>
            <xsl:element name="PDBxv:end_auth_asym_id"><xsl:value-of select="$end_auth_asym_id"/></xsl:element>
            <xsl:element name="PDBxv:end_auth_seq_id"><xsl:value-of select="$end_auth_seq_id"/></xsl:element>
            <xsl:element name="PDBxv:end_auth_comp_id">
              <xsl:value-of select="$ext_datablock/PDBxv:pdbx_poly_seq_schemeCategory/PDBxv:pdbx_poly_seq_scheme[@asym_id=$end_auth_asym_id and PDBxv:auth_seq_num=$end_auth_seq_id]/@mon_id"/>
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

  <!-- EM validation: Entry, ModelledEntityInstance -->

  <xsl:template name="pdbx_em_validate_map_model_entity">
    <xsl:if test="@average_residue_inclusion">
      <PDBxv:pdbx_em_validate_map_model_entity>
        <xsl:attribute name="label_asym_id"><xsl:value-of select="@said"/></xsl:attribute>
        <xsl:attribute name="PDB_model_num"><xsl:value-of select="@model"/></xsl:attribute>
        <xsl:element name="PDBxv:entity_id"><xsl:value-of select="@ent"/></xsl:element>
        <xsl:element name="PDBxv:auth_asym_id"><xsl:value-of select="@chain"/></xsl:element>
        <xsl:element name="PDBxv:average_atom_inclusion_all"><xsl:value-of select="@average_residue_inclusion"/></xsl:element>
      </PDBxv:pdbx_em_validate_map_model_entity>
    </xsl:if>
  </xsl:template>

  <xsl:template name="pdbx_em_validate_map_model_overall">
    <xsl:if test="@contour_level_primary_map">
      <PDBxv:pdbx_em_validate_map_model_overallCategory>
        <PDBxv:pdbx_em_validate_map_model_overall entry_id="{$entry_id}">
          <xsl:element name="PDBxv:recommended_contour_level"><xsl:value-of select="@contour_level_primary_map"/></xsl:element>
          <xsl:if test="@atom_inclusion_all">
            <xsl:element name="PDBxv:atom_inclusion_all"><xsl:value-of select="@atom_inclusion_all"/></xsl:element>
          </xsl:if>
          <xsl:if test="@atom_inclusion_backbone">
            <xsl:element name="PDBxv:atom_inclusion_main"><xsl:value-of select="@atom_inclusion_backbone"/></xsl:element>
          </xsl:if>
        </PDBxv:pdbx_em_validate_map_model_overall>
      </PDBxv:pdbx_em_validate_map_model_overallCategory>
    </xsl:if>
  </xsl:template>

  <!-- EM validation: ModelledSubgroup -->

  <xsl:template name="pdbx_em_validate_map_model">
    <xsl:if test="@residue_inclusion">
      <PDBxv:pdbx_em_validate_map_model>
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
        <xsl:element name="PDBxv:atom_inclusion_all"><xsl:value-of select="@residue_inclusion"/></xsl:element>
      </PDBxv:pdbx_em_validate_map_model>
    </xsl:if>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

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
