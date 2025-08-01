<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="datablock" select="/VRPTx:datablock"/>

  <xsl:variable name="entry_id"><xsl:value-of select="$datablock/VRPTx:entryCategory/VRPTx:entry/@id"/></xsl:variable>

  <!-- experimental method -->

  <xsl:variable name="exptl_method"><xsl:value-of select="$datablock/VRPTx:exptlCategory/VRPTx:exptl/@method"/></xsl:variable>

  <xsl:variable name="x-ray"><xsl:value-of select="contains($exptl_method,'DIFFRACTION') and not(contains($exptl_method,'NEUTRON'))"/></xsl:variable>
  <xsl:variable name="nmr"><xsl:value-of select="contains($exptl_method,'NMR')"/></xsl:variable>
  <xsl:variable name="em"><xsl:value-of select="$exptl_method='ELECTRON MICROSCOPY'"/></xsl:variable>
  <xsl:variable name="other"><xsl:value-of select="$x-ray=false() and $nmr=false() and $em=false()"/></xsl:variable>

  <xsl:variable name="percentile_d_res_high">
    <xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[VRPTx:ls_d_res_high!='']/VRPTx:ls_d_res_high"/>
  </xsl:variable>

  <xsl:variable name="percentile_d_res_low">
    <xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[VRPTx:ls_d_res_low!='']/VRPTx:ls_d_res_low"/>
  </xsl:variable>

  <xsl:variable name="nmr_models">
    <xsl:value-of select="$datablock/VRPTx:pdbx_struct_nmr_ens_clustCategory/VRPTx:pdbx_struct_nmr_ens_clust/VRPTx:conformers_total_number"/>
  </xsl:variable>

  <xsl:variable name="cs_only">
    <xsl:choose>
      <xsl:when test="$datablock/VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list">no</xsl:when>
      <xsl:otherwise>yes</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="dist_rest">
    <xsl:choose>
      <xsl:when test="$datablock/VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list[@type='distance']">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="dihed_rest">
    <xsl:choose>
      <xsl:when test="$datablock/VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list[@type='dihedral_angle']">yes</xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!-- Level 1 -->

  <xsl:template match="$datablock">

    <wwPDB-validation-information xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://wwpdb.org/validation/schema/wwpdb_validation_v6.01.xsd">
      <Entry>
	<xsl:call-template name="Entry"/>
      </Entry>

      <xsl:if test="$nmr=true()">
	<xsl:apply-templates select="VRPTx:pdbx_struct_nmr_ens_clust_genCategory/*"/>
      </xsl:if>

      <xsl:call-template name="ModelledSubgroup"/>

      <xsl:if test="$nmr=true()">

	<xsl:for-each select="VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom">

	  <cyrange_domain>

	    <xsl:variable name="dom_id"><xsl:value-of select="@id"/></xsl:variable>

	    <xsl:attribute name="domain"><xsl:value-of select="$dom_id"/></xsl:attribute>
	    <xsl:if test="VRPTx:medoid_model_number">
	      <xsl:attribute name="medoid_model"><xsl:value-of select="VRPTx:medoid_model_number"/></xsl:attribute>
	    </xsl:if>
	    <xsl:if test="VRPTx:distance_rms_dev_medoid">
	      <xsl:attribute name="medoid_rmsd"><xsl:value-of select="VRPTx:distance_rms_dev_medoid"/></xsl:attribute>
	    </xsl:if>
	    <xsl:attribute name="rmsd"><xsl:value-of select="VRPTx:distance_rms_dev"/></xsl:attribute>
	    <xsl:attribute name="number_of_gaps"><xsl:value-of select="VRPTx:number_of_gaps"/></xsl:attribute>
	    <xsl:attribute name="number_of_residues"><xsl:value-of select="VRPTx:number_of_monomers"/></xsl:attribute>
	    <xsl:attribute name="percentage_of_core"><xsl:value-of select="VRPTx:percent_of_core"/></xsl:attribute>

	    <xsl:variable name="residue_string">
	      <xsl:for-each select="$datablock/VRPTx:pdbx_struct_nmr_ens_dom_limCategory/VRPTx:pdbx_struct_nmr_ens_dom_lim[@dom_id=$dom_id]">
		<xsl:value-of select="concat(VRPTx:beg_auth_asym_id,':',VRPTx:beg_auth_seq_id,'-',VRPTx:end_auth_asym_id,':',VRPTx:end_auth_seq_id,', ')"/>
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

      <xsl:if test="$cs_only='no'">
	<xsl:call-template name="NMR_restraints_analysis"/>
	<xsl:if test="$dist_rest='yes'">
	  <xsl:call-template name="distance_restraints_analysis"/>
	</xsl:if>
	<xsl:if test="$dihed_rest='yes'">
	  <xsl:call-template name="dihedralangle_restraints_analysis"/>
	</xsl:if>
      </xsl:if>

      <programs>
	<xsl:apply-templates select="VRPTx:pdbx_validation_softwareCategory/*"/>
      </programs>
    </wwPDB-validation-information>

  </xsl:template>

  <!-- Level 2 -->

  <!-- Entry -->

  <xsl:template name="Entry">

    <xsl:attribute name="pdbid"><xsl:value-of select="$entry_id"/></xsl:attribute>
    <xsl:attribute name="extended_pdbid">
      <xsl:choose>
	<xsl:when test="string-length($entry_id)=4">
	  <xsl:value-of select="concat('pdb_0000', lower-case($entry_id))"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="lower-case($entry_id)"/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <xsl:apply-templates select="VRPTx:pdbx_database_statusCategory/*"/>

    <xsl:choose>
      <xsl:when test="VRPTx:pdbx_audit_revision_historyCategory/VRPTx:pdbx_audit_revision_history">
	<xsl:apply-templates select="VRPTx:pdbx_audit_revision_historyCategory"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="PDB-revision-number">-1</xsl:attribute>
	<xsl:attribute name="PDB-revision-date">unknown</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:pdbx_dcc_densityCategory/VRPTx:pdbx_dcc_density">
	<xsl:for-each select="VRPTx:pdbx_dcc_densityCategory/VRPTx:pdbx_dcc_density">
	  <xsl:call-template name="pdbx_dcc_density_summary"/>
	</xsl:for-each>
      </xsl:when>
      <xsl:when test="VRPTx:em_3d_reconstructionCategory/VRPTx:em_3d_reconstruction">
	<xsl:apply-templates select="VRPTx:em_3d_reconstructionCategory/*"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="PDB-resolution">NotAvailable</xsl:attribute>
	<xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="VRPTx:refineCategory/*"/>

    <xsl:variable name="polymer_entity_ids">
      <xsl:for-each select="VRPTx:entity_polyCategory/VRPTx:entity_poly">
	<xsl:if test="VRPTx:type and VRPTx:type=('polypeptide(L)','polypeptide(D)','polyribonucleotide','polydeoxyribonucleotide','polydeoxyribonucleotide/polyribonucleotide hybrid')">
	  <xsl:value-of select="concat(@entity_id,',')"/>
	</xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($polymer_entity_ids)&gt;1">
      <xsl:attribute name="protein-DNA-RNA-entities"><xsl:value-of select="substring($polymer_entity_ids,1,string-length($polymer_entity_ids)-1)"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:pdbx_coordinate_modelCategory/VRPTx:pdbx_coordinate_model/VRPTx:type='CA ATOMS ONLY'">
      <xsl:attribute name="CA_ONLY">yes</xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="VRPTx:pdbx_dcc_geometryCategory/*"/>

    <!-- x-ray -->

    <xsl:if test="$x-ray=true()">

      <xsl:apply-templates select="VRPTx:pdbx_dcc_densityCategory/*"/>
      <xsl:apply-templates select="VRPTx:pdbx_dcc_density_corrCategory/*"/>
      <xsl:apply-templates select="VRPTx:pdbx_dcc_map_overallCategory/*"/>

    </xsl:if>

    <!-- nmr -->

    <xsl:if test="$nmr=true()">

      <xsl:choose>
	<xsl:when test="VRPTx:pdbx_nmr_ensembleCategory/VRPTx:pdbx_nmr_ensemble/VRPTx:atom_consistency_flag='Y'">
	  <xsl:attribute name="nmr_models_consistency_flag">True</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="nmr_models_consistency_flag">False</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom/VRPTx:error!=''">
	  <xsl:attribute name="cyrange_error"><xsl:value-of select="VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom/VRPTx:error"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="cyrange_error">success</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
	<xsl:when test="VRPTx:pdbx_struct_nmr_ens_clustCategory/VRPTx:pdbx_struct_nmr_ens_clust/VRPTx:error!=''">
	  <xsl:attribute name="nmrclust_error"><xsl:value-of select="VRPTx:pdbx_struct_nmr_ens_clustCategory/VRPTx:pdbx_struct_nmr_ens_clust/VRPTx:error"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="nmrclust_error">success</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>

      <xsl:for-each select="VRPTx:pdbx_struct_nmr_ens_clust_genCategory/VRPTx:pdbx_struct_nmr_ens_clust_gen">
	<xsl:if test="VRPTx:cluster_id='1' and VRPTx:medoid_conformer='Y'">
	  <xsl:attribute name="nmrclust_representative_model"><xsl:value-of select="@PDB_model_num"/></xsl:attribute>
	</xsl:if>
      </xsl:for-each>

      <xsl:for-each select="VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom">
	<xsl:if test="@id='1'">
	  <xsl:attribute name="medoid_model"><xsl:value-of select="VRPTx:medoid_model_number"/></xsl:attribute>
	</xsl:if>
      </xsl:for-each>

      <xsl:apply-templates select="VRPTx:pdbx_struct_nmr_ens_clustCategory/*"/>

      <xsl:if test="VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom">
	<xsl:attribute name="cyrange_number_of_domains"><xsl:value-of select="count(VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom)"/></xsl:attribute>
      </xsl:if>

      <xsl:for-each select="VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness[@list_id='1' and @atom_group='overall' and @atom_type='Total']">
	<xsl:attribute name="chemical_shift_completeness"><xsl:value-of select="format-number(number(VRPTx:number_assigned_chem_shifts_well_formed) div number(VRPTx:number_target_shifts_well_formed) * 100,'0.00')"/></xsl:attribute>
	<xsl:attribute name="chemical_shift_completeness_full_length"><xsl:value-of select="format-number(number(VRPTx:number_assigned_chem_shifts) div number(VRPTx:number_target_shifts) * 100,'0.00')"/></xsl:attribute>
      </xsl:for-each>

      <xsl:attribute name="cs_only"><xsl:value-of select="$cs_only"/></xsl:attribute>

    </xsl:if>

    <!-- percentile view -->

    <xsl:choose>
      <xsl:when test="VRPTx:pdbx_percentile_listCategory/VRPTx:pdbx_percentile_list/VRPTx:name">
	<xsl:attribute name="percentilebins"><xsl:value-of select="VRPTx:pdbx_percentile_listCategory/VRPTx:pdbx_percentile_list/VRPTx:name"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="no-percentile-property">true</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates select="VRPTx:pdbx_percentile_viewCategory/*"/>

    <!-- program -->

    <xsl:variable name="software_list">
      <xsl:for-each select="VRPTx:pdbx_validation_softwareCategory/VRPTx:pdbx_validation_software[VRPTx:details!='']">
	<xsl:value-of select="concat(VRPTx:name,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:attribute name="attemptedValidationSteps"><xsl:value-of select="substring($software_list,1,string-length($software_list)-1)"/></xsl:attribute>

    <xsl:for-each select="VRPTx:pdbx_validation_softwareCategory/VRPTx:pdbx_validation_software">

      <xsl:if test="VRPTx:version='unknown (associated with DCC package)' and VRPTx:classification='refinement'">
	<xsl:attribute name="DCC_refinement_program"><xsl:value-of select="VRPTx:name"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="VRPTx:name='CCP4' and VRPTx:classification='data scaling and phasing'">
	<xsl:attribute name="CCP4version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="VRPTx:name='Refmac' and VRPTx:classification='refinement'">
	<xsl:attribute name="RefmacVersion"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
      </xsl:if>

      <xsl:if test="$nmr=true()">

	<xsl:if test="VRPTx:name='cyrange' and VRPTx:classification='domain identification of nmr ensemble structure'">
	  <xsl:attribute name="cyrange_version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:name='nmrclust' and VRPTx:classification='classification of nmr ensemble structure'">
	  <xsl:attribute name="nmrclust_version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:name='panav' and VRPTx:classification='nmr chemical shift validation and reference correction'">
	  <xsl:attribute name="panav_version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:name='rci' and VRPTx:classification='random coil index prediction from nmr chemical shifts'">
	  <xsl:attribute name="rci_version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:name='shiftchecker' and VRPTx:classification='nmr chemical shift validation'">
	  <xsl:attribute name="shiftchecker_version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
	</xsl:if>

      </xsl:if>

    </xsl:for-each>

    <!-- nmr -->

    <xsl:if test="$nmr=true()">

      <xsl:for-each select="VRPTx:pdbx_database_relatedCategory/VRPTx:pdbx_database_related[@db_name='BMRB']">
	<xsl:attribute name="bmrb_id"><xsl:value-of select="@db_id"/></xsl:attribute>
      </xsl:for-each>

      <xsl:apply-templates select="VRPTx:pdbx_nmr_assigned_chem_shift_listCategory/*"/>

    </xsl:if>

    <!-- EM validation : Entry -->

    <xsl:if test="$em=true()">

      <!--xsl:for-each select="VRPTx:pdbx_database_relatedCategory/VRPTx:pdbx_database_related[@db_name='EMDB']">
	<xsl:attribute name="emdb_id"><xsl:value-of select="@db_id"/></xsl:attribute>
      </xsl:for-each-->

      <xsl:for-each select="VRPTx:em_adminCategory/VRPTx:em_admin">
	<xsl:attribute name="emdb_id"><xsl:value-of select="@entry_id"/></xsl:attribute>
	<xsl:choose>
	  <xsl:when test="VRPTx:deposition_date">
	    <xsl:attribute name="EMDB-deposition-date"><xsl:value-of select="VRPTx:deposition_date"/></xsl:attribute>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:attribute name="EMDB-deposition-date">unknown</xsl:attribute>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:for-each>

      <xsl:for-each select="VRPTx:pdbx_em_validate_map_model_overallCategory/VRPTx:pdbx_em_validate_map_model_overall[VRPTx:recommended_contour_level!='']">
	<xsl:attribute name="contour_level_primary_map"><xsl:value-of select="VRPTx:recommended_contour_level"/></xsl:attribute>
	<xsl:if test="VRPTx:atom_inclusion_all">
	  <xsl:attribute name="atom_inclusion_all"><xsl:value-of select="VRPTx:atom_inclusion_all"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:atom_inclusion_main">
	  <xsl:attribute name="atom_inclusion_backbone"><xsl:value-of select="VRPTx:atom_inclusion_main"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:Q_score">
	  <xsl:attribute name="Q_score"><xsl:value-of select="VRPTx:Q_score"/></xsl:attribute>
	</xsl:if>
      </xsl:for-each>

      <xsl:for-each select="VRPTx:pdbx_em_fsc_resolutionCaetgory/VRPTx:pdbx_em_fsc_resolution">
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
	<xsl:attribute name="{$resolution_title}"><xsl:value-of select="VRPTx:resolution"/></xsl:attribute>
      </xsl:for-each>

    </xsl:if>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_validation_software">
    <xsl:if test="VRPTx:details!=''">
      <xsl:element name="program">
	<xsl:attribute name="name"><xsl:value-of select="VRPTx:name"/></xsl:attribute>
	<xsl:attribute name="properties"><xsl:value-of select="VRPTx:details"/></xsl:attribute>
	<xsl:attribute name="version"><xsl:value-of select="VRPTx:version"/></xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_audit_revision_historyCategory">

    <xsl:for-each select="VRPTx:pdbx_audit_revision_history">

    <xsl:if test="position()=last()">
      <xsl:choose>
	<xsl:when test="VRPTx:major_revision">
	  <xsl:attribute name="PDB-revision-number"><xsl:value-of select="VRPTx:major_revision"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="PDB-revision-number">-1</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
	<xsl:when test="VRPTx:revision_date">
	  <xsl:attribute name="PDB-revision-date"><xsl:value-of select="VRPTx:revision_date"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="PDB-revision-date">unknown</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <xsl:template match="VRPTx:em_3d_reconstruction">

    <xsl:if test="VRPTx:resolution">
      <xsl:attribute name="PDB-resolution"><xsl:value-of select="VRPTx:resolution"/></xsl:attribute>
      <xsl:attribute name="EMDB-resolution"><xsl:value-of select="VRPTx:resolution"/></xsl:attribute>
    </xsl:if>

    <xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>

  </xsl:template>

  <xsl:template name="pdbx_dcc_density_summary">

    <xsl:choose>
       <xsl:when test="VRPTx:ls_d_res_high">
	 <xsl:attribute name="PDB-resolution"><xsl:value-of select="VRPTx:ls_d_res_high"/></xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
	 <xsl:attribute name="PDB-resolution">NotAvailable</xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>
     <xsl:choose>
       <xsl:when test="VRPTx:ls_d_res_low">
	 <xsl:attribute name="PDB-resolution-low"><xsl:value-of select="VRPTx:ls_d_res_low"/></xsl:attribute>
       </xsl:when>
       <xsl:otherwise>
	 <xsl:attribute name="PDB-resolution-low">NotAvailable</xsl:attribute>
       </xsl:otherwise>
     </xsl:choose>

  </xsl:template>

  <xsl:template match="VRPTx:refine">

    <xsl:choose>
      <xsl:when test="VRPTx:ls_R_factor_R_work">
	<xsl:attribute name="PDB-R"><xsl:value-of select="format-number(VRPTx:ls_R_factor_R_work,'0.00')"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="PDB-R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:ls_R_factor_R_free">
	<xsl:attribute name="PDB-Rfree"><xsl:value-of select="format-number(VRPTx:ls_R_factor_R_free,'0.00')"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="PDB-Rfree">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_status">

    <xsl:if test="VRPTx:validation_created_date">
      <xsl:attribute name="XMLcreationDate"><xsl:value-of select="VRPTx:validation_created_date"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="VRPTx:recvd_initial_deposition_date">
	<xsl:attribute name="PDB-deposition-date"><xsl:value-of select="VRPTx:recvd_initial_deposition_date"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="PDB-deposition-date">unknown</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_dcc_geometry">

    <xsl:if test="VRPTx:angle_overall_rmsz">
      <xsl:attribute name="angles_rmsz"><xsl:value-of select="VRPTx:angle_overall_rmsz"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:bond_overall_rmsz">
      <xsl:attribute name="bonds_rmsz"><xsl:value-of select="VRPTx:bond_overall_rmsz"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:number_angles">
      <xsl:attribute name="num_angles_rmsz"><xsl:value-of select="VRPTx:number_angles"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:number_bonds">
      <xsl:attribute name="num_bonds_rmsz"><xsl:value-of select="VRPTx:number_bonds"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
	<xsl:if test="VRPTx:all_atom_clashscore_nmr_well_formed">
	  <xsl:attribute name="clashscore"><xsl:value-of select="VRPTx:all_atom_clashscore_nmr_well_formed"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:all_atom_clashscore">
	  <xsl:attribute name="clashscore-full-length"><xsl:value-of select="VRPTx:all_atom_clashscore"/></xsl:attribute>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:if test="VRPTx:all_atom_clashscore">
	  <xsl:attribute name="clashscore"><xsl:value-of select="VRPTx:all_atom_clashscore"/></xsl:attribute>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="VRPTx:RNA_suiteness_score">
      <xsl:attribute name="RNAsuiteness"><xsl:value-of select="VRPTx:RNA_suiteness_score"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
	<xsl:if test="VRPTx:Ramachandran_outlier_percent">
	  <xsl:attribute name="percent-rama-outliers"><xsl:value-of select="VRPTx:Ramachandran_outlier_percent_nmr_well_formed"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:Ramachandran_outlier_percent">
	  <xsl:attribute name="percent-rama-outliers-full-length"><xsl:value-of select="VRPTx:Ramachandran_outlier_percent"/></xsl:attribute>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:if test="VRPTx:Ramachandran_outlier_percent">
	  <xsl:attribute name="percent-rama-outliers"><xsl:value-of select="VRPTx:Ramachandran_outlier_percent"/></xsl:attribute>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="$nmr=true()">
	<xsl:if test="VRPTx:rotamer_outliers_percent">
	  <xsl:attribute name="percent-rota-outliers"><xsl:value-of select="VRPTx:rotamer_outliers_percent_nmr_well_formed"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:rotamer_outliers_percent">
	  <xsl:attribute name="percent-rota-outliers-full-length"><xsl:value-of select="VRPTx:rotamer_outliers_percent"/></xsl:attribute>
	</xsl:if>
      </xsl:when>
      <xsl:otherwise>
	<xsl:if test="VRPTx:rotamer_outliers_percent">
	  <xsl:attribute name="percent-rota-outliers"><xsl:value-of select="VRPTx:rotamer_outliers_percent"/></xsl:attribute>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_dcc_density">

    <xsl:if test="VRPTx:reflns_outlier_acentric">
      <xsl:attribute name="acentric_outliers"><xsl:value-of select="VRPTx:reflns_outlier_acentric"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:reflns_outlier_centric">
      <xsl:attribute name="centric_outliers"><xsl:value-of select="VRPTx:reflns_outlier_centric"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:I_over_sigI_resh">
      <xsl:attribute name="IoverSigma"><xsl:value-of select="concat(VRPTx:I_over_sigI_resh,'(',substring-before($percentile_d_res_high,' '),'A)')"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:reflns_number_obs">
      <xsl:attribute name="numMillerIndices"><xsl:value-of select="VRPTx:reflns_number_obs"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:B_wilson">
      <xsl:attribute name="WilsonBestimate"><xsl:value-of select="VRPTx:B_wilson"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:aniso_B11">
      <xsl:attribute name="WilsonBaniso"><xsl:value-of select="concat('[',VRPTx:aniso_B11,',',VRPTx:aniso_B22,',',VRPTx:aniso_B33,',',VRPTx:aniso_B12,',',VRPTx:aniso_B13,',',VRPTx:aniso_B23,']')"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:anisotropy">
      <xsl:attribute name="DataAnisotropy"><xsl:value-of select="VRPTx:anisotropy"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:error">
      <xsl:attribute name="TransNCS"><xsl:value-of select="VRPTx:error"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:warning">
      <xsl:attribute name="eds_rfactor_warning"><xsl:value-of select="VRPTx:warning"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:Padilla-Yeates_L_mean">
      <xsl:attribute name="TwinL"><xsl:value-of select="VRPTx:Padilla-Yeates_L_mean"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:Padilla-Yeates_L2_mean">
      <xsl:attribute name="TwinL2"><xsl:value-of select="VRPTx:Padilla-Yeates_L2_mean"/></xsl:attribute>
    </xsl:if>

    <xsl:if test="VRPTx:twin_operator_xtriage and VRPTx:twin_fraction_xtriage">

      <xsl:variable name="operators" select="tokenize(VRPTx:twin_operator_xtriage,'\s+')"/>
      <xsl:variable name="fractions" select="tokenize(VRPTx:twin_fraction_xtriage,'\s+')"/>

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

    <xsl:if test="VRPTx:iso_B_value_type">
      <xsl:attribute name="B_factor_type"><xsl:value-of select="upper-case(VRPTx:iso_B_value_type)"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:ls_percent_reflns_obs">
      <xsl:attribute name="DataCompleteness"><xsl:value-of select="VRPTx:ls_percent_reflns_obs"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:ls_number_reflns_R_free">
      <xsl:attribute name="num-free-reflections"><xsl:value-of select="VRPTx:ls_number_reflns_R_free"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:ls_percent_reflns_R_free">
      <xsl:attribute name="percent-free-reflections"><xsl:value-of select="VRPTx:ls_percent_reflns_R_free"/></xsl:attribute>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="VRPTx:R_value_R_work">
	<xsl:attribute name="DCC_R"><xsl:value-of select="VRPTx:R_value_R_work"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="DCC_R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:R_value_R_free">
	<xsl:attribute name="DCC_Rfree"><xsl:value-of select="VRPTx:R_value_R_free"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="DCC_Rfree">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="VRPTx:B_babinet">
      <xsl:attribute name="babinet_b"><xsl:value-of select="VRPTx:B_babinet"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:K_babinet">
      <xsl:attribute name="babinet_k"><xsl:value-of select="VRPTx:K_babinet"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:B_solvent">
      <xsl:attribute name="bulk_solvent_b"><xsl:value-of select="VRPTx:B_solvent"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:K_solvent">
      <xsl:attribute name="bulk_solvent_k"><xsl:value-of select="VRPTx:K_solvent"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_dcc_density_corr">

    <xsl:choose>
      <xsl:when test="VRPTx:ls_R_factor_R_work">
	<xsl:attribute name="EDS_R"><xsl:value-of select="VRPTx:ls_R_factor_R_work"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="EDS_R">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:ls_d_res_high">
	<xsl:attribute name="EDS_resolution"><xsl:value-of select="VRPTx:ls_d_res_high"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="EDS_resolution">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:ls_d_res_low">
	<xsl:attribute name="EDS_resolution_low"><xsl:value-of select="VRPTx:ls_d_res_low"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="EDS_resolution_low">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="VRPTx:correlation_coeff_Fo_to_Fc">
	<xsl:attribute name="Fo_Fc_correlation"><xsl:value-of select="VRPTx:correlation_coeff_Fo_to_Fc"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
	<xsl:attribute name="Fo_Fc_correlation">NotAvailable</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_dcc_map_overall">

    <xsl:if test="VRPTx:RSRZ_outliers_percent">
      <xsl:attribute name="percent-RSRZ-outliers"><xsl:value-of select="VRPTx:RSRZ_outliers_percent"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_struct_nmr_ens_clust">

    <xsl:if test="VRPTx:outliers_total_number">
      <xsl:attribute name="nmrclust_number_of_outliers"><xsl:value-of select="VRPTx:outliers_total_number"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:conformers_total_number">
      <xsl:attribute name="nmrclust_number_of_models"><xsl:value-of select="VRPTx:conformers_total_number"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="VRPTx:clusters_total_number">
      <xsl:attribute name="nmrclust_number_of_clusters"><xsl:value-of select="VRPTx:clusters_total_number"/></xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template match="VRPTx:pdbx_percentile_view">

    <xsl:call-template name="percentile_handler">
      <xsl:with-param name="conditions_id" select="@conditions_id"/>
      <xsl:with-param name="type" select="@type"/>
      <xsl:with-param name="rank" select="VRPTx:rank"/>
    </xsl:call-template>

  </xsl:template>

  <!-- percentile view -->

  <xsl:template name="percentile_handler">
    <xsl:param name="conditions_id"/>
    <xsl:param name="type"/>
    <xsl:param name="rank"/>

    <xsl:variable name="condition_res_high"><xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[@id=$conditions_id]/VRPTx:ls_d_res_high"/></xsl:variable>
    <xsl:variable name="condition_res_low"><xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[@id=$conditions_id]/VRPTx:ls_d_res_low"/></xsl:variable>

    <xsl:variable name="absolute">
      <xsl:choose>
	<xsl:when test="$condition_res_high!=''">no</xsl:when>
	<xsl:otherwise>yes</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="number_of_entries"><xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[@id=$conditions_id]/VRPTx:number_entries_total"/></xsl:variable>

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

  <xsl:template match="VRPTx:pdbx_nmr_assigned_chem_shift_list">

    <chemical_shift_list>

      <xsl:variable name="list_id"><xsl:value-of select="@id"/></xsl:variable>

      <xsl:attribute name="file_id"><xsl:value-of select="$list_id"/></xsl:attribute>
      <xsl:attribute name="file_name"><xsl:value-of select="VRPTx:data_file_name"/></xsl:attribute>
      <xsl:attribute name="block_name"><xsl:value-of select="VRPTx:label"/></xsl:attribute>
      <xsl:attribute name="list_id"><xsl:value-of select="$list_id"/></xsl:attribute>
      <xsl:choose>
	<xsl:when test="VRPTx:nmr_star_consistency_flag='Y'">
	  <xsl:attribute name="type">full</xsl:attribute>
	</xsl:when>
	<xsl:when test="VRPTx:nmr_star_consistency_flag='N'">
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
      <xsl:attribute name="number_of_errors_while_mapping"><xsl:value-of select="VRPTx:number_map_errors"/></xsl:attribute>
      <xsl:attribute name="number_of_warnings_while_mapping"><xsl:value-of select="VRPTx:number_map_warnings"/></xsl:attribute>
      <xsl:attribute name="number_of_mapped_shifts"><xsl:value-of select="VRPTx:number_mapped_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="number_of_parsed_shifts"><xsl:value-of select="VRPTx:number_parsed_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="total_number_of_shifts"><xsl:value-of select="VRPTx:number_chem_shifts"/></xsl:attribute>
      <xsl:attribute name="number_of_unparsed_shifts"><xsl:value-of select="VRPTx:number_unparsed_chem_shifts"/></xsl:attribute>

      <xsl:if test="$datablock/VRPTx:pdbx_nmr_unmapped_chem_shiftCategory/VRPTx:pdbx_nmr_unmapped_chem_shift">
	<xsl:call-template name="pdbx_nmr_unmapped_chem_shift">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_nmr_unparsed_chem_shiftCategory/VRPTx:pdbx_nmr_unparsed_chem_shift">
	<xsl:call-template name="pdbx_nmr_unparsed_chem_shift">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_missing_nmr_star_itemCategory/VRPTx:pdbx_missing_nmr_star_item">
	<xsl:call-template name="pdbx_missing_nmr_star_item">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_nmr_chem_shift_annotationCategory/VRPTx:pdbx_nmr_chem_shift_annotation">
	<xsl:call-template name="pdbx_nmr_chem_shift_annotation">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_validate_nmr_chem_shiftCategory/VRPTx:pdbx_validate_nmr_chem_shift">
	<xsl:call-template name="pdbx_validate_nmr_chem_shift">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_nmr_chem_shift_re_offsetCategory/VRPTx:pdbx_nmr_chem_shift_re_offset">
	<xsl:call-template name="pdbx_nmr_chem_shift_re_offset">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

      <xsl:if test="$datablock/VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness">
	<xsl:call-template name="pdbx_nmr_chem_shift_completeness_well_defined">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
	<xsl:call-template name="pdbx_nmr_chem_shift_completeness_full_length">
	  <xsl:with-param name="list_id" select="$list_id"/>
	</xsl:call-template>
      </xsl:if>

    </chemical_shift_list>

  </xsl:template>

  <xsl:template name="pdbx_nmr_unmapped_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_unmapped_chem_shiftCategory/VRPTx:pdbx_nmr_unmapped_chem_shift[@list_id=$list_id]">

      <unmapped_chemical_shift>

	<xsl:attribute name="chain"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	<xsl:attribute name="rescode"><xsl:value-of select="VRPTx:auth_comp_id"/></xsl:attribute>
	<xsl:attribute name="resnum"><xsl:value-of select="VRPTx:auth_seq_id"/></xsl:attribute>
	<xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="VRPTx:val"/></xsl:attribute>
	<xsl:if test="VRPTx:val_err">
	  <xsl:attribute name="error"><xsl:value-of select="VRPTx:val_err"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:ambiguity_code=('1','2','3','4','5','6','9')">
	  <xsl:attribute name="ambiguity"><xsl:value-of select="VRPTx:ambiguity_code"/></xsl:attribute>
	</xsl:if>
	<xsl:attribute name="diagnostic"><xsl:value-of select="VRPTx:details"/></xsl:attribute>

      </unmapped_chemical_shift>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_unparsed_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_unparsed_chem_shiftCategory/VRPTx:pdbx_nmr_unparsed_chem_shift[@list_id=$list_id]">

      <unparsed_chemical_shift>

	<xsl:if test="VRPTx:chem_shift_id">
	  <xsl:attribute name="id"><xsl:value-of select="VRPTx:chem_shift_id"/></xsl:attribute>
	</xsl:if>
	<xsl:attribute name="chain"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	<xsl:attribute name="rescode"><xsl:value-of select="VRPTx:auth_comp_id"/></xsl:attribute>
	<xsl:attribute name="resnum"><xsl:value-of select="VRPTx:auth_seq_id"/></xsl:attribute>
	<xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="VRPTx:val"/></xsl:attribute>
	<xsl:if test="VRPTx:val_err">
	  <xsl:attribute name="error"><xsl:value-of select="VRPTx:val_err"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:ambiguity_code=('1','2','3','4','5','6','9')">
	  <xsl:attribute name="ambiguity"><xsl:value-of select="VRPTx:ambiguity_code"/></xsl:attribute>
	</xsl:if>
	<xsl:attribute name="diagnostic"><xsl:value-of select="VRPTx:details"/></xsl:attribute>

      </unparsed_chemical_shift>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_missing_nmr_star_item">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_missing_nmr_star_itemCategory/VRPTx:pdbx_missing_nmr_star_item[@list_id=$list_id]">

      <missing_nmrstar_tag>

	<xsl:attribute name="nmrstar_tag"><xsl:value-of select="VRPTx:name"/></xsl:attribute>
	<xsl:attribute name="nmrstar_tag_description"><xsl:value-of select="VRPTx:description"/></xsl:attribute>

      </missing_nmrstar_tag>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_annotation">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_chem_shift_annotationCategory/VRPTx:pdbx_nmr_chem_shift_annotation[@list_id=$list_id]">

      <random_coil_index>

	<xsl:attribute name="chain"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	<xsl:attribute name="rescode"><xsl:value-of select="VRPTx:auth_comp_id"/></xsl:attribute>
	<xsl:attribute name="resnum"><xsl:value-of select="VRPTx:auth_seq_id"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="VRPTx:random_coil_index"/></xsl:attribute>

      </random_coil_index>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_validate_nmr_chem_shift">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_validate_nmr_chem_shiftCategory/VRPTx:pdbx_validate_nmr_chem_shift[@list_id=$list_id]">

      <chemical_shift_outlier>

	<xsl:attribute name="chain"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	<xsl:attribute name="rescode"><xsl:value-of select="VRPTx:auth_comp_id"/></xsl:attribute>
	<xsl:attribute name="resnum"><xsl:value-of select="VRPTx:auth_seq_id"/></xsl:attribute>
	<xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="VRPTx:val"/></xsl:attribute>
	<xsl:attribute name="prediction"><xsl:value-of select="VRPTx:target_val"/></xsl:attribute>
	<xsl:attribute name="zscore"><xsl:value-of select="VRPTx:Zscore"/></xsl:attribute>
	<xsl:attribute name="method"><xsl:value-of select="VRPTx:method"/></xsl:attribute>

      </chemical_shift_outlier>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_re_offset">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_chem_shift_re_offsetCategory/VRPTx:pdbx_nmr_chem_shift_re_offset[@list_id=$list_id]">

      <referencing_offset>

	<xsl:attribute name="atom"><xsl:value-of select="@atom_type"/></xsl:attribute>
	<xsl:attribute name="value"><xsl:value-of select="VRPTx:correction_val"/></xsl:attribute>
	<xsl:attribute name="uncertainty"><xsl:value-of select="VRPTx:correction_val_err"/></xsl:attribute>
	<xsl:attribute name="precision"><xsl:value-of select="VRPTx:correction_val_esd"/></xsl:attribute>
	<xsl:attribute name="number_of_measurements"><xsl:value-of select="VRPTx:number_chem_shifts"/></xsl:attribute>

      </referencing_offset>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_well_defined">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness[@list_id=$list_id]">

      <xsl:if test="VRPTx:number_assigned_chem_shifts_well_formed">

	<assignment_completeness_well_defined>

	  <xsl:attribute name="type"><xsl:value-of select="@atom_group"/></xsl:attribute>
	  <xsl:attribute name="element"><xsl:value-of select="@atom_type"/></xsl:attribute>
	  <xsl:attribute name="number_of_assigned_shifts"><xsl:value-of select="VRPTx:number_assigned_chem_shifts_well_formed"/></xsl:attribute>
	  <xsl:attribute name="number_of_shifts"><xsl:value-of select="VRPTx:number_target_shifts_well_formed"/></xsl:attribute>
	  <xsl:attribute name="number_of_unassigned_shifts"><xsl:value-of select="VRPTx:number_unassigned_chem_shifts_well_formed"/></xsl:attribute>

	</assignment_completeness_well_defined>

      </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <xsl:template name="pdbx_nmr_chem_shift_completeness_full_length">
    <xsl:param name="list_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness[@list_id=$list_id]">

      <xsl:if test="VRPTx:number_assigned_chem_shifts_well_formed">

	<assignment_completeness_full_length>

	  <xsl:attribute name="type"><xsl:value-of select="@atom_group"/></xsl:attribute>
	  <xsl:attribute name="element"><xsl:value-of select="@atom_type"/></xsl:attribute>
	  <xsl:attribute name="number_of_assigned_shifts"><xsl:value-of select="VRPTx:number_assigned_chem_shifts"/></xsl:attribute>
	  <xsl:attribute name="number_of_shifts"><xsl:value-of select="VRPTx:number_target_shifts"/></xsl:attribute>
	  <xsl:attribute name="number_of_unassigned_shifts"><xsl:value-of select="VRPTx:number_unassigned_chem_shifts"/></xsl:attribute>

	</assignment_completeness_full_length>

      </xsl:if>

    </xsl:for-each>

  </xsl:template>

  <!-- Model -->

  <xsl:template match="VRPTx:pdbx_struct_nmr_ens_clust_gen">

    <Model>

      <xsl:attribute name="model"><xsl:value-of select="@PDB_model_num"/></xsl:attribute>
      <xsl:attribute name="nmrclust_cluster_id"><xsl:value-of select="VRPTx:cluster_id"/></xsl:attribute>
      <xsl:if test="VRPTx:medoid_conformer='Y'">
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
	    <xsl:with-param name="model" select="."/>
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
      <xsl:for-each select="$datablock/VRPTx:entity_polyCategory/VRPTx:entity_poly">
	<xsl:value-of select="concat(VRPTx:pdbx_strand_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:for-each select="tokenize(substring($strand_ids,1,string-length($strand_ids)-1),',')">
      <xsl:call-template name="modelled_subgroup_strand_id">
	<xsl:with-param name="model" select="$model"/>
	<xsl:with-param name="strand_id" select="."/>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="modelled_subgroup_strand_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>

    <xsl:for-each select="$datablock/VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme[VRPTx:pdb_strand_id=$strand_id]">
      <xsl:call-template name="modelled_subgroup_mon_id">
	<xsl:with-param name="model" select="$model"/>
	<xsl:with-param name="strand_id" select="$strand_id"/>
	<xsl:with-param name="asym_id" select="@asym_id"/>
	<xsl:with-param name="entity_id" select="@entity_id"/>
	<xsl:with-param name="mon_id" select="@mon_id"/>
	<xsl:with-param name="seq_id" select="@seq_id"/>
	<xsl:with-param name="pdb_seq_num" select="VRPTx:pdb_seq_num"/>
	<xsl:with-param name="pdb_ins_code" select="VRPTx:pdb_ins_code"/>
      </xsl:call-template>
    </xsl:for-each>

    <xsl:for-each select="$datablock/VRPTx:pdbx_nonpoly_schemeCategory/VRPTx:pdbx_nonpoly_scheme[VRPTx:pdb_strand_id=$strand_id]">
      <xsl:call-template name="modelled_subgroup_mon_id">
	<xsl:with-param name="model" select="$model"/>
	<xsl:with-param name="strand_id" select="$strand_id"/>
	<xsl:with-param name="asym_id" select="@asym_id"/>
	<xsl:with-param name="entity_id" select="VRPTx:entity_id"/>
	<xsl:with-param name="mon_id" select="VRPTx:mon_id"/>
	<xsl:with-param name="seq_id"/>
	<xsl:with-param name="pdb_seq_num" select="VRPTx:pdb_seq_num"/>
	<xsl:with-param name="pdb_ins_code" select="VRPTx:pdb_ins_code"/>
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
      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_mapCategory/VRPTx:pdbx_dcc_map[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num]">
	<xsl:value-of select="concat(VRPTx:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_mon_geometryCategory/VRPTx:pdbx_dcc_mon_geometry[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num]">
	<xsl:value-of select="concat(VRPTx:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/VRPTx:struct_mon_protCategory/VRPTx:struct_mon_prot[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num]">
	<xsl:value-of select="concat(VRPTx:label_alt_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/VRPTx:struct_mon_nuclCategory/VRPTx:struct_mon_nucl[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num]">
	<xsl:value-of select="concat(VRPTx:label_alt_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="string-length($alt_ids)&gt;0">

      <xsl:variable name="alt_id_list">
	<xsl:value-of select="substring($alt_ids,1,string-length($alt_ids)-1)"/>
      </xsl:variable>

      <xsl:choose>
	<xsl:when test="$alt_id_list=''">
	  <xsl:call-template name="modelled_subgroup_alt_id">
	    <xsl:with-param name="model" select="$model"/>
	    <xsl:with-param name="strand_id" select="$strand_id"/>
	    <xsl:with-param name="asym_id" select="$asym_id"/>
	    <xsl:with-param name="entity_id" select="$entity_id"/>
	    <xsl:with-param name="mon_id" select="$mon_id"/>
	    <xsl:with-param name="seq_id" select="$seq_id"/>
	    <xsl:with-param name="pdb_seq_num" select="$pdb_seq_num"/>
	    <xsl:with-param name="pdb_ins_code" select="$pdb_ins_code"/>
	    <xsl:with-param name="alt_id"/>
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:for-each select="distinct-values(tokenize($alt_id_list,','))">
	    <xsl:call-template name="modelled_subgroup_alt_id">
	      <xsl:with-param name="model" select="$model"/>
	      <xsl:with-param name="strand_id" select="$strand_id"/>
	      <xsl:with-param name="asym_id" select="$asym_id"/>
	      <xsl:with-param name="entity_id" select="$entity_id"/>
	      <xsl:with-param name="mon_id" select="$mon_id"/>
	      <xsl:with-param name="seq_id" select="$seq_id"/>
	      <xsl:with-param name="pdb_seq_num" select="$pdb_seq_num"/>
	      <xsl:with-param name="pdb_ins_code" select="$pdb_ins_code"/>
	      <xsl:with-param name="alt_id" select="."/>
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
	  <xsl:attribute name="icode"> </xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
	<xsl:when test="$alt_id!=''">
	  <xsl:attribute name="altcode"><xsl:value-of select="$alt_id"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="altcode"> </xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>

      <!-- pdbx_dcc_map -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_mapCategory/VRPTx:pdbx_dcc_map[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<xsl:attribute name="owab"><xsl:value-of select="VRPTx:Biso_mean"/></xsl:attribute>

	<xsl:if test="VRPTx:LLDFZ">
	  <xsl:attribute name="ligRSRZ"><xsl:value-of select="VRPTx:LLDFZ"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDFZ_outlier_flag='Y'">
	  <xsl:attribute name="ligand_density_outlier">yes</xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDF_name">
	  <xsl:attribute name="lig_rsrz_nbr_id"><xsl:value-of select="VRPTx:LLDF_name"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDF_number_residues_total">
	  <xsl:attribute name="ligRSRnumnbrs"><xsl:value-of select="VRPTx:LLDF_number_residues_total"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDF">
	  <xsl:attribute name="ligRSRnbrMean"><xsl:value-of select="VRPTx:LLDF"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDF_sigma">
	  <xsl:attribute name="ligRSRnbrStdev"><xsl:value-of select="VRPTx:LLDF_sigma"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:RSCC">
	  <xsl:attribute name="rscc"><xsl:value-of select="VRPTx:RSCC"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:RSR">
	  <xsl:attribute name="rsr"><xsl:value-of select="VRPTx:RSR"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:RSRZ">
	  <xsl:attribute name="rsrz"><xsl:value-of select="VRPTx:RSRZ"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:occupancy_mean">
	  <xsl:attribute name="avgoccu"><xsl:value-of select="VRPTx:occupancy_mean"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:EDIAm">
	  <xsl:attribute name="EDIAm"><xsl:value-of select="VRPTx:EDIA_mean"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:OPIA">
	  <xsl:attribute name="OPIA"><xsl:value-of select="VRPTx:OPIA"/></xsl:attribute>
	</xsl:if>

      </xsl:for-each>

      <!-- pdbx_dcc_mon_geometry -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_mon_geometryCategory/VRPTx:pdbx_dcc_mon_geometry[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<xsl:if test="VRPTx:angle_overall_rmsz">
	  <xsl:attribute name="mogul_angles_rmsz"><xsl:value-of select="VRPTx:angle_overall_rmsz"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:bond_overall_rmsz">
	  <xsl:attribute name="mogul_bonds_rmsz"><xsl:value-of select="VRPTx:bond_overall_rmsz"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:number_angles">
	  <xsl:attribute name="mogul_rmsz_numangles"><xsl:value-of select="VRPTx:number_angles"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:number_bonds">
	  <xsl:attribute name="mogul_rmsz_numbonds"><xsl:value-of select="VRPTx:number_bonds"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:LLDFZ_outlier_flag='Y'">
	  <xsl:attribute name="ligand_geometry_outlier">yes</xsl:attribute>
	</xsl:if>

      </xsl:for-each>

      <!-- struct_mon_prot -->

      <xsl:for-each select="$datablock/VRPTx:struct_mon_protCategory/VRPTx:struct_mon_prot[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<xsl:if test="VRPTx:phi">
	  <xsl:attribute name="phi"><xsl:value-of select="VRPTx:phi"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:psi">
	  <xsl:attribute name="psi"><xsl:value-of select="VRPTx:psi"/></xsl:attribute>
	</xsl:if>
<!--
	<xsl:if test="count(plane-outlier/@omega)=1">
	  <xsl:element name="VRPTx:omega"><xsl:value-of select="plane-outlier/@omega"/></xsl:element>
	</xsl:if>
-->
	<xsl:if test="VRPTx:pdbx_Ramachandran_region">
	  <xsl:attribute name="rama"><xsl:value-of select="VRPTx:pdbx_Ramachandran_region"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:pdbx_flippable_side_chain='Y'">
	  <xsl:attribute name="flippable-sidechain">1</xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:pdbx_rotamer">
	  <xsl:attribute name="rota"><xsl:value-of select="VRPTx:pdbx_rotamer"/></xsl:attribute>
	</xsl:if>

      </xsl:for-each>

      <!-- struct_mon_nucl -->

      <xsl:for-each select="$datablock/VRPTx:struct_mon_nuclCategory/VRPTx:struct_mon_nucl[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<xsl:if test="VRPTx:pdbx_RNA_pucker_outlier_flag='Y'">
	  <xsl:attribute name="RNApucker">outlier</xsl:attribute>
	</xsl:if>

	<xsl:choose>
	  <xsl:when test="VRPTx:pdbx_RNA_suite">
	    <xsl:attribute name="RNAsuite"><xsl:value-of select="VRPTx:pdbx_RNA_suite"/></xsl:attribute>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:attribute name="RNAsuite">NotAvailable</xsl:attribute>
	  </xsl:otherwise>
	</xsl:choose>

	<xsl:if test="VRPTx:pdbx_RNA_suiteness_score">
	  <xsl:attribute name="RNAscore"><xsl:value-of select="VRPTx:pdbx_RNA_suiteness_score"/></xsl:attribute>
	</xsl:if>

      </xsl:for-each>

      <!-- cis_peptide -->

      <xsl:for-each select="$datablock/VRPTx:struct_mon_prot_cisCategory/VRPTx:struct_mon_prot_cis[VRPTx:pdbx_PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">
	<xsl:attribute name="cis_peptide">yes</xsl:attribute>
      </xsl:for-each>

      <!-- ligand -->

      <xsl:if test="$datablock/VRPTx:pdbx_dcc_mon_geometryCategory/VRPTx:pdbx_dcc_mon_geometry[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<xsl:variable name="ligand_num_clashes"><xsl:value-of select="count($datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id) and VRPTx:clash_magnitude]) + count($datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id) and VRPTx:clash_magnitude])"/></xsl:variable>

	<xsl:variable name="ligand_num_symm_clashes"><xsl:value-of select="count($datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id) and VRPTx:clash_magnitude]) + count($datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id) and VRPTx:clash_magnitude])"/></xsl:variable>

	<xsl:if test="$ligand_num_clashes&gt;0 or $ligand_num_symm_clashes&gt;0">
	  <xsl:attribute name="ligand_clashes_outlier">yes</xsl:attribute>
	  <xsl:attribute name="ligand_num_clashes"><xsl:value-of select="$ligand_num_clashes"/></xsl:attribute>
	  <xsl:attribute name="ligand_num_symm_clashes"><xsl:value-of select="$ligand_num_symm_clashes"/></xsl:attribute>
	</xsl:if>

	<xsl:if test="$datablock/VRPTx:pdbx_validate_chiralCategory/VRPTx:pdbx_validate_chiral[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">
	  <xsl:attribute name="ligand_chirality_outlier">yes</xsl:attribute>
	</xsl:if>

      </xsl:if>

      <xsl:if test="$nmr=true()">

	<xsl:choose>
	  <xsl:when test="$datablock/VRPTx:pdbx_struct_nmr_ens_dom_limCategory/VRPTx:pdbx_struct_nmr_ens_dom_lim[VRPTx:beg_auth_asym_id=$strand_id and VRPTx:end_auth_asym_id=$strand_id]">

	    <xsl:variable name="cyrange_domain_id">
	      <xsl:for-each select="$datablock/VRPTx:pdbx_struct_nmr_ens_dom_limCategory/VRPTx:pdbx_struct_nmr_ens_dom_lim[VRPTx:beg_auth_asym_id=$strand_id and VRPTx:end_auth_asym_id=$strand_id and number(VRPTx:beg_auth_seq_id)&lt;=number($pdb_seq_num) and number(VRPTx:end_auth_seq_id)&gt;=number($pdb_seq_num)]">
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

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_validate_map_modelCategory/VRPTx:pdbx_em_validate_map_model[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">
	  <xsl:attribute name="residue_inclusion"><xsl:value-of select="VRPTx:atom_inclusion_all"/></xsl:attribute>
	  <xsl:if test="VRPTx:Q_score">
	    <xsl:attribute name="Q_score"><xsl:value-of select="VRPTx:Q_score"/></xsl:attribute>
	  </xsl:if>
	</xsl:for-each>

      </xsl:if>
<!--
	    <xsd:attribute ref="NatomsEDS" use="optional"/>
	    <xsd:attribute ref="num-H-reduce" use="optional"/>
	    <xsd:attribute ref="mogul-ignore" use="optional"/>
-->
      <!-- bond-outlier, mog-bond-outlier -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_bondCategory/VRPTx:pdbx_validate_rmsd_bond[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id) and VRPTx:Zscore]">

	<xsl:choose>
	  <xsl:when test="VRPTx:number_bonds_in_kb">

	    <mog-bond-outlier>

	      <xsl:attribute name="atoms"><xsl:value-of select="concat(VRPTx:auth_atom_id_1,',',VRPTx:auth_atom_id_2)"/></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="VRPTx:Zscore">
		  <xsl:attribute name="Zscore"><xsl:value-of select="VRPTx:Zscore"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="Zscore"><xsl:value-of select="format-number(number(VRPTx:bond_deviation) div number(VRPTx:bond_standard_deviation),'0.00')"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:bond_standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="mean"><xsl:value-of select="VRPTx:bond_target_value"/></xsl:attribute>
	      <xsl:attribute name="obsval"><xsl:value-of select="VRPTx:bond_value"/></xsl:attribute>
	      <xsl:attribute name="mindiff"><xsl:value-of select="VRPTx:bond_minimum_diff_to_kb"/></xsl:attribute>
	      <xsl:attribute name="numobs"><xsl:value-of select="VRPTx:number_bonds_in_kb"/></xsl:attribute>

	    </mog-bond-outlier>

	  </xsl:when>
	  <xsl:otherwise>

	    <bond-outlier>

	      <xsl:attribute name="atom0"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom1"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="VRPTx:Zscore">
		  <xsl:attribute name="z"><xsl:value-of select="VRPTx:Zscore"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="z"><xsl:value-of select="format-number(number(VRPTx:bond_deviation) div number(VRPTx:bond_standard_deviation),'0.00')"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:bond_standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="mean"><xsl:value-of select="VRPTx:bond_target_value"/></xsl:attribute>
	      <xsl:attribute name="obs"><xsl:value-of select="VRPTx:bond_value"/></xsl:attribute>
	      <xsl:if test="VRPTx:linker_flag='Y'">
		<xsl:attribute name="link">yes</xsl:attribute>
	      </xsl:if>

	    </bond-outlier>

	  </xsl:otherwise>
	</xsl:choose>

      </xsl:for-each>

      <!-- angle-outlier, mog-angle-outlier -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_angleCategory/VRPTx:pdbx_validate_rmsd_angle[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id) and VRPTx:Zscore]">

	<xsl:choose>
	  <xsl:when test="VRPTx:number_angles_in_kb">

	    <mog-angle-outlier>

	      <xsl:attribute name="atoms"><xsl:value-of select="concat(VRPTx:auth_atom_id_1,',',VRPTx:auth_atom_id_2,',',VRPTx:auth_atom_id_3)"/></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="VRPTx:Zscore">
		  <xsl:attribute name="Zscore"><xsl:value-of select="VRPTx:Zscore"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="Zscore"><xsl:value-of select="format-number(number(VRPTx:angle_deviation) div number(VRPTx:angle_standard_deviation),'0.00')"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:angle_standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="mean"><xsl:value-of select="VRPTx:angle_target_value"/></xsl:attribute>
	      <xsl:attribute name="obsval"><xsl:value-of select="VRPTx:angle_value"/></xsl:attribute>
	      <xsl:attribute name="mindiff"><xsl:value-of select="VRPTx:angle_minimum_diff_to_kb"/></xsl:attribute>
	      <xsl:attribute name="numobs"><xsl:value-of select="VRPTx:number_angles_in_kb"/></xsl:attribute>

	    </mog-angle-outlier>

	  </xsl:when>
	  <xsl:otherwise>

	    <angle-outlier>

	      <xsl:attribute name="atom0"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom1"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="atom2"><xsl:value-of select="VRPTx:auth_atom_id_3"/></xsl:attribute>
	      <xsl:choose>
		<xsl:when test="VRPTx:Zscore">
		  <xsl:attribute name="z"><xsl:value-of select="VRPTx:Zscore"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="z"><xsl:value-of select="format-number(number(VRPTx:angle_deviation) div number(VRPTx:angle_standard_deviation),'0.00')"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:angle_standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="mean"><xsl:value-of select="VRPTx:angle_target_value"/></xsl:attribute>
	      <xsl:attribute name="obs"><xsl:value-of select="VRPTx:angle_value"/></xsl:attribute>
	      <xsl:if test="VRPTx:linker_flag='Y'">
		<xsl:attribute name="link">yes</xsl:attribute>
	      </xsl:if>

	    </angle-outlier>

	  </xsl:otherwise>
	</xsl:choose>

      </xsl:for-each>

      <!-- chiral-outlier -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_chiralCategory/VRPTx:pdbx_validate_chiral[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<chiral-outlier>

	  <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id"/></xsl:attribute>
	  <xsl:attribute name="problem"><xsl:value-of select="VRPTx:details"/></xsl:attribute>

	</chiral-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='peptide'] -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_peptide_omegaCategory/VRPTx:pdbx_validate_peptide_omega[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)]">

	<plane-outlier type="peptide">

	  <xsl:attribute name="omega"><xsl:value-of select="VRPTx:omega"/></xsl:attribute>

	</plane-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='mainchain'] -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_main_chain_planeCategory/VRPTx:pdbx_validate_main_chain_plane[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<plane-outlier type="mainchain">

	  <xsl:attribute name="improper"><xsl:value-of select="VRPTx:improper_torsion_angle"/></xsl:attribute>

	</plane-outlier>

      </xsl:for-each>

      <!-- plane-outlier[@type='sidechain'] -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_planesCategory/VRPTx:pdbx_validate_planes[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id)]">

	<plane-outlier>

	  <xsl:attribute name="type"><xsl:value-of select="lower-case(translate(VRPTx:type,' ',''))"/></xsl:attribute>
	  <xsl:attribute name="planeRMSD"><xsl:value-of select="VRPTx:rmsd"/></xsl:attribute>

	</plane-outlier>

      </xsl:for-each>

      <!-- mog-torsion-outlier -->

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_torsionCategory/VRPTx:pdbx_validate_rmsd_torsion[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id) and VRPTx:number_dihedral_angles_in_kb]">

	<mog-torsion-outlier>

	  <xsl:variable name="torsion_id"><xsl:value-of select="@id"/></xsl:variable>

	  <xsl:variable name="atoms">
	    <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_torsions_atomCategory/VRPTx:pdbx_validate_rmsd_torsions_atom[@torsion_id=$torsion_id]">
	      <xsl:value-of select="concat(VRPTx:auth_atom_id,',')"/>
	    </xsl:for-each>
	  </xsl:variable>

	  <xsl:attribute name="atoms"><xsl:value-of select="substring($atoms,1,string-length($atoms)-1)"/></xsl:attribute>
	  <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:dihedral_angle_standard_deviation"/></xsl:attribute>
	  <xsl:attribute name="mean"><xsl:value-of select="VRPTx:dihedral_angle_target_value"/></xsl:attribute>
	  <xsl:attribute name="obsval"><xsl:value-of select="VRPTx:dihedral_angle_value"/></xsl:attribute>
	  <xsl:attribute name="mindiff"><xsl:value-of select="VRPTx:dihedral_angle_minimum_diff_to_kb"/></xsl:attribute>
	  <xsl:attribute name="numobs"><xsl:value-of select="VRPTx:number_dihedral_angles_in_kb"/></xsl:attribute>
	  <xsl:if test="VRPTx:percent_dihedral_angles_fitted_to_kb">
	    <xsl:attribute name="local_density"><xsl:value-of select="VRPTx:percent_dihedral_angles_fitted_to_kb"/></xsl:attribute>
	  </xsl:if>

	</mog-torsion-outlier>

      </xsl:for-each>

      <!-- mog-ring-outlier -->

     <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_ringCategory/VRPTx:pdbx_validate_rmsd_ring[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and VRPTx:auth_comp_id=$mon_id and VRPTx:auth_seq_id=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id=$alt_id) and VRPTx:number_dihedral_angles_in_kb]">

	<mog-ring-outlier>

	  <xsl:variable name="ring_id"><xsl:value-of select="@id"/></xsl:variable>

	  <xsl:variable name="atoms">
	    <xsl:for-each select="$datablock/VRPTx:pdbx_validate_rmsd_rings_atomCategory/VRPTx:pdbx_validate_rmsd_rings_atom[@ring_id=$ring_id]">
	      <xsl:value-of select="concat(VRPTx:auth_atom_id,',')"/>
	    </xsl:for-each>
	  </xsl:variable>

	  <xsl:attribute name="atoms"><xsl:value-of select="substring($atoms,1,string-length($atoms)-1)"/></xsl:attribute>
	  <xsl:attribute name="stdev"><xsl:value-of select="VRPTx:dihedral_angle_standard_deviation"/></xsl:attribute>
	  <xsl:attribute name="mean"><xsl:value-of select="VRPTx:dihedral_angle_target_value"/></xsl:attribute>
	  <xsl:attribute name="mindiff"><xsl:value-of select="VRPTx:dihedral_angle_minimum_diff_to_kb"/></xsl:attribute>
	  <xsl:attribute name="numobs"><xsl:value-of select="VRPTx:number_dihedral_angles_in_kb"/></xsl:attribute>

	</mog-ring-outlier>

      </xsl:for-each>

      <!-- clash -->

      <xsl:variable name="clash_from_pdbml"><xsl:value-of select="count($datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact[not(VRPTx:clash_magnitude)])"/></xsl:variable>

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact[VRPTx:PDB_model_num=$model and ((VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)) or (VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id))) and VRPTx:clash_magnitude]">

	<xsl:if test="VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)">

	  <clash>

	    <xsl:attribute name="cid"><xsl:value-of select="number(@id)-$clash_from_pdbml"/></xsl:attribute>
	    <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	    <xsl:attribute name="dist"><xsl:value-of select="VRPTx:dist"/></xsl:attribute>
	    <xsl:if test="VRPTx:clash_magnitude">
	      <xsl:attribute name="clashmag"><xsl:value-of select="VRPTx:clash_magnitude"/></xsl:attribute>
	    </xsl:if>

	  </clash>

	</xsl:if>

	<xsl:if test="VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id)">

	  <clash>

	    <xsl:attribute name="cid"><xsl:value-of select="number(@id)-$clash_from_pdbml"/></xsl:attribute>
	    <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	    <xsl:attribute name="dist"><xsl:value-of select="VRPTx:dist"/></xsl:attribute>
	    <xsl:if test="VRPTx:clash_magnitude">
	      <xsl:attribute name="clashmag"><xsl:value-of select="VRPTx:clash_magnitude"/></xsl:attribute>
	    </xsl:if>

	  </clash>

	</xsl:if>

      </xsl:for-each>

      <!-- symm-clash -->

      <xsl:variable name="symm_clash_from_pdbml"><xsl:value-of select="count($datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact[not(VRPTx:clash_magnitude)])"/></xsl:variable>

      <xsl:for-each select="$datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact[VRPTx:PDB_model_num=$model and ((VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)) or (VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id))) and VRPTx:clash_magnitude]">

	<xsl:if test="VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)">

	  <symm-clash>

	    <xsl:attribute name="scid"><xsl:value-of select="number(@id)-$symm_clash_from_pdbml"/></xsl:attribute>
	    <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	    <xsl:attribute name="dist"><xsl:value-of select="VRPTx:dist"/></xsl:attribute>
	    <xsl:attribute name="symop"><xsl:value-of select="VRPTx:site_symmetry_1"/></xsl:attribute>
	    <xsl:if test="VRPTx:clash_magnitude">
	      <xsl:attribute name="clashmag"><xsl:value-of select="VRPTx:clash_magnitude"/></xsl:attribute>
	    </xsl:if>

	  </symm-clash>

	</xsl:if>

	<xsl:if test="VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id)">

	  <symm-clash>

	    <xsl:attribute name="scid"><xsl:value-of select="number(@id)-$symm_clash_from_pdbml"/></xsl:attribute>
	    <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	    <xsl:attribute name="dist"><xsl:value-of select="VRPTx:dist"/></xsl:attribute>
	    <xsl:attribute name="symop"><xsl:value-of select="VRPTx:site_symmetry_2"/></xsl:attribute>
	    <xsl:if test="VRPTx:clash_magnitude">
	      <xsl:attribute name="clashmag"><xsl:value-of select="VRPTx:clash_magnitude"/></xsl:attribute>
	    </xsl:if>

	  </symm-clash>

	</xsl:if>

      </xsl:for-each>

      <!-- distance_violation -->

      <xsl:if test="$dist_rest='yes'">

	<xsl:for-each select="$datablock/VRPTx:pdbx_nmr_distance_violationCategory/VRPTx:pdbx_nmr_distance_violation[VRPTx:PDB_model_num=$model and ((VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)) or (VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id))) and VRPTx:violation]">

	  <xsl:if test="VRPTx:auth_asym_id_1=$strand_id and VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)">

	    <distance_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="dist_violation_value"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </distance_violation>

	  </xsl:if>

	  <xsl:if test="VRPTx:auth_asym_id_2=$strand_id and VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id)">

	    <distance_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="dist_violation_value"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </distance_violation>

	  </xsl:if>

	</xsl:for-each>

      </xsl:if>

      <!-- dihedralangle_violation -->

      <xsl:if test="$dihed_rest='yes'">

	<xsl:for-each select="$datablock/VRPTx:pdbx_nmr_dihedral_angle_violationCategory/VRPTx:pdbx_nmr_dihedral_angle_violation[VRPTx:PDB_model_num=$model and VRPTx:auth_asym_id=$strand_id and ((VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)) or (VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id)) or (VRPTx:auth_comp_id_3=$mon_id and VRPTx:auth_seq_id_3=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_3=$alt_id)) or (VRPTx:auth_comp_id_4=$mon_id and VRPTx:auth_seq_id_4=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_4=$alt_id))) and VRPTx:violation]">

	  <xsl:if test="VRPTx:auth_comp_id_1=$mon_id and VRPTx:auth_seq_id_1=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_1=$alt_id)">

	    <dihedralangle_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="DihedralAngViolationValue"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </dihedralangle_violation>

	  </xsl:if>

	  <xsl:if test="VRPTx:auth_comp_id_2=$mon_id and VRPTx:auth_seq_id_2=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_2=$alt_id)">

	    <dihedralangle_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="DihedralAngViolationValue"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </dihedralangle_violation>

	  </xsl:if>

	  <xsl:if test="VRPTx:auth_comp_id_3=$mon_id and VRPTx:auth_seq_id_3=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_3=$alt_id)">

	    <dihedralangle_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_3"/></xsl:attribute>
	      <xsl:attribute name="DihedralAngViolationValue"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </dihedralangle_violation>

	  </xsl:if>

	  <xsl:if test="VRPTx:auth_comp_id_4=$mon_id and VRPTx:auth_seq_id_4=$pdb_seq_num and ($alt_id='' or VRPTx:label_alt_id_4=$alt_id)">

	    <dihedralangle_violation>

	      <xsl:attribute name="atom"><xsl:value-of select="VRPTx:auth_atom_id_4"/></xsl:attribute>
	      <xsl:attribute name="DihedralAngViolationValue"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>

	    </dihedralangle_violation>

	  </xsl:if>

	</xsl:for-each>

      </xsl:if>

    </ModelledSubgroup>

  </xsl:template>

  <!-- ModelledEntityInstance -->

  <xsl:template name="ModelledEntityInstance">

    <xsl:choose>
      <xsl:when test="$nmr=true()">
	<xsl:for-each select="1 to $nmr_models">
	  <xsl:call-template name="modelled_entity_instance_model">
	    <xsl:with-param name="model" select="."/>
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
      <xsl:for-each select="$datablock/VRPTx:entity_polyCategory/VRPTx:entity_poly">
	<xsl:value-of select="concat(VRPTx:pdbx_strand_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:for-each select="tokenize(substring($strand_ids,1,string-length($strand_ids)-1),',')">
      <xsl:call-template name="modelled_entity_instance_strand_id">
	<xsl:with-param name="model" select="$model"/>
	<xsl:with-param name="strand_id" select="."/>
      </xsl:call-template>
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="modelled_entity_instance_strand_id">
    <xsl:param name="model"/>
    <xsl:param name="strand_id"/>

    <xsl:variable name="entity_ids">
      <xsl:for-each select="$datablock/VRPTx:pdbx_percentile_entity_viewCategory/VRPTx:pdbx_percentile_entity_view[VRPTx:auth_asym_id=$strand_id]">
	<xsl:value-of select="concat(VRPTx:entity_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_entity_geometryCategory/VRPTx:pdbx_dcc_entity_geometry[VRPTx:auth_asym_id=$strand_id]">
	<xsl:value-of select="concat(VRPTx:entity_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="$entity_ids!=''">

      <xsl:for-each select="distinct-values(tokenize($entity_ids,','))">
	<xsl:if test=".!=''">
	  <xsl:call-template name="modelled_entity_instance_entity_id">
	    <xsl:with-param name="model" select="$model"/>
	    <xsl:with-param name="strand_id" select="$strand_id"/>
	    <xsl:with-param name="entity_id" select="."/>
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
      <xsl:for-each select="$datablock/VRPTx:pdbx_percentile_entity_viewCategory/VRPTx:pdbx_percentile_entity_view[VRPTx:auth_asym_id=$strand_id]">
	<xsl:value-of select="concat(@label_asym_id,',')"/>
      </xsl:for-each>
      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_entity_geometryCategory/VRPTx:pdbx_dcc_entity_geometry[VRPTx:auth_asym_id=$strand_id]">
	<xsl:value-of select="concat(@label_asym_id,',')"/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:if test="$asym_ids!=''">

      <xsl:for-each select="distinct-values(tokenize($asym_ids,','))">
	<xsl:if test=".!=''">
	  <xsl:call-template name="modelled_entity_instance_asym_id">
	    <xsl:with-param name="model" select="$model"/>
	    <xsl:with-param name="strand_id" select="$strand_id"/>
	    <xsl:with-param name="asym_id" select="."/>
	    <xsl:with-param name="entity_id" select="$entity_id"/>
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

      <xsl:for-each select="$datablock/VRPTx:pdbx_percentile_entity_viewCategory/VRPTx:pdbx_percentile_entity_view[VRPTx:auth_asym_id=$strand_id]">
	<xsl:variable name="type"><xsl:value-of select="@type"/></xsl:variable>
	<xsl:variable name="conditions_id"><xsl:value-of select="@conditions_id"/></xsl:variable>
	<xsl:variable name="condition_res_high"><xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[@id=$conditions_id]/VRPTx:ls_d_res_high"/></xsl:variable>
	<xsl:variable name="condition_res_low"><xsl:value-of select="$datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions[@id=$conditions_id]/VRPTx:ls_d_res_low"/></xsl:variable>

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
		<xsl:attribute name="relative_RSRZ_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:attribute name="absolute_RSRZ_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:when>
	  <xsl:when test="$type='Ramachandran_outlier_percent'">
	    <xsl:choose>
	      <xsl:when test="$absolute='no'">
		<xsl:attribute name="relative_rama_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:attribute name="absolute_rama_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:when>
	  <xsl:when test="$type='rotamer_outliers_percent'">
	    <xsl:choose>
	      <xsl:when test="$absolute='no'">
		<xsl:attribute name="relative_sidechain_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:attribute name="absolute_sidechain_percentile"><xsl:value-of select="VRPTx:rank"/></xsl:attribute>
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

      <xsl:for-each select="$datablock/VRPTx:pdbx_dcc_entity_geometryCategory/VRPTx:pdbx_dcc_entity_geometry[@label_asym_id=$asym_id]">

	<xsl:if test="VRPTx:angle_overall_rmsz">
	  <xsl:attribute name="angles_rmsz"><xsl:value-of select="VRPTx:angle_overall_rmsz"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:bond_overall_rmsz">
	  <xsl:attribute name="bonds_rmsz"><xsl:value-of select="VRPTx:bond_overall_rmsz"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:number_angles">
	  <xsl:attribute name="num_angles_rmsz"><xsl:value-of select="VRPTx:number_angles"/></xsl:attribute>
	</xsl:if>
	<xsl:if test="VRPTx:number_bonds">
	  <xsl:attribute name="num_bonds_rmsz"><xsl:value-of select="VRPTx:number_bonds"/></xsl:attribute>
	</xsl:if>

      </xsl:for-each>

      <!-- EM validation : ModelledEntityInstarnce -->

      <xsl:if test="$em=true()">

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_validate_map_model_entityCategory/VRPTx:pdbx_em_validate_map_model_entity[@label_asym_id=$asym_id]">
	  <xsl:attribute name="average_residue_inclusion"><xsl:value-of select="VRPTx:average_atom_inclusion_all"/></xsl:attribute>
	  <xsl:if test="VRPTx:average_Q_score">
	    <xsl:attribute name="Q_score"><xsl:value-of select="VRPTx:average_Q_score"/></xsl:attribute>
	  </xsl:if>
	</xsl:for-each>

      </xsl:if>

    </ModelledEntityInstance>

  </xsl:template>

  <!-- EM validation : EM_validation -->

  <xsl:template name="EM_validation">
    <xsl:for-each select="VRPTx:pdbx_em_validate_map_model_overallCategory/VRPTx:pdbx_em_validate_map_model_overall[VRPTx:recommended_contour_level!='']">
      <EM_validation>

	<RecommendedContourLevel>
	  <xsl:attribute name="value"><xsl:value-of select="VRPTx:recommended_contour_level"/></xsl:attribute>
	</RecommendedContourLevel>

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_density_distributionCategory/VRPTx:pdbx_em_density_distribution">
	  <map_value_distribution>
	    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:map_value_title"/></xsl:attribute>
	    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:voxel_count_title"/></xsl:attribute>
	    <xsl:attribute name="yScale"><xsl:value-of select="VRPTx:voxel_count_scale"/></xsl:attribute>
	    <xsl:for-each select="$datablock/VRPTx:pdbx_em_density_distribution_markerCategory/VRPTx:pdbx_em_density_distribution_marker">
	      <xsl:sort select="@ordinal" data-type="number"/>
	      <coordinate>
		<xsl:attribute name="x"><xsl:value-of select="VRPTx:map_value"/></xsl:attribute>
		<xsl:attribute name="y"><xsl:value-of select="VRPTx:voxel_count"/></xsl:attribute>
	      </coordinate>
	    </xsl:for-each>
	  </map_value_distribution>
	</xsl:for-each>

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_rapsCategory/VRPTx:pdbx_em_raps">
	  <rotationally_averaged_power_spectrum>
	    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:spatial_frequency_title"/></xsl:attribute>
	    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:power_title"/></xsl:attribute>
	    <xsl:attribute name="xUnit"><xsl:value-of select="VRPTx:spatial_frequency_unit"/></xsl:attribute>
	    <xsl:attribute name="yScale"><xsl:value-of select="VRPTx:power_scale"/></xsl:attribute>
	    <xsl:for-each select="$datablock/VRPTx:pdbx_em_raps_markerCategory/VRPTx:pdbx_em_raps_marker">
	      <xsl:sort select="@ordinal" data-type="number"/>
	      <coordinate>
		<xsl:attribute name="x"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
		<xsl:attribute name="y"><xsl:value-of select="VRPTx:power"/></xsl:attribute>
	      </coordinate>
	    </xsl:for-each>
	  </rotationally_averaged_power_spectrum>
	</xsl:for-each>

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_raw_rapsCategory/VRPTx:pdbx_em_raw_raps">
	  <raw_map_rotationally_averaged_power_spectrum>
	    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:spatial_frequency_title"/></xsl:attribute>
	    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:power_title"/></xsl:attribute>
	    <xsl:attribute name="xUnit"><xsl:value-of select="VRPTx:spatial_frequency_unit"/></xsl:attribute>
	    <xsl:attribute name="yScale"><xsl:value-of select="VRPTx:power_scale"/></xsl:attribute>
	    <xsl:for-each select="$datablock/VRPTx:pdbx_em_raw_raps_markerCategory/VRPTx:pdbx_em_raw_raps_marker">
	      <xsl:sort select="@ordinal" data-type="number"/>
	      <coordinate>
		<xsl:attribute name="x"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
		<xsl:attribute name="y"><xsl:value-of select="VRPTx:power"/></xsl:attribute>
	      </coordinate>
	    </xsl:for-each>
	  </raw_map_rotationally_averaged_power_spectrum>
	</xsl:for-each>

	<xsl:for-each select="$datablock/VRPTx:pdbx_em_volume_estimateCategory/VRPTx:pdbx_em_volume_estimate">
	  <volume_estimate>
	    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:contour_level_title"/></xsl:attribute>
	    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:enclosed_volume_title"/></xsl:attribute>
	    <xsl:attribute name="yUnit"><xsl:value-of select="VRPTx:enclosed_volume_unit"/></xsl:attribute>
	    <xsl:for-each select="$datablock/VRPTx:pdbx_em_volume_estimate_markerCategory/VRPTx:pdbx_em_volume_estimate_marker">
	      <xsl:sort select="@ordinal" data-type="number"/>
	      <coordinate>
		<xsl:attribute name="x"><xsl:value-of select="VRPTx:contour_level"/></xsl:attribute>
		<xsl:attribute name="y"><xsl:value-of select="VRPTx:enclosed_volume"/></xsl:attribute>
	      </coordinate>
	    </xsl:for-each>
	  </volume_estimate>
	</xsl:for-each>

	<xsl:if test="$datablock/VRPTx:pdbx_em_atom_inclusionCategory/VRPTx:pdbx_em_atom_inclusion">
	  <atom_inclusion>
	    <xsl:for-each select="$datablock/VRPTx:pdbx_em_atom_inclusionCategory/VRPTx:pdbx_em_atom_inclusion">
	      <xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
	      <xsl:choose>
		<xsl:when test="VRPTx:atom_type='all non-hydrogen atoms'">
		  <all_atoms>
		    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:contour_level_title"/></xsl:attribute>
		    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:atom_inclusion_title"/></xsl:attribute>
		    <xsl:for-each select="$datablock/VRPTx:pdbx_em_atom_inclusion_markerCategory/VRPTx:pdbx_em_atom_inclusion_marker[@plot_id=$plot_id]">
		      <xsl:sort select="@ordinal" data-type="number"/>
		      <coordinate>
			<xsl:attribute name="x"><xsl:value-of select="VRPTx:contour_level"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="VRPTx:atom_inclusion"/></xsl:attribute>
		      </coordinate>
		    </xsl:for-each>
		  </all_atoms>
		</xsl:when>
		<xsl:when test="VRPTx:atom_type='backbone atoms'">
		  <backbone>
		    <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:contour_level_title"/></xsl:attribute>
		    <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:atom_inclusion_title"/></xsl:attribute>
		    <xsl:for-each select="$datablock/VRPTx:pdbx_em_atom_inclusion_markerCategory/VRPTx:pdbx_em_atom_inclusion_marker[@plot_id=$plot_id]">
		      <xsl:sort select="@ordinal" data-type="number"/>
		      <coordinate>
			<xsl:attribute name="x"><xsl:value-of select="VRPTx:contour_level"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="VRPTx:atom_inclusion"/></xsl:attribute>
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

	<xsl:if test="$datablock/VRPTx:pdbx_em_fsc_resolutionCaetgory/VRPTx:pdbx_em_fsc_resolution">
	  <fsc>
	    <resolution_intersections>
	      <xsl:attribute name="resolution_unit"><xsl:value-of select="$datablock/VRPTx:pdbx_em_fsc_resolutionCaetgory/VRPTx:pdbx_em_fsc_resolution[1]/VRPTx:resolution_unit"/></xsl:attribute>
	      <xsl:attribute name="spatial_frequency_unit"><xsl:value-of select="$datablock/VRPTx:pdbx_em_fsc_resolutionCaetgory/VRPTx:pdbx_em_fsc_resolution[1]/VRPTx:spatial_frequency_unit"/></xsl:attribute>
	      <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_resolutionCaetgory/VRPTx:pdbx_em_fsc_resolution">
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
		  <xsl:attribute name="correlation"><xsl:value-of select="VRPTx:correlation_coef"/></xsl:attribute>
		  <xsl:attribute name="spatial_frequency"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
		  <xsl:attribute name="resolution"><xsl:value-of select="VRPTx:resolution"/></xsl:attribute>
		</intersection>
	      </xsl:for-each>
	    </resolution_intersections>

	    <fsc_curves>
	      <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_curveCaetgory/VRPTx:pdbx_em_fsc_curve">
		<xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
		<fsc_curve>
		  <xsl:attribute name="Title"><xsl:value-of select="VRPTx:title"/></xsl:attribute>
		  <xsl:if test="VRPTx:name">
		    <xsl:attribute name="curve_name"><xsl:value-of select="VRPTx:name"/></xsl:attribute>
		  </xsl:if>
		  <xsl:if test="VRPTx:type">
		    <xsl:attribute name="type"><xsl:value-of select="VRPTx:type"/></xsl:attribute>
		  </xsl:if>
		  <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:spatial_frequency_title"/></xsl:attribute>
		  <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:correlation_coef_title"/></xsl:attribute>
		  <xsl:attribute name="xUnit"><xsl:value-of select="VRPTx:spatial_frequency_unit"/></xsl:attribute>
		  <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_curve_markerCaetgory/VRPTx:pdbx_em_fsc_curve_marker[@plot_id=$plot_id]">
		    <xsl:sort select="@ordinal" data-type="number"/>
		    <coordinate>
		      <xsl:attribute name="x"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
		      <xsl:attribute name="y"><xsl:value-of select="VRPTx:correlation_coef"/></xsl:attribute>
		    </coordinate>
		  </xsl:for-each>
		</fsc_curve>
	      </xsl:for-each>
	    </fsc_curves>

	    <fsc_indicator_curves>
	      <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_cutoff_curveCaetgory/VRPTx:pdbx_em_fsc_cutoff_curve">
		<xsl:variable name="plot_id"><xsl:value-of select="@id"/></xsl:variable>
		<fsc_indicator_curve>
		  <xsl:variable name="curve">
		    <xsl:choose>
		      <xsl:when test="starts-with(VRPTx:title,'calculated_fsc') or VRPTx:target_curve='calculated_fsc'">calculated_fsc</xsl:when>
		      <xsl:when test="starts-with(VRPTx:title,'author_provided_fsc') or VRPTx:target_curve='author_provided_fsc'">author_provided_fsc</xsl:when>
		      <xsl:otherwise>
			<xsl:call-template name="error_handler">
			  <xsl:with-param name="terminate">yes</xsl:with-param>
			  <xsl:with-param name="error_message">
