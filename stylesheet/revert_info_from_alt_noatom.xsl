<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v3.xsd"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd">

  <xsl:param name="pdbml_noatom_file" required="yes"/>
  <xsl:param name="pdbml_noatom" select="document($pdbml_noatom_file)"/>

  <xsl:param name="noatom_datablock" select="$pdbml_noatom/PDBx:datablock"/>

  <xsl:param name="validation_created_date"/>
  <xsl:param name="nmr_atom_consistency"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="datablock" select="/PDBxv:datablock"/>

  <xsl:variable name="entry_id"><xsl:value-of select="$datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>

  <xsl:variable name="pdb_id"><xsl:value-of select="$noatom_datablock/PDBx:entryCategory/PDBx:entry/@id"/></xsl:variable>

  <!-- experimental method -->

  <xsl:variable name="exptl_method"><xsl:value-of select="$noatom_datablock/PDBx:exptlCategory/PDBx:exptl/@method"/></xsl:variable>

  <xsl:variable name="x-ray"><xsl:value-of select="contains($exptl_method,'DIFFRACTION') and not(contains($exptl_method,'NEUTRON'))"/></xsl:variable>
  <xsl:variable name="nmr"><xsl:value-of select="contains($exptl_method,'NMR')"/></xsl:variable>
  <xsl:variable name="em"><xsl:value-of select="$exptl_method='ELECTRON MICROSCOPY'"/></xsl:variable>
  <xsl:variable name="other"><xsl:value-of select="$x-ray=false() and $nmr=false() and $em=false()"/></xsl:variable>

  <xsl:variable name="percentile_d_res_high">
    <xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[PDBxv:ls_d_res_high!='']/PDBxv:ls_d_res_high"/>
  </xsl:variable>

  <xsl:variable name="percentile_d_res_low">
    <xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[PDBxv:ls_d_res_low!='']/PDBxv:ls_d_res_low"/>
  </xsl:variable>

  <xsl:variable name="nmr_models">
    <xsl:value-of select="$datablock/PDBxv:pdbx_struct_nmr_ens_clustCategory/PDBxv:pdbx_struct_nmr_ens_clust/PDBxv:conformers_total_number"/>
  </xsl:variable>

  <!-- Level 1 -->

  <xsl:template match="$datablock">

    <xsl:if test="$entry_id!=$pdb_id">
      <xsl:call-template name="error_handler">
        <xsl:with-param name="terminate">yes</xsl:with-param>
        <xsl:with-param name="error_message">
Unmatched entry ID in both documents (<xsl:value-of select="$entry_id"/> and <xsl:value-of select="$pdb_id"/>).
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <wwPDB-validation-information xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://wwpdb.org/validation/schema/wwpdb_validation_v5.01.xsd">
      <Entry>
        <xsl:call-template name="Entry"/>
      </Entry>

      <xsl:if test="$nmr=true()">
        <xsl:apply-templates select="PDBxv:pdbx_struct_nmr_ens_clust_genCategory/*"/>
      </xsl:if>

      <xsl:call-template name="ModelledSubgroup"/>

      <xsl:if test="$nmr=true()">

        <xsl:for-each select="PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom">

          <cyrange_domain>

            <xsl:variable name="dom_id"><xsl:value-of select="@id"/></xsl:variable>

            <xsl:attribute name="domain"><xsl:value-of select="$dom_id"/></xsl:attribute>
            <xsl:if test="PDBxv:medoid_model_number">
              <xsl:attribute name="medoid_model"><xsl:value-of select="PDBxv:medoid_model_number"/></xsl:attribute>
            </xsl:if>
            <xsl:if test="PDBxv:distance_rms_dev_medoid">
              <xsl:attribute name="medoid_rmsd"><xsl:value-of select="PDBxv:distance_rms_dev_medoid"/></xsl:attribute>
            </xsl:if>
            <xsl:attribute name="rmsd"><xsl:value-of select="PDBxv:distance_rms_dev"/></xsl:attribute>
            <xsl:attribute name="number_of_gaps"><xsl:value-of select="PDBxv:number_of_gaps"/></xsl:attribute>
            <xsl:attribute name="number_of_residues"><xsl:value-of select="PDBxv:number_of_monomers"/></xsl:attribute>
            <xsl:attribute name="percentage_of_core"><xsl:value-of select="PDBxv:percent_of_core"/></xsl:attribute>

            <xsl:variable name="residue_string">
              <xsl:for-each select="$datablock/PDBxv:pdbx_struct_nmr_ens_dom_limCategory/PDBxv:pdbx_struct_nmr_ens_dom_lim[@dom_id=$dom_id]">
                <xsl:value-of select="concat(PDBxv:beg_auth_asym_id,':',PDBxv:beg_auth_seq_id,'-',PDBxv:end_auth_asym_id,':',PDBxv:end_auth_seq_id,', ')"/>
              </xsl:for-each>
            </xsl:variable>

            <xsl:attribute name="residue_string"><xsl:value-of select="substring($residue_string,1,string-length($residue_string)-2)"/></xsl:attribute>

          </cyrange_domain>

        </xsl:for-each>

      </xsl:if>

      <xsl:call-template name="ModelledEntityInstance"/>

      <xsl:if test="$em=true()">
        <xsl:call-template name="EM_validation"/>
      </xsl:if>

      <programs>
        <xsl:apply-templates select="PDBxv:pdbx_validation_softwareCategory/*"/>
      </programs>
    </wwPDB-validation-information>

  </xsl:template>

  <!-- Level 2 -->

  <!-- Entry -->

  <xsl:template name="Entry">

    <xsl:attribute name="pdbid"><xsl:value-of select="$entry_id"/></xsl:attribute>

    <xsl:apply-templates select="$noatom_datablock/PDBx:pdbx_database_statusCategory/*"/>

    <xsl:choose>
      <xsl:when test="$noatom_datablock/PDBx:pdbx_audit_revision_historyCategory/PDBx:pdbx_audit_revision_history">
        <xsl:apply-templates select="$noatom_datablock/PDBx:pdbx_audit_revision_historyCategory"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="PDB-revision-number">-1</xsl:attribute>
        <xsl:attribute name="PDB-revision-date">unknown</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBxv:pdbx_dcc_densityCategory/PDBxv:pdbx_dcc_density">
        <xsl:for-each select="PDBxv:pdbx_dcc_densityCategory/PDBxv:pdbx_dcc_density">
          <xsl:call-template name="pdbx_dcc_density_summary"/>
        </xsl:for-each>
      </xsl:when>
      <xsl:when test="$noatom_datablock/PDBx:em_3d_reconstructionCategory/PDBx:em_3d_reconstruction">
        <xsl:apply-templates select="$noatom_datablock/PDBx:em_3d_reconstructionCategory/*"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="PDB-resolution">NotAvailable</xsl:attribute>
        <xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="$noatom_datablock/PDBx:refineCategory/*"/>

    <xsl:variable name="polymer_entity_ids">
      <xsl:for-each select="$noatom_datablock/PDBx:entity_polyCategory/PDBx:entity_poly">
        <xsl:if test="PDBx:type and PDBx:type=('polypeptide(L)','polypeptide(D)','polyribonucleotide','polydeoxyribonucleotide','polydeoxyribonucleotide/polyribonucleotide hybrid')">
          <xsl:value-of select="concat(@entity_id,',')"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($polymer_entity_ids)&gt;1">
      <xsl:attribute name="protein-DNA-RNA-entities"><xsl:value-of select="substring($polymer_entity_ids,1,string-length($polymer_entity_ids)-1)"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="$noatom_datablock/PDBx:pdbx_coordinate_modelCategory/PDBx:pdbx_coordinate_model/PDBx:type='CA ATOMS ONLY'">
      <xsl:attribute name="CA_ONLY">yes</xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="PDBxv:pdbx_dcc_geometryCategory/*"/>

    <!-- x-ray -->

    <xsl:if test="$x-ray=true()">

      <xsl:apply-templates select="PDBxv:pdbx_dcc_densityCategory/*"/>
      <xsl:apply-templates select="PDBxv:pdbx_dcc_density_corrCategory/*"/>
      <xsl:apply-templates select="PDBxv:pdbx_dcc_map_overallCategory/*"/>

    </xsl:if>

    <!-- nmr -->

    <xsl:if test="$nmr=true()">

      <xsl:choose>
        <xsl:when test="$noatom_datablock/PDBx:pdbx_nmr_ensembleCategory/PDBx:pdbx_nmr_ensemble">
          <xsl:choose>
            <xsl:when test="$noatom_datablock/PDBx:pdbx_nmr_ensembleCategory/PDBx:pdbx_nmr_ensemble/PDBx:atom_consistency_flag='Y'">
              <xsl:attribute name="nmr_models_consistency_flag">True</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="nmr_models_consistency_flag">False</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="$nmr_atom_consistency!=''">
          <xsl:choose>
            <xsl:when test="$nmr_atom_consistency='Y'">
              <xsl:attribute name="nmr_models_consistency_flag">True</xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="nmr_models_consistency_flag">False</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom/PDBxv:error!=''">
          <xsl:attribute name="cyrange_error"><xsl:value-of select="PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom/PDBxv:error"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="cyrange_error">success</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
        <xsl:when test="PDBxv:pdbx_struct_nmr_ens_clustCategory/PDBxv:pdbx_struct_nmr_ens_clust/PDBxv:error!=''">
          <xsl:attribute name="nmrclust_error"><xsl:value-of select="PDBxv:pdbx_struct_nmr_ens_clustCategory/PDBxv:pdbx_struct_nmr_ens_clust/PDBxv:error"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="nmrclust_error">success</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:for-each select="PDBxv:pdbx_struct_nmr_ens_clust_genCategory/PDBxv:pdbx_struct_nmr_ens_clust_gen">
        <xsl:if test="PDBxv:cluster_id='1' and PDBxv:medoid_conformer='Y'">
          <xsl:attribute name="nmrclust_representative_model"><xsl:value-of select="@PDB_model_num"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>

      <xsl:for-each select="PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom">
        <xsl:if test="@id='1'">
          <xsl:attribute name="medoid_model"><xsl:value-of select="PDBxv:medoid_model_number"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>

      <xsl:apply-templates select="PDBxv:pdbx_struct_nmr_ens_clustCategory/*"/>

      <xsl:if test="PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom">
        <xsl:attribute name="cyrange_number_of_domains"><xsl:value-of select="count(PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom)"/></xsl:attribute>
      </xsl:if>

      <xsl:for-each select="PDBxv:pdbx_nmr_chem_shift_completenessCategory/PDBxv:pdbx_nmr_chem_shift_completeness[@list_id='1' and @atom_group='overall' and @atom_type='Total']">
        <xsl:attribute name="chemical_shift_completeness"><xsl:value-of select="format-number(number(PDBxv:number_assigned_chem_shifts_well_formed) div number(PDBxv:number_target_shifts_well_formed) * 100,'0.00')"/></xsl:attribute>
        <xsl:attribute name="chemical_shift_completeness_full_length"><xsl:value-of select="format-number(number(PDBxv:number_assigned_chem_shifts) div number(PDBxv:number_target_shifts) * 100,'0.00')"/></xsl:attribute>
      </xsl:for-each>

    </xsl:if>

    <!-- percentile view -->

    <xsl:choose>
      <xsl:when test="PDBxv:pdbx_percentile_listCategory/PDBxv:pdbx_percentile_list/PDBxv:name">
        <xsl:attribute name="percentilebins"><xsl:value-of select="PDBxv:pdbx_percentile_listCategory/PDBxv:pdbx_percentile_list/PDBxv:name"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="no-percentile-property">true</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="PDBxv:pdbx_percentile_viewCategory/*"/>

    <!-- program -->

    <xsl:variable name="software_list">
      <xsl:for-each select="PDBxv:pdbx_validation_softwareCategory/PDBxv:pdbx_validation_software[PDBxv:details!='']">
        <xsl:value-of select="concat(PDBxv:name,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:attribute name="attemptedValidationSteps"><xsl:value-of select="substring($software_list,1,string-length($software_list)-1)"/></xsl:attribute>

    <xsl:for-each select="PDBxv:pdbx_validation_softwareCategory/PDBxv:pdbx_validation_software">

      <xsl:if test="PDBxv:version='unknown (associated with DCC package)' and PDBxv:classification='refinement'">
        <xsl:attribute name="DCC_refinement_program"><xsl:value-of select="PDBxv:name"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="PDBxv:name='CCP4' and PDBxv:classification='data scaling and phasing'">
        <xsl:attribute name="CCP4version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="PDBxv:name='Refmac' and PDBxv:classification='refinement'">
        <xsl:attribute name="RefmacVersion"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
      </xsl:if>

      <xsl:if test="$nmr=true()">

        <xsl:if test="PDBxv:name='cyrange' and PDBxv:classification='domain identification of nmr ensemble structure'">
          <xsl:attribute name="cyrange_version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:name='nmrclust' and PDBxv:classification='classification of nmr ensemble structure'">
          <xsl:attribute name="nmrclust_version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:name='panav' and PDBxv:classification='nmr chemical shift validation and reference correction'">
          <xsl:attribute name="panav_version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:name='rci' and PDBxv:classification='random coil index prediction from nmr chemical shifts'">
          <xsl:attribute name="rci_version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:name='shiftchecker' and PDBxv:classification='nmr chemical shift validation'">
          <xsl:attribute name="shiftchecker_version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
        </xsl:if>

      </xsl:if>

    </xsl:for-each>

    <!-- nmr -->

    <xsl:if test="$nmr=true()">

      <xsl:apply-templates select="PDBxv:pdbx_nmr_assigned_chem_shift_listCategory/*"/>

    </xsl:if>

    <!-- EM validation : Entry -->

    <xsl:if test="$em=true()">

      <!--xsl:for-each select="PDBxv:pdbx_database_relatedCategory/PDBxv:pdbx_database_related[PDBxv:db_name='EMDB']">
        <xsl:attribute name="emdb_id"><xsl:value-of select="PDBxv:db_id"/></xsl:attribute>
      </xsl:for-each-->

      <xsl:for-each select="PDBxv:em_adminCategory/PDBxv:em_admin">
        <xsl:attribute name="emdb_id"><xsl:value-of select="@entry_id"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="PDBxv:deposition_date">
            <xsl:attribute name="EMDB-deposition-date"><xsl:value-of select="PDBxv:deposition_date"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="EMDB-deposition-date">unknown</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>

      <xsl:for-each select="PDBxv:pdbx_em_validate_map_model_overallCategory/PDBxv:pdbx_em_validate_map_model_overall[PDBxv:recommended_contour_level!='']">
        <xsl:attribute name="contour_level_primary_map"><xsl:value-of select="PDBxv:recommended_contour_level"/></xsl:attribute>
        <xsl:if test="PDBxv:atom_inclusion_all">
          <xsl:attribute name="atom_inclusion_all"><xsl:value-of select="PDBxv:atom_inclusion_all"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:atom_inclusion_main">
          <xsl:attribute name="atom_inclusion_backbone"><xsl:value-of select="PDBxv:atom_inclusion_main"/></xsl:attribute>
        </xsl:if>
      </xsl:for-each>

      <xsl:for-each select="PDBxv:pdbx_em_fsc_resolutionCaetgory/PDBxv:pdbx_em_fsc_resolution">
        <xsl:variable name="source"><xsl:value-of select="@source"/></xsl:variable>
        <xsl:variable name="criterion">
          <xsl:choose>
            <xsl:when test="@criterion='0.143' or @criterion='0.333' or @criterion='0.5'"><xsl:value-of select="@criterion"/></xsl:when>
            <xsl:when test="@criterion='half-bit'">halfbit</xsl:when>
            <xsl:when test="@criterion='one-bit'">onebit</xsl:when>
            <xsl:when test="@criterion='3sigma'">threesigma</xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="error_handler">
                <xsl:with-param name="terminate">yes</xsl:with-param>
                <xsl:with-param name="error_message">