Source for FSC offset curve, <xsl:value-of select="VRPTx:title"/>, is not listed in XSLT code.
			  </xsl:with-param>
			</xsl:call-template>
		      </xsl:otherwise>
		    </xsl:choose>
		  </xsl:variable>
		  <xsl:variable name="type">
		    <xsl:choose>
		      <xsl:when test="ends-with(VRPTx:title,'0.143') or VRPTx:type='0.143'">0.143</xsl:when>
		      <xsl:when test="ends-with(VRPTx:title,'0.333') or VRPTx:type='0.333'">0.333</xsl:when>
		      <xsl:when test="ends-with(VRPTx:title,'0.5') or VRPTx:type='0.5'">0.5</xsl:when>
		      <xsl:when test="ends-with(VRPTx:title,'half-bit') or VRPTx:type='half-bit'">halfbit</xsl:when>
		      <xsl:when test="ends-with(VRPTx:title,'one-bit') or VRPTx:type='one-bit'">onebit</xsl:when>
		      <xsl:when test="ends-with(VRPTx:title,'3sigma') or VRPTx:type='3sigma'">threesigma</xsl:when>
		      <xsl:otherwise>
			<xsl:call-template name="error_handler">
			  <xsl:with-param name="terminate">yes</xsl:with-param>
			  <xsl:with-param name="error_message">