Criteria for FSC resolution estimation, <xsl:value-of select="@type"/>, is not listed in XSLT code.
                </xsl:with-param>
              </xsl:call-template>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="resolution_title"><xsl:value-of select="concat($source,'_resolution_by_cutoff_',$criterion)"/></xsl:variable>
        <xsl:attribute name="{$resolution_title}"><xsl:value-of select="PDBxv:resolution"/></xsl:attribute>
      </xsl:for-each>

    </xsl:if>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_validation_software">
    <xsl:if test="PDBxv:details!=''">
      <xsl:element name="program">
        <xsl:attribute name="name"><xsl:value-of select="PDBxv:name"/></xsl:attribute>
        <xsl:attribute name="properties"><xsl:value-of select="PDBxv:details"/></xsl:attribute>
        <xsl:attribute name="version"><xsl:value-of select="PDBxv:version"/></xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_audit_revision_historyCategory">

    <xsl:for-each select="PDBx:pdbx_audit_revision_history">

    <xsl:if test="position()=last()">
      <xsl:choose>
        <xsl:when test="PDBx:major_revision">
          <xsl:attribute name="PDB-revision-number"><xsl:value-of select="PDBx:major_revision"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="PDB-revision-number">-1</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="PDBx:revision_date">
          <xsl:attribute name="PDB-revision-date"><xsl:value-of select="PDBx:revision_date"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="PDB-revision-date">unknown</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <xsl:template match="PDBx:em_3d_reconstruction">

    <xsl:if test="PDBx:resolution">
      <xsl:attribute name="PDB-resolution"><xsl:value-of select="PDBx:resolution"/></xsl:attribute>
      <xsl:attribute name="EMDB-resolution"><xsl:value-of select="PDBx:resolution"/></xsl:attribute>
    </xsl:if>

    <xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>

  </xsl:template>

  <xsl:template name="pdbx_dcc_density_summary">

    <xsl:choose>
       <xsl:when test="PDBxv:ls_d_res_high">
         <xsl:attribute name="PDB-resolution"><xsl:value-of select="PDBxv:ls_d_res_high"/></xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
         <xsl:attribute name="PDB-resolution">NotAvailable</xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>
     <xsl:choose>
       <xsl:when test="PDBxv:ls_d_res_low">
         <xsl:attribute name="PDB-resolution-low"><xsl:value-of select="PDBxv:ls_d_res_low"/></xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
         <xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>

  </xsl:template>

  <xsl:template match="PDBx:refine">

    <xsl:choose>
      <xsl:when test="PDBx:ls_R_factor_R_work">
        <xsl:attribute name="PDB-R"><xsl:value-of select="format-number(PDBx:ls_R_factor_R_work,'0.00')"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="PDB-R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBx:ls_R_factor_R_free">
        <xsl:attribute name="PDB-Rfree"><xsl:value-of select="format-number(PDBx:ls_R_factor_R_free,'0.00')"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="PDB-Rfree">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_status">

    <xsl:choose>
      <xsl:when test="PDBx:validation_created_date">
        <xsl:attribute name="XMLcreationDate"><xsl:value-of select="PDBx:validation_created_date"/></xsl:attribute>
      </xsl:when>
      <xsl:when test="$validation_created_date!=''">
        <xsl:attribute name="XMLcreationDate"><xsl:value-of select="$validation_created_date"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="XMLcreationDate"><xsl:value-of select="substring(string(current-date()),1,10)"/></xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBx:recvd_initial_deposition_date">
        <xsl:attribute name="PDB-deposition-date"><xsl:value-of select="PDBx:recvd_initial_deposition_date"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="PDB-deposition-date">unknown</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_geometry">

    <xsl:if test="PDBxv:angle_overall_rmsz">
      <xsl:attribute name="angles_rmsz"><xsl:value-of select="PDBxv:angle_overall_rmsz"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:bond_overall_rmsz">
      <xsl:attribute name="bonds_rmsz"><xsl:value-of select="PDBxv:bond_overall_rmsz"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:number_angles">
      <xsl:attribute name="num_angles_rmsz"><xsl:value-of select="PDBxv:number_angles"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:number_bonds">
      <xsl:attribute name="num_bonds_rmsz"><xsl:value-of select="PDBxv:number_bonds"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
        <xsl:if test="PDBxv:all_atom_clashscore_nmr_well_formed">
          <xsl:attribute name="clashscore"><xsl:value-of select="PDBxv:all_atom_clashscore_nmr_well_formed"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:all_atom_clashscore">
          <xsl:attribute name="clashscore-full-length"><xsl:value-of select="PDBxv:all_atom_clashscore"/></xsl:attribute>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="PDBxv:all_atom_clashscore">
          <xsl:attribute name="clashscore"><xsl:value-of select="PDBxv:all_atom_clashscore"/></xsl:attribute>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="PDBxv:RNA_suiteness_score">
      <xsl:attribute name="RNAsuiteness"><xsl:value-of select="PDBxv:RNA_suiteness_score"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
        <xsl:if test="PDBxv:Ramachandran_outlier_percent">
          <xsl:attribute name="percent-rama-outliers"><xsl:value-of select="PDBxv:Ramachandran_outlier_percent_nmr_well_formed"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:Ramachandran_outlier_percent">
          <xsl:attribute name="percent-rama-outliers-full-length"><xsl:value-of select="PDBxv:Ramachandran_outlier_percent"/></xsl:attribute>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="PDBxv:Ramachandran_outlier_percent">
          <xsl:attribute name="percent-rama-outliers"><xsl:value-of select="PDBxv:Ramachandran_outlier_percent"/></xsl:attribute>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
        <xsl:if test="PDBxv:rotamer_outliers_percent">
          <xsl:attribute name="percent-rota-outliers"><xsl:value-of select="PDBxv:rotamer_outliers_percent_nmr_well_formed"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:rotamer_outliers_percent">
          <xsl:attribute name="percent-rota-outliers-full-length"><xsl:value-of select="PDBxv:rotamer_outliers_percent"/></xsl:attribute>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="PDBxv:rotamer_outliers_percent">
          <xsl:attribute name="percent-rota-outliers"><xsl:value-of select="PDBxv:rotamer_outliers_percent"/></xsl:attribute>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_density">

    <xsl:if test="PDBxv:reflns_outlier_acentric">
      <xsl:attribute name="acentric_outliers"><xsl:value-of select="PDBxv:reflns_outlier_acentric"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:reflns_outlier_centric">
      <xsl:attribute name="centric_outliers"><xsl:value-of select="PDBxv:reflns_outlier_centric"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:I_over_sigI_resh">
      <xsl:attribute name="IoverSigma"><xsl:value-of select="concat(PDBxv:I_over_sigI_resh,'(',substring-before($percentile_d_res_high,' '),'A)')"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:reflns_number_obs">
      <xsl:attribute name="numMillerIndices"><xsl:value-of select="PDBxv:reflns_number_obs"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:B_wilson">
      <xsl:attribute name="WilsonBestimate"><xsl:value-of select="PDBxv:B_wilson"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:aniso_B11">
      <xsl:attribute name="WilsonBaniso"><xsl:value-of select="concat('[',PDBxv:aniso_B11,',',PDBxv:aniso_B22,',',PDBxv:aniso_B33,',',PDBxv:aniso_B12,',',PDBxv:aniso_B13,',',PDBxv:aniso_B23,']')"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:anisotropy">
      <xsl:attribute name="DataAnisotropy"><xsl:value-of select="PDBxv:anisotropy"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:error">
      <xsl:attribute name="TransNCS"><xsl:value-of select="PDBxv:error"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:Padilla-Yeates_L_mean">
      <xsl:attribute name="TwinL"><xsl:value-of select="PDBxv:Padilla-Yeates_L_mean"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:Padilla-Yeates_L2_mean">
      <xsl:attribute name="TwinL2"><xsl:value-of select="PDBxv:Padilla-Yeates_L2_mean"/></xsl:attribute>
    </xsl:if>

    <xsl:if test="PDBxv:twin_operator_xtriage and PDBxv:twin_fraction_xtriage">

      <xsl:variable name="operators" select="tokenize(PDBxv:twin_operator_xtriage,'\s+')"/>
      <xsl:variable name="fractions" select="tokenize(PDBxv:twin_fraction_xtriage,'\s+')"/>

      <xsl:variable name="twin_fraction">
        <xsl:for-each select="$operators">
          <xsl:variable name="index"><xsl:value-of select="position()"/></xsl:variable>
          <xsl:variable name="fraction">
            <xsl:for-each select="$fractions">
              <xsl:if test="$index=position()">
                <xsl:value-of select="."/>
              </xsl:if>
            </xsl:for-each>
          </xsl:variable>
          <xsl:value-of select="concat(.,':',$fraction,' ')"/>
        </xsl:for-each>
      </xsl:variable>

      <xsl:attribute name="TwinFraction"><xsl:value-of select="translate(normalize-space($twin_fraction),' ',';')"/></xsl:attribute>

    </xsl:if>

    <xsl:if test="PDBxv:iso_B_value_type">
      <xsl:attribute name="B_factor_type"><xsl:value-of select="upper-case(PDBxv:iso_B_value_type)"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:ls_percent_reflns_obs">
      <xsl:attribute name="DataCompleteness"><xsl:value-of select="PDBxv:ls_percent_reflns_obs"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:ls_number_reflns_R_free">
      <xsl:attribute name="num-free-reflections"><xsl:value-of select="PDBxv:ls_number_reflns_R_free"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:ls_percent_reflns_R_free">
      <xsl:attribute name="percent-free-reflections"><xsl:value-of select="PDBxv:ls_percent_reflns_R_free"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="PDBxv:R_value_R_work">
        <xsl:attribute name="DCC_R"><xsl:value-of select="PDBxv:R_value_R_work"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="DCC_R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBxv:R_value_R_free">
        <xsl:attribute name="DCC_Rfree"><xsl:value-of select="PDBxv:R_value_R_free"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="DCC_Rfree">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="PDBxv:B_babinet">
      <xsl:attribute name="babinet_b"><xsl:value-of select="PDBxv:B_babinet"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:K_babinet">
      <xsl:attribute name="babinet_k"><xsl:value-of select="PDBxv:K_babinet"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:B_solvent">
      <xsl:attribute name="bulk_solvent_b"><xsl:value-of select="PDBxv:B_solvent"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:K_solvent">
      <xsl:attribute name="bulk_solvent_k"><xsl:value-of select="PDBxv:K_solvent"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_density_corr">

    <xsl:choose>
      <xsl:when test="PDBxv:ls_R_factor_R_work">
        <xsl:attribute name="EDS_R"><xsl:value-of select="PDBxv:ls_R_factor_R_work"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="EDS_R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBxv:ls_d_res_high">
        <xsl:attribute name="EDS_resolution"><xsl:value-of select="PDBxv:ls_d_res_high"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="EDS_resolution">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBxv:ls_d_res_low">
        <xsl:attribute name="EDS_resolution_low"><xsl:value-of select="PDBxv:ls_d_res_low"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="EDS_resolution_low">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="PDBxv:correlation_coeff_Fo_to_Fc">
        <xsl:attribute name="Fo_Fc_correlation"><xsl:value-of select="PDBxv:correlation_coeff_Fo_to_Fc"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="Fo_Fc_correlation">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_dcc_map_overall">

    <xsl:if test="PDBxv:RSRZ_outliers_percent">
      <xsl:attribute name="percent-RSRZ-outliers"><xsl:value-of select="PDBxv:RSRZ_outliers_percent"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_clust">

    <xsl:if test="PDBxv:outliers_total_number">
      <xsl:attribute name="nmrclust_number_of_outliers"><xsl:value-of select="PDBxv:outliers_total_number"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:conformers_total_number">
      <xsl:attribute name="nmrclust_number_of_models"><xsl:value-of select="PDBxv:conformers_total_number"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="PDBxv:clusters_total_number">
      <xsl:attribute name="nmrclust_number_of_clusters"><xsl:value-of select="PDBxv:clusters_total_number"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="PDBxv:pdbx_percentile_view">

    <xsl:call-template name="percentile_handler">
      <xsl:with-param name="conditions_id"><xsl:value-of select="@conditions_id"/></xsl:with-param>
      <xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param>
      <xsl:with-param name="rank"><xsl:value-of select="PDBxv:rank"/></xsl:with-param>
    </xsl:call-template>

  </xsl:template>

  <!-- percentile view -->

  <xsl:template name="percentile_handler">
    <xsl:param name="conditions_id"/>
    <xsl:param name="type"/>
    <xsl:param name="rank"/>

    <xsl:variable name="condition_res_high"><xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[@id=$conditions_id]/PDBxv:ls_d_res_high"/></xsl:variable>
    <xsl:variable name="condition_res_low"><xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[@id=$conditions_id]/PDBxv:ls_d_res_low"/></xsl:variable>

    <xsl:variable name="absolute">
      <xsl:choose>
        <xsl:when test="$condition_res_high!=''">no</xsl:when>
        <xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="number_of_entries"><xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[@id=$conditions_id]/PDBxv:number_entries_total"/></xsl:variable>

    <xsl:choose>
      <xsl:when test="$type='RNA_suiteness_score'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-RNAsuiteness"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-RNAsuiteness"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-RNAsuiteness"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-RNAsuiteness"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-RNAsuiteness"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-RNAsuiteness"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='all_atom_clashscore'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-clashscore"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-clashscore"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-clashscore"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-clashscore"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-clashscore"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-clashscore"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='Ramachandran_outlier_percent'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-percent-rama-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-percent-rama-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-percent-rama-outliers"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-percent-rama-outliers"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-percent-rama-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-percent-rama-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='rotamer_outliers_percent'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-percent-rota-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-percent-rota-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-percent-rota-outliers"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-percent-rota-outliers"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-percent-rota-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-percent-rota-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='R_value_R_free'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-DCC_Rfree"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-DCC_Rfree"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-DCC_Rfree"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-DCC_Rfree"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-DCC_Rfree"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-DCC_Rfree"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$type='RSRZ_outliers_percent'">
        <xsl:choose>
          <xsl:when test="$absolute='no'">
            <xsl:attribute name="relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
            <xsl:attribute name="low-resol-relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$condition_res_low"/></xsl:attribute>
            <xsl:attribute name="high-resol-relative-percentile-percent-RSRZ-outliers"><xsl:value-of select="$condition_res_high"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="absolute-percentile-percent-RSRZ-outliers"><xsl:value-of select="$rank"/></xsl:attribute>
            <xsl:attribute name="numPDBids-absolute-percentile-percent-RSRZ-outliers"><xsl:value-of select="$number_of_entries"/></xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="error_handler">
          <xsl:with-param name="terminate">yes</xsl:with-param>
          <xsl:with-param name="error_message">
Unmatched type exist in _pdbx_percentile_view.type, <xsl:value-of select="position()"/>, found in XSLT code.
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <!-- chemical shift list -->

  <xsl:template match="PDBxv:pdbx_nmr_assigned_chem_shift_list">

    <chemical_shift_list>

      <xsl:variable name="list_id"><xsl:value-of select="@id"/></xsl:variable>

      <xsl:attribute name="file_id"><xsl:value-of select="$list_id"/></xsl:attribute>
      <xsl:attribute name="file_name"><xsl:value-of select="PDBxv:data_file_name"/></xsl:attribute>
      <xsl:attribute name="block_name"><xsl:value-of select="PDBxv:label"/></xsl:attribute>
      <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="PDBxv:nmr_star_consistency_flag='Y'">
          <xsl:attribute name="type">full</xsl:attribute>
        </xsl:when>
        <xsl:when test="PDBxv:nmr_star_consistency_flag='N'">
          <xsl:attribute name="type">partial</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="error_handler">
            <xsl:with-param name="terminate">yes</xsl:with-param>
            <xsl:with-param name="error_message">
Unmatched type exist in _pdbx_nmr_assigned_chem_shift_list.nmr_star_consistency_flag, <xsl:value-of select="position()"/>, found in XSLT code.
            </xsl:with-param>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="number_of_errors_while_mapping"><xsl:value-of select="PDBxv:number_map_errors"/></xsl:attribute>
      <xsl:attribute name="number_of_warnings_while_mapping"><xsl:value-of select="PDBxv:number_map_warnings"/></xsl:attribute>
      <xsl:attribute name="number_of_mapped_shifts"><xsl:value-of select="PDBxv:number_mapped_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="number_of_parsed_shifts"><xsl:value-of select="PDBxv:number_parsed_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="total_number_of_shifts"><xsl:value-of select="PDBxv:number_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="number_of_unparsed_shifts"><xsl:value-of select="PDBxv:number_unparsed_chem_shifts"/></xsl:attribute>

      <xsl:if test="$datablock/PDBxv:pdbx_nmr_unmapped_chem_shiftCategory/PDBxv:pdbx_nmr_unmapped_chem_shift">
        <xsl:call-template name="pdbx_nmr_unmapped_chem_shift">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_nmr_unparsed_chem_shiftCategory/PDBxv:pdbx_nmr_unparsed_chem_shift">
        <xsl:call-template name="pdbx_nmr_unparsed_chem_shift">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_missing_nmr_star_itemCategory/PDBxv:pdbx_missing_nmr_star_item">
        <xsl:call-template name="pdbx_missing_nmr_star_item">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_nmr_chem_shift_annotationCategory/PDBxv:pdbx_nmr_chem_shift_annotation">
        <xsl:call-template name="pdbx_nmr_chem_shift_annotation">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_validate_nmr_chem_shiftCategory/PDBxv:pdbx_validate_nmr_chem_shift">
        <xsl:call-template name="pdbx_validate_nmr_chem_shift">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_nmr_chem_shift_re_offsetCategory/PDBxv:pdbx_nmr_chem_shift_re_offset">
        <xsl:call-template name="pdbx_nmr_chem_shift_re_offset">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/PDBxv:pdbx_nmr_chem_shift_completenessCategory/PDBxv:pdbx_nmr_chem_shift_completeness">
        <xsl:call-template name="pdbx_nmr_chem_shift_completeness_well_defined">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="pdbx_nmr_chem_shift_completeness_full_length">
          <xsl:with-param name="list_id"><xsl:value-of select="$list_id"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>

    </chemical_shift_list>

  </xsl:template>

  <xsl:template name="pdbx_nmr_unmapped_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_unmapped_chem_shiftCategory/PDBxv:pdbx_nmr_unmapped_chem_shift[@list_id=$list_id]">

      <unmapped_chemical_shift>

        <xsl:attribute name="chain"><xsl:value-of select="PDBxv:auth_asym_id"/></xsl:attribute>
        <xsl:attribute name="rescode"><xsl:value-of select="PDBxv:auth_comp_id"/></xsl:attribute>
        <xsl:attribute name="resnum"><xsl:value-of select="PDBxv:auth_seq_id"/></xsl:attribute>
        <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="PDBxv:val"/></xsl:attribute>
        <xsl:if test="PDBxv:val_err">
          <xsl:attribute name="error"><xsl:value-of select="PDBxv:val_err"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:ambiguity_code=('1','2','3','4','5','6','9')">
          <xsl:attribute name="ambiguity"><xsl:value-of select="PDBxv:ambiguity_code"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="diagnostic"><xsl:value-of select="PDBxv:details"/></xsl:attribute>

      </unmapped_chemical_shift>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_unparsed_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_unparsed_chem_shiftCategory/PDBxv:pdbx_nmr_unparsed_chem_shift[@list_id=$list_id]">

      <unparsed_chemical_shift>

        <xsl:if test="PDBxv:chem_shift_id">
          <xsl:attribute name="id"><xsl:value-of select="PDBxv:chem_shift_id"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="chain"><xsl:value-of select="PDBxv:auth_asym_id"/></xsl:attribute>
        <xsl:attribute name="rescode"><xsl:value-of select="PDBxv:auth_comp_id"/></xsl:attribute>
        <xsl:attribute name="resnum"><xsl:value-of select="PDBxv:auth_seq_id"/></xsl:attribute>
        <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="PDBxv:val"/></xsl:attribute>
        <xsl:if test="PDBxv:val_err">
          <xsl:attribute name="error"><xsl:value-of select="PDBxv:val_err"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:ambiguity_code=('1','2','3','4','5','6','9')">
          <xsl:attribute name="ambiguity"><xsl:value-of select="PDBxv:ambiguity_code"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="diagnostic"><xsl:value-of select="PDBxv:details"/></xsl:attribute>

      </unparsed_chemical_shift>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_missing_nmr_star_item">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_missing_nmr_star_itemCategory/PDBxv:pdbx_missing_nmr_star_item[@list_id=$list_id]">

      <missing_nmrstar_tag>

        <xsl:attribute name="nmrstar_tag"><xsl:value-of select="PDBxv:name"/></xsl:attribute>
        <xsl:attribute name="nmrstar_tag_description"><xsl:value-of select="PDBxv:description"/></xsl:attribute>

      </missing_nmrstar_tag>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_annotation">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_chem_shift_annotationCategory/PDBxv:pdbx_nmr_chem_shift_annotation[@list_id=$list_id]">

      <random_coil_index>

        <xsl:attribute name="chain"><xsl:value-of select="PDBxv:auth_asym_id"/></xsl:attribute>
        <xsl:attribute name="rescode"><xsl:value-of select="PDBxv:auth_comp_id"/></xsl:attribute>
        <xsl:attribute name="resnum"><xsl:value-of select="PDBxv:auth_seq_id"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="PDBxv:random_coil_index"/></xsl:attribute>

      </random_coil_index>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_validate_nmr_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_validate_nmr_chem_shiftCategory/PDBxv:pdbx_validate_nmr_chem_shift[@list_id=$list_id]">

      <chemical_shift_outlier>

        <xsl:attribute name="chain"><xsl:value-of select="PDBxv:auth_asym_id"/></xsl:attribute>
        <xsl:attribute name="rescode"><xsl:value-of select="PDBxv:auth_comp_id"/></xsl:attribute>
        <xsl:attribute name="resnum"><xsl:value-of select="PDBxv:auth_seq_id"/></xsl:attribute>
        <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="PDBxv:val"/></xsl:attribute>
        <xsl:attribute name="prediction"><xsl:value-of select="PDBxv:target_val"/></xsl:attribute>
        <xsl:attribute name="zscore"><xsl:value-of select="PDBxv:Zscore"/></xsl:attribute>
        <xsl:attribute name="method"><xsl:value-of select="PDBxv:method"/></xsl:attribute>

      </chemical_shift_outlier>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_re_offset">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_chem_shift_re_offsetCategory/PDBxv:pdbx_nmr_chem_shift_re_offset[@list_id=$list_id]">

      <referencing_offset>

        <xsl:attribute name="atom"><xsl:value-of select="@atom_type"/></xsl:attribute>
        <xsl:attribute name="value"><xsl:value-of select="PDBxv:correction_val"/></xsl:attribute>
        <xsl:attribute name="uncertainty"><xsl:value-of select="PDBxv:correction_val_err"/></xsl:attribute>
        <xsl:attribute name="precision"><xsl:value-of select="PDBxv:correction_val_esd"/></xsl:attribute>
        <xsl:attribute name="number_of_measurements"><xsl:value-of select="PDBxv:number_chem_shifts"/></xsl:attribute>

      </referencing_offset>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_well_defined">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_chem_shift_completenessCategory/PDBxv:pdbx_nmr_chem_shift_completeness[@list_id=$list_id]">

      <xsl:if test="PDBxv:number_assigned_chem_shifts_well_formed">

        <assignment_completeness_well_defined>

          <xsl:attribute name="type"><xsl:value-of select="@atom_group"/></xsl:attribute>
          <xsl:attribute name="element"><xsl:value-of select="@atom_type"/></xsl:attribute>
          <xsl:attribute name="number_of_assigned_shifts"><xsl:value-of select="PDBxv:number_assigned_chem_shifts_well_formed"/></xsl:attribute>
          <xsl:attribute name="number_of_shifts"><xsl:value-of select="PDBxv:number_target_shifts_well_formed"/></xsl:attribute>
          <xsl:attribute name="number_of_unassigned_shifts"><xsl:value-of select="PDBxv:number_unassigned_chem_shifts_well_formed"/></xsl:attribute>

        </assignment_completeness_well_defined>

      </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_full_length">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/PDBxv:pdbx_nmr_chem_shift_completenessCategory/PDBxv:pdbx_nmr_chem_shift_completeness[@list_id=$list_id]">

      <xsl:if test="PDBxv:number_assigned_chem_shifts_well_formed">

        <assignment_completeness_full_length>

          <xsl:attribute name="type"><xsl:value-of select="@atom_group"/></xsl:attribute>
          <xsl:attribute name="element"><xsl:value-of select="@atom_type"/></xsl:attribute>
          <xsl:attribute name="number_of_assigned_shifts"><xsl:value-of select="PDBxv:number_assigned_chem_shifts"/></xsl:attribute>
          <xsl:attribute name="number_of_shifts"><xsl:value-of select="PDBxv:number_target_shifts"/></xsl:attribute>
          <xsl:attribute name="number_of_unassigned_shifts"><xsl:value-of select="PDBxv:number_unassigned_chem_shifts"/></xsl:attribute>

        </assignment_completeness_full_length>

      </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <!-- Model -->

  <xsl:template match="PDBxv:pdbx_struct_nmr_ens_clust_gen">

    <Model>

      <xsl:attribute name="model"><xsl:value-of select="@PDB_model_num"/></xsl:attribute>
      <xsl:attribute name="nmrclust_cluster_id"><xsl:value-of select="PDBxv:cluster_id"/></xsl:attribute>
      <xsl:if test="PDBxv:medoid_conformer='Y'">
        <xsl:attribute name="nmrclust_representative">True</xsl:attribute>
      </xsl:if>

    </Model>

  </xsl:template>

  <!-- ModelledSubgroup -->

  <xsl:template name="ModelledSubgroup">

    <xsl:choose>
      <xsl:when test="$nmr=true()">
        <xsl:for-each select="1 to $nmr_models">
          <xsl:call-template name="modelled_subgroup_model">
            <xsl:with-param name="model"><xsl:value-of select="."/></xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="modelled_subgroup_model">
          <xsl:with-param name="model">1</xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="modelled_subgroup_model">
    <xsl:param name="model"/>

    <xsl:variable name="strand_ids">
      <xsl:for-each select="$noatom_datablock/PDBx:entity_polyCategory/PDBx:entity_poly">
        <xsl:value-of select="concat(PDBx:pdbx_strand_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:for-each select="tokenize(substring($strand_ids,1,string-length($strand_ids)-1),',')">
      <xsl:call-template name="modelled_subgroup_strand_id">
        <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
        <xsl:with-param name="strand_id"><xsl:value-of select="."/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="modelled_subgroup_strand_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>

    <xsl:for-each select="$noatom_datablock/PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme[PDBx:pdb_strand_id=$strand_id]">
      <xsl:call-template name="modelled_subgroup_mon_id">
        <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
        <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
        <xsl:with-param name="asym_id"><xsl:value-of select="@asym_id"/></xsl:with-param>
        <xsl:with-param name="entity_id"><xsl:value-of select="@entity_id"/></xsl:with-param>
        <xsl:with-param name="mon_id"><xsl:value-of select="@mon_id"/></xsl:with-param>
        <xsl:with-param name="seq_id"><xsl:value-of select="@seq_id"/></xsl:with-param>
        <xsl:with-param name="pdb_seq_num"><xsl:value-of select="PDBx:pdb_seq_num"/></xsl:with-param>
        <xsl:with-param name="pdb_ins_code"><xsl:value-of select="PDBx:pdb_ins_code"/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

    <xsl:for-each select="$noatom_datablock/PDBx:pdbx_nonpoly_schemeCategory/PDBx:pdbx_nonpoly_scheme[PDBx:pdb_strand_id=$strand_id]">
      <xsl:call-template name="modelled_subgroup_mon_id">
        <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
        <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
        <xsl:with-param name="asym_id"><xsl:value-of select="@asym_id"/></xsl:with-param>
        <xsl:with-param name="entity_id"><xsl:value-of select="PDBx:entity_id"/></xsl:with-param>
        <xsl:with-param name="mon_id"><xsl:value-of select="PDBx:mon_id"/></xsl:with-param>
        <xsl:with-param name="seq_id"/>
        <xsl:with-param name="pdb_seq_num"><xsl:value-of select="PDBx:pdb_seq_num"/></xsl:with-param>
        <xsl:with-param name="pdb_ins_code"><xsl:value-of select="PDBx:pdb_ins_code"/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="modelled_subgroup_mon_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>
    <xsl:param name="asym_id"/>
    <xsl:param name="entity_id"/>
    <xsl:param name="mon_id"/>
    <xsl:param name="seq_id"/>
    <xsl:param name="pdb_seq_num"/>
    <xsl:param name="pdb_ins_code"/>

    <xsl:variable name="alt_ids">
      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_mapCategory/PDBxv:pdbx_dcc_map[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num]">
        <xsl:value-of select="concat(PDBxv:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_mon_geometryCategory/PDBxv:pdbx_dcc_mon_geometry[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num]">
        <xsl:value-of select="concat(PDBxv:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/PDBxv:struct_mon_protCategory/PDBxv:struct_mon_prot[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num]">
        <xsl:value-of select="concat(PDBxv:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/PDBxv:struct_mon_nuclCategory/PDBxv:struct_mon_nucl[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num]">
        <xsl:value-of select="concat(PDBxv:label_alt_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($alt_ids)&gt;0">

      <xsl:variable name="alt_id_list">
        <xsl:value-of select="substring($alt_ids,1,string-length($alt_ids)-1)"/>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$alt_id_list=''">
          <xsl:call-template name="modelled_subgroup_alt_id">
            <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
            <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
            <xsl:with-param name="asym_id"><xsl:value-of select="$asym_id"/></xsl:with-param>
            <xsl:with-param name="entity_id"><xsl:value-of select="$entity_id"/></xsl:with-param>
            <xsl:with-param name="mon_id"><xsl:value-of select="$mon_id"/></xsl:with-param>
            <xsl:with-param name="seq_id"><xsl:value-of select="$seq_id"/></xsl:with-param>
            <xsl:with-param name="pdb_seq_num"><xsl:value-of select="$pdb_seq_num"/></xsl:with-param>
            <xsl:with-param name="pdb_ins_code"><xsl:value-of select="$pdb_ins_code"/></xsl:with-param>
            <xsl:with-param name="alt_id"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="distinct-values(tokenize($alt_id_list,','))">
            <xsl:call-template name="modelled_subgroup_alt_id">
              <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
              <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
              <xsl:with-param name="asym_id"><xsl:value-of select="$asym_id"/></xsl:with-param>
              <xsl:with-param name="entity_id"><xsl:value-of select="$entity_id"/></xsl:with-param>
              <xsl:with-param name="mon_id"><xsl:value-of select="$mon_id"/></xsl:with-param>
              <xsl:with-param name="seq_id"><xsl:value-of select="$seq_id"/></xsl:with-param>
              <xsl:with-param name="pdb_seq_num"><xsl:value-of select="$pdb_seq_num"/></xsl:with-param>
              <xsl:with-param name="pdb_ins_code"><xsl:value-of select="$pdb_ins_code"/></xsl:with-param>
              <xsl:with-param name="alt_id"><xsl:value-of select="."/></xsl:with-param>
            </xsl:call-template>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:if>

  </xsl:template>

  <xsl:template name="modelled_subgroup_alt_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>
    <xsl:param name="asym_id"/>
    <xsl:param name="entity_id"/>
    <xsl:param name="mon_id"/>
    <xsl:param name="seq_id"/>
    <xsl:param name="pdb_seq_num"/>
    <xsl:param name="pdb_ins_code"/>
    <xsl:param name="alt_id"/>

    <ModelledSubgroup>

      <xsl:attribute name="model"><xsl:value-of select="$model"/></xsl:attribute>
      <xsl:attribute name="chain"><xsl:value-of select="$strand_id"/></xsl:attribute>
      <xsl:attribute name="said"><xsl:value-of select="$asym_id"/></xsl:attribute>
      <xsl:attribute name="ent"><xsl:value-of select="$entity_id"/></xsl:attribute>
      <xsl:attribute name="resname"><xsl:value-of select="$mon_id"/></xsl:attribute>
      <xsl:attribute name="seq"><xsl:value-of select="$seq_id"/></xsl:attribute>
      <xsl:attribute name="resnum"><xsl:value-of select="$pdb_seq_num"/></xsl:attribute>
      <xsl:choose>
        <xsl:when test="$pdb_ins_code!=''">
          <xsl:attribute name="icode"><xsl:value-of select="$pdb_ins_code"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="icode"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$alt_id!=''">
          <xsl:attribute name="altcode"><xsl:value-of select="$alt_id"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="altcode"/>
        </xsl:otherwise>
      </xsl:choose>

      <!-- pdbx_dcc_map -->

      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_mapCategory/PDBxv:pdbx_dcc_map[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">

        <xsl:attribute name="owab"><xsl:value-of select="PDBxv:Biso_mean"/></xsl:attribute>

        <xsl:if test="PDBxv:LLDFZ">
          <xsl:attribute name="ligRSRZ"><xsl:value-of select="PDBxv:LLDFZ"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDFZ_outlier_flag='Y'">
          <xsl:attribute name="ligand_density_outlier">yes</xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDF_name">
          <xsl:attribute name="lig_rsrz_nbr_id"><xsl:value-of select="PDBxv:LLDF_name"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDF_number_residues_total">
          <xsl:attribute name="ligRSRnumnbrs"><xsl:value-of select="PDBxv:LLDF_number_residues_total"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDF">
          <xsl:attribute name="ligRSRnbrMean"><xsl:value-of select="PDBxv:LLDF"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDF_sigma">
          <xsl:attribute name="ligRSRnbrStdev"><xsl:value-of select="PDBxv:LLDF_sigma"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:RSCC">
          <xsl:attribute name="rscc"><xsl:value-of select="PDBxv:RSCC"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:RSR">
          <xsl:attribute name="rsr"><xsl:value-of select="PDBxv:RSR"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:RSRZ">
          <xsl:attribute name="rsrz"><xsl:value-of select="PDBxv:RSRZ"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:occupancy_mean">
          <xsl:attribute name="avgoccu"><xsl:value-of select="PDBxv:occupancy_mean"/></xsl:attribute>
        </xsl:if>

      </xsl:for-each>

      <!-- pdbx_dcc_mon_geometry -->

      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_mon_geometryCategory/PDBxv:pdbx_dcc_mon_geometry[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">

        <xsl:if test="PDBxv:angle_overall_rmsz">
          <xsl:attribute name="mogul_angles_rmsz"><xsl:value-of select="PDBxv:angle_overall_rmsz"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:bond_overall_rmsz">
          <xsl:attribute name="mogul_bonds_rmsz"><xsl:value-of select="PDBxv:bond_overall_rmsz"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:number_angles">
          <xsl:attribute name="mogul_rmsz_numangles"><xsl:value-of select="PDBxv:number_angles"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:number_bonds">
          <xsl:attribute name="mogul_rmsz_numbonds"><xsl:value-of select="PDBxv:number_bonds"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:LLDFZ_outlier_flag='Y'">
          <xsl:attribute name="ligand_geometry_outlier">yes</xsl:attribute>
        </xsl:if>

      </xsl:for-each>

      <!-- struct_mon_prot -->

      <xsl:for-each select="$datablock/PDBxv:struct_mon_protCategory/PDBxv:struct_mon_prot[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">

        <xsl:if test="PDBxv:phi">
          <xsl:attribute name="phi"><xsl:value-of select="PDBxv:phi"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:psi">
          <xsl:attribute name="psi"><xsl:value-of select="PDBxv:psi"/></xsl:attribute>
        </xsl:if>
<!--
        <xsl:if test="count(plane-outlier/@omega)=1">
          <xsl:element name="PDBxv:omega"><xsl:value-of select="plane-outlier/@omega"/></xsl:element>
        </xsl:if>
-->
        <xsl:if test="PDBxv:pdbx_Ramachandran_region">
          <xsl:attribute name="rama"><xsl:value-of select="PDBxv:pdbx_Ramachandran_region"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:pdbx_flippable_side_chain='Y'">
          <xsl:attribute name="flippable-sidechain">1</xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:pdbx_rotamer">
          <xsl:attribute name="rota"><xsl:value-of select="PDBxv:pdbx_rotamer"/></xsl:attribute>
        </xsl:if>

      </xsl:for-each>

      <!-- struct_mon_nucl -->

      <xsl:for-each select="$datablock/PDBxv:struct_mon_nuclCategory/PDBxv:struct_mon_nucl[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">

        <xsl:if test="PDBxv:pdbx_RNA_pucker_outlier_flag='Y'">
          <xsl:attribute name="RNApucker">outlier</xsl:attribute>
        </xsl:if>

        <xsl:choose>
          <xsl:when test="PDBxv:pdbx_RNA_suite">
            <xsl:attribute name="RNAsuite"><xsl:value-of select="PDBxv:pdbx_RNA_suite"/></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="RNAsuite">NotAvailable</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="PDBxv:pdbx_RNA_suiteness_score">
          <xsl:attribute name="RNAscore"><xsl:value-of select="PDBxv:pdbx_RNA_suiteness_score"/></xsl:attribute>
        </xsl:if>

      </xsl:for-each>

      <!-- cis_peptide -->

      <xsl:for-each select="$noatom_datablock/PDBx:struct_mon_prot_cisCategory/PDBx:struct_mon_prot_cis[PDBx:pdbx_PDB_model_num=$model and PDBx:auth_asym_id=$strand_id and PDBx:auth_comp_id=$mon_id and PDBx:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBx:label_alt_id=$alt_id)]">
        <xsl:attribute name="cis_peptide">yes</xsl:attribute>
      </xsl:for-each>

      <!-- ligand -->

      <xsl:if test="$datablock/PDBxv:pdbx_dcc_mon_geometryCategory/PDBxv:pdbx_dcc_mon_geometry[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">

        <xsl:variable name="ligand_num_clashes"><xsl:value-of select="count($datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id) and PDBxv:clash_magnitude]) + count($datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id) and PDBxv:clash_magnitude])"/></xsl:variable>

        <xsl:variable name="ligand_num_symm_clashes"><xsl:value-of select="count($datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id) and PDBxv:clash_magnitude]) + count($datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id) and PDBxv:clash_magnitude])"/></xsl:variable>

        <xsl:if test="$ligand_num_clashes&gt;0 or $ligand_num_symm_clashes&gt;0">
          <xsl:attribute name="ligand_clashes_outlier">yes</xsl:attribute>
          <xsl:attribute name="ligand_num_clashes"><xsl:value-of select="$ligand_num_clashes"/></xsl:attribute>
          <xsl:attribute name="ligand_num_symm_clashes"><xsl:value-of select="$ligand_num_symm_clashes"/></xsl:attribute>
        </xsl:if>

        <xsl:if test="$datablock/PDBxv:pdbx_validate_chiralCategory/PDBxv:pdbx_validate_chiral[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">
          <xsl:attribute name="ligand_chirality_outlier">yes</xsl:attribute>
        </xsl:if>

      </xsl:if>

      <xsl:if test="$nmr=true()">

        <xsl:choose>
          <xsl:when test="$datablock/PDBxv:pdbx_struct_nmr_ens_dom_limCategory/PDBxv:pdbx_struct_nmr_ens_dom_lim[PDBxv:beg_auth_asym_id=$strand_id and PDBxv:end_auth_asym_id=$strand_id]">

            <xsl:variable name="cyrange_domain_id">
              <xsl:for-each select="$datablock/PDBxv:pdbx_struct_nmr_ens_dom_limCategory/PDBxv:pdbx_struct_nmr_ens_dom_lim[PDBxv:beg_auth_asym_id=$strand_id and PDBxv:end_auth_asym_id=$strand_id and number(PDBxv:beg_auth_seq_id)&lt;=number($pdb_seq_num) and number(PDBxv:end_auth_seq_id)&gt;=number($pdb_seq_num)]">
                <xsl:value-of select="@dom_id"/>
              </xsl:for-each>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="$cyrange_domain_id!=''">
                <xsl:attribute name="cyrange_domain_id"><xsl:value-of select="$cyrange_domain_id"/></xsl:attribute>
                <xsl:attribute name="validate">True</xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="validate">False</xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="validate">True</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:if>

      <!-- EM validation : ModelledSubgroup -->

      <xsl:if test="$em=true()">

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_validate_map_modelCategory/PDBxv:pdbx_em_validate_map_model[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id)]">
          <xsl:attribute name="residue_inclusion"><xsl:value-of select="PDBxv:atom_inclusion_all"/></xsl:attribute>
        </xsl:for-each>

      </xsl:if>
<!--
            <xsd:attribute ref="NatomsEDS" use="optional"/>
            <xsd:attribute ref="num-H-reduce" use="optional"/>
            <xsd:attribute ref="mogul-ignore" use="optional"/>
-->
      <!-- bond-outlier, mog-bond-outlier -->

      <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_bondCategory/PDBxv:pdbx_validate_rmsd_bond[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id) and PDBxv:Zscore]">

        <xsl:choose>
          <xsl:when test="PDBxv:number_bonds_in_kb">

            <mog-bond-outlier>

              <xsl:attribute name="atoms"><xsl:value-of select="concat(PDBxv:auth_atom_id_1,',',PDBxv:auth_atom_id_2)"/></xsl:attribute>
              <xsl:choose>
                <xsl:when test="PDBxv:Zscore">
                  <xsl:attribute name="Zscore"><xsl:value-of select="PDBxv:Zscore"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="Zscore"><xsl:value-of select="format-number(number(PDBxv:bond_deviation) div number(PDBxv:bond_standard_deviation),'0.00')"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:bond_standard_deviation"/></xsl:attribute>
              <xsl:attribute name="mean"><xsl:value-of select="PDBxv:bond_target_value"/></xsl:attribute>
              <xsl:attribute name="obsval"><xsl:value-of select="PDBxv:bond_value"/></xsl:attribute>
              <xsl:attribute name="mindiff"><xsl:value-of select="PDBxv:bond_minimum_diff_to_kb"/></xsl:attribute>
              <xsl:attribute name="numobs"><xsl:value-of select="PDBxv:number_bonds_in_kb"/></xsl:attribute>

            </mog-bond-outlier>

          </xsl:when>
          <xsl:otherwise>

            <bond-outlier>

              <xsl:attribute name="atom0"><xsl:value-of select="PDBxv:auth_atom_id_1"/></xsl:attribute>
              <xsl:attribute name="atom1"><xsl:value-of select="PDBxv:auth_atom_id_2"/></xsl:attribute>
              <xsl:choose>
                <xsl:when test="PDBxv:Zscore">
                  <xsl:attribute name="z"><xsl:value-of select="PDBxv:Zscore"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="z"><xsl:value-of select="format-number(number(PDBxv:bond_deviation) div number(PDBxv:bond_standard_deviation),'0.00')"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:bond_standard_deviation"/></xsl:attribute>
              <xsl:attribute name="mean"><xsl:value-of select="PDBxv:bond_target_value"/></xsl:attribute>
              <xsl:attribute name="obs"><xsl:value-of select="PDBxv:bond_value"/></xsl:attribute>
              <xsl:if test="PDBxv:linker_flag='Y'">
                <xsl:attribute name="link">yes</xsl:attribute>
              </xsl:if>

            </bond-outlier>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

      <!-- angle-outlier, mog-angle-outlier -->

      <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_angleCategory/PDBxv:pdbx_validate_rmsd_angle[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id) and PDBxv:Zscore]">

        <xsl:choose>
          <xsl:when test="PDBxv:number_angles_in_kb">

            <mog-angle-outlier>

              <xsl:attribute name="atoms"><xsl:value-of select="concat(PDBxv:auth_atom_id_1,',',PDBxv:auth_atom_id_2,',',PDBxv:auth_atom_id_3)"/></xsl:attribute>
              <xsl:choose>
                <xsl:when test="PDBxv:Zscore">
                  <xsl:attribute name="Zscore"><xsl:value-of select="PDBxv:Zscore"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="Zscore"><xsl:value-of select="format-number(number(PDBxv:angle_deviation) div number(PDBxv:angle_standard_deviation),'0.00')"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:angle_standard_deviation"/></xsl:attribute>
              <xsl:attribute name="mean"><xsl:value-of select="PDBxv:angle_target_value"/></xsl:attribute>
              <xsl:attribute name="obsval"><xsl:value-of select="PDBxv:angle_value"/></xsl:attribute>
              <xsl:attribute name="mindiff"><xsl:value-of select="PDBxv:angle_minimum_diff_to_kb"/></xsl:attribute>
              <xsl:attribute name="numobs"><xsl:value-of select="PDBxv:number_angles_in_kb"/></xsl:attribute>

            </mog-angle-outlier>

          </xsl:when>
          <xsl:otherwise>

            <angle-outlier>

              <xsl:attribute name="atom0"><xsl:value-of select="PDBxv:auth_atom_id_1"/></xsl:attribute>
              <xsl:attribute name="atom1"><xsl:value-of select="PDBxv:auth_atom_id_2"/></xsl:attribute>
              <xsl:attribute name="atom2"><xsl:value-of select="PDBxv:auth_atom_id_3"/></xsl:attribute>
              <xsl:choose>
                <xsl:when test="PDBxv:Zscore">
                  <xsl:attribute name="z"><xsl:value-of select="PDBxv:Zscore"/></xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="z"><xsl:value-of select="format-number(number(PDBxv:angle_deviation) div number(PDBxv:angle_standard_deviation),'0.00')"/></xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:angle_standard_deviation"/></xsl:attribute>
              <xsl:attribute name="mean"><xsl:value-of select="PDBxv:angle_target_value"/></xsl:attribute>
              <xsl:attribute name="obs"><xsl:value-of select="PDBxv:angle_value"/></xsl:attribute>
              <xsl:if test="PDBxv:linker_flag='Y'">
                <xsl:attribute name="link">yes</xsl:attribute>
              </xsl:if>

            </angle-outlier>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

      <!-- chiral-outlier -->

      <xsl:for-each select="$noatom_datablock/PDBx:pdbx_validate_chiralCategory/PDBx:pdbx_validate_chiral[PDBx:PDB_model_num=$model and PDBx:auth_asym_id=$strand_id and PDBx:auth_comp_id=$mon_id and PDBx:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBx:label_alt_id=$alt_id)]">

        <chiral-outlier>

          <xsl:attribute name="atom"><xsl:value-of select="PDBx:auth_atom_id"/></xsl:attribute>
          <xsl:attribute name="problem"><xsl:value-of select="PDBx:details"/></xsl:attribute>

        </chiral-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='peptide'] -->

      <xsl:for-each select="$noatom_datablock/PDBx:pdbx_validate_peptide_omegaCategory/PDBx:pdbx_validate_peptide_omega[PDBx:PDB_model_num=$model and PDBx:auth_asym_id_1=$strand_id and PDBx:auth_comp_id_1=$mon_id and PDBx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBx:label_alt_id_1=$alt_id)]">

        <plane-outlier type="peptide">

          <xsl:attribute name="omega"><xsl:value-of select="PDBx:omega"/></xsl:attribute>

        </plane-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='mainchain'] -->

      <xsl:for-each select="$noatom_datablock/PDBx:pdbx_validate_main_chain_planeCategory/PDBx:pdbx_validate_main_chain_plane[PDBx:PDB_model_num=$model and PDBx:auth_asym_id=$strand_id and PDBx:auth_comp_id=$mon_id and PDBx:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBx:label_alt_id=$alt_id)]">

        <plane-outlier type="mainchain">

          <xsl:attribute name="improper"><xsl:value-of select="PDBx:improper_torsion_angle"/></xsl:attribute>

        </plane-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='sidechain'] -->

      <xsl:for-each select="$noatom_datablock/PDBx:pdbx_validate_planesCategory/PDBx:pdbx_validate_planes[PDBx:PDB_model_num=$model and PDBx:auth_asym_id=$strand_id and PDBx:auth_comp_id=$mon_id and PDBx:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBx:label_alt_id=$alt_id)]">

        <plane-outlier>

          <xsl:attribute name="type"><xsl:value-of select="lower-case(translate(PDBx:type,' ',''))"/></xsl:attribute>
          <xsl:attribute name="planeRMSD"><xsl:value-of select="PDBx:rmsd"/></xsl:attribute>

        </plane-outlier>

      </xsl:for-each>

      <!-- mog-torsion-outlier -->

      <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_torsionCategory/PDBxv:pdbx_validate_rmsd_torsion[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id) and PDBxv:number_dihedral_angles_in_kb]">

        <mog-torsion-outlier>

          <xsl:variable name="torsion_id"><xsl:value-of select="@id"/></xsl:variable>

          <xsl:variable name="atoms">
            <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_torsions_atomCategory/PDBxv:pdbx_validate_rmsd_torsions_atom[@torsion_id=$torsion_id]">
              <xsl:value-of select="concat(PDBxv:auth_atom_id,',')"/>
            </xsl:for-each>
          </xsl:variable>

          <xsl:attribute name="atoms"><xsl:value-of select="substring($atoms,1,string-length($atoms)-1)"/></xsl:attribute>
          <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:dihedral_angle_standard_deviation"/></xsl:attribute>
          <xsl:attribute name="mean"><xsl:value-of select="PDBxv:dihedral_angle_target_value"/></xsl:attribute>
          <xsl:attribute name="obsval"><xsl:value-of select="PDBxv:dihedral_angle_value"/></xsl:attribute>
          <xsl:attribute name="mindiff"><xsl:value-of select="PDBxv:dihedral_angle_minimum_diff_to_kb"/></xsl:attribute>
          <xsl:attribute name="numobs"><xsl:value-of select="PDBxv:number_dihedral_angles_in_kb"/></xsl:attribute>
          <xsl:if test="PDBxv:percent_dihedral_angles_fitted_to_kb">
            <xsl:attribute name="local_density"><xsl:value-of select="PDBxv:percent_dihedral_angles_fitted_to_kb"/></xsl:attribute>
          </xsl:if>

        </mog-torsion-outlier>

      </xsl:for-each>

      <!-- mog-ring-outlier -->

     <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_ringCategory/PDBxv:pdbx_validate_rmsd_ring[PDBxv:PDB_model_num=$model and PDBxv:auth_asym_id=$strand_id and PDBxv:auth_comp_id=$mon_id and PDBxv:auth_seq_id=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id=$alt_id) and PDBxv:number_dihedral_angles_in_kb]">

        <mog-ring-outlier>

          <xsl:variable name="ring_id"><xsl:value-of select="@id"/></xsl:variable>

          <xsl:variable name="atoms">
            <xsl:for-each select="$datablock/PDBxv:pdbx_validate_rmsd_rings_atomCategory/PDBxv:pdbx_validate_rmsd_rings_atom[@ring_id=$ring_id]">
              <xsl:value-of select="concat(PDBxv:auth_atom_id,',')"/>
            </xsl:for-each>
          </xsl:variable>

          <xsl:attribute name="atoms"><xsl:value-of select="substring($atoms,1,string-length($atoms)-1)"/></xsl:attribute>
          <xsl:attribute name="stdev"><xsl:value-of select="PDBxv:dihedral_angle_standard_deviation"/></xsl:attribute>
          <xsl:attribute name="mean"><xsl:value-of select="PDBxv:dihedral_angle_target_value"/></xsl:attribute>
          <xsl:attribute name="mindiff"><xsl:value-of select="PDBxv:dihedral_angle_minimum_diff_to_kb"/></xsl:attribute>
          <xsl:attribute name="numobs"><xsl:value-of select="PDBxv:number_dihedral_angles_in_kb"/></xsl:attribute>

        </mog-ring-outlier>

      </xsl:for-each>

      <!-- clash -->

      <xsl:variable name="clash_from_pdbml"><xsl:value-of select="count($noatom_datablock/PDBx:pdbx_validate_close_contactCategory/PDBx:pdbx_validate_close_contact[not(PDBx:clash_magnitude)])"/></xsl:variable>

      <xsl:for-each select="$datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact[PDBxv:PDB_model_num=$model and ((PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id)) or (PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id))) and PDBxv:clash_magnitude]">

        <xsl:if test="PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id)">

          <clash>

            <xsl:attribute name="cid"><xsl:value-of select="number(@id)-$clash_from_pdbml"/></xsl:attribute>
            <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id_1"/></xsl:attribute>
            <xsl:attribute name="dist"><xsl:value-of select="PDBxv:dist"/></xsl:attribute>
            <xsl:if test="PDBxv:clash_magnitude">
              <xsl:attribute name="clashmag"><xsl:value-of select="PDBxv:clash_magnitude"/></xsl:attribute>
            </xsl:if>

          </clash>

        </xsl:if>

        <xsl:if test="PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id)">

          <clash>

            <xsl:attribute name="cid"><xsl:value-of select="number(@id)-$clash_from_pdbml"/></xsl:attribute>
            <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id_2"/></xsl:attribute>
            <xsl:attribute name="dist"><xsl:value-of select="PDBxv:dist"/></xsl:attribute>
            <xsl:if test="PDBxv:clash_magnitude">
              <xsl:attribute name="clashmag"><xsl:value-of select="PDBxv:clash_magnitude"/></xsl:attribute>
            </xsl:if>

          </clash>

        </xsl:if>

      </xsl:for-each>

      <!-- symm-clash -->

      <xsl:variable name="symm_clash_from_pdbml"><xsl:value-of select="count($noatom_datablock/PDBx:pdbx_validate_symm_contactCategory/PDBx:pdbx_validate_symm_contact[not(PDBx:clash_magnitude)])"/></xsl:variable>

      <xsl:for-each select="$datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact[PDBxv:PDB_model_num=$model and ((PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id)) or (PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id))) and PDBxv:clash_magnitude]">

        <xsl:if test="PDBxv:auth_asym_id_1=$strand_id and PDBxv:auth_comp_id_1=$mon_id and PDBxv:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_1=$alt_id)">

          <symm-clash>

            <xsl:attribute name="scid"><xsl:value-of select="number(@id)-$symm_clash_from_pdbml"/></xsl:attribute>
            <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id_1"/></xsl:attribute>
            <xsl:attribute name="dist"><xsl:value-of select="PDBxv:dist"/></xsl:attribute>
            <xsl:attribute name="symop"><xsl:value-of select="PDBxv:site_symmetry_1"/></xsl:attribute>
            <xsl:if test="PDBxv:clash_magnitude">
              <xsl:attribute name="clashmag"><xsl:value-of select="PDBxv:clash_magnitude"/></xsl:attribute>
            </xsl:if>

          </symm-clash>

        </xsl:if>

        <xsl:if test="PDBxv:auth_asym_id_2=$strand_id and PDBxv:auth_comp_id_2=$mon_id and PDBxv:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or PDBxv:label_alt_id_2=$alt_id)">

          <symm-clash>

            <xsl:attribute name="scid"><xsl:value-of select="number(@id)-$symm_clash_from_pdbml"/></xsl:attribute>
            <xsl:attribute name="atom"><xsl:value-of select="PDBxv:auth_atom_id_2"/></xsl:attribute>
            <xsl:attribute name="dist"><xsl:value-of select="PDBxv:dist"/></xsl:attribute>
            <xsl:attribute name="symop"><xsl:value-of select="PDBxv:site_symmetry_2"/></xsl:attribute>
            <xsl:if test="PDBxv:clash_magnitude">
              <xsl:attribute name="clashmag"><xsl:value-of select="PDBxv:clash_magnitude"/></xsl:attribute>
            </xsl:if>

          </symm-clash>

        </xsl:if>

      </xsl:for-each>

    </ModelledSubgroup>

  </xsl:template>

  <!-- ModelledEntityInstance -->

  <xsl:template name="ModelledEntityInstance">

    <xsl:choose>
      <xsl:when test="$nmr=true()">
        <xsl:for-each select="1 to $nmr_models">
          <xsl:call-template name="modelled_entity_instance_model">
            <xsl:with-param name="model"><xsl:value-of select="."/></xsl:with-param>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="modelled_entity_instance_model">
          <xsl:with-param name="model">1</xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="modelled_entity_instance_model">
    <xsl:param name="model"/>

    <xsl:variable name="strand_ids">
      <xsl:for-each select="$noatom_datablock/PDBx:entity_polyCategory/PDBx:entity_poly">
        <xsl:value-of select="concat(PDBx:pdbx_strand_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:for-each select="tokenize(substring($strand_ids,1,string-length($strand_ids)-1),',')">
      <xsl:call-template name="modelled_entity_instance_strand_id">
        <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
        <xsl:with-param name="strand_id"><xsl:value-of select="."/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="modelled_entity_instance_strand_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>

    <xsl:variable name="entity_ids">
      <xsl:for-each select="$datablock/PDBxv:pdbx_percentile_entity_viewCategory/PDBxv:pdbx_percentile_entity_view[PDBxv:auth_asym_id=$strand_id]">
        <xsl:value-of select="concat(PDBxv:entity_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_entity_geometryCategory/PDBxv:pdbx_dcc_entity_geometry[PDBxv:auth_asym_id=$strand_id]">
        <xsl:value-of select="concat(PDBxv:entity_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="$entity_ids!=''">

      <xsl:for-each select="distinct-values(tokenize($entity_ids,','))">
        <xsl:if test=".!=''">
          <xsl:call-template name="modelled_entity_instance_entity_id">
            <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
            <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
            <xsl:with-param name="entity_id"><xsl:value-of select="."/></xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>

    </xsl:if>

  </xsl:template>

  <xsl:template name="modelled_entity_instance_entity_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>
    <xsl:param name="entity_id"/>

    <xsl:variable name="asym_ids">
      <xsl:for-each select="$datablock/PDBxv:pdbx_percentile_entity_viewCategory/PDBxv:pdbx_percentile_entity_view[PDBxv:auth_asym_id=$strand_id]">
        <xsl:value-of select="concat(@label_asym_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_entity_geometryCategory/PDBxv:pdbx_dcc_entity_geometry[PDBxv:auth_asym_id=$strand_id]">
        <xsl:value-of select="concat(@label_asym_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="$asym_ids!=''">

      <xsl:for-each select="distinct-values(tokenize($asym_ids,','))">
        <xsl:if test=".!=''">
          <xsl:call-template name="modelled_entity_instance_asym_id">
            <xsl:with-param name="model"><xsl:value-of select="$model"/></xsl:with-param>
            <xsl:with-param name="strand_id"><xsl:value-of select="$strand_id"/></xsl:with-param>
            <xsl:with-param name="asym_id"><xsl:value-of select="."/></xsl:with-param>
            <xsl:with-param name="entity_id"><xsl:value-of select="$entity_id"/></xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:for-each>

    </xsl:if>

  </xsl:template>

  <xsl:template name="modelled_entity_instance_asym_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>
    <xsl:param name="asym_id"/>
    <xsl:param name="entity_id"/>

    <ModelledEntityInstance>

      <xsl:attribute name="model"><xsl:value-of select="$model"/></xsl:attribute>
      <xsl:attribute name="chain"><xsl:value-of select="$strand_id"/></xsl:attribute>
      <xsl:attribute name="said"><xsl:value-of select="$asym_id"/></xsl:attribute>
      <xsl:attribute name="ent"><xsl:value-of select="$entity_id"/></xsl:attribute>

      <xsl:for-each select="$datablock/PDBxv:pdbx_percentile_entity_viewCategory/PDBxv:pdbx_percentile_entity_view[PDBxv:auth_asym_id=$strand_id]">
        <xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable>
        <xsl:variable name="conditions_id"><xsl:value-of select="@conditions_id"/></xsl:variable>
        <xsl:variable name="condition_res_high"><xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[@id=$conditions_id]/PDBxv:ls_d_res_high"/></xsl:variable>
        <xsl:variable name="condition_res_low"><xsl:value-of select="$datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions[@id=$conditions_id]/PDBxv:ls_d_res_low"/></xsl:variable>

        <xsl:variable name="absolute">
          <xsl:choose>
            <xsl:when test="$condition_res_high!=''">no</xsl:when>
            <xsl:otherwise>yes</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="$type='RSRZ_outliers_percent'">
            <xsl:choose>
              <xsl:when test="$absolute='no'">
                <xsl:attribute name="relative_RSRZ_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="absolute_RSRZ_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$type='Ramachandran_outlier_percent'">
            <xsl:choose>
              <xsl:when test="$absolute='no'">
                <xsl:attribute name="relative_rama_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="absolute_rama_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$type='rotamer_outliers_percent'">
            <xsl:choose>
              <xsl:when test="$absolute='no'">
                <xsl:attribute name="relative_sidechain_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="absolute_sidechain_percentile"><xsl:value-of select="PDBxv:rank"/></xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="error_handler">
              <xsl:with-param name="terminate">yes</xsl:with-param>
              <xsl:with-param name="error_message">