Criteria for FSC offset curve, <xsl:value-of select="VRPTx:title"/>, is not listed in XSLT code.
			  </xsl:with-param>
			</xsl:call-template>
		      </xsl:otherwise>
		    </xsl:choose>
		  </xsl:variable>
		  <xsl:attribute name="Title"><xsl:value-of select="VRPTx:title"/></xsl:attribute>
		  <xsl:if test="VRPTx:name">
		    <xsl:attribute name="curve_name"><xsl:value-of select="concat($curve,'_',$type)"/></xsl:attribute>
		  </xsl:if>
		  <xsl:if test="VRPTx:type">
		    <xsl:attribute name="type"><xsl:value-of select="$type"/></xsl:attribute>
		  </xsl:if>
		  <xsl:if test="VRPTx:target_name">
		    <xsl:attribute name="data_curve"><xsl:value-of select="$curve"/></xsl:attribute>
		  </xsl:if>
		  <xsl:attribute name="xTitle"><xsl:value-of select="VRPTx:spatial_frequency_title"/></xsl:attribute>
		  <xsl:attribute name="yTitle"><xsl:value-of select="VRPTx:correlation_coef_title"/></xsl:attribute>
		  <xsl:attribute name="xUnit"><xsl:value-of select="VRPTx:spatial_frequency_unit"/></xsl:attribute>
		  <xsl:choose>
		    <xsl:when test="$type='halfbit' or $type='onebit' or $type='threesigma'">
		      <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_cutoff_curve_markerCaetgory/VRPTx:pdbx_em_fsc_cutoff_curve_marker[@plot_id=$plot_id]">
			<xsl:sort select="@ordinal" data-type="number"/>
			<coordinate>
			  <xsl:attribute name="x"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
			  <xsl:attribute name="y"><xsl:value-of select="VRPTx:correlation_coef"/></xsl:attribute>
			</coordinate>
		      </xsl:for-each>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:variable name="plot_id"><xsl:value-of select="$datablock/VRPTx:pdbx_em_fsc_curveCategory/VRPTx:pdbx_em_fsc_curve[VRPTx:title=$curve]/@id"/></xsl:variable>
		      <xsl:for-each select="$datablock/VRPTx:pdbx_em_fsc_curve_markerCategory/VRPTx:pdbx_em_fsc_curve_marker[@plot_id=$plot_id]">
			<xsl:sort select="@ordinal" data-type="number"/>
			<coordinate>
			  <xsl:attribute name="x"><xsl:value-of select="VRPTx:spatial_frequency"/></xsl:attribute>
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

  <!-- NMR restraint validation: NMR_restraints_analysis -->

  <xsl:template name="NMR_restraints_analysis">
    <NMR_restraints_analysis>

      <conformationally_restricting_restraints>
	<xsl:for-each select="VRPTx:pdbx_nmr_restraint_summaryCategory/VRPTx:pdbx_nmr_restraint_summary">
	  <xsl:if test="VRPTx:distance_restraints_total">
	    <restraint_summary description="Total distance restraints" value="{VRPTx:distance_restraints_total}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:intraresidue_total_count">
	    <restraint_summary description="Intra-residue (|i-j|=0)" value="{VRPTx:intraresidue_total_count}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:sequential_total_count">
	    <restraint_summary description="Sequential (|i-j|=1)" value="{VRPTx:sequential_total_count}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:medium_range_total_count">
	    <restraint_summary description="Medium range (|i-j|&gt;1 and |i-j|&lt;5)" value="{VRPTx:medium_range_total_count}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:long_range_total_count">
	    <restraint_summary description="Long range (|i-j|&gt;=5)" value="{VRPTx:long_range_total_count}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:interchain_total_count">
	    <restraint_summary description="Inter-chain" value="{VRPTx:interchain_total_count}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:dihedral_angle_restraints_total">
	    <restraint_summary description="Total dihedral-angle restraints" value="{VRPTx:dihedral_angle_restraints_total}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:hydrogen_bond_restraints_total">
	    <restraint_summary description="Total hydrogen bond restraints" value="{VRPTx:hydrogen_bond_restraints_total}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:disulfide_bond_restraints_total">
	    <restraint_summary description="Total disulfide bond restraints" value="{VRPTx:disulfide_bond_restraints_total}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:unmapped_restraints_total">
	    <restraint_summary description="Number of unmapped restraints" value="{VRPTx:unmapped_restraints_total}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:restraints_per_residue">
	    <restraint_summary description="Number of restraints per residue" value="{VRPTx:restraints_per_residue}"/>
	  </xsl:if>
	  <xsl:if test="VRPTx:long_range_restraints_per_residue">
	    <restraint_summary description="Number of long range restraints per residue" value="{VRPTx:long_range_restraints_per_residue}"/>
	  </xsl:if>
	</xsl:for-each>
      </conformationally_restricting_restraints>

      <xsl:if test="VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list[@type='distance']">
	<residual_distance_violations>
	  <xsl:for-each select="VRPTx:pdbx_nmr_restraint_violationCategory/VRPTx:pdbx_nmr_restraint_violation[@type='distance']">
	    <xsl:sort select="@ordinal"/>
	    <residual_distance_violation>
	      <xsl:choose>
		<xsl:when test="VRPTx:limit_bin_max!='?'">
		  <xsl:attribute name="bins"><xsl:value-of select="concat(VRPTx:limit_bin_min,'-',VRPTx:limit_bin_max)"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="bins"><xsl:value-of select="concat('&gt;',VRPTx:limit_bin_min)"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="max_violation"><xsl:value-of select="VRPTx:maximum_violation_in_bin"/></xsl:attribute>
	      <xsl:attribute name="violations_per_model"><xsl:value-of select="VRPTx:violations_per_model"/></xsl:attribute>
	    </residual_distance_violation>
	  </xsl:for-each>
	</residual_distance_violations>
      </xsl:if>

      <xsl:if test="VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list[@type='dihedral_angle']">
	<residual_angle_violations>
	  <xsl:for-each select="VRPTx:pdbx_nmr_restraint_violationCategory/VRPTx:pdbx_nmr_restraint_violation[@type='dihedral_angle']">
	    <xsl:sort select="@ordinal"/>
	    <residual_angle_violation>
	      <xsl:choose>
		<xsl:when test="VRPTx:limit_bin_max!='?'">
		  <xsl:attribute name="bins"><xsl:value-of select="concat(VRPTx:limit_bin_min,'-',VRPTx:limit_bin_max)"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:attribute name="bins"><xsl:value-of select="concat('&gt;',VRPTx:limit_bin_min)"/></xsl:attribute>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="max_violation"><xsl:value-of select="VRPTx:maximum_violation_in_bin"/></xsl:attribute>
	      <xsl:attribute name="violations_per_model"><xsl:value-of select="VRPTx:violations_per_model"/></xsl:attribute>
	    </residual_angle_violation>
	  </xsl:for-each>
	</residual_angle_violations>
      </xsl:if>

    </NMR_restraints_analysis>
  </xsl:template>

  <!-- NMR restraint validation: distance_restraints_analysis -->

  <xsl:template name="distance_restraints_analysis">
    <distance_restraints_analysis>

      <xsl:if test="VRPTx:pdbx_nmr_distance_violation_summaryCategory/VRPTx:pdbx_nmr_distance_violation_summary">
	<distance_violations_summary>
	  <xsl:for-each select="VRPTx:pdbx_nmr_distance_violation_summaryCategory/VRPTx:pdbx_nmr_distance_violation_summary">
	    <distance_violation_summary>
	      <xsl:choose>
		<xsl:when test="@type='intraresidue'">
		  <xsl:attribute name="restraint_type">Intra-residue</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='sequential'">
		  <xsl:attribute name="restraint_type">Sequential</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='medium_range'">
		  <xsl:attribute name="restraint_type">MediumRange</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='long_range'">
		  <xsl:attribute name="restraint_type">LongRange</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='interchain'">
		  <xsl:attribute name="restraint_type">InterChain</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='hydrogen_bond'">
		  <xsl:attribute name="restraint_type">HydrogenBond</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='disulfide_bond'">
		  <xsl:attribute name="restraint_type">DisulfideBond</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='all'">
		  <xsl:attribute name="restraint_type">Total</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:call-template name="error_handler">
		    <xsl:with-param name="terminate">yes</xsl:with-param>
		    <xsl:with-param name="error_message">