Unmatched type exist in _pdbx_percentile_entity_view.type, <xsl:value-of select="position()"/>, found in XSLT code.
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>

      <xsl:for-each select="$datablock/PDBxv:pdbx_dcc_entity_geometryCategory/PDBxv:pdbx_dcc_entity_geometry[@label_asym_id=$asym_id]">

        <xsl:if test="PDBxv:angle_overall_rmsz">
          <xsl:attribute name="angles_rmsz"><xsl:value-of select="PDBxv:angle_overall_rmsz"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:bond_overall_rmsz">
          <xsl:attribute name="bonds_rmsz"><xsl:value-of select="PDBxv:bond_overall_rmsz"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:number_angles">
          <xsl:attribute name="num_angles_rmsz"><xsl:value-of select="PDBxv:number_angles"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="PDBxv:number_bonds">
          <xsl:attribute name="num_bonds_rmsz"><xsl:value-of select="PDBxv:number_bonds"/></xsl:attribute>
        </xsl:if>

      </xsl:for-each>

      <!-- EM validation : ModelledEntityInstarnce -->

      <xsl:if test="$em=true()">

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_validate_map_model_entityCategory/PDBxv:pdbx_em_validate_map_model_entity[@label_asym_id=$asym_id]">
          <xsl:attribute name="average_residue_inclusion"><xsl:value-of select="PDBxv:average_atom_inclusion_all"/></xsl:attribute>
        </xsl:for-each>

      </xsl:if>

    </ModelledEntityInstance>

  </xsl:template>

  <!-- EM validation : EM_validation -->

  <xsl:template name="EM_validation">
    <xsl:for-each select="PDBxv:pdbx_em_validate_map_model_overallCategory/PDBxv:pdbx_em_validate_map_model_overall[PDBxv:recommended_contour_level!='']">

      <EM_validation>

        <RecommendedContourLevel>
          <xsl:attribute name="value"><xsl:value-of select="PDBxv:recommended_contour_level"/></xsl:attribute>
        </RecommendedContourLevel>

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_density_distributionCategory/PDBxv:pdbx_em_density_distribution">
          <map_value_distribution>
            <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:map_value_title"/></xsl:attribute>
            <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:voxel_count_title"/></xsl:attribute>
            <xsl:attribute name="yScale"><xsl:value-of select="PDBxv:voxel_count_scale"/></xsl:attribute>
            <xsl:for-each select="$datablock/PDBxv:pdbx_em_density_distribution_markerCategory/PDBxv:pdbx_em_density_distribution_marker">
              <xsl:sort select="@ordinal" data-type="number"/>
              <coordinate>
                <xsl:attribute name="x"><xsl:value-of select="PDBxv:map_value"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="PDBxv:voxel_count"/></xsl:attribute>
              </coordinate>
            </xsl:for-each>
          </map_value_distribution>
        </xsl:for-each>

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_rapsCategory/PDBxv:pdbx_em_raps">
          <rotationally_averaged_power_spectrum>
            <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:spatial_frequency_title"/></xsl:attribute>
            <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:power_title"/></xsl:attribute>
            <xsl:attribute name="xUnit"><xsl:value-of select="PDBxv:spatial_frequency_unit"/></xsl:attribute>
            <xsl:attribute name="yScale"><xsl:value-of select="PDBxv:power_scale"/></xsl:attribute>
            <xsl:for-each select="$datablock/PDBxv:pdbx_em_raps_markerCategory/PDBxv:pdbx_em_raps_marker">
              <xsl:sort select="@ordinal" data-type="number"/>
              <coordinate>
                <xsl:attribute name="x"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="PDBxv:power"/></xsl:attribute>
              </coordinate>
            </xsl:for-each>
          </rotationally_averaged_power_spectrum>
        </xsl:for-each>

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_raw_rapsCategory/PDBxv:pdbx_em_raw_raps">
          <raw_map_rotationally_averaged_power_spectrum>
            <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:spatial_frequency_title"/></xsl:attribute>
            <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:power_title"/></xsl:attribute>
            <xsl:attribute name="xUnit"><xsl:value-of select="PDBxv:spatial_frequency_unit"/></xsl:attribute>
            <xsl:attribute name="yScale"><xsl:value-of select="PDBxv:power_scale"/></xsl:attribute>
            <xsl:for-each select="$datablock/PDBxv:pdbx_em_raw_raps_markerCategory/PDBxv:pdbx_em_raw_raps_marker">
              <xsl:sort select="@ordinal" data-type="number"/>
              <coordinate>
                <xsl:attribute name="x"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="PDBxv:power"/></xsl:attribute>
              </coordinate>
            </xsl:for-each>
          </raw_map_rotationally_averaged_power_spectrum>
        </xsl:for-each>

        <xsl:for-each select="$datablock/PDBxv:pdbx_em_volume_estimateCategory/PDBxv:pdbx_em_volume_estimate">
          <volume_estimate>
            <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:contour_level_title"/></xsl:attribute>
            <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:enclosed_volume_title"/></xsl:attribute>
            <xsl:attribute name="yUnit"><xsl:value-of select="PDBxv:enclosed_volume_unit"/></xsl:attribute>
            <xsl:for-each select="$datablock/PDBxv:pdbx_em_volume_estimate_markerCategory/PDBxv:pdbx_em_volume_estimate_marker">
              <xsl:sort select="@ordinal" data-type="number"/>
              <coordinate>
                <xsl:attribute name="x"><xsl:value-of select="PDBxv:contour_level"/></xsl:attribute>
                <xsl:attribute name="y"><xsl:value-of select="PDBxv:enclosed_volume"/></xsl:attribute>
              </coordinate>
            </xsl:for-each>
          </volume_estimate>
        </xsl:for-each>

        <xsl:if test="$datablock/PDBxv:pdbx_em_atom_inclusionCategory/PDBxv:pdbx_em_atom_inclusion">
          <atom_inclusion>
            <xsl:for-each select="$datablock/PDBxv:pdbx_em_atom_inclusionCategory/PDBxv:pdbx_em_atom_inclusion">
              <xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
              <xsl:choose>
                <xsl:when test="PDBxv:atom_type='all non-hydrogen atoms'">
                  <all_atoms>
                    <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:contour_level_title"/></xsl:attribute>
                    <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:atom_inclusion_title"/></xsl:attribute>
                    <xsl:for-each select="$datablock/PDBxv:pdbx_em_atom_inclusion_markerCategory/PDBxv:pdbx_em_atom_inclusion_marker[@plot_id=$plot_id]">
                      <xsl:sort select="@ordinal" data-type="number"/>
                      <coordinate>
                        <xsl:attribute name="x"><xsl:value-of select="PDBxv:contour_level"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="PDBxv:atom_inclusion"/></xsl:attribute>
                      </coordinate>
                    </xsl:for-each>
                  </all_atoms>
                </xsl:when>
                <xsl:when test="PDBxv:atom_type='backbone atoms'">
                  <backbone>
                    <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:contour_level_title"/></xsl:attribute>
                    <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:atom_inclusion_title"/></xsl:attribute>
                    <xsl:for-each select="$datablock/PDBxv:pdbx_em_atom_inclusion_markerCategory/PDBxv:pdbx_em_atom_inclusion_marker[@plot_id=$plot_id]">
                      <xsl:sort select="@ordinal" data-type="number"/>
                      <coordinate>
                        <xsl:attribute name="x"><xsl:value-of select="PDBxv:contour_level"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="PDBxv:atom_inclusion"/></xsl:attribute>
                      </coordinate>
                    </xsl:for-each>
                  </backbone>
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
            </xsl:for-each>
          </atom_inclusion>
        </xsl:if>

        <xsl:if test="$datablock/PDBxv:pdbx_em_fsc_resolutionCaetgory/PDBxv:pdbx_em_fsc_resolution">
          <fsc>
            <resolution_intersections>
              <xsl:attribute name="resolution_unit"><xsl:value-of select="$datablock/PDBxv:pdbx_em_fsc_resolutionCaetgory/PDBxv:pdbx_em_fsc_resolution[1]/PDBxv:resolution_unit"/></xsl:attribute>
              <xsl:attribute name="spatial_frequency_unit"><xsl:value-of select="$datablock/PDBxv:pdbx_em_fsc_resolutionCaetgory/PDBxv:pdbx_em_fsc_resolution[1]/PDBxv:spatial_frequency_unit"/></xsl:attribute>
              <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_resolutionCaetgory/PDBxv:pdbx_em_fsc_resolution">
                <intersection>
                  <xsl:attribute name="curve"><xsl:value-of select="@source"/></xsl:attribute>
                  <xsl:variable name="type">
                    <xsl:choose>
                      <xsl:when test="@criterion='0.143' or @criterion='0.333' or @criterion='0.5'"><xsl:value-of select="@criterion"/></xsl:when>
                      <xsl:when test="@criterion='half-bit'">halfbit</xsl:when>
                      <xsl:when test="@criterion='one-bit'">onebit</xsl:when>
                      <xsl:when test="@criterion='3sigma'">threesig</xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="error_handler">
                          <xsl:with-param name="terminate">yes</xsl:with-param>
                          <xsl:with-param name="error_message">
Criteria for FSC resolution estimation, <xsl:value-of select="@type"/>, is not listed in XSLT code.
                          </xsl:with-param>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:attribute name="type"><xsl:value-of select="$type"/></xsl:attribute>
                  <xsl:attribute name="correlation"><xsl:value-of select="PDBxv:correlation_coef"/></xsl:attribute>
                  <xsl:attribute name="spatial_frequency"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                  <xsl:attribute name="resolution"><xsl:value-of select="PDBxv:resolution"/></xsl:attribute>
                </intersection>
              </xsl:for-each>
            </resolution_intersections>

            <fsc_curves>
              <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_curveCaetgory/PDBxv:pdbx_em_fsc_curve">
                <xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
                <fsc_curve>
                  <xsl:attribute name="Title"><xsl:value-of select="PDBxv:title"/></xsl:attribute>
                  <xsl:if test="PDBxv:name">
                    <xsl:attribute name="curve_name"><xsl:value-of select="PDBxv:name"/></xsl:attribute>
                  </xsl:if>
                  <xsl:if test="PDBxv:type">
                    <xsl:attribute name="type"><xsl:value-of select="PDBxv:type"/></xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:spatial_frequency_title"/></xsl:attribute>
                  <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:correlation_coef_title"/></xsl:attribute>
                  <xsl:attribute name="xUnit"><xsl:value-of select="PDBxv:spatial_frequency_unit"/></xsl:attribute>
                  <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_curve_markerCaetgory/PDBxv:pdbx_em_fsc_curve_marker[@plot_id=$plot_id]">
                    <xsl:sort select="@ordinal" data-type="number"/>
                    <coordinate>
                      <xsl:attribute name="x"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                      <xsl:attribute name="y"><xsl:value-of select="PDBxv:correlation_coef"/></xsl:attribute>
                    </coordinate>
                  </xsl:for-each>
                </fsc_curve>
              </xsl:for-each>
            </fsc_curves>

            <fsc_indicator_curves>
              <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_cutoff_curveCaetgory/PDBxv:pdbx_em_fsc_cutoff_curve">
                <xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
                <fsc_indicator_curve>
                  <xsl:variable name="curve">
                    <xsl:choose>
                      <xsl:when test="starts-with(PDBxv:title,'calculated_fsc') or PDBxv:target_curve='calculated_fsc'">calculated_fsc</xsl:when>
                      <xsl:when test="starts-with(PDBxv:title,'author_provided_fsc') or PDBxv:target_curve='author_provided_fsc'">author_provided_fsc</xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="error_handler">
                          <xsl:with-param name="terminate">yes</xsl:with-param>
                          <xsl:with-param name="error_message">