Distance restraint type , <xsl:value-of select="@type"/>, is not listed in XSLT code.
		    </xsl:with-param>
		  </xsl:call-template>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:choose>
		<xsl:when test="@subtype='backbone_backbone'">
		  <xsl:attribute name="restraint_sub_type">BackboneBackbone</xsl:attribute>
		</xsl:when>
		<xsl:when test="@subtype='backbone_sidechain'">
		  <xsl:attribute name="restraint_sub_type">BackboneSidechain</xsl:attribute>
		</xsl:when>
		<xsl:when test="@subtype='sidechain_sidechain'">
		  <xsl:attribute name="restraint_sub_type">SidechainSidechain</xsl:attribute>
		</xsl:when>
		<xsl:when test="@subtype='all'">
		  <xsl:attribute name="restraint_sub_type">all</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:call-template name="error_handler">
		    <xsl:with-param name="terminate">yes</xsl:with-param>
		    <xsl:with-param name="error_message">
Distance restraint subtype , <xsl:value-of select="@subtype"/>, is not listed in XSLT code.
		    </xsl:with-param>
		  </xsl:call-template>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="restraints_count"><xsl:value-of select="VRPTx:restraints_count"/></xsl:attribute>
	      <xsl:attribute name="percent_total"><xsl:value-of select="VRPTx:restraints_percent"/></xsl:attribute>
	      <xsl:attribute name="violated_count"><xsl:value-of select="VRPTx:violations_count"/></xsl:attribute>
	      <xsl:attribute name="violated_percent_total"><xsl:value-of select="VRPTx:violations_percent"/></xsl:attribute>
	      <xsl:attribute name="violated_percent_type"><xsl:value-of select="VRPTx:violations_percent_type"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_count"><xsl:value-of select="VRPTx:consistent_violations_count"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_percent_total"><xsl:value-of select="VRPTx:consistent_violations_percent"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_percent_type"><xsl:value-of select="VRPTx:consistent_violations_percent_type"/></xsl:attribute>
	    </distance_violation_summary>
	  </xsl:for-each>
	</distance_violations_summary>
      </xsl:if>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_distance_violation_modelCategory/VRPTx:pdbx_nmr_distance_violation_model">
	<distance_violations_in_models>
	  <xsl:for-each select="VRPTx:pdbx_nmr_distance_violation_modelCategory/VRPTx:pdbx_nmr_distance_violation_model">
	    <distance_violations_in_model model="{@PDB_model_num}">
	      <xsl:attribute name="max_violation"><xsl:value-of select="VRPTx:maximum_violation"/></xsl:attribute>
	      <xsl:attribute name="mean_violation"><xsl:value-of select="VRPTx:average_violation"/></xsl:attribute>
	      <xsl:attribute name="standard_deviation"><xsl:value-of select="VRPTx:standard_deviation"/></xsl:attribute>
	      <xsl:if test="VRPTx:violations_count">
		<dist_rest_types dist_rest_type="Total" violations_count="{VRPTx:violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:intraresidue_violations_count">
		<dist_rest_types dist_rest_type="Intra-residue" violations_count="{VRPTx:intraresidue_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:sequential_violations_count">
		<dist_rest_types dist_rest_type="Sequential" violations_count="{VRPTx:sequential_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:medium_range_violations_count">
		<dist_rest_types dist_rest_type="MediumRange" violations_count="{VRPTx:medium_range_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:long_range_violations_count">
		<dist_rest_types dist_rest_type="LongRange" violations_count="{VRPTx:long_range_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:interchain_violations_count">
		<dist_rest_types dist_rest_type="InterChain" violations_count="{VRPTx:interchain_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:hydrogen_bond_violations_count">
		<dist_rest_types dist_rest_type="HydrogenBond" violations_count="{VRPTx:hydrogen_bond_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:disulfide_bond_violations_count">
		<dist_rest_types dist_rest_type="DisulfideBond" violations_count="{VRPTx:disulfide_bond_violations_count}"/>
	      </xsl:if>
	    </distance_violations_in_model>
	  </xsl:for-each>
	</distance_violations_in_models>
      </xsl:when>
      <xsl:otherwise>
	<distance_violations_in_models/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_distance_violation_ensembleCategory/VRPTx:pdbx_nmr_distance_violation_ensemble">
	<distance_violations_in_ensemble>
	  <xsl:for-each select="VRPTx:pdbx_nmr_distance_violation_ensembleCategory/VRPTx:pdbx_nmr_distance_violation_ensemble">
	    <distance_violation_in_ensemble fraction_of_ensemble_count="{@fraction_ensemble_size}" fraction_of_ensemble_percent="{VRPTx:fraction_ensemble_percent}">
	      <xsl:if test="VRPTx:violations_count">
		<dist_rest_types dist_rest_type="Total" violations_count="{VRPTx:violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:intraresidue_violations_count">
		<dist_rest_types dist_rest_type="Intra-residue" violations_count="{VRPTx:intraresidue_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:sequential_violations_count">
		<dist_rest_types dist_rest_type="Sequential" violations_count="{VRPTx:sequential_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:medium_range_violations_count">
		<dist_rest_types dist_rest_type="MediumRange" violations_count="{VRPTx:medium_range_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:long_range_violations_count">
		<dist_rest_types dist_rest_type="LongRange" violations_count="{VRPTx:long_range_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:interchain_violations_count">
		<dist_rest_types dist_rest_type="InterChain" violations_count="{VRPTx:interchain_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:hydrogen_bond_violations_count">
		<dist_rest_types dist_rest_type="HydrigenBond" violations_count="{VRPTx:hydrogen_bond_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:disulfide_bond_violations_count">
		<dist_rest_types dist_rest_type="DisulfideBond" violations_count="{VRPTx:disulfide_bond_violations_count}"/>
	      </xsl:if>
	    </distance_violation_in_ensemble>
	  </xsl:for-each>
	</distance_violations_in_ensemble>
      </xsl:when>
      <xsl:otherwise>
	<distance_violations_in_ensemble/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_distance_violation_pluralCategory/VRPTx:pdbx_nmr_distance_violation_plural">
	<most_violated_distance_restraints>
	  <xsl:for-each select="VRPTx:pdbx_nmr_distance_violation_pluralCategory/VRPTx:pdbx_nmr_distance_violation_plural">
	    <xsl:sort select="@ordinal"/>
	    <most_violated_distance_restraint>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="violated_models"><xsl:value-of select="VRPTx:violation_models_count"/></xsl:attribute>
	      <xsl:attribute name="mean_distance_violation"><xsl:value-of select="VRPTx:average_violation"/></xsl:attribute>
	      <xsl:attribute name="median_violation"><xsl:value-of select="VRPTx:median_violation"/></xsl:attribute>
	      <xsl:attribute name="standard_deviation"><xsl:value-of select="VRPTx:standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="ent_1"><xsl:value-of select="VRPTx:entity_id_1"/></xsl:attribute>
	      <xsl:attribute name="ent_2"><xsl:value-of select="VRPTx:entity_id_2"/></xsl:attribute>
	      <xsl:attribute name="chain_1"><xsl:value-of select="VRPTx:auth_asym_id_1"/></xsl:attribute>
	      <xsl:attribute name="chain_2"><xsl:value-of select="VRPTx:auth_asym_id_2"/></xsl:attribute>
	      <xsl:attribute name="resnum_1"><xsl:value-of select="VRPTx:auth_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="resnum_2"><xsl:value-of select="VRPTx:auth_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="resname_1"><xsl:value-of select="VRPTx:auth_comp_id_1"/></xsl:attribute>
	      <xsl:attribute name="resname_2"><xsl:value-of select="VRPTx:auth_comp_id_2"/></xsl:attribute>
	      <xsl:attribute name="atom_1"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom_2"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="said_1"><xsl:value-of select="VRPTx:label_asym_id_1"/></xsl:attribute>
	      <xsl:attribute name="said_2"><xsl:value-of select="VRPTx:label_asym_id_2"/></xsl:attribute>
	      <xsl:attribute name="seq_1"><xsl:value-of select="VRPTx:label_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="seq_2"><xsl:value-of select="VRPTx:label_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="icode_1"><xsl:value-of select="translate(VRPTx:PDB_ins_code_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_2"><xsl:value-of select="translate(VRPTx:PDB_ins_code_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_1"><xsl:value-of select="translate(VRPTx:label_alt_id_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_2"><xsl:value-of select="translate(VRPTx:label_alt_id_2,'?.','  ')"/></xsl:attribute>
	    </most_violated_distance_restraint>
	  </xsl:for-each>
	</most_violated_distance_restraints>
      </xsl:when>
      <xsl:otherwise>
	<most_violated_distance_restraints/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_distance_violationCategory/VRPTx:pdbx_nmr_distance_violation">
	<violated_distance_restraints>
	  <xsl:for-each select="VRPTx:pdbx_nmr_distance_violationCategory/VRPTx:pdbx_nmr_distance_violation">
	    <xsl:sort select="@ordinal"/>
	    <violated_distance_restraint>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="model"><xsl:value-of select="VRPTx:PDB_model_num"/></xsl:attribute>
	      <xsl:attribute name="violation"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="ent_1"><xsl:value-of select="VRPTx:entity_id_1"/></xsl:attribute>
	      <xsl:attribute name="ent_2"><xsl:value-of select="VRPTx:entity_id_2"/></xsl:attribute>
	      <xsl:attribute name="chain_1"><xsl:value-of select="VRPTx:auth_asym_id_1"/></xsl:attribute>
	      <xsl:attribute name="chain_2"><xsl:value-of select="VRPTx:auth_asym_id_2"/></xsl:attribute>
	      <xsl:attribute name="resnum_1"><xsl:value-of select="VRPTx:auth_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="resnum_2"><xsl:value-of select="VRPTx:auth_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="resname_1"><xsl:value-of select="VRPTx:auth_comp_id_1"/></xsl:attribute>
	      <xsl:attribute name="resname_2"><xsl:value-of select="VRPTx:auth_comp_id_2"/></xsl:attribute>
	      <xsl:attribute name="atom_1"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom_2"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="said_1"><xsl:value-of select="VRPTx:label_asym_id_1"/></xsl:attribute>
	      <xsl:attribute name="said_2"><xsl:value-of select="VRPTx:label_asym_id_2"/></xsl:attribute>
	      <xsl:attribute name="seq_1"><xsl:value-of select="VRPTx:label_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="seq_2"><xsl:value-of select="VRPTx:label_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="icode_1"><xsl:value-of select="translate(VRPTx:PDB_ins_code_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_2"><xsl:value-of select="translate(VRPTx:PDB_ins_code_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_1"><xsl:value-of select="translate(VRPTx:label_alt_id_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_2"><xsl:value-of select="translate(VRPTx:label_alt_id_2,'?.','  ')"/></xsl:attribute>
	    </violated_distance_restraint>
	  </xsl:for-each>
	</violated_distance_restraints>
      </xsl:when>
      <xsl:otherwise>
	<violated_distance_restraints/>
      </xsl:otherwise>
      </xsl:choose>

    </distance_restraints_analysis>
  </xsl:template>

  <!-- NMR restraint validation: dihedralangle_restraints_analysis -->

  <xsl:template name="dihedralangle_restraints_analysis">
    <dihedralangle_restraints_analysis>

      <xsl:if test="VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_summary">
	<dihedralangle_violations_summary>
	  <xsl:for-each select="VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_summary">
	    <dihedralangle_violation_summary>
	      <xsl:choose>
		<xsl:when test="@type='phi'">
		  <xsl:attribute name="restraint_type">PHI</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='psi'">
		  <xsl:attribute name="restraint_type">PSI</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='omega'">
		  <xsl:attribute name="restraint_type">OMEGA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi1'">
		  <xsl:attribute name="restraint_type">CHI1</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi2'">
		  <xsl:attribute name="restraint_type">CHI2</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi3'">
		  <xsl:attribute name="restraint_type">CHI3</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi4'">
		  <xsl:attribute name="restraint_type">CHI4</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi5'">
		  <xsl:attribute name="restraint_type">CHI5</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='alpha'">
		  <xsl:attribute name="restraint_type">ALPHA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='beta'">
		  <xsl:attribute name="restraint_type">BETA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='gamma'">
		  <xsl:attribute name="restraint_type">GAMMA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='delta'">
		  <xsl:attribute name="restraint_type">DELTA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='epsilon'">
		  <xsl:attribute name="restraint_type">EPSILON</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='zeta'">
		  <xsl:attribute name="restraint_type">ZETA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='nu0'">
		  <xsl:attribute name="restraint_type">NU0</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='nu1'">
		  <xsl:attribute name="restraint_type">NU1</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='nu2'">
		  <xsl:attribute name="restraint_type">NU2</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='nu3'">
		  <xsl:attribute name="restraint_type">NU3</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='nu4'">
		  <xsl:attribute name="restraint_type">NU4</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi21'">
		  <xsl:attribute name="restraint_type">CHI21</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi22'">
		  <xsl:attribute name="restraint_type">CHI22</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi31'">
		  <xsl:attribute name="restraint_type">CHI31</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi32'">
		  <xsl:attribute name="restraint_type">CHI32</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi42'">
		  <xsl:attribute name="restraint_type">CHI42</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='all'">
		  <xsl:attribute name="restraint_type">Total</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='chi'">
		  <xsl:attribute name="restraint_type">CHI</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='eta'">
		  <xsl:attribute name="restraint_type">ETA</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='theta'">
		  <xsl:attribute name="restraint_type">THETA</xsl:attribute>
		</xsl:when>
		<xsl:when test='@type="eta&apos;"'>
		  <xsl:attribute name="restraint_type">ETA'</xsl:attribute>
		</xsl:when>
		<xsl:when test='@type="theta&apos;"'>
		  <xsl:attribute name="restraint_type">THETA'</xsl:attribute>
		</xsl:when>
		<xsl:when test="@type='other'">
		  <xsl:attribute name="restraint_type">.</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:call-template name="error_handler">
		    <xsl:with-param name="terminate">yes</xsl:with-param>
		    <xsl:with-param name="error_message">