Source for FSC offset curve, <xsl:value-of select="PDBxv:title"/>, is not listed in XSLT code.
                          </xsl:with-param>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:variable name="type">
                    <xsl:choose>
                      <xsl:when test="ends-with(PDBxv:title,'0.143') or PDBxv:type='0.143'">0.143</xsl:when>
                      <xsl:when test="ends-with(PDBxv:title,'0.333') or PDBxv:type='0.333'">0.333</xsl:when>
                      <xsl:when test="ends-with(PDBxv:title,'0.5') or PDBxv:type='0.5'">0.5</xsl:when>
                      <xsl:when test="ends-with(PDBxv:title,'half-bit') or PDBxv:type='half-bit'">halfbit</xsl:when>
                      <xsl:when test="ends-with(PDBxv:title,'one-bit') or PDBxv:type='one-bit'">onebit</xsl:when>
                      <xsl:when test="ends-with(PDBxv:title,'3sigma') or PDBxv:type='3sigma'">threesigma</xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="error_handler">
                          <xsl:with-param name="terminate">yes</xsl:with-param>
                          <xsl:with-param name="error_message">
Criteria for FSC offset curve, <xsl:value-of select="PDBxv:title"/>, is not listed in XSLT code.
                          </xsl:with-param>
                        </xsl:call-template>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <xsl:attribute name="Title"><xsl:value-of select="PDBxv:title"/></xsl:attribute>
                  <xsl:if test="PDBxv:name">
                    <xsl:attribute name="curve_name"><xsl:value-of select="concat($curve,'_',$type)"/></xsl:attribute>
                  </xsl:if>
                  <xsl:if test="PDBxv:type">
                    <xsl:attribute name="type"><xsl:value-of select="$type"/></xsl:attribute>
                  </xsl:if>
                  <xsl:if test="PDBxv:target_name">
                    <xsl:attribute name="data_curve"><xsl:value-of select="$curve"/></xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="xTitle"><xsl:value-of select="PDBxv:spatial_frequency_title"/></xsl:attribute>
                  <xsl:attribute name="yTitle"><xsl:value-of select="PDBxv:correlation_coef_title"/></xsl:attribute>
                  <xsl:attribute name="xUnit"><xsl:value-of select="PDBxv:spatial_frequency_unit"/></xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="$type='halfbit' or $type='onebit' or $type='threesigma'">
                      <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_cutoff_curve_markerCaetgory/PDBxv:pdbx_em_fsc_cutoff_curve_marker[@plot_id=$plot_id]">
                        <xsl:sort select="@ordinal" data-type="number"/>
                        <coordinate>
                          <xsl:attribute name="x"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                          <xsl:attribute name="y"><xsl:value-of select="PDBxv:correlation_coef"/></xsl:attribute>
                        </coordinate>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:variable name="plot_id"><xsl:value-of select="$datablock/PDBxv:pdbx_em_fsc_curveCategory/PDBxv:pdbx_em_fsc_curve[PDBxv:title=$curve]/@id"/></xsl:variable>
                      <xsl:for-each select="$datablock/PDBxv:pdbx_em_fsc_curve_markerCategory/PDBxv:pdbx_em_fsc_curve_marker[@plot_id=$plot_id]">
                        <xsl:sort select="@ordinal" data-type="number"/>
                        <coordinate>
                          <xsl:attribute name="x"><xsl:value-of select="PDBxv:spatial_frequency"/></xsl:attribute>
                          <xsl:attribute name="y"><xsl:value-of select="$type"/></xsl:attribute>
                        </coordinate>
                      </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                </fsc_indicator_curve>
              </xsl:for-each>
            </fsc_indicator_curves>

          </fsc>
        </xsl:if>

      </EM_validation>
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
          <xsl:text>ERROR in revert_info_from_alt_noatom.xsl: </xsl:text>
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