Dihedral angle restraint type , <xsl:value-of select="@type"/>, is not listed in XSLT code.
		    </xsl:with-param>
		  </xsl:call-template>
		</xsl:otherwise>
	      </xsl:choose>
	      <xsl:attribute name="restraints_count"><xsl:value-of select="VRPTx:restraints_count"/></xsl:attribute>
	      <xsl:attribute name="percent_total"><xsl:value-of select="VRPTx:restraints_percent"/></xsl:attribute>
	      <xsl:attribute name="violated_count"><xsl:value-of select="VRPTx:violations_count"/></xsl:attribute>
	      <xsl:attribute name="violated_percent_total"><xsl:value-of select="VRPTx:violations_percent"/></xsl:attribute>
	      <xsl:attribute name="violated_percent_type"><xsl:value-of select="VRPTx:violations_percent_type"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_count"><xsl:value-of select="VRPTx:consistent_violations_count"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_percent_total"><xsl:value-of select="VRPTx:consistent_violations_percent"/></xsl:attribute>
	      <xsl:attribute name="consistently_violated_percent_type"><xsl:value-of select="VRPTx:consistent_violations_percent_type"/></xsl:attribute>
	    </dihedralangle_violation_summary>
	  </xsl:for-each>
	</dihedralangle_violations_summary>
      </xsl:if>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_model">
	<dihedralangle_violations_in_models>
	  <xsl:for-each select="VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_model">
	    <dihedralangle_violations_in_model model="{@PDB_model_num}">
	      <xsl:attribute name="max_violation"><xsl:value-of select="VRPTx:maximum_violation"/></xsl:attribute>
	      <xsl:attribute name="mean_violation"><xsl:value-of select="VRPTx:average_violation"/></xsl:attribute>
	      <xsl:attribute name="standard_deviation"><xsl:value-of select="VRPTx:standard_deviation"/></xsl:attribute>
	      <xsl:if test="VRPTx:violations_count">
		<ang_rest_types ang_rest_type="Total" violations_count="{VRPTx:violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:phi_violations_count">
		<ang_rest_types ang_rest_type="PHI" violations_count="{VRPTx:phi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:psi_violations_count">
		<ang_rest_types ang_rest_type="PSI" violations_count="{VRPTx:psi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:omega_violations_count">
		<ang_rest_types ang_rest_type="OMEGA" violations_count="{VRPTx:omega_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi1_violations_count">
		<ang_rest_types ang_rest_type="CHI1" violations_count="{VRPTx:chi1_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi2_violations_count">
		<ang_rest_types ang_rest_type="CHI2" violations_count="{VRPTx:chi2_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi3_violations_count">
		<ang_rest_types ang_rest_type="CHI3" violations_count="{VRPTx:chi3_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi4_violations_count">
		<ang_rest_types ang_rest_type="CHI4" violations_count="{VRPTx:chi4_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi5_violations_count">
		<ang_rest_types ang_rest_type="CHI5" violations_count="{VRPTx:chi5_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:alpha_violations_count">
		<ang_rest_types ang_rest_type="ALPHA" violations_count="{VRPTx:alpha_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:beta_violations_count">
		<ang_rest_types ang_rest_type="BETA" violations_count="{VRPTx:beta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:gamma_violations_count">
		<ang_rest_types ang_rest_type="GAMMA" violations_count="{VRPTx:gamma_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:delta_violations_count">
		<ang_rest_types ang_rest_type="DELTA" violations_count="{VRPTx:delta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:epsilon_violations_count">
		<ang_rest_types ang_rest_type="EPSILON" violations_count="{VRPTx:epsilon_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:zeta_violations_count">
		<ang_rest_types ang_rest_type="ZETA" violations_count="{VRPTx:zeta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu0_violations_count">
		<ang_rest_types ang_rest_type="NU0" violations_count="{VRPTx:nu0_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu1_violations_count">
		<ang_rest_types ang_rest_type="NU1" violations_count="{VRPTx:nu1_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu2_violations_count">
		<ang_rest_types ang_rest_type="NU2" violations_count="{VRPTx:nu2_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu3_violations_count">
		<ang_rest_types ang_rest_type="NU3" violations_count="{VRPTx:nu3_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu4_violations_count">
		<ang_rest_types ang_rest_type="NU4" violations_count="{VRPTx:nu4_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi21_violations_count">
		<ang_rest_types ang_rest_type="CHI21" violations_count="{VRPTx:chi21_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi22_violations_count">
		<ang_rest_types ang_rest_type="CHI22" violations_count="{VRPTx:chi22_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi31_violations_count">
		<ang_rest_types ang_rest_type="CHI31" violations_count="{VRPTx:chi31_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi32_violations_count">
		<ang_rest_types ang_rest_type="CHI32" violations_count="{VRPTx:chi32_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi42_violations_count">
		<ang_rest_types ang_rest_type="CHI42" violations_count="{VRPTx:chi42_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi_violations_count">
		<ang_rest_types ang_rest_type="CHI" violations_count="{VRPTx:chi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:eta_violations_count">
		<ang_rest_types ang_rest_type="ETA" violations_count="{VRPTx:eta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:theta_violations_count">
		<ang_rest_types ang_rest_type="THETA" violations_count="{VRPTx:theta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:eta_prime_violations_count">
		<ang_rest_types ang_rest_type="ETA'" violations_count="{VRPTx:eta_prime_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:theta_prime_violations_count">
		<ang_rest_types ang_rest_type="THETA'" violations_count="{VRPTx:theta_prime_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:other_violations_count">
		<ang_rest_types ang_rest_type="." violations_count="{VRPTx:other_violations_count}"/>
	      </xsl:if>
	    </dihedralangle_violations_in_model>
	  </xsl:for-each>
	</dihedralangle_violations_in_models>
      </xsl:when>
      <xsl:otherwise>
	<dihedralangle_violations_in_models/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble">
	<dihedralangle_violations_in_ensemble>
	  <xsl:for-each select="VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble">
	    <dihedralangle_violation_in_ensemble fraction_of_ensemble_count="{@fraction_ensemble_size}" fraction_of_ensemble_percent="{VRPTx:fraction_ensemble_percent}">
	      <xsl:if test="VRPTx:violations_count">
		<ang_rest_types ang_rest_type="Total" violations_count="{VRPTx:violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:phi_violations_count">
		<ang_rest_types ang_rest_type="PHI" violations_count="{VRPTx:phi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:psi_violations_count">
		<ang_rest_types ang_rest_type="PSI" violations_count="{VRPTx:psi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:omega_violations_count">
		<ang_rest_types ang_rest_type="OMEGA" violations_count="{VRPTx:omega_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi1_violations_count">
		<ang_rest_types ang_rest_type="CHI1" violations_count="{VRPTx:chi1_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi2_violations_count">
		<ang_rest_types ang_rest_type="CHI2" violations_count="{VRPTx:chi2_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi3_violations_count">
		<ang_rest_types ang_rest_type="CHI3" violations_count="{VRPTx:chi3_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi4_violations_count">
		<ang_rest_types ang_rest_type="CHI4" violations_count="{VRPTx:chi4_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi5_violations_count">
		<ang_rest_types ang_rest_type="CHI5" violations_count="{VRPTx:chi5_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:alpha_violations_count">
		<ang_rest_types ang_rest_type="ALPHA" violations_count="{VRPTx:alpha_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:beta_violations_count">
		<ang_rest_types ang_rest_type="BETA" violations_count="{VRPTx:beta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:gamma_violations_count">
		<ang_rest_types ang_rest_type="GAMMA" violations_count="{VRPTx:gamma_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:delta_violations_count">
		<ang_rest_types ang_rest_type="DELTA" violations_count="{VRPTx:delta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:epsilon_violations_count">
		<ang_rest_types ang_rest_type="EPSILON" violations_count="{VRPTx:epsilon_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:zeta_violations_count">
		<ang_rest_types ang_rest_type="ZETA" violations_count="{VRPTx:zeta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu0_violations_count">
		<ang_rest_types ang_rest_type="NU0" violations_count="{VRPTx:nu0_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu1_violations_count">
		<ang_rest_types ang_rest_type="NU1" violations_count="{VRPTx:nu1_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu2_violations_count">
		<ang_rest_types ang_rest_type="NU2" violations_count="{VRPTx:nu2_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu3_violations_count">
		<ang_rest_types ang_rest_type="NU3" violations_count="{VRPTx:nu3_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:nu4_violations_count">
		<ang_rest_types ang_rest_type="NU4" violations_count="{VRPTx:nu4_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi21_violations_count">
		<ang_rest_types ang_rest_type="CHI21" violations_count="{VRPTx:chi21_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi22_violations_count">
		<ang_rest_types ang_rest_type="CHI22" violations_count="{VRPTx:chi22_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi31_violations_count">
		<ang_rest_types ang_rest_type="CHI31" violations_count="{VRPTx:chi31_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi32_violations_count">
		<ang_rest_types ang_rest_type="CHI32" violations_count="{VRPTx:chi32_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi42_violations_count">
		<ang_rest_types ang_rest_type="CHI42" violations_count="{VRPTx:chi42_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:chi_violations_count">
		<ang_rest_types ang_rest_type="CHI" violations_count="{VRPTx:chi_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:eta_violations_count">
		<ang_rest_types ang_rest_type="ETA" violations_count="{VRPTx:eta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:theta_violations_count">
		<ang_rest_types ang_rest_type="THETA" violations_count="{VRPTx:theta_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:eta_prime_violations_count">
		<ang_rest_types ang_rest_type="ETA'" violations_count="{VRPTx:eta_prime_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:theta_prime_violations_count">
		<ang_rest_types ang_rest_type="THETA'" violations_count="{VRPTx:theta_prime_violations_count}"/>
	      </xsl:if>
	      <xsl:if test="VRPTx:other_violations_count">
		<ang_rest_types ang_rest_type="." violations_count="{VRPTx:other_violations_count}"/>
	      </xsl:if>
	    </dihedralangle_violation_in_ensemble>
	  </xsl:for-each>
	</dihedralangle_violations_in_ensemble>
      </xsl:when>
      <xsl:otherwise>
	<dihedralangle_violations_in_ensemble/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_plural">
	<most_violated_dihedralangle_restraints>
	  <xsl:for-each select="VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_plural">
	    <xsl:sort select="@ordinal"/>
	    <most_violated_dihedralangle_restraint>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="violated_models"><xsl:value-of select="VRPTx:violation_models_count"/></xsl:attribute>
	      <xsl:attribute name="mean_angle_violation"><xsl:value-of select="VRPTx:average_violation"/></xsl:attribute>
	      <xsl:attribute name="median_violation"><xsl:value-of select="VRPTx:median_violation"/></xsl:attribute>
	      <xsl:attribute name="standard_deviation"><xsl:value-of select="VRPTx:standard_deviation"/></xsl:attribute>
	      <xsl:attribute name="ent_1"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_2"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_3"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_4"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="chain_1"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_2"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_3"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_4"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="resnum_1"><xsl:value-of select="VRPTx:auth_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="resnum_2"><xsl:value-of select="VRPTx:auth_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="resnum_3"><xsl:value-of select="VRPTx:auth_seq_id_3"/></xsl:attribute>
	      <xsl:attribute name="resnum_4"><xsl:value-of select="VRPTx:auth_seq_id_4"/></xsl:attribute>
	      <xsl:attribute name="resname_1"><xsl:value-of select="VRPTx:auth_comp_id_1"/></xsl:attribute>
	      <xsl:attribute name="resname_2"><xsl:value-of select="VRPTx:auth_comp_id_2"/></xsl:attribute>
	      <xsl:attribute name="resname_3"><xsl:value-of select="VRPTx:auth_comp_id_3"/></xsl:attribute>
	      <xsl:attribute name="resname_4"><xsl:value-of select="VRPTx:auth_comp_id_4"/></xsl:attribute>
	      <xsl:attribute name="atom_1"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom_2"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="atom_3"><xsl:value-of select="VRPTx:auth_atom_id_3"/></xsl:attribute>
	      <xsl:attribute name="atom_4"><xsl:value-of select="VRPTx:auth_atom_id_4"/></xsl:attribute>
	      <xsl:attribute name="said_1"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_2"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_3"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_4"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="seq_1"><xsl:value-of select="VRPTx:label_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="seq_2"><xsl:value-of select="VRPTx:label_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="seq_3"><xsl:value-of select="VRPTx:label_seq_id_3"/></xsl:attribute>
	      <xsl:attribute name="seq_4"><xsl:value-of select="VRPTx:label_seq_id_4"/></xsl:attribute>
	      <xsl:attribute name="icode_1"><xsl:value-of select="translate(VRPTx:PDB_ins_code_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_2"><xsl:value-of select="translate(VRPTx:PDB_ins_code_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_3"><xsl:value-of select="translate(VRPTx:PDB_ins_code_3,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_4"><xsl:value-of select="translate(VRPTx:PDB_ins_code_4,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_1"><xsl:value-of select="translate(VRPTx:label_alt_id_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_2"><xsl:value-of select="translate(VRPTx:label_alt_id_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_3"><xsl:value-of select="translate(VRPTx:label_alt_id_3,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_4"><xsl:value-of select="translate(VRPTx:label_alt_id_4,'?.','  ')"/></xsl:attribute>
	    </most_violated_dihedralangle_restraint>
	  </xsl:for-each>
	</most_violated_dihedralangle_restraints>
      </xsl:when>
      <xsl:otherwise>
	<most_violated_dihedralangle_restraints/>
      </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
      <xsl:when test="VRPTx:pdbx_nmr_dihedral_angle_violationCategory/VRPTx:pdbx_nmr_dihedral_angle_violation">
	<violated_dihedralangle_restraints>
	  <xsl:for-each select="VRPTx:pdbx_nmr_dihedral_angle_violationCategory/VRPTx:pdbx_nmr_dihedral_angle_violation">
	    <xsl:sort select="@ordinal"/>
	    <violated_dihedralangle_restraint>
	      <xsl:attribute name="rlist_id"><xsl:value-of select="VRPTx:list_id"/></xsl:attribute>
	      <xsl:attribute name="rest_id"><xsl:value-of select="VRPTx:restraint_id"/></xsl:attribute>
	      <xsl:attribute name="model"><xsl:value-of select="VRPTx:PDB_model_num"/></xsl:attribute>
	      <xsl:attribute name="violation"><xsl:value-of select="VRPTx:violation"/></xsl:attribute>
	      <xsl:attribute name="ent_1"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_2"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_3"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="ent_4"><xsl:value-of select="VRPTx:entity_id"/></xsl:attribute>
	      <xsl:attribute name="chain_1"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_2"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_3"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="chain_4"><xsl:value-of select="VRPTx:auth_asym_id"/></xsl:attribute>
	      <xsl:attribute name="resnum_1"><xsl:value-of select="VRPTx:auth_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="resnum_2"><xsl:value-of select="VRPTx:auth_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="resnum_3"><xsl:value-of select="VRPTx:auth_seq_id_3"/></xsl:attribute>
	      <xsl:attribute name="resnum_4"><xsl:value-of select="VRPTx:auth_seq_id_4"/></xsl:attribute>
	      <xsl:attribute name="resname_1"><xsl:value-of select="VRPTx:auth_comp_id_1"/></xsl:attribute>
	      <xsl:attribute name="resname_2"><xsl:value-of select="VRPTx:auth_comp_id_2"/></xsl:attribute>
	      <xsl:attribute name="resname_3"><xsl:value-of select="VRPTx:auth_comp_id_3"/></xsl:attribute>
	      <xsl:attribute name="resname_4"><xsl:value-of select="VRPTx:auth_comp_id_4"/></xsl:attribute>
	      <xsl:attribute name="atom_1"><xsl:value-of select="VRPTx:auth_atom_id_1"/></xsl:attribute>
	      <xsl:attribute name="atom_2"><xsl:value-of select="VRPTx:auth_atom_id_2"/></xsl:attribute>
	      <xsl:attribute name="atom_3"><xsl:value-of select="VRPTx:auth_atom_id_3"/></xsl:attribute>
	      <xsl:attribute name="atom_4"><xsl:value-of select="VRPTx:auth_atom_id_4"/></xsl:attribute>
	      <xsl:attribute name="said_1"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_2"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_3"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="said_4"><xsl:value-of select="VRPTx:label_asym_id"/></xsl:attribute>
	      <xsl:attribute name="seq_1"><xsl:value-of select="VRPTx:label_seq_id_1"/></xsl:attribute>
	      <xsl:attribute name="seq_2"><xsl:value-of select="VRPTx:label_seq_id_2"/></xsl:attribute>
	      <xsl:attribute name="seq_3"><xsl:value-of select="VRPTx:label_seq_id_3"/></xsl:attribute>
	      <xsl:attribute name="seq_4"><xsl:value-of select="VRPTx:label_seq_id_4"/></xsl:attribute>
	      <xsl:attribute name="icode_1"><xsl:value-of select="translate(VRPTx:PDB_ins_code_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_2"><xsl:value-of select="translate(VRPTx:PDB_ins_code_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_3"><xsl:value-of select="translate(VRPTx:PDB_ins_code_3,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="icode_4"><xsl:value-of select="translate(VRPTx:PDB_ins_code_4,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_1"><xsl:value-of select="translate(VRPTx:label_alt_id_1,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_2"><xsl:value-of select="translate(VRPTx:label_alt_id_2,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_3"><xsl:value-of select="translate(VRPTx:label_alt_id_3,'?.','  ')"/></xsl:attribute>
	      <xsl:attribute name="altcode_4"><xsl:value-of select="translate(VRPTx:label_alt_id_4,'?.','  ')"/></xsl:attribute>
	    </violated_dihedralangle_restraint>
	  </xsl:for-each>
	</violated_dihedralangle_restraints>
      </xsl:when>
      <xsl:otherwise>
	<violated_dihedralangle_restraints/>
      </xsl:otherwise>
      </xsl:choose>

    </dihedralangle_restraints_analysis>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
	<xsl:message terminate="yes">
	  <xsl:text>ERROR in revert_info_from_full.xsl: </xsl:text>
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
