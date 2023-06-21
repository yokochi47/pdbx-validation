--
-- PostgreSQL DDL generated from pdbx-validation-v4.xsd using xsd2pgschema
--  xsd2pgschema - Database replication tool based on XML Schema
--  https://sourceforge.net/projects/xsd2pgschema/
--
-- Schema modeling options:
--  explicit named schema: false
--  relational extension: false
--  inline simple content: true
--  realize simple bridge: false
--  wild card extension: true
--  case sensitive name: true
--  no name collision: true
--  append document key: true (in-place)
--  append serial key: false
--  append xpath key: false
--  retain constraint: false
--  retrieve field annotation: false
--  map integer numbers to: signed int 32 bits
--  map decimal numbers to: big decimal
--  map xsd date type to: sql date type
--
-- Statistics of schema:
--  Generated 282 tables (3702 fields), 0 views (0 fields), 0 attr groups, 0 model groups in total
--   Unnecessary tables by inlining simple content as a primitive data type:
--    schema location: pdbx-validation-v4.xsd
--      improper_torsion_angle_rms_dev_error, mean_guiner_radius, angle_value, bond_angle_rms_dev, "B_iso", diff_density_max_esd, "L22", "B_calc", distance_rms_dev, "B_calc_au", pdbx_phase_calc_part_solvent, improper_torsion_angle_rms_dev, "S22_esd", atom_deviation, "S31", "A_meas", "pdbx_F_calc_part_solvent", upper_limit, psi, "L23", prot_cis, "L11", "L23_esd", "T23_esd", "F_meas_au", "sigmaI", omega, "S32", "Luzzati_sigma_a_free", "F_squared_calc", "L12", distance_rms_dev_medoid, pdbx_solvent_shrinkage_radii, current, chi1, pdbx_rotation_angle, chi2, chi3, chi4, chi5, "S21", "S33", scan_time_backgd, maximum_upper_distance_constraint_violation, pdbx_scan_angle, "L13", "A_calc", "T12_esd", "S12_esd", "Luzzati_d_res_low_free", value, "B_meas", "S22", value_esd, "Cartn_y_esd", pdbx_solvent_vdw_probe_radii, "S13_esd", "B_meas_au", origin_y, origin_z, origin_x, "Cartn_z_esd", peptide_planarity_rms_dev, "P", phi, pdbx_collection_time_total, dihedral_angle_value, "B_iso_Wilson_estimate", zeta, maximum_lower_distance_constraint_violation, energyfilter_lower, "S11", "S23", nu1, "F_meas_sigma", nu2, nu3, "L12_esd", "F_calc_au", diff_density_min, nu4, nu0, "T33", tilt_angle_min, phase_meas, nominal_defocus_min, "S32_esd", "S12", calibrated_defocus_min, rise_per_n_subunits, "aniso_B33", "Luzzati_d_res_low_obs", pdbx_solvent_ion_probe_radii, "Luzzati_coordinate_error_free", "T22", lower_limit, "Luzzati_coordinate_error_obs", "S13", "T11_esd", "L11_esd", "aniso_B22", "S23_esd", concentration_range, "T23", max_mean_cross_sectional_radii_gyration_esd, "T11", clash_magnitude, angle_target_value, dihedral_angles_rms_dev, min_mean_cross_sectional_radii_gyration_esd, "L22_esd", neighbor_ligand_distance, tau0, "S21_esd", tau1, "aniso_B11", "aniso_B23", average_distance_constraint_violation, "B_iso_esd", maximum_distance_constraint_violation, "T12", max_mean_cross_sectional_radii_gyration, "A_calc_au", "S33_esd", "pdbx_F_calc_with_solvent", phase_calc, bond_angle_rms_dev_error, nominal_defocus_max, "aniso_B12", "B_iso_max", bond_deviation, angle_phi, min_mean_cross_sectional_radii_gyration, "T13", delta, distance_rms_dev_error, "B_iso_mean", energyfilter_upper, covalent_bond_rms_dev, "F_squared_meas", epsilon, "aniso_B13", angle_theta, "F_meas_sigma_au", mean_guiner_radius_esd, angle_deviation, dihedral_angles_rms_dev_error, "T22_esd", peptide_planarity_rms_dev_error, "pdbx_res_netI_over_sigmaI_2", "Luzzati_sigma_a_obs", "Cartn_z", detector_distance, "S31_esd", beta, "L13_esd", "F_squared_sigma", voltage, angle_kappa, ambient_pressure_esd, "T13_esd", gamma, rotation_per_n_subunits, "Cartn_y", temp, covalent_bond_rms_dev_error, rmsd, "S11_esd", temperature, "A_meas_au", alpha, "Cartn_x_esd", "Cartn_x", "F_calc", power, diff_density_min_esd, ambient_temp_esd, neighbor_macromolecule_distance, "I", diff_density_max, angle_psi, "L33_esd", dihedral_angle_target_value, taum, angle_omega, pdbx_dist_value, scan_rate, "T33_esd", tau2, tau3, tau4, "B_iso_min", pdbx_phase_calc_with_solvent, tilt_angle_max, "F_meas", angle_chi, diff_density_rms_esd, average_torsion_angle_constraint_violation, maximum_torsion_angle_constraint_violation, "L33", diff_density_rms, dist, improper_torsion_angle, "pdbx_res_netI_over_av_sigmaI_2"
--   Namespaces:
--    http://www.w3.org/2001/XMLSchema (xsd), http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx)
--   Schema locations:
--    pdbx-validation-v4.xsd
--   Table types:
--    0 root, 0 root children, 0 admin roots, 282 admin children
--   System keys:
--    0 primary keys (0 unique constraints), 0 foreign keys, 0 nested keys (0 as attribute, 0 as attribute group)
--   User keys:
--    234 document keys, 0 serial keys, 0 xpath keys
--   Contents:
--    495 attributes (43 in-place document keys), 2973 elements (5 in-place document keys), 0 simple contents (0 in-place document keys, 0 as attribute, 0 as conditional attribute)
--   Wild cards:
--    0 any elements, 0 any attributes
--   Constraints:
--    282 unique constraints from xsd:key, 1 unique constraints from xsd:unique, 148 foreign key constraints from xsd:keyref
--

--
-- VRPT PDBML Schema v4.370
-- VRPT PDBML Schema translated from wwPDB Validation Information Dictionary v4.370, which is backward compatible with the PDBx/mmCIF Dictionary v5.370: http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic
-- URI-reference = http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd
--

DROP TABLE IF EXISTS diffrn_attenuator CASCADE;
DROP TABLE IF EXISTS diffrn_detector CASCADE;
DROP TABLE IF EXISTS diffrn_measurement CASCADE;
DROP TABLE IF EXISTS diffrn_orient_matrix CASCADE;
DROP TABLE IF EXISTS diffrn_orient_refln CASCADE;
DROP TABLE IF EXISTS diffrn_radiation CASCADE;
DROP TABLE IF EXISTS diffrn_radiation_wavelength CASCADE;
DROP TABLE IF EXISTS diffrn_refln CASCADE;
DROP TABLE IF EXISTS diffrn_reflns CASCADE;
DROP TABLE IF EXISTS diffrn_reflns_class CASCADE;
DROP TABLE IF EXISTS diffrn_scale_group CASCADE;
DROP TABLE IF EXISTS diffrn_source CASCADE;
DROP TABLE IF EXISTS diffrn_standard_refln CASCADE;
DROP TABLE IF EXISTS diffrn_standards CASCADE;
DROP TABLE IF EXISTS em_2d_crystal_entity CASCADE;
DROP TABLE IF EXISTS em_3d_crystal_entity CASCADE;
DROP TABLE IF EXISTS em_3d_fitting CASCADE;
DROP TABLE IF EXISTS em_3d_fitting_list CASCADE;
DROP TABLE IF EXISTS em_3d_reconstruction CASCADE;
DROP TABLE IF EXISTS em_admin CASCADE;
DROP TABLE IF EXISTS em_buffer CASCADE;
DROP TABLE IF EXISTS em_buffer_component CASCADE;
DROP TABLE IF EXISTS em_crystal_formation CASCADE;
DROP TABLE IF EXISTS em_ctf_correction CASCADE;
DROP TABLE IF EXISTS em_diffraction CASCADE;
DROP TABLE IF EXISTS em_diffraction_shell CASCADE;
DROP TABLE IF EXISTS em_diffraction_stats CASCADE;
DROP TABLE IF EXISTS em_embedding CASCADE;
DROP TABLE IF EXISTS em_entity_assembly_molwt CASCADE;
DROP TABLE IF EXISTS em_entity_assembly_naturalsource CASCADE;
DROP TABLE IF EXISTS em_entity_assembly_recombinant CASCADE;
DROP TABLE IF EXISTS em_entity_assembly_synthetic CASCADE;
DROP TABLE IF EXISTS em_experiment CASCADE;
DROP TABLE IF EXISTS em_helical_entity CASCADE;
DROP TABLE IF EXISTS em_image_processing CASCADE;
DROP TABLE IF EXISTS em_image_recording CASCADE;
DROP TABLE IF EXISTS em_image_scans CASCADE;
DROP TABLE IF EXISTS em_imaging CASCADE;
DROP TABLE IF EXISTS em_imaging_optics CASCADE;
DROP TABLE IF EXISTS em_particle_selection CASCADE;
DROP TABLE IF EXISTS em_single_particle_entity CASCADE;
DROP TABLE IF EXISTS em_software CASCADE;
DROP TABLE IF EXISTS em_specimen CASCADE;
DROP TABLE IF EXISTS em_staining CASCADE;
DROP TABLE IF EXISTS em_virus_entity CASCADE;
DROP TABLE IF EXISTS em_virus_natural_host CASCADE;
DROP TABLE IF EXISTS em_virus_shell CASCADE;
DROP TABLE IF EXISTS em_virus_synthetic CASCADE;
DROP TABLE IF EXISTS em_vitrification CASCADE;
DROP TABLE IF EXISTS em_volume_selection CASCADE;
DROP TABLE IF EXISTS entity_name_com CASCADE;
DROP TABLE IF EXISTS entity_name_sys CASCADE;
DROP TABLE IF EXISTS entry_link CASCADE;
DROP TABLE IF EXISTS exptl CASCADE;
DROP TABLE IF EXISTS ndb_struct_conf_na CASCADE;
DROP TABLE IF EXISTS ndb_struct_na_base_pair CASCADE;
DROP TABLE IF EXISTS ndb_struct_na_base_pair_step CASCADE;
DROP TABLE IF EXISTS pdbx_audit_author CASCADE;
DROP TABLE IF EXISTS pdbx_audit_revision_category CASCADE;
DROP TABLE IF EXISTS pdbx_audit_revision_details CASCADE;
DROP TABLE IF EXISTS pdbx_audit_revision_group CASCADE;
DROP TABLE IF EXISTS pdbx_audit_revision_item CASCADE;
DROP TABLE IF EXISTS pdbx_bond_distance_limits CASCADE;
DROP TABLE IF EXISTS pdbx_branch_scheme CASCADE;
DROP TABLE IF EXISTS pdbx_coordinate_model CASCADE;
DROP TABLE IF EXISTS pdbx_database_related CASCADE;
DROP TABLE IF EXISTS pdbx_database_status CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_density CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_density_corr CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_entity_geometry CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_geometry CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_map CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_map_overall CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_mapman CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_mon_geometry CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_rscc_mapman CASCADE;
DROP TABLE IF EXISTS pdbx_dcc_rscc_mapman_overall CASCADE;
DROP TABLE IF EXISTS pdbx_diffrn_reflns_shell CASCADE;
DROP TABLE IF EXISTS pdbx_distant_solvent_atoms CASCADE;
DROP TABLE IF EXISTS pdbx_domain_range CASCADE;
DROP TABLE IF EXISTS pdbx_em_atom_inclusion_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_density_distribution_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_fsc_curve_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_fsc_cutoff_curve_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_fsc_resolution CASCADE;
DROP TABLE IF EXISTS pdbx_em_raps_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_raw_raps_marker CASCADE;
DROP TABLE IF EXISTS pdbx_em_validate_map_model CASCADE;
DROP TABLE IF EXISTS pdbx_em_validate_map_model_entity CASCADE;
DROP TABLE IF EXISTS pdbx_em_validate_map_model_overall CASCADE;
DROP TABLE IF EXISTS pdbx_em_volume_estimate_marker CASCADE;
DROP TABLE IF EXISTS pdbx_entity_assembly CASCADE;
DROP TABLE IF EXISTS pdbx_entity_branch CASCADE;
DROP TABLE IF EXISTS pdbx_entity_branch_descriptor CASCADE;
DROP TABLE IF EXISTS pdbx_entity_branch_link CASCADE;
DROP TABLE IF EXISTS pdbx_entity_branch_list CASCADE;
DROP TABLE IF EXISTS pdbx_entity_descriptor CASCADE;
DROP TABLE IF EXISTS pdbx_entity_nonpoly CASCADE;
DROP TABLE IF EXISTS pdbx_entity_poly_comp_link_list CASCADE;
DROP TABLE IF EXISTS pdbx_entry_details CASCADE;
DROP TABLE IF EXISTS pdbx_helical_symmetry CASCADE;
DROP TABLE IF EXISTS pdbx_missing_nmr_star_item CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_chem_shift_annotation CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_chem_shift_completeness CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_chem_shift_re_offset CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_constraints CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_details CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_dihedral_angle_violation CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_dihedral_angle_violation_ensemble CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_dihedral_angle_violation_model CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_dihedral_angle_violation_plural CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_dihedral_angle_violation_summary CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_distance_violation CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_distance_violation_ensemble CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_distance_violation_model CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_distance_violation_plural CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_distance_violation_summary CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_ensemble CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_ensemble_rms CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_exptl CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_exptl_sample CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_exptl_sample_conditions CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_force_constants CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_refine CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_representative CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_restraint_list CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_restraint_summary CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_restraint_violation CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_software CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_spectrometer CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_unmapped_chem_shift CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_unparsed_chem_shift CASCADE;
DROP TABLE IF EXISTS pdbx_nonpoly_scheme CASCADE;
DROP TABLE IF EXISTS pdbx_percentile_entity_view CASCADE;
DROP TABLE IF EXISTS pdbx_percentile_list CASCADE;
DROP TABLE IF EXISTS pdbx_percentile_view CASCADE;
DROP TABLE IF EXISTS "pdbx_phasing_MAD_set" CASCADE;
DROP TABLE IF EXISTS "pdbx_phasing_MAD_set_shell" CASCADE;
DROP TABLE IF EXISTS "pdbx_phasing_MAD_set_site" CASCADE;
DROP TABLE IF EXISTS "pdbx_phasing_MAD_shell" CASCADE;
DROP TABLE IF EXISTS "pdbx_phasing_MR" CASCADE;
DROP TABLE IF EXISTS pdbx_phasing_dm CASCADE;
DROP TABLE IF EXISTS pdbx_phasing_dm_shell CASCADE;
DROP TABLE IF EXISTS pdbx_point_symmetry CASCADE;
DROP TABLE IF EXISTS pdbx_poly_seq_scheme CASCADE;
DROP TABLE IF EXISTS pdbx_re_refinement CASCADE;
DROP TABLE IF EXISTS pdbx_refine CASCADE;
DROP TABLE IF EXISTS pdbx_refine_component CASCADE;
DROP TABLE IF EXISTS pdbx_refine_tls_group CASCADE;
DROP TABLE IF EXISTS pdbx_refln_signal_binning CASCADE;
DROP TABLE IF EXISTS pdbx_reflns_twin CASCADE;
DROP TABLE IF EXISTS pdbx_sequence_range CASCADE;
DROP TABLE IF EXISTS pdbx_sifts_unp_segments CASCADE;
DROP TABLE IF EXISTS pdbx_sifts_xref_db CASCADE;
DROP TABLE IF EXISTS pdbx_sifts_xref_db_segments CASCADE;
DROP TABLE IF EXISTS pdbx_soln_scatter CASCADE;
DROP TABLE IF EXISTS pdbx_soln_scatter_model CASCADE;
DROP TABLE IF EXISTS pdbx_struct_assembly_gen CASCADE;
DROP TABLE IF EXISTS pdbx_struct_assembly_prop CASCADE;
DROP TABLE IF EXISTS pdbx_struct_asym_gen CASCADE;
DROP TABLE IF EXISTS pdbx_struct_chem_comp_diagnostics CASCADE;
DROP TABLE IF EXISTS pdbx_struct_conn_angle CASCADE;
DROP TABLE IF EXISTS pdbx_struct_group_component_range CASCADE;
DROP TABLE IF EXISTS pdbx_struct_group_components CASCADE;
DROP TABLE IF EXISTS pdbx_struct_info CASCADE;
DROP TABLE IF EXISTS pdbx_struct_legacy_oper_list CASCADE;
DROP TABLE IF EXISTS pdbx_struct_mod_residue CASCADE;
DROP TABLE IF EXISTS pdbx_struct_msym_gen CASCADE;
DROP TABLE IF EXISTS pdbx_struct_nmr_ens_clust CASCADE;
DROP TABLE IF EXISTS pdbx_struct_nmr_ens_clust_gen CASCADE;
DROP TABLE IF EXISTS pdbx_struct_nmr_ens_dom_lim CASCADE;
DROP TABLE IF EXISTS pdbx_struct_oper_list CASCADE;
DROP TABLE IF EXISTS pdbx_struct_ref_seq_deletion CASCADE;
DROP TABLE IF EXISTS pdbx_struct_ref_seq_insertion CASCADE;
DROP TABLE IF EXISTS pdbx_struct_sheet_hbond CASCADE;
DROP TABLE IF EXISTS pdbx_struct_special_symmetry CASCADE;
DROP TABLE IF EXISTS pdbx_unobs_or_zero_occ_atoms CASCADE;
DROP TABLE IF EXISTS pdbx_unobs_or_zero_occ_residues CASCADE;
DROP TABLE IF EXISTS pdbx_validate_chiral CASCADE;
DROP TABLE IF EXISTS pdbx_validate_close_contact CASCADE;
DROP TABLE IF EXISTS pdbx_validate_main_chain_plane CASCADE;
DROP TABLE IF EXISTS pdbx_validate_nmr_chem_shift CASCADE;
DROP TABLE IF EXISTS pdbx_validate_peptide_omega CASCADE;
DROP TABLE IF EXISTS pdbx_validate_planes_atom CASCADE;
DROP TABLE IF EXISTS pdbx_validate_polymer_linkage CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_angle CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_bond CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_rings_atom CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_torsions_atom CASCADE;
DROP TABLE IF EXISTS pdbx_validate_symm_contact CASCADE;
DROP TABLE IF EXISTS pdbx_validate_torsion CASCADE;
DROP TABLE IF EXISTS pdbx_validation_software CASCADE;
DROP TABLE IF EXISTS phasing CASCADE;
DROP TABLE IF EXISTS "phasing_MAD" CASCADE;
DROP TABLE IF EXISTS "phasing_MAD_clust" CASCADE;
DROP TABLE IF EXISTS "phasing_MAD_ratio" CASCADE;
DROP TABLE IF EXISTS "phasing_MAD_set" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR_der_refln" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR_der_shell" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR_der_site" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR_shell" CASCADE;
DROP TABLE IF EXISTS phasing_averaging CASCADE;
DROP TABLE IF EXISTS phasing_isomorphous CASCADE;
DROP TABLE IF EXISTS phasing_set_refln CASCADE;
DROP TABLE IF EXISTS refine CASCADE;
DROP TABLE IF EXISTS "refine_B_iso" CASCADE;
DROP TABLE IF EXISTS refine_analyze CASCADE;
DROP TABLE IF EXISTS refine_funct_minimized CASCADE;
DROP TABLE IF EXISTS refine_hist CASCADE;
DROP TABLE IF EXISTS refine_ls_class CASCADE;
DROP TABLE IF EXISTS refine_ls_restr CASCADE;
DROP TABLE IF EXISTS refine_ls_restr_ncs CASCADE;
DROP TABLE IF EXISTS refine_ls_restr_type CASCADE;
DROP TABLE IF EXISTS refine_ls_shell CASCADE;
DROP TABLE IF EXISTS refine_occupancy CASCADE;
DROP TABLE IF EXISTS refln CASCADE;
DROP TABLE IF EXISTS refln_sys_abs CASCADE;
DROP TABLE IF EXISTS reflns CASCADE;
DROP TABLE IF EXISTS reflns_class CASCADE;
DROP TABLE IF EXISTS reflns_scale CASCADE;
DROP TABLE IF EXISTS reflns_shell CASCADE;
DROP TABLE IF EXISTS space_group CASCADE;
DROP TABLE IF EXISTS space_group_symop CASCADE;
DROP TABLE IF EXISTS struct CASCADE;
DROP TABLE IF EXISTS struct_biol_view CASCADE;
DROP TABLE IF EXISTS struct_conf CASCADE;
DROP TABLE IF EXISTS struct_conn CASCADE;
DROP TABLE IF EXISTS struct_conn_type CASCADE;
DROP TABLE IF EXISTS struct_mon_details CASCADE;
DROP TABLE IF EXISTS struct_mon_nucl CASCADE;
DROP TABLE IF EXISTS struct_mon_prot CASCADE;
DROP TABLE IF EXISTS struct_mon_prot_cis CASCADE;
DROP TABLE IF EXISTS struct_ncs_dom_lim CASCADE;
DROP TABLE IF EXISTS struct_ncs_ens_gen CASCADE;
DROP TABLE IF EXISTS struct_ref_seq_dif CASCADE;
DROP TABLE IF EXISTS struct_sheet_hbond CASCADE;
DROP TABLE IF EXISTS struct_sheet_order CASCADE;
DROP TABLE IF EXISTS struct_sheet_range CASCADE;
DROP TABLE IF EXISTS struct_sheet_topology CASCADE;
DROP TABLE IF EXISTS struct_site_gen CASCADE;
DROP TABLE IF EXISTS struct_site_view CASCADE;
DROP TABLE IF EXISTS symmetry CASCADE;
DROP TABLE IF EXISTS symmetry_equiv CASCADE;
DROP TABLE IF EXISTS pdbx_domain CASCADE;
DROP TABLE IF EXISTS pdbx_em_atom_inclusion CASCADE;
DROP TABLE IF EXISTS pdbx_em_density_distribution CASCADE;
DROP TABLE IF EXISTS pdbx_em_raps CASCADE;
DROP TABLE IF EXISTS pdbx_em_raw_raps CASCADE;
DROP TABLE IF EXISTS pdbx_em_volume_estimate CASCADE;
DROP TABLE IF EXISTS pdbx_refine_tls CASCADE;
DROP TABLE IF EXISTS pdbx_struct_assembly CASCADE;
DROP TABLE IF EXISTS pdbx_struct_nmr_ens_dom CASCADE;
DROP TABLE IF EXISTS pdbx_validate_planes CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_ring CASCADE;
DROP TABLE IF EXISTS pdbx_validate_rmsd_torsion CASCADE;
DROP TABLE IF EXISTS struct_conf_type CASCADE;
DROP TABLE IF EXISTS struct_ncs_dom CASCADE;
DROP TABLE IF EXISTS struct_ncs_oper CASCADE;
DROP TABLE IF EXISTS struct_ref_seq CASCADE;
DROP TABLE IF EXISTS entity_poly_seq CASCADE;
DROP TABLE IF EXISTS pdbx_em_fsc_curve CASCADE;
DROP TABLE IF EXISTS pdbx_em_fsc_cutoff_curve CASCADE;
DROP TABLE IF EXISTS pdbx_percentile_conditions CASCADE;
DROP TABLE IF EXISTS pdbx_struct_entity_inst CASCADE;
DROP TABLE IF EXISTS pdbx_struct_group_list CASCADE;
DROP TABLE IF EXISTS struct_biol CASCADE;
DROP TABLE IF EXISTS struct_ref CASCADE;
DROP TABLE IF EXISTS struct_site CASCADE;
DROP TABLE IF EXISTS entity_poly CASCADE;
DROP TABLE IF EXISTS "phasing_MAD_expt" CASCADE;
DROP TABLE IF EXISTS "phasing_MIR_der" CASCADE;
DROP TABLE IF EXISTS struct_ncs_ens CASCADE;
DROP TABLE IF EXISTS pdbx_audit_revision_history CASCADE;
DROP TABLE IF EXISTS struct_asym CASCADE;
DROP TABLE IF EXISTS struct_sheet CASCADE;
DROP TABLE IF EXISTS pdbx_nmr_assigned_chem_shift_list CASCADE;
DROP TABLE IF EXISTS phasing_set CASCADE;
DROP TABLE IF EXISTS em_entity_assembly CASCADE;
DROP TABLE IF EXISTS diffrn CASCADE;
DROP TABLE IF EXISTS entity CASCADE;
DROP TABLE IF EXISTS entry CASCADE;

--
-- (quoted from entryType)
-- There is only one item in the ENTRY category, attribute id in category entry. This data item gives a name to this entry and is indirectly a key to the categories (such as CELL, GEOM, EXPTL) that describe information pertinent to the entire data block. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entryCategory> <VRPTx:entry id="5HVP"></VRPTx:entry> </VRPTx:entryCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:entryCategory> <VRPTx:entry id="TOZ"></VRPTx:entry> </VRPTx:entryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE entry (
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	id TEXT NOT NULL
);

--
-- (quoted from entityType)
-- Data items in the ENTITY category record details (such as chemical composition, name and source) about the molecular entities that are present in the crystallographic structure. Items in the various ENTITY subcategories provide a full chemical description of these molecular entities. Entities are of three types: polymer, non-polymer and water. Note that the water category includes only water; ordered solvent such as sulfate ion or acetone would be described as individual non-polymer entities. The ENTITY category is specific to macromolecular CIF applications and replaces the function of the CHEMICAL category in the CIF core. It is important to remember that the ENTITY data are not the result of the crystallographic experiment; those results are represented by the ATOM_SITE data items. ENTITY data items describe the chemistry of the molecules under investigation and can most usefully be thought of as the ideal groups to which the structure is restrained or constrained during refinement. It is also important to remember that entities do not correspond directly to the enumeration of the contents of the asymmetric unit. Entities are described only once, even in those structures that contain multiple observations of an entity. The STRUCT_ASYM data items, which reference the entity list, describe and label the contents of the asymmetric unit. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entityCategory> <VRPTx:entity id="1"> <VRPTx:details> The enzymatically competent form of HIV protease is a dimer. This entity corresponds to one monomer of an active dimer.</VRPTx:details> <VRPTx:formula_weight>10916</VRPTx:formula_weight> <VRPTx:type>polymer</VRPTx:type> </VRPTx:entity> <VRPTx:entity id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:formula_weight>762</VRPTx:formula_weight> <VRPTx:type>non-polymer</VRPTx:type> </VRPTx:entity> <VRPTx:entity id="3"> <VRPTx:details xsi:nil="true" /> <VRPTx:formula_weight>18</VRPTx:formula_weight> <VRPTx:type>water</VRPTx:type> </VRPTx:entity> </VRPTx:entityCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_entity_pdbx_formula_weight_exptl_method CASCADE;
CREATE TYPE ENUM_entity_pdbx_formula_weight_exptl_method AS ENUM ( 'MASS SPEC' );
DROP TYPE IF EXISTS ENUM_entity_src_method CASCADE;
CREATE TYPE ENUM_entity_src_method AS ENUM ( 'nat', 'man', 'syn' );
DROP TYPE IF EXISTS ENUM_entity_type CASCADE;
CREATE TYPE ENUM_entity_type AS ENUM ( 'polymer', 'non-polymer', 'macrolide', 'water', 'branched' );
CREATE TABLE entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- xsd:restriction/xsd:minInclusive="1.0"
	formula_weight DECIMAL CHECK ( formula_weight >= 1.0 ) ,
	pdbx_description TEXT ,
	pdbx_ec TEXT ,
-- xsd:restriction/xsd:minInclusive="1.0"
	pdbx_formula_weight_exptl DECIMAL CHECK ( pdbx_formula_weight_exptl >= 1.0 ) ,
	pdbx_formula_weight_exptl_method ENUM_entity_pdbx_formula_weight_exptl_method ,
	pdbx_fragment TEXT ,
	pdbx_modification TEXT ,
	pdbx_mutation TEXT ,
	pdbx_number_of_molecules INTEGER ,
	pdbx_parent_entity_id TEXT ,
	src_method ENUM_entity_src_method ,
	type ENUM_entity_type ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from diffrnType)
-- Data items in the DIFFRN category record details about the diffraction data and their measurement. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrnCategory> <VRPTx:diffrn id="Set1"> <VRPTx:ambient_environment> Mother liquor from the reservoir of the vapor diffusion experiment, mounted in room air</VRPTx:ambient_environment> <VRPTx:ambient_temp>293.0</VRPTx:ambient_temp> <VRPTx:crystal_support> 0.7 mm glass capillary, sealed with dental wax</VRPTx:crystal_support> <VRPTx:crystal_treatment> Equilibrated in rotating anode radiation enclosure for 18 hours prior to beginning of data collection</VRPTx:crystal_treatment> </VRPTx:diffrn> </VRPTx:diffrnCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [(1991). Acta Cryst. C47, 2276-2277]. <VRPTx:diffrnCategory> <VRPTx:diffrn id="d1"> <VRPTx:ambient_temp>293</VRPTx:ambient_temp> <VRPTx:details> \q scan width (1.0 + 0.14tan\q)\&#37;, \q scan rate 1.2\&#37; per min. Background counts for 5 sec on each side every scan.</VRPTx:details> </VRPTx:diffrn> </VRPTx:diffrnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ambient_environment TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_pressure DECIMAL CHECK ( ambient_pressure >= 0.0 ) ,
-- omit an attribute having a fixed value: @units="kilopascals"
	ambient_pressure_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_pressure_gt DECIMAL CHECK ( ambient_pressure_gt >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_pressure_lt DECIMAL CHECK ( ambient_pressure_lt >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="450.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_temp DECIMAL CHECK ( ambient_temp >= 0.0 AND ambient_temp <= 450.0 ) ,
	ambient_temp_details TEXT ,
-- omit an attribute having a fixed value: @units="kelvins"
	ambient_temp_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_temp_gt DECIMAL CHECK ( ambient_temp_gt >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ambient_temp_lt DECIMAL CHECK ( ambient_temp_lt >= 0.0 ) ,
	crystal_id TEXT ,
	crystal_support TEXT ,
	crystal_treatment TEXT ,
	details TEXT ,
	pdbx_serial_crystal_experiment TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_entity_assemblyType)
-- Data items in the EM_ENTITY_ASSEMBLY category record details about each component of the complex. Example 1 - based on PDB entry 1C2W <VRPTx:em_entity_assemblyCategory> <VRPTx:em_entity_assembly id="1"> <VRPTx:name>50S Ribosomal Subunit</VRPTx:name> <VRPTx:parent_id>0</VRPTx:parent_id> <VRPTx:type>RIBOSOME</VRPTx:type> </VRPTx:em_entity_assembly> </VRPTx:em_entity_assemblyCategory> Example 2 - based on PDB entry 3IY7 <VRPTx:em_entity_assemblyCategory> <VRPTx:em_entity_assembly id="1"> <VRPTx:name>Fab fragment from MAb F interacting with feline panleukopenia virus (FPV)</VRPTx:name> <VRPTx:parent_id>0</VRPTx:parent_id> <VRPTx:type>COMPLEX</VRPTx:type> </VRPTx:em_entity_assembly> <VRPTx:em_entity_assembly id="2"> <VRPTx:name>feline panleukopenia virus</VRPTx:name> <VRPTx:parent_id>1</VRPTx:parent_id> <VRPTx:synonym>FPV</VRPTx:synonym> <VRPTx:type>VIRUS</VRPTx:type> </VRPTx:em_entity_assembly> <VRPTx:em_entity_assembly id="3"> <VRPTx:name>Fab fragment from Mab F</VRPTx:name> <VRPTx:parent_id>1</VRPTx:parent_id> <VRPTx:synonym>Fab</VRPTx:synonym> <VRPTx:type>COMPLEX</VRPTx:type> </VRPTx:em_entity_assembly> </VRPTx:em_entity_assemblyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_entity_assembly.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_entity_assembly_source CASCADE;
CREATE TYPE ENUM_em_entity_assembly_source AS ENUM ( 'NATURAL', 'RECOMBINANT', 'MULTIPLE SOURCES', 'SYNTHETIC' );
CREATE TABLE em_entity_assembly (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	entity_id_list TEXT ,
	name TEXT ,
	oligomeric_details TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	parent_id INTEGER CHECK ( parent_id >= 0 ) ,
	source ENUM_em_entity_assembly_source ,
	synonym TEXT ,
	type TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_assigned_chem_shift_listType)
-- Items in the PDBX_NMR_ASSIGNED_CHEM_SHIFT_LIST category provide information about a list of reported assigned chemical shift values.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_assigned_chem_shift_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_assigned_chem_shift_list_nmr_star_consistency_fla CASCADE;
CREATE TYPE ENUM_pdbx_nmr_assigned_chem_shift_list_nmr_star_consistency_fla AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_nmr_assigned_chem_shift_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"chem_shift_13C_err" DECIMAL ,
	"chem_shift_15N_err" DECIMAL ,
	"chem_shift_19F_err" DECIMAL ,
	"chem_shift_1H_err" DECIMAL ,
	"chem_shift_2H_err" DECIMAL ,
	"chem_shift_31P_err" DECIMAL ,
	data_file_name TEXT ,
	label TEXT ,
	nmr_star_consistency_flag ENUM_pdbx_nmr_assigned_chem_shift_list_nmr_star_consistency_fla ,
-- xsd:restriction/xsd:minInclusive="0"
	number_chem_shifts INTEGER CHECK ( number_chem_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_map_errors INTEGER CHECK ( number_map_errors >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_map_warnings INTEGER CHECK ( number_map_warnings >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_mapped_chem_shifts INTEGER CHECK ( number_mapped_chem_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_parsed_chem_shifts INTEGER CHECK ( number_parsed_chem_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_unparsed_chem_shifts INTEGER CHECK ( number_unparsed_chem_shifts >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from phasing_setType)
-- Data items in the PHASING_SET category record details about the data sets used in a phasing experiment. A given data set may be used in a number of different ways; for instance, a single data set could be used both as an isomorphous derivative and as a component of a multiple-wavelength calculation. This category establishes identifiers for each data set and permits the archiving of a subset of experimental information for each data set (cell constants, wavelength, temperature etc.). This and related categories of data items are provided so that derivative intensity and phase information can be stored in the same data block as the information for the refined structure. If all the possible experimental information for each data set (raw data sets, crystal growth conditions etc.) is to be archived, these data items should be recorded in a separate data block. Example 1 - based on laboratory records for an Hg/Pt derivative of protein NS1. <VRPTx:phasing_setCategory> <VRPTx:phasing_set id="NS1-96"> <VRPTx:cell_angle_alpha>90.0</VRPTx:cell_angle_alpha> <VRPTx:cell_angle_beta>90.0</VRPTx:cell_angle_beta> <VRPTx:cell_angle_gamma>90.0</VRPTx:cell_angle_gamma> <VRPTx:cell_length_a>38.63</VRPTx:cell_length_a> <VRPTx:cell_length_b>38.63</VRPTx:cell_length_b> <VRPTx:cell_length_c>82.88</VRPTx:cell_length_c> <VRPTx:detector_specific>RXII</VRPTx:detector_specific> <VRPTx:detector_type>image plate</VRPTx:detector_type> <VRPTx:radiation_wavelength>1.5145</VRPTx:radiation_wavelength> </VRPTx:phasing_set> </VRPTx:phasing_setCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_set.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE phasing_set (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_angle_alpha DECIMAL CHECK ( cell_angle_alpha >= 0.0 AND cell_angle_alpha <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_angle_beta DECIMAL CHECK ( cell_angle_beta >= 0.0 AND cell_angle_beta <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_angle_gamma DECIMAL CHECK ( cell_angle_gamma >= 0.0 AND cell_angle_gamma <= 180.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_length_a DECIMAL CHECK ( cell_length_a >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_length_b DECIMAL CHECK ( cell_length_b >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	cell_length_c DECIMAL CHECK ( cell_length_c >= 0.0 ) ,
	detector_specific TEXT ,
	detector_type TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_d_res_high DECIMAL CHECK ( pdbx_d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_d_res_low DECIMAL CHECK ( pdbx_d_res_low >= 0.0 ) ,
	pdbx_temp_details TEXT ,
	radiation_source_specific TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	radiation_wavelength DECIMAL CHECK ( radiation_wavelength >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	temp DECIMAL CHECK ( temp >= 0.0 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_sheetType)
-- Data items in the STRUCT_SHEET category record details about the beta-sheets. Example 1 - simple beta-barrel. N O N O N O N O N O N O 10--11--12--13--14--15--16--17--18--19--20 strand_a N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 30--31--32--33--34--35--36--37--38--39--40 strand_b N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 50--51--52--53--54--55--56--57--58--59--60 strand_c N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 70--71--72--73--74--75--76--77--78--79--80 strand_d N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 90--91--92--93--94--95--96--97--98--99-100 strand_e N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 110-111-112-113-114-115-116-117-118-119-120 strand_f N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 130-131-132-133-134-135-136-137-138-139-140 strand_g N O N O N O N O N O / \ / \ / \ / \ / \ N O N O N O N O N O N O 150-151-152-153-154-155-156-157-158-159-160 strand_h N O N O N O N O N O / \ / \ / \ / \ / \ <VRPTx:struct_sheetCategory> <VRPTx:struct_sheet id="sheet_1"> <VRPTx:details xsi:nil="true" /> <VRPTx:number_strands>8</VRPTx:number_strands> <VRPTx:type>beta-barrel</VRPTx:type> </VRPTx:struct_sheet> </VRPTx:struct_sheetCategory> Example 2 - five stranded mixed-sense sheet with one two-piece strand. N O N O N O N O -10--11--12--13--14--15--16--17--18-> strand_a N O N O N O N O N O | | | | | | | | | | O N O N O N O N O N <-119-118-117-116-115-114-113-112-111-110- strand_b O N O N O N O N O N \ / \ / \ / \ / \ O N O N O N O N O N O N <-41--40--39--38--37--36--35--34--33--32--31--30- strand_c O N O N O N O N O N O N | | | | | | | | | | | | N O N O N O N O N O N O strand_d1 -50--51--52-> -90--91--92--93--95--95--96--97-> strand_d2 N O N O N O N O N O | | | | | | | | | | | | O N O N O N O N O N O N <-80--79--78--77--76--75--74--73--72--71--70- strand_e O N O N O N O N O N <VRPTx:struct_sheetCategory> <VRPTx:struct_sheet id="sheet_2"> <VRPTx:details>strand_d is in two pieces</VRPTx:details> <VRPTx:number_strands>5</VRPTx:number_strands> <VRPTx:type>five stranded, mixed-sense</VRPTx:type> </VRPTx:struct_sheet> </VRPTx:struct_sheetCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_sheet.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_sheet (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	number_strands INTEGER ,
	type TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_audit_revision_historyType)
-- Data items in the PDBX_AUDIT_REVISION_HISTORY category record the revision history for a data entry. Example 1 - <VRPTx:pdbx_audit_revision_historyCategory> <VRPTx:pdbx_audit_revision_history data_content_type="Structure model" ordinal="1"> <VRPTx:major_revision>1</VRPTx:major_revision> <VRPTx:minor_revision>0</VRPTx:minor_revision> <VRPTx:revision_date>2017-03-01</VRPTx:revision_date> </VRPTx:pdbx_audit_revision_history> <VRPTx:pdbx_audit_revision_history data_content_type="Structure model" ordinal="2"> <VRPTx:major_revision>1</VRPTx:major_revision> <VRPTx:minor_revision>1</VRPTx:minor_revision> <VRPTx:revision_date>2017-03-08</VRPTx:revision_date> </VRPTx:pdbx_audit_revision_history> </VRPTx:pdbx_audit_revision_historyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_revision_history.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_history_data_content_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_history_data_content_type AS ENUM ( 'Structure model', 'NMR restraints', 'NMR shifts', 'Structure factors' );
CREATE TABLE pdbx_audit_revision_history (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	major_revision INTEGER ,
	minor_revision INTEGER ,
-- map XSD date (xsd:date) to SQL DATE
	revision_date DATE ,
-- ATTRIBUTE
	data_content_type ENUM_pdbx_audit_revision_history_data_content_type NOT NULL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from struct_asymType)
-- Data items in the STRUCT_ASYM category record details about the structural elements in the asymmetric unit. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_asymCategory> <VRPTx:struct_asym id="A"> <VRPTx:details>one monomer of the dimeric enzyme</VRPTx:details> <VRPTx:entity_id>1</VRPTx:entity_id> </VRPTx:struct_asym> <VRPTx:struct_asym id="B"> <VRPTx:details>one monomer of the dimeric enzyme</VRPTx:details> <VRPTx:entity_id>1</VRPTx:entity_id> </VRPTx:struct_asym> <VRPTx:struct_asym id="C"> <VRPTx:details>one partially occupied position for the inhibitor</VRPTx:details> <VRPTx:entity_id>2</VRPTx:entity_id> </VRPTx:struct_asym> <VRPTx:struct_asym id="D"> <VRPTx:details>one partially occupied position for the inhibitor</VRPTx:details> <VRPTx:entity_id>2</VRPTx:entity_id> </VRPTx:struct_asym> </VRPTx:struct_asymCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_asym.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_asym_pdbx_blank_PDB_chainid_flag CASCADE;
CREATE TYPE ENUM_struct_asym_pdbx_blank_PDB_chainid_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE struct_asym (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	entity_id TEXT ,
	"pdbx_blank_PDB_chainid_flag" ENUM_struct_asym_pdbx_blank_PDB_chainid_flag ,
	pdbx_modified TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from entity_polyType)
-- Data items in the ENTITY_POLY category record details about the polymer, such as the type of the polymer, the number of monomers and whether it has nonstandard features. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entity_polyCategory> <VRPTx:entity_poly entity_id="1"> <VRPTx:nstd_chirality>no</VRPTx:nstd_chirality> <VRPTx:nstd_linkage>no</VRPTx:nstd_linkage> <VRPTx:nstd_monomer>no</VRPTx:nstd_monomer> <VRPTx:type>polypeptide(L)</VRPTx:type> <VRPTx:type_details xsi:nil="true" /> </VRPTx:entity_poly> </VRPTx:entity_polyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entity_poly.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_entity_poly_nstd_chirality CASCADE;
CREATE TYPE ENUM_entity_poly_nstd_chirality AS ENUM ( 'no', 'n', 'yes', 'y' );
DROP TYPE IF EXISTS ENUM_entity_poly_nstd_linkage CASCADE;
CREATE TYPE ENUM_entity_poly_nstd_linkage AS ENUM ( 'no', 'n', 'yes', 'y' );
DROP TYPE IF EXISTS ENUM_entity_poly_nstd_monomer CASCADE;
CREATE TYPE ENUM_entity_poly_nstd_monomer AS ENUM ( 'no', 'n', 'yes', 'y' );
DROP TYPE IF EXISTS ENUM_entity_poly_type CASCADE;
CREATE TYPE ENUM_entity_poly_type AS ENUM ( 'polypeptide(D)', 'polypeptide(L)', 'polydeoxyribonucleotide', 'polyribonucleotide', 'polydeoxyribonucleotide/polyribonucleotide hybrid', 'cyclic-pseudo-peptide', 'peptide nucleic acid', 'other' );
CREATE TABLE entity_poly (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	nstd_chirality ENUM_entity_poly_nstd_chirality ,
	nstd_linkage ENUM_entity_poly_nstd_linkage ,
	nstd_monomer ENUM_entity_poly_nstd_monomer ,
-- xsd:restriction/xsd:minInclusive="1"
	number_of_monomers INTEGER CHECK ( number_of_monomers >= 1 ) ,
	pdbx_seq_one_letter_code TEXT ,
	pdbx_seq_one_letter_code_can TEXT ,
	pdbx_seq_one_letter_code_sample TEXT ,
	pdbx_strand_id TEXT ,
	pdbx_target_identifier TEXT ,
	type ENUM_entity_poly_type ,
	type_details TEXT ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL
);

--
-- (quoted from phasing_MAD_exptType)
-- Data items in the PHASING_MAD_EXPT category record details about a MAD phasing experiment, such as the number of experiments that were clustered together to produce a set of phases or the statistics for those phases. Example 1 - based on a paper by Shapiro et al. [Nature (London) (1995), 374, 327-337]. <VRPTx:phasing_MAD_exptCategory> <VRPTx:phasing_MAD_expt id="1"> <VRPTx:R_normal_all>0.063</VRPTx:R_normal_all> <VRPTx:R_normal_anom_scat>0.451</VRPTx:R_normal_anom_scat> <VRPTx:delta_delta_phi>58.5</VRPTx:delta_delta_phi> <VRPTx:delta_phi_sigma>20.3</VRPTx:delta_phi_sigma> <VRPTx:mean_fom>0.88</VRPTx:mean_fom> <VRPTx:number_clust>2</VRPTx:number_clust> </VRPTx:phasing_MAD_expt> <VRPTx:phasing_MAD_expt id="2"> <VRPTx:R_normal_all>0.051</VRPTx:R_normal_all> <VRPTx:R_normal_anom_scat>0.419</VRPTx:R_normal_anom_scat> <VRPTx:delta_delta_phi>36.8</VRPTx:delta_delta_phi> <VRPTx:delta_phi_sigma>18.2</VRPTx:delta_phi_sigma> <VRPTx:mean_fom>0.93</VRPTx:mean_fom> <VRPTx:number_clust>1</VRPTx:number_clust> </VRPTx:phasing_MAD_expt> </VRPTx:phasing_MAD_exptCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MAD_expt.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MAD_expt" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"R_normal_all" DECIMAL ,
	"R_normal_anom_scat" DECIMAL ,
	delta_delta_phi DECIMAL ,
	delta_phi DECIMAL ,
	delta_phi_sigma DECIMAL ,
	mean_fom DECIMAL ,
	number_clust INTEGER ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from phasing_MIR_derType)
-- Data items in the PHASING_MIR_DER category record details about individual derivatives used in the phasing of the structure when methods involving isomorphous replacement are involved. A derivative in this context does not necessarily equate with a data set; for instance, the same data set could be used to one resolution limit as an isomorphous scatterer and to a different resolution (and with a different sigma cutoff) as an anomalous scatterer. These would be treated as two distinct derivatives, although both derivatives would point to the same data sets via attribute der_set_id in category phasing_MIR_der and attribute native_set_id in category phasing_MIR_der. Example 1 - based on a paper by Zanotti et al. [J. Biol. Chem. (1993), 268, 10728-10738]. <VRPTx:phasing_MIR_derCategory> <VRPTx:phasing_MIR_der id="KAu(CN)2"> <VRPTx:details>major site interpreted in difference Patterson</VRPTx:details> <VRPTx:number_of_sites>3</VRPTx:number_of_sites> </VRPTx:phasing_MIR_der> <VRPTx:phasing_MIR_der id="K2HgI4"> <VRPTx:details>sites found in cross-difference Fourier</VRPTx:details> <VRPTx:number_of_sites>6</VRPTx:number_of_sites> </VRPTx:phasing_MIR_der> <VRPTx:phasing_MIR_der id="K3IrCl6"> <VRPTx:details>sites found in cross-difference Fourier</VRPTx:details> <VRPTx:number_of_sites>2</VRPTx:number_of_sites> </VRPTx:phasing_MIR_der> <VRPTx:phasing_MIR_der id="All"> <VRPTx:details>data for all three derivatives combined</VRPTx:details> <VRPTx:number_of_sites>11</VRPTx:number_of_sites> </VRPTx:phasing_MIR_der> </VRPTx:phasing_MIR_derCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR_der.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR_der" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_cullis_acentric" DECIMAL CHECK ( "R_cullis_acentric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_cullis_anomalous" DECIMAL CHECK ( "R_cullis_anomalous" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_cullis_centric" DECIMAL CHECK ( "R_cullis_centric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	der_set_id TEXT ,
	details TEXT ,
	native_set_id TEXT ,
	number_of_sites INTEGER ,
	"pdbx_R_cullis" DECIMAL ,
	"pdbx_R_kraut" DECIMAL ,
	"pdbx_R_kraut_acentric" DECIMAL ,
	"pdbx_R_kraut_centric" DECIMAL ,
	pdbx_fom DECIMAL ,
	pdbx_fom_acentric DECIMAL ,
	pdbx_fom_centric DECIMAL ,
	pdbx_loc DECIMAL ,
	pdbx_loc_acentric DECIMAL ,
	pdbx_loc_centric DECIMAL ,
	pdbx_power DECIMAL ,
	pdbx_reflns INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	power_acentric DECIMAL CHECK ( power_acentric >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	power_centric DECIMAL CHECK ( power_centric >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_acentric INTEGER CHECK ( reflns_acentric >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_anomalous INTEGER CHECK ( reflns_anomalous >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_centric INTEGER CHECK ( reflns_centric >= 0 ) ,
	reflns_criteria TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_ncs_ensType)
-- Data items in the STRUCT_NCS_ENS category record information about ensembles of domains related by noncrystallographic symmetry. The point group of the ensemble when taken as a whole may be specified, as well as any special aspects of the ensemble that require description. Example 1 - based on laboratory records for the collagen-like peptide, HYP-. <VRPTx:struct_ncs_ensCategory> <VRPTx:struct_ncs_ens id="en1"> <VRPTx:details> The ensemble represents the pseudo-twofold symmetry between domains d1 and d2.</VRPTx:details> </VRPTx:struct_ncs_ens> </VRPTx:struct_ncs_ensCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ncs_ens.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ncs_ens (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	point_group TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from entity_poly_seqType)
-- Data items in the ENTITY_POLY_SEQ category specify the sequence of monomers in a polymer. Allowance is made for the possibility of microheterogeneity in a sample by allowing a given sequence number to be correlated with more than one monomer ID. The corresponding ATOM_SITE entries should reflect this heterogeneity. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entity_poly_seqCategory> <VRPTx:entity_poly_seq entity_id="1" mon_id="PRO" num="1"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLN" num="2"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ILE" num="3"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="THR" num="4"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LEU" num="5"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="TRP" num="6"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLN" num="7"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ARG" num="8"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="PRO" num="9"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LEU" num="10"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="VAL" num="11"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="THR" num="12"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ILE" num="13"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LYS" num="14"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ILE" num="15"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLY" num="16"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLY" num="17"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLN" num="18"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LEU" num="19"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LYS" num="20"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="GLU" num="21"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ALA" num="22"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LEU" num="23"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="LEU" num="24"></VRPTx:entity_poly_seq> <VRPTx:entity_poly_seq entity_id="1" mon_id="ASP" num="25"></VRPTx:entity_poly_seq> </VRPTx:entity_poly_seqCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entity_poly_seq.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_entity_poly_seq_hetero CASCADE;
CREATE TYPE ENUM_entity_poly_seq_hetero AS ENUM ( 'no', 'n', 'yes', 'y' );
CREATE TABLE entity_poly_seq (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	hetero ENUM_entity_poly_seq_hetero ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	mon_id TEXT NOT NULL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="1"
	num INTEGER CHECK ( num >= 1 ) NOT NULL
);

--
-- (quoted from pdbx_em_fsc_curveType)
-- Data items in the category record Fourier-Shell Correlation (FSC) curve. Ref: User guide to the wwPDB EM validation reports 8. FSC validation 8.1 Calculated FSC 8.2 Author provided FSC Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_fsc_curveCategory> <VRPTx:pdbx_em_fsc_curve id="1"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc</VRPTx:title> </VRPTx:pdbx_em_fsc_curve> <VRPTx:pdbx_em_fsc_curve id="2"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc</VRPTx:title> </VRPTx:pdbx_em_fsc_curve> </VRPTx:pdbx_em_fsc_curveCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_fsc_curve (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	correlation_coef_title TEXT ,
	name TEXT ,
	spatial_frequency_title TEXT ,
	spatial_frequency_unit TEXT ,
	title TEXT ,
	type TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_fsc_cutoff_curveType)
-- Data items in the category record Fourier-Shell Correlation (FSC) cut-off curve that represents a given criterion. Ref: User guide to the wwPDB EM validation reports 8. FSC validation 8.1 Calculated FSC 8.2 Author provided FSC Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_fsc_cutoff_curveCategory> <VRPTx:pdbx_em_fsc_cutoff_curve id="1"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_one-bit</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="2"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_0.143</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="3"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_0.5</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="4"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_0.333</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="5"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_half-bit</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="6"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>calculated_fsc_3sigma</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="7"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_3sigma</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="8"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_one-bit</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="9"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_0.143</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="10"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_0.5</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="11"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_0.333</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> <VRPTx:pdbx_em_fsc_cutoff_curve id="12"> <VRPTx:correlation_coef_title>Correlation coefficient</VRPTx:correlation_coef_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> <VRPTx:title>author_provided_fsc_half-bit</VRPTx:title> </VRPTx:pdbx_em_fsc_cutoff_curve> </VRPTx:pdbx_em_fsc_cutoff_curveCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_fsc_cutoff_curve (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	correlation_coef_title TEXT ,
	name TEXT ,
	spatial_frequency_title TEXT ,
	spatial_frequency_unit TEXT ,
	target_name TEXT ,
	title TEXT ,
	type TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_percentile_conditionsType)
-- Data items in the PDBX_PERCENTILE_CONDITIONS category describe conditions to calculate percentile rank representations of each validation metric in the wwPDB validation report. For example, relative evaluation for X-ray structure is obtained by by comparing other X-ray structures having similar resolution. If there are no conditions by default, absolute evaluation is calculated based on all available PDB structures determined by the same methodology. Example 1 - <VRPTx:pdbx_percentile_conditionsCategory> <VRPTx:pdbx_percentile_conditions id="1"> <VRPTx:ls_d_res_high xsi:nil="true" /> <VRPTx:ls_d_res_low xsi:nil="true" /> <VRPTx:number_entries_total>101464</VRPTx:number_entries_total> </VRPTx:pdbx_percentile_conditions> <VRPTx:pdbx_percentile_conditions id="2"> <VRPTx:ls_d_res_high>1.9</VRPTx:ls_d_res_high> <VRPTx:ls_d_res_low>1.9</VRPTx:ls_d_res_low> <VRPTx:number_entries_total>5100</VRPTx:number_entries_total> </VRPTx:pdbx_percentile_conditions> </VRPTx:pdbx_percentile_conditionsCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_percentile_conditions (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ls_d_res_high DECIMAL ,
	ls_d_res_low DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	number_entries_total INTEGER CHECK ( number_entries_total >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_entity_instType)
-- Data items in the PDBX_STRUCT_ENTITY_INST category record details about the structural elements in the deposited entry. The entity instance is a method neutral identifier for the observed molecular entities in the deposited coordinate set. Example 1 - <VRPTx:pdbx_struct_entity_instCategory> <VRPTx:pdbx_struct_entity_inst id="A"> <VRPTx:details>one monomer of the dimeric enzyme</VRPTx:details> <VRPTx:entity_id>1</VRPTx:entity_id> </VRPTx:pdbx_struct_entity_inst> <VRPTx:pdbx_struct_entity_inst id="B"> <VRPTx:details>one monomer of the dimeric enzyme</VRPTx:details> <VRPTx:entity_id>1</VRPTx:entity_id> </VRPTx:pdbx_struct_entity_inst> </VRPTx:pdbx_struct_entity_instCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_entity_inst.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_entity_inst (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	entity_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_group_listType)
-- Data items in the PDBX_STRUCT_GROUP_LIST define groups of related components or atoms. Example 1 - <VRPTx:pdbx_struct_group_listCategory> <VRPTx:pdbx_struct_group_list struct_group_id="1"> <VRPTx:description> Decaplanin is a tricyclic glycopeptide. The scaffold is a heptapeptide with the configuration D-D-L-D-D-L-L, glycosylated by a monosaccharide and a disaccharide</VRPTx:description> <VRPTx:group_enumeration_type>component</VRPTx:group_enumeration_type> <VRPTx:name>DECAPLANIN</VRPTx:name> <VRPTx:type>MolecularComplex</VRPTx:type> </VRPTx:pdbx_struct_group_list> </VRPTx:pdbx_struct_group_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_group_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_group_list_group_enumeration_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_group_list_group_enumeration_type AS ENUM ( 'atom', 'component', 'component_range' );
DROP TYPE IF EXISTS ENUM_pdbx_struct_group_list_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_group_list_type AS ENUM ( 'Molecular Complex', 'Heterogen Complex', 'TLS group', 'NCS group' );
CREATE TABLE pdbx_struct_group_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	description TEXT ,
	group_enumeration_type ENUM_pdbx_struct_group_list_group_enumeration_type ,
	name TEXT ,
	selection TEXT ,
	selection_details TEXT ,
	type ENUM_pdbx_struct_group_list_type ,
-- ATTRIBUTE
	struct_group_id TEXT NOT NULL
);

--
-- (quoted from struct_biolType)
-- Data items in the STRUCT_BIOL category record details about the structural elements that form each structure of biological significance. A given crystal structure may contain many different biological structures. A given structural component in the asymmetric unit may be part of more than one biological unit. A given biological structure may involve crystallographic symmetry. For instance, in a structure of a lysozyme-FAB structure, the light- and heavy-chain components of the FAB could be one biological unit, while the two chains of the FAB and the lysozyme could constitute a second biological unit. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_biolCategory> <VRPTx:struct_biol id="1"> <VRPTx:details> significant deviations from twofold symmetry exist in this dimeric enzyme</VRPTx:details> </VRPTx:struct_biol> <VRPTx:struct_biol id="2"> <VRPTx:details> The drug binds to this enzyme in two roughly twofold symmetric modes. Hence this biological unit (2) is roughly twofold symmetric to biological unit (3). Disorder in the protein chain indicated with alternative ID 1 should be used with this biological unit.</VRPTx:details> </VRPTx:struct_biol> <VRPTx:struct_biol id="3"> <VRPTx:details> The drug binds to this enzyme in two roughly twofold symmetric modes. Hence this biological unit (3) is roughly twofold symmetric to biological unit (2). Disorder in the protein chain indicated with alternative ID 2 should be used with this biological unit.</VRPTx:details> </VRPTx:struct_biol> </VRPTx:struct_biolCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_biol.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_biol_pdbx_aggregation_state CASCADE;
CREATE TYPE ENUM_struct_biol_pdbx_aggregation_state AS ENUM ( 'MONOMER', 'DIMER', 'TRIMER', 'TETRAMER', 'HEXAMER', 'MORE' );
CREATE TABLE struct_biol (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	pdbx_aggregation_state ENUM_struct_biol_pdbx_aggregation_state ,
	pdbx_assembly_method TEXT ,
-- xsd:restriction/xsd:minInclusive="1.0"
	pdbx_formula_weight DECIMAL CHECK ( pdbx_formula_weight >= 1.0 ) ,
	pdbx_formula_weight_method TEXT ,
	pdbx_parent_biol_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_refType)
-- Data items in the STRUCT_REF category allow the author of a data block to relate the entities or biological units described in the data block to information archived in external databases. For references to the sequence of a polymer, the value of the data item attribute seq_align in category struct_ref is used to indicate whether the correspondence between the sequence of the entity or biological unit in the data block and the sequence in the referenced database entry is 'complete' or 'partial'. If this value is 'partial', the region (or regions) of the alignment may be delimited using data items in the STRUCT_REF_SEQ category. Similarly, the value of attribute seq_dif in category struct_ref is used to indicate whether the two sequences contain point differences. If the value is 'yes', the differences may be identified and annotated using data items in the STRUCT_REF_SEQ_DIF category. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_refCategory> <VRPTx:struct_ref id="1"> <VRPTx:biol_id xsi:nil="true" /> <VRPTx:db_code>12345</VRPTx:db_code> <VRPTx:db_name>Genbank</VRPTx:db_name> <VRPTx:details xsi:nil="true" /> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:seq_align>entire</VRPTx:seq_align> <VRPTx:seq_dif>yes</VRPTx:seq_dif> </VRPTx:struct_ref> <VRPTx:struct_ref id="2"> <VRPTx:biol_id>2</VRPTx:biol_id> <VRPTx:db_code>1ABC</VRPTx:db_code> <VRPTx:db_name>PDB</VRPTx:db_name> <VRPTx:details> The structure of the closely related compound, isobutyryl-pepstatin (pepstatin A) in complex with rhizopuspepsin</VRPTx:details> <VRPTx:entity_id xsi:nil="true" /> <VRPTx:seq_align xsi:nil="true" /> <VRPTx:seq_dif xsi:nil="true" /> </VRPTx:struct_ref> </VRPTx:struct_refCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ref.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_ref_seq_align CASCADE;
CREATE TYPE ENUM_struct_ref_seq_align AS ENUM ( 'complete', 'partial' );
DROP TYPE IF EXISTS ENUM_struct_ref_seq_dif CASCADE;
CREATE TYPE ENUM_struct_ref_seq_dif AS ENUM ( 'no', 'n', 'yes', 'y' );
CREATE TABLE struct_ref (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	biol_id TEXT ,
	db_code TEXT ,
	db_name TEXT ,
	details TEXT ,
	entity_id TEXT ,
	pdbx_align_begin TEXT ,
	pdbx_align_end TEXT ,
	pdbx_db_accession TEXT ,
	pdbx_db_isoform TEXT ,
	pdbx_seq_one_letter_code TEXT ,
	seq_align ENUM_struct_ref_seq_align ,
	seq_dif ENUM_struct_ref_seq_dif ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_siteType)
-- Data items in the STRUCT_SITE category record details about portions of the structure that contribute to structurally relevant sites (e.g. active sites, substrate-binding subsites, metal-coordination sites). Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_siteCategory> <VRPTx:struct_site id="P2 site C"> <VRPTx:details> residues with a contact &lt; 3.7 \&#37;A to an atom in the P2 moiety of the inhibitor in the conformation with _struct_asym.id = C</VRPTx:details> </VRPTx:struct_site> <VRPTx:struct_site id="P2 site D"> <VRPTx:details> residues with a contact &lt; 3.7 \&#37;A to an atom in the P1 moiety of the inhibitor in the conformation with _struct_asym.id = D</VRPTx:details> </VRPTx:struct_site> </VRPTx:struct_siteCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_site.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_site (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	pdbx_auth_asym_id TEXT ,
	pdbx_auth_comp_id TEXT ,
	pdbx_auth_ins_code TEXT ,
	pdbx_auth_seq_id TEXT ,
	pdbx_evidence_code TEXT ,
	pdbx_num_residues INTEGER ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_domainType)
-- Data items in the PDBX_DOMAIN category record information about domain definitions. A domain need not correspond to a completely polypeptide chain; it can be composed of one or more segments in a single chain, or by segments from more than one chain. Example 1 - <VRPTx:pdbx_domainCategory> <VRPTx:pdbx_domain id="d1"> <VRPTx:details>Chains A, B</VRPTx:details> </VRPTx:pdbx_domain> <VRPTx:pdbx_domain id="d2"> <VRPTx:details>Asym_id D Residues 1-134</VRPTx:details> </VRPTx:pdbx_domain> </VRPTx:pdbx_domainCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_domain.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_domain (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_em_atom_inclusionType)
-- Data items in the category record fraction of atoms that are inside the surface at a given contour level. Ref: User guide to the wwPDB EM validation reports 9. Map-model fit 9.2 Atom inclusion Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_atom_inclusionCategory> <VRPTx:pdbx_em_atom_inclusion id="1"> <VRPTx:atom_inclusion_title>Fraction of model inside the map</VRPTx:atom_inclusion_title> <VRPTx:atom_type>all non-hydrogen atoms</VRPTx:atom_type> <VRPTx:contour_level_title>Contour level</VRPTx:contour_level_title> </VRPTx:pdbx_em_atom_inclusion> <VRPTx:pdbx_em_atom_inclusion id="2"> <VRPTx:atom_inclusion_title>Fraction of model inside the map</VRPTx:atom_inclusion_title> <VRPTx:atom_type>backbone atoms</VRPTx:atom_type> <VRPTx:contour_level_title>Contour level</VRPTx:contour_level_title> </VRPTx:pdbx_em_atom_inclusion> </VRPTx:pdbx_em_atom_inclusionCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_em_atom_inclusion_atom_type CASCADE;
CREATE TYPE ENUM_pdbx_em_atom_inclusion_atom_type AS ENUM ( 'backbone atoms', 'all non-hydrogen atoms' );
CREATE TABLE pdbx_em_atom_inclusion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	atom_inclusion_title TEXT ,
	atom_type ENUM_pdbx_em_atom_inclusion_atom_type ,
	contour_level_title TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_density_distributionType)
-- Data items in the category record map-value distribution of the primary EM volume. Ref: User guide to the wwPDB EM validation reports 7. Map analysis 7.1 Map value distribution Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_density_distributionCategory> <VRPTx:pdbx_em_density_distribution id="1"> <VRPTx:map_value_title>Map-value</VRPTx:map_value_title> <VRPTx:voxel_count_scale>log10</VRPTx:voxel_count_scale> <VRPTx:voxel_count_title>Number of voxels</VRPTx:voxel_count_title> </VRPTx:pdbx_em_density_distribution> </VRPTx:pdbx_em_density_distributionCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_density_distribution (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	map_value_title TEXT ,
	voxel_count_scale TEXT ,
	voxel_count_title TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_rapsType)
-- Data items in the category record Rotationally Averaged Power Spectrum (RAPS) for the primary EM volume (map). The RAPS provides insight into the data processing steps leading to the map, in terms of: CTF correction, Temperature factor correction, Low and/or high-pass filtering, Masking artifacts. The RAPS is only generated for cubic volumes. Ref: User guide to the wwPDB EM validation reports 7. Map analysis 7.3 Rotationally averaged power spectrum Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_rapsCategory> <VRPTx:pdbx_em_raps id="1"> <VRPTx:power_scale>log10</VRPTx:power_scale> <VRPTx:power_title>Intensity</VRPTx:power_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_raps> </VRPTx:pdbx_em_rapsCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_raps (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	power_scale TEXT ,
	power_title TEXT ,
	spatial_frequency_title TEXT ,
	spatial_frequency_unit TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_raw_rapsType)
-- Data items in the category record Rotationally Averaged Power Spectrum (RAPS) for raw EM volume (map). The RAPS provides insight into the data processing steps leading to the map, in terms of: CTF correction, Temperature factor correction, Low and/or high-pass filtering, Masking artifacts. The RAPS is only generated for cubic volumes. Ref: User guide to the wwPDB EM validation reports 7. Map analysis 7.3 Rotationally averaged power spectrum Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_raw_rapsCategory> <VRPTx:pdbx_em_raw_raps id="1"> <VRPTx:power_scale>log10</VRPTx:power_scale> <VRPTx:power_title>Intensity</VRPTx:power_title> <VRPTx:spatial_frequency_title>Spatial frequency</VRPTx:spatial_frequency_title> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_raw_raps> </VRPTx:pdbx_em_raw_rapsCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_raw_raps (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	power_scale TEXT ,
	power_title TEXT ,
	spatial_frequency_title TEXT ,
	spatial_frequency_unit TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_volume_estimateType)
-- Data items in the category record volume estimation of the primary EM volume. Ref: User guide to the wwPDB EM validation reports 7. Map analysis 7.2 Volume estimate by contour Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_volume_estimateCategory> <VRPTx:pdbx_em_volume_estimate id="1"> <VRPTx:contour_level_title>Contour level</VRPTx:contour_level_title> <VRPTx:enclosed_volume_title>Volume</VRPTx:enclosed_volume_title> <VRPTx:enclosed_volume_unit>nm3</VRPTx:enclosed_volume_unit> </VRPTx:pdbx_em_volume_estimate> </VRPTx:pdbx_em_volume_estimateCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_volume_estimate (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	contour_level_title TEXT ,
	enclosed_volume_title TEXT ,
	enclosed_volume_unit TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_refine_tlsType)
-- Data items in the REFINE_TLS category record details about TLS parameters used in structure refinement. Note that the intention is primarily to describe directly refined TLS parameters, although other methods of obtaining TLS parameters may be covered, see item attribute method in category pdbx_refine_tls
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_refine_tls.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_refine_tls_method CASCADE;
CREATE TYPE ENUM_pdbx_refine_tls_method AS ENUM ( 'refined', 'fitted' );
CREATE TABLE pdbx_refine_tls (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L11" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L11_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L12" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L12_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L13" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L13_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L22" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L22_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L23" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L23_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L33" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees_squared"
	"L33_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S11" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S11_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S12" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S12_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S13" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S13_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S21" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S21_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S22" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S22_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S23" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S23_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S31" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S31_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S32" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S32_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S33" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_degrees"
	"S33_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T11" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T11_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T12" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T12_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T13" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T13_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T22" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T22_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T23" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T23_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T33" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"T33_esd" DECIMAL ,
	details TEXT ,
	method ENUM_pdbx_refine_tls_method ,
-- omit an attribute having a fixed value: @units="angstroms"
	origin_x DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	origin_y DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	origin_z DECIMAL ,
	pdbx_refine_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_assemblyType)
-- Data items in the PDBX_STRUCT_ASSEMBLY category record details about the structural elements that form macromolecular assemblies. Example 1 - <VRPTx:pdbx_struct_assemblyCategory> <VRPTx:pdbx_struct_assembly id="1"> <VRPTx:details> The icosahedral virus particle.</VRPTx:details> </VRPTx:pdbx_struct_assembly> </VRPTx:pdbx_struct_assemblyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_assembly.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_assembly (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	method_details TEXT ,
	oligomeric_count INTEGER ,
	oligomeric_details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_nmr_ens_domType)
-- Data items in the PDBX_STRUCT_NMR_ENS_DOM category records generation of domains (polypeptide chain segments) by domain identification of the NMR ensemble structure. Example 1 - <VRPTx:pdbx_struct_nmr_ens_domCategory> <VRPTx:pdbx_struct_nmr_ens_dom id="1"> <VRPTx:distance_rms_dev>0.800</VRPTx:distance_rms_dev> <VRPTx:distance_rms_dev_medoid>0.652</VRPTx:distance_rms_dev_medoid> <VRPTx:error>success</VRPTx:error> <VRPTx:medoid_model_number>3</VRPTx:medoid_model_number> <VRPTx:number_of_gaps>2</VRPTx:number_of_gaps> <VRPTx:number_of_monomers>96</VRPTx:number_of_monomers> </VRPTx:pdbx_struct_nmr_ens_dom> </VRPTx:pdbx_struct_nmr_ens_domCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_nmr_ens_dom (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	distance_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	distance_rms_dev_medoid DECIMAL ,
	error TEXT ,
	medoid_model_number INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number_of_gaps INTEGER CHECK ( number_of_gaps >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_of_monomers INTEGER CHECK ( number_of_monomers >= 0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_of_core DECIMAL CHECK ( percent_of_core >= 0.0 AND percent_of_core <= 100.0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_planesType)
-- Data items in the PDBX_VALIDATE_PLANES category list the residues that contain unexpected deviations from planes centers. Example 1 - <VRPTx:pdbx_validate_planesCategory> <VRPTx:pdbx_validate_planes id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>DG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:rmsd>0.068</VRPTx:rmsd> <VRPTx:type>SIDE CHAIN</VRPTx:type> </VRPTx:pdbx_validate_planes> <VRPTx:pdbx_validate_planes id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>DT</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>4</VRPTx:auth_seq_id> <VRPTx:rmsd>0.198</VRPTx:rmsd> <VRPTx:type>SIDE CHAIN</VRPTx:type> </VRPTx:pdbx_validate_planes> <VRPTx:pdbx_validate_planes id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>DC</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>8</VRPTx:auth_seq_id> <VRPTx:rmsd>0.090</VRPTx:rmsd> <VRPTx:type>SIDE CHAIN</VRPTx:type> </VRPTx:pdbx_validate_planes> </VRPTx:pdbx_validate_planesCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_planes.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_validate_planes_type CASCADE;
CREATE TYPE ENUM_pdbx_validate_planes_type AS ENUM ( 'MAIN_CHAIN', 'SIDE_CHAIN', 'MAIN CHAIN', 'SIDE CHAIN' );
CREATE TABLE pdbx_validate_planes (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	rmsd DECIMAL ,
	type ENUM_pdbx_validate_planes_type ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_ringType)
-- Data items in the PDBX_VALIDATE_RMSD_RING category list the residues that contain unexpected deviations of dihedral angles in a ring conformation. The values are computed by Mogul. Mogul finds the similar ring conformations from small-molecule structures in the Cambridge Structural Database (CSD). Example 1 - <VRPTx:pdbx_validate_rmsd_ringCategory> <VRPTx:pdbx_validate_rmsd_ring id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> <VRPTx:dihedral_angle_standard_deviation>5.62</VRPTx:dihedral_angle_standard_deviation> <VRPTx:dihedral_angle_target_value>73.11</VRPTx:dihedral_angle_target_value> </VRPTx:pdbx_validate_rmsd_ring> <VRPTx:pdbx_validate_rmsd_ring id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> <VRPTx:dihedral_angle_standard_deviation>6.08</VRPTx:dihedral_angle_standard_deviation> <VRPTx:dihedral_angle_target_value>74.52</VRPTx:dihedral_angle_target_value> </VRPTx:pdbx_validate_rmsd_ring> </VRPTx:pdbx_validate_rmsd_ringCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_ring (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dihedral_angle_minimum_diff_to_kb DECIMAL CHECK ( dihedral_angle_minimum_diff_to_kb >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dihedral_angle_standard_deviation DECIMAL CHECK ( dihedral_angle_standard_deviation >= 0.0 ) ,
-- omit an attribute having a fixed value: @units="degrees"
	dihedral_angle_target_value DECIMAL ,
	label_alt_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_dihedral_angles_in_kb INTEGER CHECK ( number_dihedral_angles_in_kb >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_torsionType)
-- Data items in the PDBX_VALIDATE_RMSD_TORSION category list the residues that contain unexpected deviations of torsion angles. The values are computed by Mogul. Mogul finds the similar conformations from small-molecule structures in the Cambridge Structural Database (CSD). Example 1 - <VRPTx:pdbx_validate_rmsd_torsionCategory> <VRPTx:pdbx_validate_rmsd_torsion id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> <VRPTx:dihedral_angle_standard_deviation>5.62</VRPTx:dihedral_angle_standard_deviation> <VRPTx:dihedral_angle_target_value>73.11</VRPTx:dihedral_angle_target_value> </VRPTx:pdbx_validate_rmsd_torsion> <VRPTx:pdbx_validate_rmsd_torsion id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> <VRPTx:dihedral_angle_standard_deviation>6.08</VRPTx:dihedral_angle_standard_deviation> <VRPTx:dihedral_angle_target_value>74.52</VRPTx:dihedral_angle_target_value> </VRPTx:pdbx_validate_rmsd_torsion> </VRPTx:pdbx_validate_rmsd_torsionCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_torsion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dihedral_angle_minimum_diff_to_kb DECIMAL CHECK ( dihedral_angle_minimum_diff_to_kb >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dihedral_angle_standard_deviation DECIMAL CHECK ( dihedral_angle_standard_deviation >= 0.0 ) ,
-- omit an attribute having a fixed value: @units="degrees"
	dihedral_angle_target_value DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	dihedral_angle_value DECIMAL ,
	label_alt_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_dihedral_angles_in_kb INTEGER CHECK ( number_dihedral_angles_in_kb >= 0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_dihedral_angles_fitted_to_kb DECIMAL CHECK ( percent_dihedral_angles_fitted_to_kb >= 0.0 AND percent_dihedral_angles_fitted_to_kb <= 100.0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from struct_conf_typeType)
-- Data items in the STRUCT_CONF_TYPE category record details about the criteria used to identify backbone conformations of a segment of polymer. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_conf_typeCategory> <VRPTx:struct_conf_type id="HELX_RH_AL_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> <VRPTx:struct_conf_type id="STRN_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> <VRPTx:struct_conf_type id="TURN_TY1_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> <VRPTx:struct_conf_type id="TURN_TY1P_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> <VRPTx:struct_conf_type id="TURN_TY2_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> <VRPTx:struct_conf_type id="TURN_TY2P_P"> <VRPTx:criteria>author judgement</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conf_type> </VRPTx:struct_conf_typeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_conf_type.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_conf_type_id CASCADE;
CREATE TYPE ENUM_struct_conf_type_id AS ENUM ( 'BEND', 'HELX_P', 'HELX_OT_P', 'HELX_RH_P', 'HELX_RH_OT_P', 'HELX_RH_AL_P', 'HELX_RH_GA_P', 'HELX_RH_OM_P', 'HELX_RH_PI_P', 'HELX_RH_27_P', 'HELX_RH_3T_P', 'HELX_RH_PP_P', 'HELX_LH_P', 'HELX_LH_OT_P', 'HELX_LH_AL_P', 'HELX_LH_GA_P', 'HELX_LH_OM_P', 'HELX_LH_PI_P', 'HELX_LH_27_P', 'HELX_LH_3T_P', 'HELX_LH_PP_P', 'HELX_N', 'HELX_OT_N', 'HELX_RH_N', 'HELX_RH_OT_N', 'HELX_RH_A_N', 'HELX_RH_B_N', 'HELX_RH_Z_N', 'HELX_LH_N', 'HELX_LH_OT_N', 'HELX_LH_A_N', 'HELX_LH_B_N', 'HELX_LH_Z_N', 'TURN_P', 'TURN_OT_P', 'TURN_TY1_P', 'TURN_TY1P_P', 'TURN_TY2_P', 'TURN_TY2P_P', 'TURN_TY3_P', 'TURN_TY3P_P', 'STRN', 'OTHER' );
CREATE TABLE struct_conf_type (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	criteria TEXT ,
	reference TEXT ,
-- ATTRIBUTE
	id ENUM_struct_conf_type_id NOT NULL
);

--
-- (quoted from struct_ncs_domType)
-- Data items in the STRUCT_NCS_DOM category record information about the domains in an ensemble of domains related by one or more noncrystallographic symmetry operators. A domain need not correspond to a complete polypeptide chain; it can be composed of one or more segments in a single chain, or by segments from more than one chain. Example 1 - based on laboratory records for the collagen-like peptide, HYP-. <VRPTx:struct_ncs_domCategory> <VRPTx:struct_ncs_dom id="d1" pdbx_ens_id="1"> <VRPTx:details>Chains A, B, and C</VRPTx:details> </VRPTx:struct_ncs_dom> <VRPTx:struct_ncs_dom id="d2" pdbx_ens_id="1"> <VRPTx:details>Chains D, E, and F</VRPTx:details> </VRPTx:struct_ncs_dom> </VRPTx:struct_ncs_domCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ncs_dom.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ncs_dom (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_ens_id TEXT NOT NULL
);

--
-- (quoted from struct_ncs_operType)
-- Data items in the STRUCT_NCS_OPER category describe the noncrystallographic symmetry operations. Each operator is specified as a matrix and a subsequent translation vector. Operators need not represent proper rotations. Example 1 - based on laboratory records for the protein NS1. <VRPTx:struct_ncs_operCategory> <VRPTx:struct_ncs_oper id="1"> <VRPTx:code>given</VRPTx:code> <VRPTx:details> Matrix and translation vector for pseudo-twofold operation.</VRPTx:details> <VRPTx:matrix11>0.247</VRPTx:matrix11> <VRPTx:matrix12>0.935</VRPTx:matrix12> <VRPTx:matrix13>0.256</VRPTx:matrix13> <VRPTx:matrix21>0.929</VRPTx:matrix21> <VRPTx:matrix22>0.153</VRPTx:matrix22> <VRPTx:matrix23>0.337</VRPTx:matrix23> <VRPTx:matrix31>0.276</VRPTx:matrix31> <VRPTx:matrix32>0.321</VRPTx:matrix32> <VRPTx:matrix33>-0.906</VRPTx:matrix33> <VRPTx:vector1>-8.253</VRPTx:vector1> <VRPTx:vector2>-11.743</VRPTx:vector2> <VRPTx:vector3>-1.782</VRPTx:vector3> </VRPTx:struct_ncs_oper> </VRPTx:struct_ncs_operCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ncs_oper.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_ncs_oper_code CASCADE;
CREATE TYPE ENUM_struct_ncs_oper_code AS ENUM ( 'given', 'generate' );
CREATE TABLE struct_ncs_oper (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	code ENUM_struct_ncs_oper_code ,
	details TEXT ,
	matrix11 DECIMAL ,
	matrix12 DECIMAL ,
	matrix13 DECIMAL ,
	matrix21 DECIMAL ,
	matrix22 DECIMAL ,
	matrix23 DECIMAL ,
	matrix31 DECIMAL ,
	matrix32 DECIMAL ,
	matrix33 DECIMAL ,
	vector1 DECIMAL ,
	vector2 DECIMAL ,
	vector3 DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from struct_ref_seqType)
-- Data items in the STRUCT_REF_SEQ category provide a mechanism for indicating and annotating a region (or regions) of alignment between the sequence of an entity or biological unit described in the data block and the sequence in the referenced database entry. Example 1 - based on the sequence alignment of CHER from M. xantus (36 to 288) and CHER from S. typhimurium (18 to 276). <VRPTx:struct_ref_seqCategory> <VRPTx:struct_ref_seq align_id="alg1"> <VRPTx:db_align_beg>18</VRPTx:db_align_beg> <VRPTx:db_align_end>276</VRPTx:db_align_end> <VRPTx:details> The alignment contains 3 gaps larger than 2 residues</VRPTx:details> <VRPTx:ref_id>seqdb1</VRPTx:ref_id> <VRPTx:seq_align_beg>36</VRPTx:seq_align_beg> <VRPTx:seq_align_end>288</VRPTx:seq_align_end> </VRPTx:struct_ref_seq> </VRPTx:struct_ref_seqCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ref_seq.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ref_seq (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	db_align_beg INTEGER ,
	db_align_end INTEGER ,
	details TEXT ,
	"pdbx_PDB_id_code" TEXT ,
	pdbx_auth_seq_align_beg TEXT ,
	pdbx_auth_seq_align_end TEXT ,
	pdbx_db_accession TEXT ,
	pdbx_db_align_beg_ins_code TEXT ,
	pdbx_db_align_end_ins_code TEXT ,
	pdbx_seq_align_beg_ins_code TEXT ,
	pdbx_seq_align_end_ins_code TEXT ,
	pdbx_strand_id TEXT ,
	ref_id TEXT ,
	seq_align_beg INTEGER ,
	seq_align_end INTEGER ,
-- ATTRIBUTE
	align_id TEXT NOT NULL
);

--
-- (quoted from diffrn_attenuatorType)
-- Data items in the DIFFRN_ATTENUATOR category record details about the diffraction attenuator scales employed. Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:diffrn_attenuatorCategory> <VRPTx:diffrn_attenuator code="1"> <VRPTx:scale>16.976</VRPTx:scale> </VRPTx:diffrn_attenuator> </VRPTx:diffrn_attenuatorCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_attenuator.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_attenuator (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	material TEXT ,
-- xsd:restriction/xsd:minInclusive="1.0"
	scale DECIMAL CHECK ( scale >= 1.0 ) ,
-- ATTRIBUTE
	code TEXT NOT NULL
);

--
-- (quoted from diffrn_detectorType)
-- Data items in the DIFFRN_DETECTOR category describe the detector used to measure the scattered radiation, including any analyser and post-sample collimation. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrn_detectorCategory> <VRPTx:diffrn_detector diffrn_id="d1"> <VRPTx:detector>multiwire</VRPTx:detector> <VRPTx:type>Siemens</VRPTx:type> </VRPTx:diffrn_detector> </VRPTx:diffrn_detectorCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_detector.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_detector (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	area_resol_mean DECIMAL CHECK ( area_resol_mean >= 0.0 ) ,
	details TEXT ,
	detector TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dtime DECIMAL CHECK ( dtime >= 0.0 ) ,
	pdbx_collection_date TEXT ,
-- omit an attribute having a fixed value: @units="seconds"
	pdbx_collection_time_total DECIMAL ,
	pdbx_frames_total INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_frequency DECIMAL CHECK ( pdbx_frequency >= 0.0 ) ,
	type TEXT ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_measurementType)
-- Data items in the DIFFRN_MEASUREMENT category record details about the device used to orient and/or position the crystal during data measurement and the manner in which the diffraction data were measured. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrn_measurementCategory> <VRPTx:diffrn_measurement diffrn_id="d1"> <VRPTx:details> 440 frames, 0.20 degrees, 150 sec, detector distance 12 cm, detector angle 22.5 degrees</VRPTx:details> <VRPTx:device>3-circle camera</VRPTx:device> <VRPTx:device_details>none</VRPTx:device_details> <VRPTx:device_type>Supper model x</VRPTx:device_type> <VRPTx:method>omega scan</VRPTx:method> </VRPTx:diffrn_measurement> </VRPTx:diffrn_measurementCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:diffrn_measurementCategory> <VRPTx:diffrn_measurement diffrn_id="s1"> <VRPTx:device_type>Philips PW1100/20 diffractometer</VRPTx:device_type> <VRPTx:method>\q/2\q</VRPTx:method> </VRPTx:diffrn_measurement> </VRPTx:diffrn_measurementCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_measurement.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_measurement (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	device TEXT ,
	device_details TEXT ,
	device_type TEXT ,
	method TEXT ,
	specimen_support TEXT ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_orient_matrixType)
-- Data items in the DIFFRN_ORIENT_MATRIX category record details about the orientation matrix used in the measurement of the diffraction data. Example 1 - based on CAD-4 diffractometer data obtained for Yb(S-C5H4N)2(THF)4. <VRPTx:diffrn_orient_matrixCategory> <VRPTx:diffrn_orient_matrix diffrn_id="set1"> <VRPTx:UB11>-0.071479</VRPTx:UB11> <VRPTx:UB12>0.020208</VRPTx:UB12> <VRPTx:UB13>0.039076</VRPTx:UB13> <VRPTx:UB21>0.035372</VRPTx:UB21> <VRPTx:UB22>0.056209</VRPTx:UB22> <VRPTx:UB23>0.078324</VRPTx:UB23> <VRPTx:UB31>-0.007470</VRPTx:UB31> <VRPTx:UB32>0.067854</VRPTx:UB32> <VRPTx:UB33>-0.017832</VRPTx:UB33> <VRPTx:type> reciprocal axis matrix, multiplies hkl vector to generate diffractometer xyz vector and diffractometer angles</VRPTx:type> </VRPTx:diffrn_orient_matrix> </VRPTx:diffrn_orient_matrixCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_orient_matrix.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_orient_matrix (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"UB11" DECIMAL ,
	"UB12" DECIMAL ,
	"UB13" DECIMAL ,
	"UB21" DECIMAL ,
	"UB22" DECIMAL ,
	"UB23" DECIMAL ,
	"UB31" DECIMAL ,
	"UB32" DECIMAL ,
	"UB33" DECIMAL ,
	type TEXT ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_orient_reflnType)
-- Data items in the DIFFRN_ORIENT_REFLN category record details about the reflections that define the orientation matrix used in the measurement of the diffraction intensities. Example 1 - based on CAD-4 diffractometer data obtained for Yb(S-C5H4N)2(THF)4. <VRPTx:diffrn_orient_reflnCategory> <VRPTx:diffrn_orient_refln diffrn_id="myset1" index_h="2" index_k="0" index_l="2"> <VRPTx:angle_chi>-28.45</VRPTx:angle_chi> <VRPTx:angle_kappa>-11.32</VRPTx:angle_kappa> <VRPTx:angle_omega>5.33</VRPTx:angle_omega> <VRPTx:angle_phi>101.78</VRPTx:angle_phi> <VRPTx:angle_psi>0.00</VRPTx:angle_psi> <VRPTx:angle_theta>10.66</VRPTx:angle_theta> </VRPTx:diffrn_orient_refln> </VRPTx:diffrn_orient_reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_orient_refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_orient_refln (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_chi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_kappa DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_omega DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_phi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_psi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_theta DECIMAL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL ,
-- ATTRIBUTE
	index_h INTEGER NOT NULL ,
-- ATTRIBUTE
	index_k INTEGER NOT NULL ,
-- ATTRIBUTE
	index_l INTEGER NOT NULL
);

--
-- (quoted from diffrn_radiationType)
-- Data items in the DIFFRN_RADIATION category describe the radiation used in measuring the diffraction intensities, its collimation and monochromatization before the sample. Post-sample treatment of the beam is described by data items in the DIFFRN_DETECTOR category. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrn_radiationCategory> <VRPTx:diffrn_radiation diffrn_id="set1"> <VRPTx:collimation>0.3 mm double pinhole</VRPTx:collimation> <VRPTx:monochromator>graphite</VRPTx:monochromator> <VRPTx:type>Cu K\a</VRPTx:type> <VRPTx:wavelength_id>1</VRPTx:wavelength_id> </VRPTx:diffrn_radiation> </VRPTx:diffrn_radiationCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:diffrn_radiationCategory> <VRPTx:diffrn_radiation diffrn_id="set1"> <VRPTx:monochromator>graphite</VRPTx:monochromator> <VRPTx:type>Cu K\a</VRPTx:type> <VRPTx:wavelength_id>1</VRPTx:wavelength_id> </VRPTx:diffrn_radiation> </VRPTx:diffrn_radiationCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_radiation.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_diffrn_radiation_pdbx_monochromatic_or_laue_m_l CASCADE;
CREATE TYPE ENUM_diffrn_radiation_pdbx_monochromatic_or_laue_m_l AS ENUM ( 'M', 'L' );
DROP TYPE IF EXISTS ENUM_diffrn_radiation_pdbx_scattering_type CASCADE;
CREATE TYPE ENUM_diffrn_radiation_pdbx_scattering_type AS ENUM ( 'x-ray', 'neutron', 'electron' );
DROP TYPE IF EXISTS ENUM_diffrn_radiation_probe CASCADE;
CREATE TYPE ENUM_diffrn_radiation_probe AS ENUM ( 'x-ray', 'neutron', 'electron', 'gamma' );
DROP TYPE IF EXISTS ENUM_diffrn_radiation_xray_symbol CASCADE;
CREATE TYPE ENUM_diffrn_radiation_xray_symbol AS ENUM ( 'K-L~3~', 'K-L~2~', 'K-M~3~', 'K-L~2,3~' );
CREATE TABLE diffrn_radiation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	collimation TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	filter_edge DECIMAL CHECK ( filter_edge >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	inhomogeneity DECIMAL CHECK ( inhomogeneity >= 0.0 ) ,
	monochromator TEXT ,
	pdbx_analyzer TEXT ,
	pdbx_diffrn_protocol TEXT ,
	pdbx_monochromatic_or_laue_m_l ENUM_diffrn_radiation_pdbx_monochromatic_or_laue_m_l ,
	pdbx_scattering_type ENUM_diffrn_radiation_pdbx_scattering_type ,
	pdbx_wavelength TEXT ,
	pdbx_wavelength_list TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	polarisn_norm DECIMAL CHECK ( polarisn_norm >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	polarisn_ratio DECIMAL CHECK ( polarisn_ratio >= 0.0 ) ,
	probe ENUM_diffrn_radiation_probe ,
	type TEXT ,
	wavelength_id TEXT ,
	xray_symbol ENUM_diffrn_radiation_xray_symbol ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_radiation_wavelengthType)
-- Data items in the DIFFRN_RADIATION_WAVELENGTH category describe the wavelength of the radiation used to measure the diffraction intensities. Items may be looped to identify and assign weights to distinct components of a polychromatic beam. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrn_radiation_wavelengthCategory> <VRPTx:diffrn_radiation_wavelength id="1"> <VRPTx:wavelength>1.54</VRPTx:wavelength> <VRPTx:wt>1.0</VRPTx:wt> </VRPTx:diffrn_radiation_wavelength> </VRPTx:diffrn_radiation_wavelengthCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_radiation_wavelength.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_radiation_wavelength (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	wavelength DECIMAL CHECK ( wavelength >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	wt DECIMAL CHECK ( wt >= 0.0 AND wt <= 1.0 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from diffrn_reflnType)
-- Data items in the DIFFRN_REFLN category record details about the intensities in the diffraction data set identified by attribute diffrn_id. in category diffrn_refln The DIFFRN_REFLN data items refer to individual intensity measurements and must be included in looped lists. The DIFFRN_REFLNS data items specify the parameters that apply to all intensity measurements in the particular diffraction data set identified by attribute diffrn_id in category diffrn_reflns. Example 1 - based on CAD-4 diffractometer data obtained for Yb(S-C5H4N)2(THF)4 for data set 'set1' reflection 1102. <VRPTx:diffrn_reflnCategory> <VRPTx:diffrn_refln diffrn_id="set1" id="1102"> <VRPTx:angle_chi>32.21</VRPTx:angle_chi> <VRPTx:angle_kappa>20.12</VRPTx:angle_kappa> <VRPTx:angle_omega>11.54</VRPTx:angle_omega> <VRPTx:angle_phi>176.02</VRPTx:angle_phi> <VRPTx:angle_psi>0.00</VRPTx:angle_psi> <VRPTx:angle_theta>23.08</VRPTx:angle_theta> <VRPTx:attenuator_code>Ni.005</VRPTx:attenuator_code> <VRPTx:counts_bg_1>22</VRPTx:counts_bg_1> <VRPTx:counts_bg_2>25</VRPTx:counts_bg_2> <VRPTx:counts_net>3450</VRPTx:counts_net> <VRPTx:counts_peak>321</VRPTx:counts_peak> <VRPTx:counts_total>3499</VRPTx:counts_total> <VRPTx:detect_slit_horiz>0.04</VRPTx:detect_slit_horiz> <VRPTx:detect_slit_vert>0.02</VRPTx:detect_slit_vert> <VRPTx:elapsed_time>1.00</VRPTx:elapsed_time> <VRPTx:index_h>4</VRPTx:index_h> <VRPTx:index_k>0</VRPTx:index_k> <VRPTx:index_l>2</VRPTx:index_l> <VRPTx:intensity_net>202.56</VRPTx:intensity_net> <VRPTx:intensity_sigma>2.18</VRPTx:intensity_sigma> <VRPTx:scale_group_code>A24</VRPTx:scale_group_code> <VRPTx:scan_mode>om</VRPTx:scan_mode> <VRPTx:scan_mode_backgd>mo</VRPTx:scan_mode_backgd> <VRPTx:scan_rate>1.2</VRPTx:scan_rate> <VRPTx:scan_time_backgd>900.00</VRPTx:scan_time_backgd> <VRPTx:scan_width>1.0</VRPTx:scan_width> <VRPTx:sint_over_lambda>0.25426</VRPTx:sint_over_lambda> <VRPTx:standard_code>1</VRPTx:standard_code> <VRPTx:wavelength>1.54184</VRPTx:wavelength> <VRPTx:wavelength_id>Cu1fixed</VRPTx:wavelength_id> </VRPTx:diffrn_refln> </VRPTx:diffrn_reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_diffrn_refln_scan_mode CASCADE;
CREATE TYPE ENUM_diffrn_refln_scan_mode AS ENUM ( 'om', 'ot', 'q' );
DROP TYPE IF EXISTS ENUM_diffrn_refln_scan_mode_backgd CASCADE;
CREATE TYPE ENUM_diffrn_refln_scan_mode_backgd AS ENUM ( 'st', 'mo' );
CREATE TABLE diffrn_refln (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_chi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_kappa DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_omega DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_phi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_psi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_theta DECIMAL ,
	attenuator_code TEXT ,
	class_code TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	counts_bg_1 INTEGER CHECK ( counts_bg_1 >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	counts_bg_2 INTEGER CHECK ( counts_bg_2 >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	counts_net INTEGER CHECK ( counts_net >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	counts_peak INTEGER CHECK ( counts_peak >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	counts_total INTEGER CHECK ( counts_total >= 0 ) ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	detect_slit_horiz DECIMAL CHECK ( detect_slit_horiz >= 0.0 AND detect_slit_horiz <= 90.0 ) ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	detect_slit_vert DECIMAL CHECK ( detect_slit_vert >= 0.0 AND detect_slit_vert <= 90.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	elapsed_time DECIMAL CHECK ( elapsed_time >= 0.0 ) ,
	index_h INTEGER ,
	index_k INTEGER ,
	index_l INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	intensity_net DECIMAL CHECK ( intensity_net >= 0 ) ,
	intensity_sigma DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	intensity_u DECIMAL CHECK ( intensity_u >= 0.0 ) ,
	pdbx_detector_x DECIMAL ,
	pdbx_detector_y DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_image_id INTEGER CHECK ( pdbx_image_id >= 0 ) ,
-- omit an attribute having a fixed value: @units="degrees"
	pdbx_rotation_angle DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_scale_value DECIMAL CHECK ( pdbx_scale_value >= 0.0 ) ,
-- omit an attribute having a fixed value: @units="degrees"
	pdbx_scan_angle DECIMAL ,
	scale_group_code TEXT ,
	scan_mode ENUM_diffrn_refln_scan_mode ,
	scan_mode_backgd ENUM_diffrn_refln_scan_mode_backgd ,
-- omit an attribute having a fixed value: @units="degrees_per_minute"
	scan_rate DECIMAL ,
-- omit an attribute having a fixed value: @units="seconds"
	scan_time_backgd DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	scan_width DECIMAL CHECK ( scan_width >= 0.0 AND scan_width <= 90.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	sint_over_lambda DECIMAL CHECK ( sint_over_lambda >= 0.0 ) ,
	standard_code TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	wavelength DECIMAL CHECK ( wavelength >= 0.0 ) ,
	wavelength_id TEXT ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from diffrn_reflnsType)
-- Data items in the DIFFRN_REFLNS category record details about the set of intensities measured in the diffraction experiment. The DIFFRN_REFLN data items refer to individual intensity measurements and must be included in looped lists. The DIFFRN_REFLNS data items specify the parameters that apply to all intensity measurements in a diffraction data set.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_reflns.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_reflns (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_R_equivalents" DECIMAL CHECK ( "av_R_equivalents" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_sigmaI_over_netI" DECIMAL CHECK ( "av_sigmaI_over_netI" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_unetI_over_netI" DECIMAL CHECK ( "av_unetI_over_netI" >= 0.0 ) ,
	limit_h_max INTEGER ,
	limit_h_min INTEGER ,
	limit_k_max INTEGER ,
	limit_k_min INTEGER ,
	limit_l_max INTEGER ,
	limit_l_min INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number INTEGER CHECK ( number >= 0 ) ,
	"pdbx_Rmerge_I_obs" DECIMAL ,
	"pdbx_Rsym_value" DECIMAL ,
	pdbx_chi_squared DECIMAL ,
	pdbx_d_res_high DECIMAL ,
	pdbx_d_res_low DECIMAL ,
	pdbx_number_obs INTEGER ,
	pdbx_observed_criterion DECIMAL ,
	pdbx_percent_possible_obs DECIMAL ,
	pdbx_redundancy DECIMAL ,
	pdbx_rejects INTEGER ,
	reduction_process TEXT ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	theta_max DECIMAL CHECK ( theta_max >= 0.0 AND theta_max <= 90.0 ) ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	theta_min DECIMAL CHECK ( theta_min >= 0.0 AND theta_min <= 90.0 ) ,
	transf_matrix11 DECIMAL ,
	transf_matrix12 DECIMAL ,
	transf_matrix13 DECIMAL ,
	transf_matrix21 DECIMAL ,
	transf_matrix22 DECIMAL ,
	transf_matrix23 DECIMAL ,
	transf_matrix31 DECIMAL ,
	transf_matrix32 DECIMAL ,
	transf_matrix33 DECIMAL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_reflns_classType)
-- Data items in the DIFFRN_REFLNS_CLASS category record details about the classes of reflections measured in the diffraction experiment. Example 1 - example corresponding to the one-dimensional incommensurately modulated structure of K~2~SeO~4~. Each reflection class is defined by the number m=sum|m~i~|, where the m~i~ are the integer coefficients that, in addition to h,k,l, index the corresponding diffraction vector in the basis defined for the reciprocal lattice. <VRPTx:diffrn_reflns_classCategory> <VRPTx:diffrn_reflns_class code="Main"> <VRPTx:av_R_eq>0.015</VRPTx:av_R_eq> <VRPTx:d_res_high>0.551</VRPTx:d_res_high> <VRPTx:d_res_low>6.136</VRPTx:d_res_low> <VRPTx:description>m=0; main reflections</VRPTx:description> <VRPTx:number>1580</VRPTx:number> </VRPTx:diffrn_reflns_class> <VRPTx:diffrn_reflns_class code="Sat1"> <VRPTx:av_R_eq>0.010</VRPTx:av_R_eq> <VRPTx:d_res_high>0.551</VRPTx:d_res_high> <VRPTx:d_res_low>6.136</VRPTx:d_res_low> <VRPTx:description>m=1; first-order satellites</VRPTx:description> <VRPTx:number>1045</VRPTx:number> </VRPTx:diffrn_reflns_class> </VRPTx:diffrn_reflns_classCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_reflns_class.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_reflns_class (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_R_eq" DECIMAL CHECK ( "av_R_eq" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_sgI_over_I" DECIMAL CHECK ( "av_sgI_over_I" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"av_uI_over_I" DECIMAL CHECK ( "av_uI_over_I" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	description TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number INTEGER CHECK ( number >= 0 ) ,
-- ATTRIBUTE
	code TEXT NOT NULL
);

--
-- (quoted from diffrn_scale_groupType)
-- Data items in the DIFFRN_SCALE_GROUP category record details of the scaling factors applied to place all intensities in the reflection lists on a common scale. Scaling groups might, for example, correspond to each film in a multi-film data set or each crystal in a multi-crystal data set. Example 1 - based on CAD-4 diffractometer data obtained for Yb(S-C5H4N)2(THF)4. <VRPTx:diffrn_scale_groupCategory> <VRPTx:diffrn_scale_group code="A24"> <VRPTx:I_net>1.021</VRPTx:I_net> </VRPTx:diffrn_scale_group> </VRPTx:diffrn_scale_groupCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_scale_group.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_scale_group (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"I_net" DECIMAL CHECK ( "I_net" >= 0.0 ) ,
-- ATTRIBUTE
	code TEXT NOT NULL
);

--
-- (quoted from diffrn_sourceType)
-- Data items in the DIFFRN_SOURCE category record details of the source of radiation used in the diffraction experiment. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:diffrn_sourceCategory> <VRPTx:diffrn_source diffrn_id="s1"> <VRPTx:current>180</VRPTx:current> <VRPTx:power>50</VRPTx:power> <VRPTx:size>8mm x 0.4 mm broad-focus</VRPTx:size> <VRPTx:source>rotating anode</VRPTx:source> <VRPTx:type>Rigaku RU-200</VRPTx:type> </VRPTx:diffrn_source> </VRPTx:diffrn_sourceCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_source.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_diffrn_source_target CASCADE;
CREATE TYPE ENUM_diffrn_source_target AS ENUM ( 'H', 'He', 'Li', 'Be', 'B', 'C', 'N', 'O', 'F', 'Ne', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'Ar', 'K', 'Ca', 'Sc', 'Ti', 'V', 'Cr', 'Mn', 'Fe', 'Co', 'Ni', 'Cu', 'Zn', 'Ga', 'Ge', 'As', 'Se', 'Br', 'Kr', 'Rb', 'Sr', 'Y', 'Zr', 'Nb', 'Mo', 'Tc', 'Ru', 'Rh', 'Pd', 'Ag', 'Cd', 'In', 'Sn', 'Sb', 'Te', 'I', 'Xe', 'Cs', 'Ba', 'La', 'Ce', 'Pr', 'Nd', 'Pm', 'Sm', 'Eu', 'Gd', 'Tb', 'Dy', 'Ho', 'Er', 'Tm', 'Yb', 'Lu', 'Hf', 'Ta', 'W', 'Re', 'Os', 'Ir', 'Pt', 'Au', 'Hg', 'Tl', 'Pb', 'Bi', 'Po', 'At', 'Rn', 'Fr', 'Ra', 'Ac', 'Th', 'Pa', 'U', 'Np', 'Pu', 'Am', 'Cm', 'Bk', 'Cf', 'Es', 'Fm', 'Md', 'No', 'Lr' );
CREATE TABLE diffrn_source (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="milliamperes"
	current DECIMAL ,
	details TEXT ,
	pdbx_synchrotron_beamline TEXT ,
	pdbx_synchrotron_site TEXT ,
	pdbx_wavelength TEXT ,
	pdbx_wavelength_list TEXT ,
-- omit an attribute having a fixed value: @units="kilowatts"
	power DECIMAL ,
	size TEXT ,
	source TEXT ,
-- xsd:restriction/xsd:maxInclusive="90.0"
-- xsd:restriction/xsd:minInclusive="0.00"
	"take-off_angle" DECIMAL CHECK ( "take-off_angle" >= 0.00 AND "take-off_angle" <= 90.0 ) ,
	target ENUM_diffrn_source_target ,
	type TEXT ,
-- omit an attribute having a fixed value: @units="kilovolts"
	voltage DECIMAL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_standard_reflnType)
-- Data items in the DIFFRN_STANDARD_REFLN category record details about the reflections treated as standards during the measurement of a set of diffraction intensities. Note that these are the individual standard reflections, not the results of the analysis of the standard reflections. Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:diffrn_standard_reflnCategory> <VRPTx:diffrn_standard_refln code="1" diffrn_id="s1"> <VRPTx:index_h>3</VRPTx:index_h> <VRPTx:index_k>2</VRPTx:index_k> <VRPTx:index_l>4</VRPTx:index_l> </VRPTx:diffrn_standard_refln> <VRPTx:diffrn_standard_refln code="1" diffrn_id="s1"> <VRPTx:index_h>1</VRPTx:index_h> <VRPTx:index_k>9</VRPTx:index_k> <VRPTx:index_l>1</VRPTx:index_l> </VRPTx:diffrn_standard_refln> <VRPTx:diffrn_standard_refln code="1" diffrn_id="s1"> <VRPTx:index_h>3</VRPTx:index_h> <VRPTx:index_k>0</VRPTx:index_k> <VRPTx:index_l>10</VRPTx:index_l> </VRPTx:diffrn_standard_refln> </VRPTx:diffrn_standard_reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_standard_refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_standard_refln (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	index_h INTEGER ,
	index_k INTEGER ,
	index_l INTEGER ,
-- ATTRIBUTE
	code TEXT NOT NULL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from diffrn_standardsType)
-- Data items in the DIFFRN_STANDARDS category record details about the set of standard reflections used to monitor intensity stability during the measurement of diffraction intensities. Note that these records describe properties common to the set of standard reflections, not the standard reflections themselves. Example 1 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:diffrn_standardsCategory> <VRPTx:diffrn_standards diffrn_id="s1"> <VRPTx:decay_>0</VRPTx:decay_> <VRPTx:interval_time>120</VRPTx:interval_time> <VRPTx:number>3</VRPTx:number> </VRPTx:diffrn_standards> </VRPTx:diffrn_standardsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/diffrn_standards.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE diffrn_standards (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
	decay_ DECIMAL CHECK ( decay_ <= 100.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	interval_count INTEGER CHECK ( interval_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	interval_time DECIMAL CHECK ( interval_time >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number INTEGER CHECK ( number >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	scale_sigma DECIMAL CHECK ( scale_sigma >= 0.0 ) ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from em_2d_crystal_entityType)
-- Data items in the EM_SYMMETRY_2DX category record 2D crystal symmetry parameters utilized in a 3DEM reconstruction.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_2d_crystal_entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_2d_crystal_entity_space_group_name_H_M CASCADE;
CREATE TYPE ENUM_em_2d_crystal_entity_space_group_name_H_M AS ENUM ( 'P 1', 'P 2', 'P 1 2', 'P 1 21', 'C 1 2', 'P 2 2 2', 'P 2 2 21', 'P 2 21 21', 'C 2 2 2', 'P 4', 'P 4 2 2', 'P 4 21 2', 'P 3', 'P 3 1 2', 'P 3 2 1', 'P 6', 'P 6 2 2' );
CREATE TABLE em_2d_crystal_entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_gamma DECIMAL CHECK ( angle_gamma >= 0.0 AND angle_gamma <= 180.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	c_sampling_length DECIMAL CHECK ( c_sampling_length >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_a DECIMAL CHECK ( length_a >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_b DECIMAL CHECK ( length_b >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_c DECIMAL CHECK ( length_c >= 0.0 ) ,
	"space_group_name_H-M" ENUM_em_2d_crystal_entity_space_group_name_H_M ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_3d_crystal_entityType)
-- Data items in the EM_SYMMETRY_3DX category record 3D crystal symmetry parameters utilized in 3DEM reconstruction averaging.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_3d_crystal_entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_3d_crystal_entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_alpha DECIMAL CHECK ( angle_alpha >= 0.0 AND angle_alpha <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_beta DECIMAL CHECK ( angle_beta >= 0.0 AND angle_beta <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_gamma DECIMAL CHECK ( angle_gamma >= 0.0 AND angle_gamma <= 180.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_a DECIMAL CHECK ( length_a >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_b DECIMAL CHECK ( length_b >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	length_c DECIMAL CHECK ( length_c >= 0.0 ) ,
	space_group_name TEXT ,
-- xsd:restriction/xsd:maxInclusive="230"
-- xsd:restriction/xsd:minInclusive="1"
	space_group_num INTEGER CHECK ( space_group_num >= 1 AND space_group_num <= 230 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_3d_fittingType)
-- Data items in the 3D_FITTING category record details of the method of fitting atomic coordinates from a PDB file into a 3d-em volume map file Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_3d_fittingCategory> <VRPTx:em_3d_fitting entry_id="1DYL" id="1"> <VRPTx:details> THE CRYSTAL STRUCTURE OF THE CAPSID PROTEIN FROM CHOI ET AL (1997) PROTEINS 3 27:345-359 (SUBUNIT A OF PDB FILE 1VCQ) WAS PLACED INTO THE CRYO-EM DENSITY MAP. THE CAPSID PROTEIN WAS FIRST MANUALLY POSITIONED INTO THE CRYO-EM DENSITY CORRESPONDING TO POSITIONS OF THE FOUR INDEPENDENT MONOMER DENSITIES BETWEEN THE INNER LEAFLET OF THE BILAYER AND THE RNA. THESE POSITIONS WERE THEN REFINED BY RIGID BODY REFINEMENT IN REAL SPACE WITH THE PROGRAM EMFIT (CHENG ET AL. 1995, CELL 80, 621-630). THE QUALITY OF THE FIT CAN BE SEEN FROM THE MAP DENSITY WITHIN THE PROTEIN. ALL 4563 ATOMS ARE IN DENSITY OF AT LEAST 4 SIGMA (96.73) ABOVE THE AVERAGE (512.04), 1167 ATOMS ARE IN DENSITY BETWEEN 4 AND 5 SIGMA, 3174 ATOMS ARE IN DENSITY BETWEEN 5 AND 6 SIGMA, AND 222 ATOMS ARE IN DENSTY OF 6 SIGMA OR ABOVE. THE VARIATION IN DENSITY OVER THE FITTED PROTEIN CAN BE VISUALIZED WITH THE PSEUDO TEMPERATURE FACTOR. THE DENSITY VALUE AT EACH ATOM IS GIVEN IN THE 8TH COLUM (USUALLY THE OCCUPANCY) AS THE NUMBER OF STANDARD DEVIATION ABOVE BACKGROUND. COLUMN NINE (USUALLY THE TEMPERATURE FACTOR) CONTAINS THE VALUE OF THE RELATIVE DENSITY WITHIN THE FITTED PROTEIN SCALED LINEARLY SO THAT THE MINIMUM DENSITY IS 100.0 AND THE MAXIMUM DENSITY IS 1.0. THE ATOMS THAT LIE IN THE LOWER DENSITY REGIONS WILL HAVE THE HIGHEST PSEUDO TEMPERATURE FACTORS.</VRPTx:details> <VRPTx:method>AUTOMATIC</VRPTx:method> <VRPTx:overall_b_value xsi:nil="true" /> <VRPTx:ref_protocol>RIGID BODY REFINEMENT</VRPTx:ref_protocol> <VRPTx:ref_space>REAL</VRPTx:ref_space> <VRPTx:target_criteria>R-FACTOR</VRPTx:target_criteria> </VRPTx:em_3d_fitting> </VRPTx:em_3d_fittingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_3d_fitting.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_3d_fitting_ref_protocol CASCADE;
CREATE TYPE ENUM_em_3d_fitting_ref_protocol AS ENUM ( 'RIGID BODY FIT', 'FLEXIBLE FIT', 'BACKBONE TRACE', 'AB INITIO MODEL', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_3d_fitting_ref_space CASCADE;
CREATE TYPE ENUM_em_3d_fitting_ref_space AS ENUM ( 'REAL', 'RECIPROCAL' );
CREATE TABLE em_3d_fitting (
	details TEXT ,
	method TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	overall_b_value DECIMAL CHECK ( overall_b_value >= 0 ) ,
	ref_protocol ENUM_em_3d_fitting_ref_protocol ,
	ref_space ENUM_em_3d_fitting_ref_space ,
	target_criteria TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_3d_fitting_listType)
-- Data items in the 3D_FITTING_LIST category lists the methods of fitting atomic coordinates from a PDB file into a 3d-em volume map file Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_3d_fitting_listCategory> <VRPTx:em_3d_fitting_list _3d_fitting_id="l" id="1"> <VRPTx:pdb_chain_id xsi:nil="true" /> <VRPTx:pdb_entry_id>1VCQ</VRPTx:pdb_entry_id> </VRPTx:em_3d_fitting_list> </VRPTx:em_3d_fitting_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_3d_fitting_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_3d_fitting_list_source_name CASCADE;
CREATE TYPE ENUM_em_3d_fitting_list_source_name AS ENUM ( 'PDB', 'AlphaFold', 'RoseTTAFold', 'ModelArchive', 'SwissModel', 'Modeller', 'ITasser', 'Other' );
DROP TYPE IF EXISTS ENUM_em_3d_fitting_list_type CASCADE;
CREATE TYPE ENUM_em_3d_fitting_list_type AS ENUM ( 'in silico model', 'experimental model', 'integrative model', 'other' );
CREATE TABLE em_3d_fitting_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	accession_code TEXT ,
	details TEXT ,
	pdb_chain_id TEXT ,
	pdb_chain_residue_range TEXT ,
	pdb_entry_id TEXT ,
	source_name ENUM_em_3d_fitting_list_source_name ,
	type ENUM_em_3d_fitting_list_type ,
-- ATTRIBUTE
	_3d_fitting_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_3d_reconstructionType)
-- Data items in the EM_3D_RECONSTRUCTION category record details of the 3D reconstruction procedure from 2D projections. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_3d_reconstructionCategory> <VRPTx:em_3d_reconstruction id="1"> <VRPTx:actual_pixel_size>2.52</VRPTx:actual_pixel_size> <VRPTx:details xsi:nil="true" /> <VRPTx:entry_id>1DYL</VRPTx:entry_id> <VRPTx:method>CROSS-COMMON LINES</VRPTx:method> <VRPTx:nominal_pixel_size>2.64</VRPTx:nominal_pixel_size> <VRPTx:resolution>9</VRPTx:resolution> <VRPTx:resolution_method xsi:nil="true" /> </VRPTx:em_3d_reconstruction> </VRPTx:em_3d_reconstructionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_3d_reconstruction.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_3d_reconstruction_refinement_type CASCADE;
CREATE TYPE ENUM_em_3d_reconstruction_refinement_type AS ENUM ( 'HALF-MAPS REFINED AGAINST SAME DATA', 'HALF-MAPS REFINED INDEPENDENTLY', 'HALF-MAPS REFINED WITH FREQUENCY RANGE OMITTED', 'HALF-MAPS REFINED INDEPENDENTLY WITH FREQUENCY RANGE OMITTED', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_3d_reconstruction_symmetry_type CASCADE;
CREATE TYPE ENUM_em_3d_reconstruction_symmetry_type AS ENUM ( 'POINT', 'HELICAL', '2D CRYSTAL', '3D CRYSTAL' );
CREATE TABLE em_3d_reconstruction (
	actual_pixel_size DECIMAL ,
	algorithm TEXT ,
	citation_id TEXT ,
	details TEXT ,
-- IN-PLACE DOCUMENT KEY
	entry_id TEXT ,
	euler_angles_details TEXT ,
	magnification_calibration TEXT ,
	method TEXT ,
	nominal_pixel_size DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	num_class_averages INTEGER CHECK ( num_class_averages >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	num_particles INTEGER CHECK ( num_particles >= 0 ) ,
	refinement_type ENUM_em_3d_reconstruction_refinement_type ,
-- xsd:restriction/xsd:minInclusive="0.0"
	resolution DECIMAL CHECK ( resolution >= 0.0 ) ,
	resolution_method TEXT ,
	symmetry_type ENUM_em_3d_reconstruction_symmetry_type ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_adminType)
-- Administration-related data items Example 1 <VRPTx:em_adminCategory> <VRPTx:em_admin entry_id="D_100005"> <VRPTx:current_status>REL</VRPTx:current_status> <VRPTx:deposition_date>2008-12-01</VRPTx:deposition_date> <VRPTx:details xsi:nil="true" /> <VRPTx:last_update>2011-05-22</VRPTx:last_update> <VRPTx:map_release_date>2009-12-01</VRPTx:map_release_date> </VRPTx:em_admin> </VRPTx:em_adminCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_admin.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_admin_current_status CASCADE;
CREATE TYPE ENUM_em_admin_current_status AS ENUM ( 'PROC', 'WAIT', 'AUTH', 'REUP', 'REPL', 'AUXU', 'AUXS', 'AUCO', 'REFI', 'POLC', 'HPUB', 'HOLD', 'HOLD8W', 'REL', 'WDRN', 'OBS' );
DROP TYPE IF EXISTS ENUM_em_admin_deposition_site CASCADE;
CREATE TYPE ENUM_em_admin_deposition_site AS ENUM ( 'PDBE', 'RCSB', 'PDBJ', 'PDBC' );
CREATE TABLE em_admin (
	current_status ENUM_em_admin_current_status ,
-- map XSD date (xsd:date) to SQL DATE
	deposition_date DATE ,
	deposition_site ENUM_em_admin_deposition_site ,
	details TEXT ,
-- map XSD date (xsd:date) to SQL DATE
	last_update DATE ,
-- map XSD date (xsd:date) to SQL DATE
	map_release_date DATE ,
	title TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from em_bufferType)
-- Data items in the BUFFER category record details of the sample buffer.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_buffer.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_buffer (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	name TEXT ,
-- xsd:restriction/xsd:maxInclusive="14.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"pH" DECIMAL CHECK ( "pH" >= 0.0 AND "pH" <= 14.0 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	specimen_id TEXT NOT NULL
);

--
-- (quoted from em_buffer_componentType)
-- Buffer category
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_buffer_component.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_buffer_component (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	concentration DECIMAL CHECK ( concentration >= 0.0 ) ,
	concentration_units TEXT ,
	formula TEXT ,
	name TEXT ,
-- ATTRIBUTE
	buffer_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_crystal_formationType)
-- Description of growth of a 2D, 3D, or helical crystal array.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_crystal_formation.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_crystal_formation_time_unit CASCADE;
CREATE TYPE ENUM_em_crystal_formation_time_unit AS ENUM ( 'MINUTE', 'HOUR', 'DAY', 'MONTH', 'YEAR' );
CREATE TABLE em_crystal_formation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	atmosphere TEXT ,
	details TEXT ,
	instrument TEXT ,
	lipid_mixture TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	lipid_protein_ratio DECIMAL CHECK ( lipid_protein_ratio >= 0.0 ) ,
	specimen_id TEXT ,
-- omit an attribute having a fixed value: @units="kelvins"
	temperature TEXT ,
	time TEXT ,
	time_unit ENUM_em_crystal_formation_time_unit ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_ctf_correctionType)
-- Description of the Contrast Transfer Function (CTF) correction Example 1 - <VRPTx:em_ctf_correctionCategory> <VRPTx:em_ctf_correction id="1"> <VRPTx:em_image_processing_id>1</VRPTx:em_image_processing_id> <VRPTx:type>PHASE FLIPPING ONLY</VRPTx:type> </VRPTx:em_ctf_correction> </VRPTx:em_ctf_correctionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_ctf_correction.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_ctf_correction (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	em_image_processing_id TEXT ,
	type TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_diffractionType)
-- Microscopy parameters relevant only for crystallography Example 1 - <VRPTx:em_diffractionCategory> <VRPTx:em_diffraction id="1"> <VRPTx:camera_length>800</VRPTx:camera_length> <VRPTx:imaging_id>1</VRPTx:imaging_id> </VRPTx:em_diffraction> <VRPTx:em_diffraction id="2"> <VRPTx:camera_length>750</VRPTx:camera_length> <VRPTx:imaging_id>2</VRPTx:imaging_id> </VRPTx:em_diffraction> </VRPTx:em_diffractionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_diffraction.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_diffraction (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	camera_length DECIMAL CHECK ( camera_length >= 0.0 ) ,
	imaging_id TEXT ,
	tilt_angle_list TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_diffraction_shellType)
-- Statistical parameters for electron diffraction measurements within a resolution shell Example 1 - <VRPTx:em_diffraction_shellCategory> <VRPTx:em_diffraction_shell id="1"> <VRPTx:fourier_space_coverage>93.0</VRPTx:fourier_space_coverage> <VRPTx:high_resolution>7.5</VRPTx:high_resolution> <VRPTx:low_resolution>45</VRPTx:low_resolution> <VRPTx:multiplicity>2.3</VRPTx:multiplicity> <VRPTx:num_structure_factors>327</VRPTx:num_structure_factors> <VRPTx:phase_residual>13.5</VRPTx:phase_residual> </VRPTx:em_diffraction_shell> </VRPTx:em_diffraction_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_diffraction_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_diffraction_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	em_diffraction_stats_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	fourier_space_coverage DECIMAL CHECK ( fourier_space_coverage >= 0.0 AND fourier_space_coverage <= 100.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	high_resolution DECIMAL CHECK ( high_resolution >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	low_resolution DECIMAL CHECK ( low_resolution >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	multiplicity DECIMAL CHECK ( multiplicity >= 0.0 ) ,
	num_structure_factors TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	phase_residual DECIMAL CHECK ( phase_residual >= 0.0 AND phase_residual <= 180.0 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_diffraction_statsType)
-- Statistical parameters for electron diffraction measurements Example 1 - <VRPTx:em_diffraction_statsCategory> <VRPTx:em_diffraction_stats id="1"> <VRPTx:fourier_space_coverage>92</VRPTx:fourier_space_coverage> <VRPTx:high_resolution>7.2</VRPTx:high_resolution> <VRPTx:num_intensities_measured>1524</VRPTx:num_intensities_measured> <VRPTx:num_structure_factors>325</VRPTx:num_structure_factors> <VRPTx:overall_phase_error>18.6</VRPTx:overall_phase_error> <VRPTx:overall_phase_residual>9.5</VRPTx:overall_phase_residual> <VRPTx:phase_error_rejection_criteria>None</VRPTx:phase_error_rejection_criteria> <VRPTx:r_merge>19.5</VRPTx:r_merge> <VRPTx:r_sym>23.2</VRPTx:r_sym> </VRPTx:em_diffraction_stats> </VRPTx:em_diffraction_statsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_diffraction_stats.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_diffraction_stats (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	fourier_space_coverage DECIMAL CHECK ( fourier_space_coverage >= 0.0 AND fourier_space_coverage <= 100.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	high_resolution DECIMAL CHECK ( high_resolution >= 0.0 ) ,
	image_processing_id TEXT ,
	num_intensities_measured TEXT ,
	num_structure_factors TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	overall_phase_error DECIMAL CHECK ( overall_phase_error >= 0.0 AND overall_phase_error <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	overall_phase_residual DECIMAL CHECK ( overall_phase_residual >= 0.0 AND overall_phase_residual <= 180.0 ) ,
	phase_error_rejection_criteria TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	r_merge DECIMAL CHECK ( r_merge >= 0.0 AND r_merge <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	r_sym DECIMAL CHECK ( r_sym >= 0.0 AND r_sym <= 100.0 ) ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_embeddingType)
-- Sugar embedding category
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_embedding.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_embedding (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	material TEXT ,
	specimen_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_entity_assembly_molwtType)
-- Data items in this category record details about the molecular weight of an assembly component of the sample. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_entity_assembly_molwtCategory> <VRPTx:em_entity_assembly_molwt entity_assembly_id="1" id="1"> <VRPTx:units>MEGADALTONS</VRPTx:units> <VRPTx:value>30.5</VRPTx:value> </VRPTx:em_entity_assembly_molwt> </VRPTx:em_entity_assembly_molwtCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_entity_assembly_molwt.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_entity_assembly_molwt_experimental_flag CASCADE;
CREATE TYPE ENUM_em_entity_assembly_molwt_experimental_flag AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_entity_assembly_molwt_units CASCADE;
CREATE TYPE ENUM_em_entity_assembly_molwt_units AS ENUM ( 'MEGADALTONS', 'KILODALTONS/NANOMETER' );
CREATE TABLE em_entity_assembly_molwt (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	experimental_flag ENUM_em_entity_assembly_molwt_experimental_flag ,
	units ENUM_em_entity_assembly_molwt_units ,
-- xsd:restriction/xsd:minInclusive="0.0"
	value DECIMAL CHECK ( value >= 0.0 ) ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_entity_assembly_naturalsourceType)
-- Data items in this category record taxonomic details about the natural source for EM assemblies and assembly components. Example 1 - <VRPTx:em_entity_assembly_naturalsourceCategory> <VRPTx:em_entity_assembly_naturalsource entity_assembly_id="8333" id="1"> <VRPTx:cellular_location xsi:nil="true" /> <VRPTx:ncbi_tax_id>Escherichia coli</VRPTx:ncbi_tax_id> <VRPTx:organ xsi:nil="true" /> <VRPTx:organelle>cytoplasm</VRPTx:organelle> <VRPTx:organism>K12</VRPTx:organism> <VRPTx:strain xsi:nil="true" /> <VRPTx:tissue xsi:nil="true" /> </VRPTx:em_entity_assembly_naturalsource> </VRPTx:em_entity_assembly_naturalsourceCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_entity_assembly_naturalsource.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_entity_assembly_naturalsource (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	cell TEXT ,
	cellular_location TEXT ,
	ncbi_tax_id TEXT ,
	organ TEXT ,
	organelle TEXT ,
	organism TEXT ,
	strain TEXT ,
	tissue TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_entity_assembly_recombinantType)
-- Data items in this category record details about recombinant expression of the assembly or assembly component. Example 1 - <VRPTx:em_entity_assembly_recombinantCategory> <VRPTx:em_entity_assembly_recombinant entity_assembly_id="1" id="1"> <VRPTx:organism>Escherichia coli</VRPTx:organism> <VRPTx:plasmid>pET17c</VRPTx:plasmid> </VRPTx:em_entity_assembly_recombinant> </VRPTx:em_entity_assembly_recombinantCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_entity_assembly_recombinant.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_entity_assembly_recombinant (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	cell TEXT ,
	ncbi_tax_id TEXT ,
	organism TEXT ,
	plasmid TEXT ,
	strain TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_entity_assembly_syntheticType)
-- Data items in this category record taxonomic details about the synthetic source for EM assemblies and assembly components. Example 1 <VRPTx:em_entity_assembly_syntheticCategory> <VRPTx:em_entity_assembly_synthetic entity_assembly_id="1" id="1"> <VRPTx:cellular_location xsi:nil="true" /> <VRPTx:ncbi_tax_id>8333</VRPTx:ncbi_tax_id> <VRPTx:organ xsi:nil="true" /> <VRPTx:organelle xsi:nil="true" /> <VRPTx:organism>Escherichia coli</VRPTx:organism> <VRPTx:strain>K12</VRPTx:strain> <VRPTx:tissue xsi:nil="true" /> </VRPTx:em_entity_assembly_synthetic> </VRPTx:em_entity_assembly_syntheticCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_entity_assembly_synthetic.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_entity_assembly_synthetic (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	cell TEXT ,
	cellular_location TEXT ,
	ncbi_tax_id TEXT ,
	organ TEXT ,
	organelle TEXT ,
	organism TEXT ,
	strain TEXT ,
	tissue TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_experimentType)
-- Data items in the EM_EXPERIMENT category provide high-level classification of the EM experiment. Example 1 - based on PDB entry 1EG0 <VRPTx:em_experimentCategory> <VRPTx:em_experiment entry_id="1EG0"> <VRPTx:aggregation_state>PARTICLE</VRPTx:aggregation_state> <VRPTx:reconstruction_method>SINGLE PARTICLE</VRPTx:reconstruction_method> </VRPTx:em_experiment> </VRPTx:em_experimentCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_experiment.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_experiment_aggregation_state CASCADE;
CREATE TYPE ENUM_em_experiment_aggregation_state AS ENUM ( '2D ARRAY', '3D ARRAY', 'HELICAL ARRAY', 'FILAMENT', 'PARTICLE', 'TISSUE', 'CELL' );
DROP TYPE IF EXISTS ENUM_em_experiment_reconstruction_method CASCADE;
CREATE TYPE ENUM_em_experiment_reconstruction_method AS ENUM ( 'SINGLE PARTICLE', 'HELICAL', 'CRYSTALLOGRAPHY', 'SUBTOMOGRAM AVERAGING', 'TOMOGRAPHY' );
CREATE TABLE em_experiment (
	aggregation_state ENUM_em_experiment_aggregation_state ,
	entity_assembly_id TEXT ,
	id TEXT ,
	reconstruction_method ENUM_em_experiment_reconstruction_method ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from em_helical_entityType)
-- Data items in the EM_HELICAL_ENTITY category record details for a helical or filament type of assembly component.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_helical_entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_helical_entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="-180.0"
	angular_rotation_per_subunit DECIMAL CHECK ( angular_rotation_per_subunit >= -180.0 AND angular_rotation_per_subunit <= 180.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	axial_rise_per_subunit DECIMAL CHECK ( axial_rise_per_subunit >= 0.0 ) ,
	axial_symmetry TEXT ,
	details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_image_processingType)
-- Data items in the EM_IMAGE_PROCESSING category record details of the EM image processing procedure. Example 1 - <VRPTx:em_image_processingCategory> <VRPTx:em_image_processing id="1" image_recording_id="1"> <VRPTx:details>The selected images were high-pass filtered and normalized</VRPTx:details> </VRPTx:em_image_processing> </VRPTx:em_image_processingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_image_processing.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_image_processing (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_recording_id TEXT NOT NULL
);

--
-- (quoted from em_image_recordingType)
-- Data items in the EM_IMAGE_RECORDING category record details of the image recording (either film/microdensitometer or electronic detector) and parameters for image digitization. Example 1 - images collected on film <VRPTx:em_image_recordingCategory> <VRPTx:em_image_recording id="1" imaging_id="1"> <VRPTx:avg_electron_dose_per_image>0.9</VRPTx:avg_electron_dose_per_image> <VRPTx:film_or_detector_model>GENERIC FILM</VRPTx:film_or_detector_model> <VRPTx:num_diffraction_images>48</VRPTx:num_diffraction_images> </VRPTx:em_image_recording> </VRPTx:em_image_recordingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_image_recording.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_image_recording_detector_mode CASCADE;
CREATE TYPE ENUM_em_image_recording_detector_mode AS ENUM ( 'COUNTING', 'INTEGRATING', 'SUPER-RESOLUTION', 'OTHER' );
CREATE TABLE em_image_recording (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="240.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	average_exposure_time DECIMAL CHECK ( average_exposure_time >= 0.0 AND average_exposure_time <= 240.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	avg_electron_dose_per_image DECIMAL CHECK ( avg_electron_dose_per_image >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	avg_electron_dose_per_subtomogram DECIMAL CHECK ( avg_electron_dose_per_subtomogram >= 0.0 ) ,
	details TEXT ,
	detector_mode ENUM_em_image_recording_detector_mode ,
	film_or_detector_model TEXT ,
	num_diffraction_images TEXT ,
	num_grids_imaged TEXT ,
	num_real_images TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	imaging_id TEXT NOT NULL
);

--
-- (quoted from em_image_scansType)
-- Data items in the EM_IMAGE_SCANS category record details of the image scanning device (microdensitometer) and parameters for digitization of the image. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_image_scansCategory> <VRPTx:em_image_scans id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:entry_id>1DYL</VRPTx:entry_id> <VRPTx:number_digital_images>48</VRPTx:number_digital_images> <VRPTx:od_range xsi:nil="true" /> <VRPTx:quant_bit_size xsi:nil="true" /> <VRPTx:sampling_size xsi:nil="true" /> <VRPTx:scanner_model xsi:nil="true" /> </VRPTx:em_image_scans> </VRPTx:em_image_scansCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_image_scans.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_image_scans_scanner_model CASCADE;
CREATE TYPE ENUM_em_image_scans_scanner_model AS ENUM ( 'ZEISS SCAI', 'EMIL 10', 'OPTRONICS', 'PERKIN ELMER', 'TEMSCAN', 'EIKONIX IEEE 488', 'NIKON COOLSCAN', 'NIKON SUPER COOLSCAN 9000', 'IMAGE SCIENCE PATCHWORK DENSITOMETER', 'PRIMESCAN', 'OTHER' );
CREATE TABLE em_image_scans (
	citation_id TEXT ,
	details TEXT ,
	dimension_height TEXT ,
	dimension_width TEXT ,
-- IN-PLACE DOCUMENT KEY
	entry_id TEXT ,
	frames_per_image TEXT ,
	number_digital_images INTEGER ,
	od_range DECIMAL ,
	quant_bit_size INTEGER ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	sampling_size DECIMAL CHECK ( sampling_size >= 0.0 AND sampling_size <= 100.0 ) ,
	scanner_model ENUM_em_image_scans_scanner_model ,
	used_frames_per_image TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_recording_id TEXT NOT NULL
);

--
-- (quoted from em_imagingType)
-- Data items in the EM_IMAGING category record details about the parameters used in imaging the sample in the electron microscope. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_imagingCategory> <VRPTx:em_imaging entry_id="1DYL" id="1"> <VRPTx:accelerating_voltage>200</VRPTx:accelerating_voltage> <VRPTx:calibrated_magnification xsi:nil="true" /> <VRPTx:date>1998-15-06</VRPTx:date> <VRPTx:details xsi:nil="true" /> <VRPTx:detector_distance xsi:nil="true" /> <VRPTx:electron_source>FEG</VRPTx:electron_source> <VRPTx:illumination_mode>bright field</VRPTx:illumination_mode> <VRPTx:microscope_model>FEI/PHILIPS CM200 FEG</VRPTx:microscope_model> <VRPTx:mode>low dose</VRPTx:mode> <VRPTx:nominal_cs>2.0</VRPTx:nominal_cs> <VRPTx:nominal_defocus_max>7600</VRPTx:nominal_defocus_max> <VRPTx:nominal_defocus_min>975</VRPTx:nominal_defocus_min> <VRPTx:nominal_magnification>50000</VRPTx:nominal_magnification> <VRPTx:recording_temperature_maximum xsi:nil="true" /> <VRPTx:recording_temperature_minimum xsi:nil="true" /> <VRPTx:specimen_holder_model>gatan 626-0300</VRPTx:specimen_holder_model> <VRPTx:specimen_holder_type>cryotransfer</VRPTx:specimen_holder_type> <VRPTx:temperature>95</VRPTx:temperature> <VRPTx:tilt_angle_max>0</VRPTx:tilt_angle_max> <VRPTx:tilt_angle_min>0</VRPTx:tilt_angle_min> </VRPTx:em_imaging> </VRPTx:em_imagingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_imaging.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_imaging_alignment_procedure CASCADE;
CREATE TYPE ENUM_em_imaging_alignment_procedure AS ENUM ( 'NONE', 'BASIC', 'ZEMLIN TABLEAU', 'COMA FREE', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_imaging_cryogen CASCADE;
CREATE TYPE ENUM_em_imaging_cryogen AS ENUM ( 'NITROGEN', 'HELIUM' );
DROP TYPE IF EXISTS ENUM_em_imaging_illumination_mode CASCADE;
CREATE TYPE ENUM_em_imaging_illumination_mode AS ENUM ( 'FLOOD BEAM', 'SPOT SCAN', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_imaging_microscope_model CASCADE;
CREATE TYPE ENUM_em_imaging_microscope_model AS ENUM ( 'FEI MORGAGNI', 'FEI POLARA 300', 'FEI TALOS ARCTICA', 'FEI TECNAI 10', 'FEI TECNAI 12', 'FEI TECNAI 20', 'FEI TECNAI F20', 'FEI TECNAI F30', 'FEI TECNAI ARCTICA', 'FEI TECNAI SPHERA', 'FEI TECNAI SPIRIT', 'FEI TITAN', 'FEI TITAN KRIOS', 'FEI/PHILIPS CM10', 'FEI/PHILIPS CM12', 'FEI/PHILIPS CM120T', 'FEI/PHILIPS CM200FEG', 'FEI/PHILIPS CM200FEG/SOPHIE', 'FEI/PHILIPS CM200FEG/ST', 'FEI/PHILIPS CM200FEG/UT', 'FEI/PHILIPS CM200T', 'FEI/PHILIPS CM300FEG/HE', 'FEI/PHILIPS CM300FEG/ST', 'FEI/PHILIPS CM300FEG/T', 'FEI/PHILIPS EM400', 'FEI/PHILIPS EM420', 'HITACHI EF2000', 'HITACHI EF3000', 'HITACHI H7600', 'HITACHI HF2000', 'HITACHI HF3000', 'HITACHI H3000 UHVEM', 'HITACHI H-9500SD', 'JEOL 100B', 'JEOL 100CX', 'JEOL 1010', 'JEOL 1000EES', 'JEOL 1200', 'JEOL 1200EX', 'JEOL 1200EXII', 'JEOL 1230', 'JEOL 1400', 'JEOL 2000EX', 'JEOL 2000EXII', 'JEOL 2010', 'JEOL 2010F', 'JEOL 2010HT', 'JEOL 2010HC', 'JEOL 2010UHR', 'JEOL 2011', 'JEOL 2100', 'JEOL 2100F', 'JEOL 2200FS', 'JEOL 2200FSC', 'JEOL 3000SFF', 'JEOL 3100FEF', 'JEOL 3100FFC', 'JEOL 3200FS', 'JEOL 3200FSC', 'JEOL KYOTO-3000SFF', 'JEOL 4000', 'JEOL 4000EX', 'JEOL CRYO ARM 200', 'JEOL CRYO ARM 300', 'SIEMENS SULEIKA', 'TFS GLACIOS', 'TFS KRIOS', 'TFS TALOS', 'TFS TALOS F200C', 'TFS TALOS L120C', 'TFS TUNDRA', 'ZEISS LEO912', 'ZEISS LIBRA120PLUS' );
DROP TYPE IF EXISTS ENUM_em_imaging_mode CASCADE;
CREATE TYPE ENUM_em_imaging_mode AS ENUM ( 'BRIGHT FIELD', 'DARK FIELD', 'DIFFRACTION', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_imaging_specimen_holder_model CASCADE;
CREATE TYPE ENUM_em_imaging_specimen_holder_model AS ENUM ( 'FEI TITAN KRIOS AUTOGRID HOLDER', 'FISCHIONE 2550', 'FISCHIONE INSTRUMENTS DUAL AXIS TOMOGRAPHY HOLDER', 'GATAN 626 SINGLE TILT LIQUID NITROGEN CRYO TRANSFER HOLDER', 'GATAN 910 MULTI-SPECIMEN SINGLE TILT CRYO TRANSFER HOLDER', 'GATAN 914 HIGH TILT LIQUID NITROGEN CRYO TRANSFER TOMOGRAPHY HO', 'GATAN 915 DOUBLE TILT LIQUID NITROGEN CRYO TRANSFER HOLDER', 'GATAN CHDT 3504 DOUBLE TILT HIGH RESOLUTION NITROGEN COOLING HO', 'GATAN CT3500 SINGLE TILT LIQUID NITROGEN CRYO TRANSFER HOLDER', 'GATAN CT3500TR SINGLE TILT ROTATION LIQUID NITROGEN CRYO TRANSF', 'GATAN ELSA 698 SINGLE TILT LIQUID NITROGEN CRYO TRANSFER HOLDER', 'GATAN HC 3500 SINGLE TILT HEATING/NITROGEN COOLING HOLDER', 'GATAN HCHDT 3010 DOUBLE TILT HIGH RESOLUTION HELIUM COOLING HOL', 'GATAN HCHST 3008 SINGLE TILT HIGH RESOLUTION HELIUM COOLING HOL', 'GATAN HELIUM', 'GATAN LIQUID NITROGEN', 'GATAN UHRST 3500 SINGLE TILT ULTRA HIGH RESOLUTION NITROGEN COO', 'GATAN ULTDT ULTRA LOW TEMPERATURE DOUBLE TILT HELIUM COOLING HO', 'GATAN ULTST ULTRA LOW TEMPERATURE SINGLE TILT HELIUM COOLING HO', 'HOME BUILD', 'JEOL', 'JEOL CRYOSPECPORTER', 'JEOL 3200FSC CRYOHOLDER', 'PHILIPS ROTATION HOLDER', 'SIDE ENTRY, EUCENTRIC', 'OTHER' );
CREATE TABLE em_imaging (
-- xsd:restriction/xsd:minInclusive="0"
	accelerating_voltage INTEGER CHECK ( accelerating_voltage >= 0 ) ,
	alignment_procedure ENUM_em_imaging_alignment_procedure ,
	astigmatism TEXT ,
-- xsd:restriction/xsd:maxInclusive="150"
-- xsd:restriction/xsd:minInclusive="1"
	c2_aperture_diameter DECIMAL CHECK ( c2_aperture_diameter >= 1 AND c2_aperture_diameter <= 150 ) ,
-- xsd:restriction/xsd:maxInclusive="30000"
-- xsd:restriction/xsd:minInclusive="-30000"
	calibrated_defocus_max DECIMAL CHECK ( calibrated_defocus_max >= -30000 AND calibrated_defocus_max <= 30000 ) ,
-- omit an attribute having a fixed value: @units="nanometers"
	calibrated_defocus_min DECIMAL ,
-- xsd:restriction/xsd:minInclusive="1"
	calibrated_magnification INTEGER CHECK ( calibrated_magnification >= 1 ) ,
	citation_id TEXT ,
	cryogen ENUM_em_imaging_cryogen ,
-- map XSD date (xsd:date) to SQL DATE
	date DATE ,
	details TEXT ,
-- omit an attribute having a fixed value: @units="millimetres"
	detector_distance DECIMAL ,
	electron_beam_tilt_params TEXT ,
	electron_source TEXT ,
	illumination_mode ENUM_em_imaging_illumination_mode ,
	microscope_model ENUM_em_imaging_microscope_model ,
	mode ENUM_em_imaging_mode ,
-- xsd:restriction/xsd:maxInclusive="20"
-- xsd:restriction/xsd:minInclusive="0"
	nominal_cs DECIMAL CHECK ( nominal_cs >= 0 AND nominal_cs <= 20 ) ,
-- omit an attribute having a fixed value: @units="nanometers"
	nominal_defocus_max DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometers"
	nominal_defocus_min DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="500000"
-- xsd:restriction/xsd:minInclusive="1000"
	nominal_magnification INTEGER CHECK ( nominal_magnification >= 1000 AND nominal_magnification <= 500000 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	recording_temperature_maximum DECIMAL CHECK ( recording_temperature_maximum >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	recording_temperature_minimum DECIMAL CHECK ( recording_temperature_minimum >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	residual_tilt DECIMAL CHECK ( residual_tilt >= 0.0 ) ,
	specimen_holder_model ENUM_em_imaging_specimen_holder_model ,
	specimen_holder_type TEXT ,
	specimen_id TEXT ,
-- omit an attribute having a fixed value: @units="kelvins"
	temperature TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	tilt_angle_max DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tilt_angle_min DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_imaging_opticsType)
-- Description of a few specialist optics apparatus Example 1 - <VRPTx:em_imaging_opticsCategory> <VRPTx:em_imaging_optics id="1" imaging_id="1"> <VRPTx:chr_aberration_corrector>CEOS manufactured Cc corrector</VRPTx:chr_aberration_corrector> <VRPTx:energyfilter_lower>0</VRPTx:energyfilter_lower> <VRPTx:energyfilter_name>FEI</VRPTx:energyfilter_name> <VRPTx:energyfilter_upper>15</VRPTx:energyfilter_upper> </VRPTx:em_imaging_optics> </VRPTx:em_imaging_opticsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_imaging_optics.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_imaging_optics (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	chr_aberration_corrector TEXT ,
	details TEXT ,
-- omit an attribute having a fixed value: @units="electron_volts"
	energyfilter_lower TEXT ,
	energyfilter_name TEXT ,
-- xsd:restriction/xsd:maxInclusive="1000.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	energyfilter_slit_width DECIMAL CHECK ( energyfilter_slit_width >= 0.0 AND energyfilter_slit_width <= 1000.0 ) ,
-- omit an attribute having a fixed value: @units="electron_volts"
	energyfilter_upper TEXT ,
	phase_plate TEXT ,
	sph_aberration_corrector TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	imaging_id TEXT NOT NULL
);

--
-- (quoted from em_particle_selectionType)
-- Data items in this category record details of images from scanned micrographs and the number of particles selected from a scanned set of micrographs. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_particle_selectionCategory> <VRPTx:em_particle_selection id="1" image_processing_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:method>INTERACTIVE</VRPTx:method> <VRPTx:num_particles_selected>5267</VRPTx:num_particles_selected> </VRPTx:em_particle_selection> </VRPTx:em_particle_selectionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_particle_selection.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_particle_selection (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	method TEXT ,
	num_particles_selected TEXT ,
	reference_model TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_single_particle_entityType)
-- Data items in the EM_SINGLE_PARTICLE_ENTITY category provide the details of the symmetry for a single particle entity type. Example 1 - <VRPTx:em_single_particle_entityCategory> <VRPTx:em_single_particle_entity id="1" image_processing_id="1"> <VRPTx:point_symmetry>I</VRPTx:point_symmetry> </VRPTx:em_single_particle_entity> </VRPTx:em_single_particle_entityCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_single_particle_entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_single_particle_entity (
-- IN-PLACE DOCUMENT KEY
	entry_id TEXT ,
	point_symmetry TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from em_softwareType)
-- Description of the software that was used for data collection, data processing, data analysis, structure calculations and refinement. The description should include the name of the software, the author of the software and the version used. Example 1 - <VRPTx:em_softwareCategory> <VRPTx:em_software id="1"> <VRPTx:category>IMAGE ACQUISITION</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>Leginon</VRPTx:name> <VRPTx:version>1.3</VRPTx:version> </VRPTx:em_software> <VRPTx:em_software id="2"> <VRPTx:category>PARTICLE SELECTION</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>X3D</VRPTx:name> <VRPTx:version xsi:nil="true" /> </VRPTx:em_software> <VRPTx:em_software id="3"> <VRPTx:category>BACKGROUND MASKING</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>bsoft</VRPTx:name> <VRPTx:version>1.1</VRPTx:version> </VRPTx:em_software> <VRPTx:em_software id="4"> <VRPTx:category>RECONSTRUCTION</VRPTx:category> <VRPTx:details>em3dr2 -low 20</VRPTx:details> <VRPTx:name>EM2DR2</VRPTx:name> <VRPTx:version>3.2</VRPTx:version> </VRPTx:em_software> <VRPTx:em_software id="5"> <VRPTx:category>EULER ASSIGNMENT</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>erandom</VRPTx:name> <VRPTx:version xsi:nil="true" /> </VRPTx:em_software> <VRPTx:em_software id="6"> <VRPTx:category>CTF CORRECTION</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>bctf</VRPTx:name> <VRPTx:version xsi:nil="true" /> </VRPTx:em_software> <VRPTx:em_software id="7"> <VRPTx:category>MODEL FITTING</VRPTx:category> <VRPTx:details xsi:nil="true" /> <VRPTx:name>chimera</VRPTx:name> <VRPTx:version>1.6</VRPTx:version> </VRPTx:em_software> </VRPTx:em_softwareCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_software.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_software_category CASCADE;
CREATE TYPE ENUM_em_software_category AS ENUM ( 'IMAGE ACQUISITION', 'PARTICLE SELECTION', 'VOLUME SELECTION', 'CLASSIFICATION', 'MASKING', 'RECONSTRUCTION', 'INITIAL EULER ASSIGNMENT', 'FINAL EULER ASSIGNMENT', 'CTF CORRECTION', 'LAYERLINE INDEXING', 'DIFFRACTION INDEXING', 'MODEL FITTING', 'MODEL REFINEMENT', 'SERIES ALIGNMENT', 'MOLECULAR REPLACEMENT', 'LATTICE DISTORTION CORRECTION', 'SYMMETRY DETERMINATION', 'CRYSTALLOGRAPHY MERGING', 'EWALD SPHERE CORRECTION', 'OTHER' );
CREATE TABLE em_software (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	category ENUM_em_software_category ,
	details TEXT ,
	fitting_id TEXT ,
	image_processing_id TEXT ,
	imaging_id TEXT ,
	name TEXT ,
	version TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_specimenType)
-- Data items in the EMD_SPECIMEN category record details about specimens prepared for imaging by electron microscopy. Example 1 - based on PDB 2FL8 <VRPTx:em_specimenCategory> <VRPTx:em_specimen experiment_id="1" id="1"> <VRPTx:embedding_applied>NO</VRPTx:embedding_applied> <VRPTx:shadowing_applied>NO</VRPTx:shadowing_applied> <VRPTx:staining_applied>NO</VRPTx:staining_applied> <VRPTx:vitrification_applied>YES</VRPTx:vitrification_applied> </VRPTx:em_specimen> </VRPTx:em_specimenCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_specimen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_specimen_embedding_applied CASCADE;
CREATE TYPE ENUM_em_specimen_embedding_applied AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_specimen_shadowing_applied CASCADE;
CREATE TYPE ENUM_em_specimen_shadowing_applied AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_specimen_staining_applied CASCADE;
CREATE TYPE ENUM_em_specimen_staining_applied AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_specimen_vitrification_applied CASCADE;
CREATE TYPE ENUM_em_specimen_vitrification_applied AS ENUM ( 'YES', 'NO' );
CREATE TABLE em_specimen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	concentration DECIMAL CHECK ( concentration >= 0.0 ) ,
	details TEXT ,
	embedding_applied ENUM_em_specimen_embedding_applied ,
	shadowing_applied ENUM_em_specimen_shadowing_applied ,
	staining_applied ENUM_em_specimen_staining_applied ,
	vitrification_applied ENUM_em_specimen_vitrification_applied ,
-- ATTRIBUTE
	experiment_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_stainingType)
-- Staining category Example 1 - <VRPTx:em_stainingCategory> <VRPTx:em_staining id="1"> <VRPTx:material>Uranyl Acetate</VRPTx:material> <VRPTx:specimen_id>1</VRPTx:specimen_id> <VRPTx:type>NEGATIVE</VRPTx:type> </VRPTx:em_staining> </VRPTx:em_stainingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_staining.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_staining_type CASCADE;
CREATE TYPE ENUM_em_staining_type AS ENUM ( 'NEGATIVE', 'POSITIVE', 'NONE' );
CREATE TABLE em_staining (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	material TEXT ,
	specimen_id TEXT ,
	type ENUM_em_staining_type ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_virus_entityType)
-- Data items in the EM_VIRUS_ENTITY category record details of the icosahedral virus. Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_virus_entityCategory> <VRPTx:em_virus_entity entity_assembly_id="1" id="1"> <VRPTx:empty>NO</VRPTx:empty> <VRPTx:enveloped>YES</VRPTx:enveloped> <VRPTx:virus_host_category>VERTERBRATES</VRPTx:virus_host_category> <VRPTx:virus_isolate>STRAIN</VRPTx:virus_isolate> <VRPTx:virus_type>VIRUS</VRPTx:virus_type> </VRPTx:em_virus_entity> </VRPTx:em_virus_entityCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_virus_entity.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_virus_entity_empty CASCADE;
CREATE TYPE ENUM_em_virus_entity_empty AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_virus_entity_enveloped CASCADE;
CREATE TYPE ENUM_em_virus_entity_enveloped AS ENUM ( 'YES', 'NO' );
DROP TYPE IF EXISTS ENUM_em_virus_entity_virus_isolate CASCADE;
CREATE TYPE ENUM_em_virus_entity_virus_isolate AS ENUM ( 'STRAIN', 'SEROTYPE', 'SEROCOMPLEX', 'SUBSPECIES', 'SPECIES', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_virus_entity_virus_type CASCADE;
CREATE TYPE ENUM_em_virus_entity_virus_type AS ENUM ( 'VIRION', 'SATELLITE', 'PRION', 'VIROID', 'VIRUS-LIKE PARTICLE' );
CREATE TABLE em_virus_entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	empty ENUM_em_virus_entity_empty ,
	enveloped ENUM_em_virus_entity_enveloped ,
	virus_host_category TEXT ,
	virus_isolate ENUM_em_virus_entity_virus_isolate ,
	virus_type ENUM_em_virus_entity_virus_type ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_virus_natural_hostType)
-- Data items in this category record details of a virus entity.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_virus_natural_host.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_virus_natural_host (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ncbi_tax_id TEXT ,
	organism TEXT ,
	strain TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_virus_shellType)
-- Data items in the EMD_VIRUS_SHELL category record details of the viral shell number, shell diameter, and icosahedral triangulation number. Example 1 - Bluetongue Virus <VRPTx:em_virus_shellCategory> <VRPTx:em_virus_shell entity_assembly_id="1" id="1"> <VRPTx:diameter>348</VRPTx:diameter> <VRPTx:name>VP7 layer</VRPTx:name> <VRPTx:triangulation>13</VRPTx:triangulation> </VRPTx:em_virus_shell> <VRPTx:em_virus_shell entity_assembly_id="1" id="2"> <VRPTx:diameter>348</VRPTx:diameter> <VRPTx:name>VP3 layer</VRPTx:name> <VRPTx:triangulation>2</VRPTx:triangulation> </VRPTx:em_virus_shell> </VRPTx:em_virus_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_virus_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_virus_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	diameter DECIMAL CHECK ( diameter >= 0.0 ) ,
	name TEXT ,
	triangulation TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_virus_syntheticType)
-- Data items in this category record details of a synthetic virus entity.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_virus_synthetic.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_virus_synthetic (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ncbi_tax_id TEXT ,
	organism TEXT ,
	strain TEXT ,
-- ATTRIBUTE
	entity_assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from em_vitrificationType)
-- Data items in the EM_VITRIFICATION category record details about the method and cryogen used in rapid freezing of the sample on the grid prior to its insertion in the electron microscope Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_vitrificationCategory> <VRPTx:em_vitrification id="1"> <VRPTx:cryogen_name>ETHANE</VRPTx:cryogen_name> <VRPTx:details> SAMPLES WERE PREPARED AS THIN LAYERS OF VITREOUS ICE AND MAINTAINED AT NEAR LIQUID NITROGEN TEMPERATURE IN THE ELECTRON MICROSCOPE WITH A GATAN 626-0300 CRYOTRANSFER HOLDER.</VRPTx:details> <VRPTx:entry_id>1DYL</VRPTx:entry_id> <VRPTx:humidity>90</VRPTx:humidity> <VRPTx:instrument xsi:nil="true" /> <VRPTx:method>PLUNGE VITRIFICATION</VRPTx:method> <VRPTx:temp>95</VRPTx:temp> <VRPTx:time_resolved_state xsi:nil="true" /> </VRPTx:em_vitrification> </VRPTx:em_vitrificationCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_vitrification.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_em_vitrification_cryogen_name CASCADE;
CREATE TYPE ENUM_em_vitrification_cryogen_name AS ENUM ( 'HELIUM', 'NITROGEN', 'PROPANE', 'ETHANE', 'ETHANE-PROPANE', 'METHANE', 'FREON 22', 'FREON 12', 'OTHER' );
DROP TYPE IF EXISTS ENUM_em_vitrification_instrument CASCADE;
CREATE TYPE ENUM_em_vitrification_instrument AS ENUM ( 'EMS-002 RAPID IMMERSION FREEZER', 'FEI VITROBOT MARK I', 'FEI VITROBOT MARK II', 'FEI VITROBOT MARK III', 'FEI VITROBOT MARK IV', 'GATAN CRYOPLUNGE 3', 'HOMEMADE PLUNGER', 'LEICA PLUNGER', 'LEICA EM GP', 'LEICA EM CPC', 'LEICA KF80', 'REICHERT-JUNG PLUNGER', 'SPOTITON', 'ZEISS PLUNGE FREEZER CRYOBOX' );
CREATE TABLE em_vitrification (
-- xsd:restriction/xsd:minInclusive="0.0"
	chamber_temperature DECIMAL CHECK ( chamber_temperature >= 0.0 ) ,
	citation_id TEXT ,
	cryogen_name ENUM_em_vitrification_cryogen_name ,
	details TEXT ,
-- IN-PLACE DOCUMENT KEY
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	humidity DECIMAL CHECK ( humidity >= 0.0 AND humidity <= 100.0 ) ,
	instrument ENUM_em_vitrification_instrument ,
	method TEXT ,
-- omit an attribute having a fixed value: @units="kelvins"
	temp DECIMAL ,
	time_resolved_state TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	specimen_id TEXT NOT NULL
);

--
-- (quoted from em_volume_selectionType)
-- Volume selection in image processing Example 1 - based on PDB entry 1DYL and laboratory records for the structure corresponding to PDB entry 1DYL <VRPTx:em_volume_selectionCategory> <VRPTx:em_volume_selection id="1" image_processing_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:method>INTERACTIVE</VRPTx:method> <VRPTx:num_volumes_extracted>5267</VRPTx:num_volumes_extracted> </VRPTx:em_volume_selection> </VRPTx:em_volume_selectionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/em_volume_selection.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE em_volume_selection (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	method TEXT ,
	num_tomograms TEXT ,
	num_volumes_extracted TEXT ,
	reference_model TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	image_processing_id TEXT NOT NULL
);

--
-- (quoted from entity_name_comType)
-- Data items in the ENTITY_NAME_COM category record the common name or names associated with the entity. In some cases, the entity name may not be the same as the name of the biological structure. For example, haemoglobin alpha chain would be the entity common name, not haemoglobin. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entity_name_comCategory> <VRPTx:entity_name_com entity_id="1"> <VRPTx:name>HIV-1 protease monomer</VRPTx:name> </VRPTx:entity_name_com> <VRPTx:entity_name_com entity_id="1"> <VRPTx:name>HIV-1 PR monomer</VRPTx:name> </VRPTx:entity_name_com> <VRPTx:entity_name_com entity_id="2"> <VRPTx:name>acetyl-pepstatin</VRPTx:name> </VRPTx:entity_name_com> <VRPTx:entity_name_com entity_id="2"> <VRPTx:name>acetyl-Ile-Val-Asp-Statine-Ala-Ile-Statine</VRPTx:name> </VRPTx:entity_name_com> <VRPTx:entity_name_com entity_id="3"> <VRPTx:name>water</VRPTx:name> </VRPTx:entity_name_com> </VRPTx:entity_name_comCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entity_name_com.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_entity_name_com_pdbx_provenance CASCADE;
CREATE TYPE ENUM_entity_name_com_pdbx_provenance AS ENUM ( 'UNIPROT', 'AUTHOR' );
CREATE TABLE entity_name_com (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	name TEXT ,
	pdbx_provenance ENUM_entity_name_com_pdbx_provenance ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL
);

--
-- (quoted from entity_name_sysType)
-- Data items in the ENTITY_NAME_SYS category record the systematic name or names associated with the entity and the system that was used to construct the systematic name. In some cases, the entity name may not be the same as the name of the biological structure. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:entity_name_sysCategory> <VRPTx:entity_name_sys entity_id="1"> <VRPTx:name>EC 3.4.23.16</VRPTx:name> </VRPTx:entity_name_sys> <VRPTx:entity_name_sys entity_id="2"> <VRPTx:name>acetyl-Ile-Val-Asp-Sta-Ala-Ile-Sta</VRPTx:name> </VRPTx:entity_name_sys> <VRPTx:entity_name_sys entity_id="3"> <VRPTx:name>water</VRPTx:name> </VRPTx:entity_name_sys> </VRPTx:entity_name_sysCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entity_name_sys.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE entity_name_sys (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	name TEXT ,
	system TEXT ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL
);

--
-- (quoted from entry_linkType)
-- Data items in the ENTRY_LINK category record the relationships between the current data block identified by attribute id in category entry and other data blocks within the current file which may be referenced in the current data block. Example 1 - example file for the one-dimensional incommensurately modulated structure of K~2~SeO~4~. <VRPTx:entry_linkCategory> <VRPTx:entry_link entry_id="KSE_TEXT" id="KSE_COM"> <VRPTx:details>experimental data common to ref./mod. structures</VRPTx:details> </VRPTx:entry_link> <VRPTx:entry_link entry_id="KSE_TEXT" id="KSE_REF"> <VRPTx:details>reference structure</VRPTx:details> </VRPTx:entry_link> <VRPTx:entry_link entry_id="KSE_TEXT" id="KSE_MOD"> <VRPTx:details>modulated structure</VRPTx:details> </VRPTx:entry_link> </VRPTx:entry_linkCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/entry_link.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE entry_link (
	details TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from exptlType)
-- Data items in the EXPTL category record details about the experimental work prior to the intensity measurements and details about the absorption-correction technique employed. Example 1 - based on laboratory records for Yb(S-C5H4N)2(THF)4. <VRPTx:exptlCategory> <VRPTx:exptl entry_id="datablock1" method="single-crystal x-ray diffraction"> <VRPTx:absorpt_coefficient_mu>1.22</VRPTx:absorpt_coefficient_mu> <VRPTx:absorpt_correction_T_max>0.896</VRPTx:absorpt_correction_T_max> <VRPTx:absorpt_correction_T_min>0.802</VRPTx:absorpt_correction_T_min> <VRPTx:absorpt_correction_type>integration</VRPTx:absorpt_correction_type> <VRPTx:absorpt_process_details> Gaussian grid method from SHELX76 Sheldrick, G. M., &quot;SHELX-76: structure determination and refinement program&quot;, Cambridge University, UK, 1976</VRPTx:absorpt_process_details> <VRPTx:crystals_number>1</VRPTx:crystals_number> <VRPTx:details> Enraf-Nonius LT2 liquid nitrogen variable-temperature device used</VRPTx:details> <VRPTx:method_details> graphite monochromatized Cu K(alpha) fixed tube and Enraf-Nonius CAD4 diffractometer used</VRPTx:method_details> </VRPTx:exptl> </VRPTx:exptlCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/exptl.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_exptl_absorpt_correction_type CASCADE;
CREATE TYPE ENUM_exptl_absorpt_correction_type AS ENUM ( 'analytical', 'cylinder', 'empirical', 'gaussian', 'integration', 'multi-scan', 'none', 'numerical', 'psi-scan', 'refdelf', 'sphere' );
DROP TYPE IF EXISTS ENUM_exptl_method CASCADE;
CREATE TYPE ENUM_exptl_method AS ENUM ( 'X-RAY DIFFRACTION', 'NEUTRON DIFFRACTION', 'FIBER DIFFRACTION', 'ELECTRON CRYSTALLOGRAPHY', 'ELECTRON MICROSCOPY', 'SOLUTION NMR', 'SOLID-STATE NMR', 'SOLUTION SCATTERING', 'POWDER DIFFRACTION', 'INFRARED SPECTROSCOPY', 'EPR', 'FLUORESCENCE TRANSFER', 'THEORETICAL MODEL' );
CREATE TABLE exptl (
-- xsd:restriction/xsd:minInclusive="0.0"
	absorpt_coefficient_mu DECIMAL CHECK ( absorpt_coefficient_mu >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"absorpt_correction_T_max" DECIMAL CHECK ( "absorpt_correction_T_max" >= 0.0 AND "absorpt_correction_T_max" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"absorpt_correction_T_min" DECIMAL CHECK ( "absorpt_correction_T_min" >= 0.0 AND "absorpt_correction_T_min" <= 1.0 ) ,
	absorpt_correction_type ENUM_exptl_absorpt_correction_type ,
	absorpt_process_details TEXT ,
-- xsd:restriction/xsd:minInclusive="1"
	crystals_number INTEGER CHECK ( crystals_number >= 1 ) ,
	details TEXT ,
	method_details TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	method ENUM_exptl_method NOT NULL
);

--
-- (quoted from ndb_struct_conf_naType)
-- Data items in the NDB_STRUCT_CONF_NA category describes secondary structure features in this entry.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/ndb_struct_conf_na.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_ndb_struct_conf_na_feature CASCADE;
CREATE TYPE ENUM_ndb_struct_conf_na_feature AS ENUM ( 'double helix', 'a-form double helix', 'b-form double helix', 'z-form double helix', 'other right-handed double helix', 'triple helix', 'quadruple helix', 'parallel strands', 'internal loop', 'bulge loop', 'tetraloop', 'hairpin loop', 'two-way junction', 'three-way junction', 'four-way junction', 'mismatched base pair' );
CREATE TABLE ndb_struct_conf_na (
	feature_count INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	feature ENUM_ndb_struct_conf_na_feature NOT NULL
);

--
-- (quoted from ndb_struct_na_base_pairType)
-- Data items in the NDB_STRUCT_NA_BASE_PAIR category record details of base pairing interactions. <VRPTx:ndb_struct_na_base_pairCategory> <VRPTx:ndb_struct_na_base_pair i_label_asym_id="A" i_label_comp_id="G" i_label_seq_id="1" i_symmetry="1_555" j_label_asym_id="A" j_label_comp_id="C" j_label_seq_id="8" j_symmetry="7_555" model_number="1"> <VRPTx:buckle>-5.523</VRPTx:buckle> <VRPTx:opening>-3.291</VRPTx:opening> <VRPTx:propeller>-6.752</VRPTx:propeller> <VRPTx:shear>-0.396</VRPTx:shear> <VRPTx:stagger>-0.018</VRPTx:stagger> <VRPTx:stretch>-0.156</VRPTx:stretch> </VRPTx:ndb_struct_na_base_pair> <VRPTx:ndb_struct_na_base_pair i_label_asym_id="A" i_label_comp_id="G" i_label_seq_id="2" i_symmetry="1_555" j_label_asym_id="A" j_label_comp_id="C" j_label_seq_id="7" j_symmetry="7_555" model_number="1"> <VRPTx:buckle>-4.727</VRPTx:buckle> <VRPTx:opening>2.311</VRPTx:opening> <VRPTx:propeller>-9.765</VRPTx:propeller> <VRPTx:shear>-0.094</VRPTx:shear> <VRPTx:stagger>-0.334</VRPTx:stagger> <VRPTx:stretch>-0.220</VRPTx:stretch> </VRPTx:ndb_struct_na_base_pair> <VRPTx:ndb_struct_na_base_pair i_label_asym_id="A" i_label_comp_id="G" i_label_seq_id="3" i_symmetry="1_555" j_label_asym_id="A" j_label_comp_id="C" j_label_seq_id="6" j_symmetry="7_555" model_number="1"> <VRPTx:buckle>-6.454</VRPTx:buckle> <VRPTx:opening>-1.181</VRPTx:opening> <VRPTx:propeller>-12.575</VRPTx:propeller> <VRPTx:shear>-0.285</VRPTx:shear> <VRPTx:stagger>0.008</VRPTx:stagger> <VRPTx:stretch>-0.239</VRPTx:stretch> </VRPTx:ndb_struct_na_base_pair> </VRPTx:ndb_struct_na_base_pairCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/ndb_struct_na_base_pair.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE ndb_struct_na_base_pair (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	buckle DECIMAL ,
	hbond_type_12 INTEGER ,
	hbond_type_28 INTEGER ,
	"i_PDB_ins_code" TEXT ,
	i_auth_asym_id TEXT ,
	i_auth_seq_id TEXT ,
	"j_PDB_ins_code" TEXT ,
	j_auth_asym_id TEXT ,
	j_auth_seq_id TEXT ,
	opening DECIMAL ,
	pair_name TEXT ,
	pair_number INTEGER ,
	propeller DECIMAL ,
	shear DECIMAL ,
	stagger DECIMAL ,
	stretch DECIMAL ,
-- ATTRIBUTE
	i_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	i_symmetry TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	j_symmetry TEXT NOT NULL ,
-- ATTRIBUTE
	model_number INTEGER NOT NULL
);

--
-- (quoted from ndb_struct_na_base_pair_stepType)
-- Data items in the NDB_STRUCT_NA_BASE_PAIR_STEP category record details of base pair step interactions. <VRPTx:ndb_struct_na_base_pair_stepCategory> <VRPTx:ndb_struct_na_base_pair_step i_label_asym_id_1="A" i_label_asym_id_2="A" i_label_comp_id_1="G" i_label_comp_id_2="G" i_label_seq_id_1="1" i_label_seq_id_2="2" i_symmetry_1="1_555" i_symmetry_2="1_555" j_label_asym_id_1="A" j_label_asym_id_2="A" j_label_comp_id_1="C" j_label_comp_id_2="C" j_label_seq_id_1="8" j_label_seq_id_2="7" j_symmetry_1="7_555" j_symmetry_2="7_555" model_number="1"> <VRPTx:rise>3.339</VRPTx:rise> <VRPTx:roll>9.755</VRPTx:roll> <VRPTx:shift>0.369</VRPTx:shift> <VRPTx:slide>-1.414</VRPTx:slide> <VRPTx:tilt>3.056</VRPTx:tilt> <VRPTx:twist>33.530</VRPTx:twist> </VRPTx:ndb_struct_na_base_pair_step> <VRPTx:ndb_struct_na_base_pair_step i_label_asym_id_1="A" i_label_asym_id_2="A" i_label_comp_id_1="G" i_label_comp_id_2="G" i_label_seq_id_1="2" i_label_seq_id_2="3" i_symmetry_1="1_555" i_symmetry_2="1_555" j_label_asym_id_1="A" j_label_asym_id_2="A" j_label_comp_id_1="C" j_label_comp_id_2="C" j_label_seq_id_1="7" j_label_seq_id_2="6" j_symmetry_1="7_555" j_symmetry_2="7_555" model_number="1"> <VRPTx:rise>3.371</VRPTx:rise> <VRPTx:roll>6.725</VRPTx:roll> <VRPTx:shift>0.176</VRPTx:shift> <VRPTx:slide>-1.672</VRPTx:slide> <VRPTx:tilt>-1.176</VRPTx:tilt> <VRPTx:twist>30.004</VRPTx:twist> </VRPTx:ndb_struct_na_base_pair_step> </VRPTx:ndb_struct_na_base_pair_stepCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/ndb_struct_na_base_pair_step.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE ndb_struct_na_base_pair_step (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	helical_rise DECIMAL ,
	helical_twist DECIMAL ,
	"i_PDB_ins_code_1" TEXT ,
	"i_PDB_ins_code_2" TEXT ,
	i_auth_asym_id_1 TEXT ,
	i_auth_asym_id_2 TEXT ,
	i_auth_seq_id_1 TEXT ,
	i_auth_seq_id_2 TEXT ,
	inclination DECIMAL ,
	"j_PDB_ins_code_1" TEXT ,
	"j_PDB_ins_code_2" TEXT ,
	j_auth_asym_id_1 TEXT ,
	j_auth_asym_id_2 TEXT ,
	j_auth_seq_id_1 TEXT ,
	j_auth_seq_id_2 TEXT ,
	rise DECIMAL ,
	roll DECIMAL ,
	shift DECIMAL ,
	slide DECIMAL ,
	step_name TEXT ,
	step_number INTEGER ,
	tilt DECIMAL ,
	tip DECIMAL ,
	twist DECIMAL ,
	x_displacement DECIMAL ,
	y_displacement DECIMAL ,
-- ATTRIBUTE
	i_label_asym_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_asym_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_comp_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_comp_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	i_label_seq_id_1 INTEGER NOT NULL ,
-- ATTRIBUTE
	i_label_seq_id_2 INTEGER NOT NULL ,
-- ATTRIBUTE
	i_symmetry_1 TEXT NOT NULL ,
-- ATTRIBUTE
	i_symmetry_2 TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_asym_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_asym_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_comp_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_comp_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	j_label_seq_id_1 INTEGER NOT NULL ,
-- ATTRIBUTE
	j_label_seq_id_2 INTEGER NOT NULL ,
-- ATTRIBUTE
	j_symmetry_1 TEXT NOT NULL ,
-- ATTRIBUTE
	j_symmetry_2 TEXT NOT NULL ,
-- ATTRIBUTE
	model_number INTEGER NOT NULL
);

--
-- (quoted from pdbx_audit_authorType)
-- Data items in the PDBX_AUDIT_AUTHOR category record details about the author(s) of the data block. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP <VRPTx:pdbx_audit_authorCategory> <VRPTx:pdbx_audit_author ordinal="1"> <VRPTx:address> Department of Biophysical Chemistry Merck Research Laboratories P. O. Box 2000, Ry80M203 Rahway, New Jersey 07065 USA</VRPTx:address> <VRPTx:name>Fitzgerald, Paula M.D.</VRPTx:name> </VRPTx:pdbx_audit_author> <VRPTx:pdbx_audit_author ordinal="2"> <VRPTx:address> Department of Biophysical Chemistry Merck Research Laboratories P. O. Box 2000, Ry80M203 Rahway, New Jersey 07065 USA</VRPTx:address> <VRPTx:name>McKeever, Brian M.</VRPTx:name> </VRPTx:pdbx_audit_author> <VRPTx:pdbx_audit_author ordinal="3"> <VRPTx:address> Department of Biophysical Chemistry Merck Research Laboratories P. O. Box 2000, Ry80M203 Rahway, New Jersey 07065 USA</VRPTx:address> <VRPTx:name>Van Middlesworth, J.F.</VRPTx:name> </VRPTx:pdbx_audit_author> <VRPTx:pdbx_audit_author ordinal="4"> <VRPTx:address> Department of Biophysical Chemistry Merck Research Laboratories P. O. Box 2000, Ry80M203 Rahway, New Jersey 07065 USA</VRPTx:address> <VRPTx:name>Springer, James P.</VRPTx:name> </VRPTx:pdbx_audit_author> </VRPTx:pdbx_audit_authorCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_author.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_audit_author (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	address TEXT ,
	name TEXT ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_audit_revision_categoryType)
-- Data items in the PDBX_AUDIT_REVISION_CATEGORY category report the data categories associated with a PDBX_AUDIT_REVISION_HISTORY record. Example 1 <VRPTx:pdbx_audit_revision_categoryCategory> <VRPTx:pdbx_audit_revision_category data_content_type="Structure model" ordinal="1" revision_ordinal="1"> <VRPTx:category>audit_author</VRPTx:category> </VRPTx:pdbx_audit_revision_category> <VRPTx:pdbx_audit_revision_category data_content_type="Structure model" ordinal="2" revision_ordinal="1"> <VRPTx:category>citation</VRPTx:category> </VRPTx:pdbx_audit_revision_category> <VRPTx:pdbx_audit_revision_category data_content_type="Structure model" ordinal="3" revision_ordinal="1"> <VRPTx:category>citation_author</VRPTx:category> </VRPTx:pdbx_audit_revision_category> <VRPTx:pdbx_audit_revision_category data_content_type="Structure model" ordinal="4" revision_ordinal="2"> <VRPTx:category>citation</VRPTx:category> </VRPTx:pdbx_audit_revision_category> </VRPTx:pdbx_audit_revision_categoryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_revision_category.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_category_data_content_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_category_data_content_type AS ENUM ( 'Structure model', 'NMR restraints', 'NMR shifts', 'Structure factors', 'Chemical component' );
CREATE TABLE pdbx_audit_revision_category (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	category TEXT ,
-- ATTRIBUTE
	data_content_type ENUM_pdbx_audit_revision_category_data_content_type NOT NULL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	revision_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_audit_revision_detailsType)
-- Data items in the PDBX_audit_revision_details category record descriptions of changes associated with PDBX_AUDIT_REVISION_HISTORY records. Example 1 - <VRPTx:pdbx_audit_revision_detailsCategory> <VRPTx:pdbx_audit_revision_details data_content_type="Structure model" ordinal="1" revision_ordinal="1"> <VRPTx:provider>repository</VRPTx:provider> <VRPTx:type>Initial release</VRPTx:type> </VRPTx:pdbx_audit_revision_details> <VRPTx:pdbx_audit_revision_details data_content_type="Structure model" ordinal="2" revision_ordinal="7"> <VRPTx:description>Remodeling of inhibitor</VRPTx:description> <VRPTx:provider>author</VRPTx:provider> <VRPTx:type>Coordinate replacement</VRPTx:type> </VRPTx:pdbx_audit_revision_details> </VRPTx:pdbx_audit_revision_detailsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_revision_details.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_details_provider CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_details_provider AS ENUM ( 'repository', 'author' );
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_details_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_details_type AS ENUM ( 'Initial release', 'Coordinate replacement', 'Obsolete', 'Remediation' );
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_details_data_content_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_details_data_content_type AS ENUM ( 'Structure model', 'NMR restraints', 'NMR shifts', 'Structure factors' );
CREATE TABLE pdbx_audit_revision_details (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	description TEXT ,
	details TEXT ,
	provider ENUM_pdbx_audit_revision_details_provider ,
	type ENUM_pdbx_audit_revision_details_type ,
-- ATTRIBUTE
	data_content_type ENUM_pdbx_audit_revision_details_data_content_type NOT NULL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	revision_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_audit_revision_groupType)
-- Data items in the PDBX_AUDIT_revision_group category report the content groups associated with a PDBX_AUDIT_REVISION_HISTORY record. Example 1 - <VRPTx:pdbx_audit_revision_groupCategory> <VRPTx:pdbx_audit_revision_group data_content_type="Structure model" ordinal="1" revision_ordinal="2"> <VRPTx:group>citation</VRPTx:group> </VRPTx:pdbx_audit_revision_group> <VRPTx:pdbx_audit_revision_group data_content_type="Structure model" ordinal="2" revision_ordinal="3"> <VRPTx:group>sample</VRPTx:group> </VRPTx:pdbx_audit_revision_group> </VRPTx:pdbx_audit_revision_groupCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_revision_group.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_group_group CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_group_group AS ENUM ( 'Advisory', 'Atomic model', 'Author supporting evidence', 'Data collection', 'Data processing', 'Database references', 'Derived calculations', 'Experimental data', 'Experimental preparation', 'Initial release', 'Non-polymer description', 'Other', 'Polymer sequence', 'Refinement description', 'Structure summary', 'Source and taxonomy', 'Version format compliance' );
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_group_data_content_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_group_data_content_type AS ENUM ( 'Structure model', 'NMR restraints', 'NMR shifts', 'Structure factors', 'Chemical component' );
CREATE TABLE pdbx_audit_revision_group (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"group" ENUM_pdbx_audit_revision_group_group ,
-- ATTRIBUTE
	data_content_type ENUM_pdbx_audit_revision_group_data_content_type NOT NULL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	revision_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_audit_revision_itemType)
-- Data items in the PDBX_AUDIT_REVISION_ITEM category report the data items associated with a PDBX_AUDIT_REVISION_HISTORY record. Example 1 <VRPTx:pdbx_audit_revision_itemCategory> <VRPTx:pdbx_audit_revision_item data_content_type="Structure model" ordinal="1" revision_ordinal="1"> <VRPTx:item>_atom_site.type_symbol</VRPTx:item> </VRPTx:pdbx_audit_revision_item> </VRPTx:pdbx_audit_revision_itemCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_audit_revision_item.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_audit_revision_item_data_content_type CASCADE;
CREATE TYPE ENUM_pdbx_audit_revision_item_data_content_type AS ENUM ( 'Structure model', 'NMR restraints', 'NMR shifts', 'Structure factors', 'Chemical component' );
CREATE TABLE pdbx_audit_revision_item (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	item TEXT ,
-- ATTRIBUTE
	data_content_type ENUM_pdbx_audit_revision_item_data_content_type NOT NULL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	revision_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_bond_distance_limitsType)
-- This category provides a table of upper and lower distance limits used as criteria in determining covalent bonds. The table is organized by atom type pairs. Example 1 - Abbreviated bond distance limit table <VRPTx:pdbx_bond_distance_limitsCategory> <VRPTx:pdbx_bond_distance_limits atom_type_1="N" atom_type_2="Ag"> <VRPTx:lower_limit>1.85</VRPTx:lower_limit> <VRPTx:upper_limit>2.70</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="O" atom_type_2="Ag"> <VRPTx:lower_limit>1.85</VRPTx:lower_limit> <VRPTx:upper_limit>2.70</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="S" atom_type_2="Ag"> <VRPTx:lower_limit>2.00</VRPTx:lower_limit> <VRPTx:upper_limit>3.00</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="Al" atom_type_2="H"> <VRPTx:lower_limit>1.35</VRPTx:lower_limit> <VRPTx:upper_limit>1.65</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="As" atom_type_2="H"> <VRPTx:lower_limit>1.20</VRPTx:lower_limit> <VRPTx:upper_limit>1.60</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="N" atom_type_2="Au"> <VRPTx:lower_limit>1.80</VRPTx:lower_limit> <VRPTx:upper_limit>2.80</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="O" atom_type_2="Au"> <VRPTx:lower_limit>1.80</VRPTx:lower_limit> <VRPTx:upper_limit>2.80</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="S" atom_type_2="Au"> <VRPTx:lower_limit>1.80</VRPTx:lower_limit> <VRPTx:upper_limit>3.00</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="B" atom_type_2="B"> <VRPTx:lower_limit>1.45</VRPTx:lower_limit> <VRPTx:upper_limit>1.95</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="C" atom_type_2="B"> <VRPTx:lower_limit>1.20</VRPTx:lower_limit> <VRPTx:upper_limit>1.85</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> <VRPTx:pdbx_bond_distance_limits atom_type_1="F" atom_type_2="B"> <VRPTx:lower_limit>1.20</VRPTx:lower_limit> <VRPTx:upper_limit>1.75</VRPTx:upper_limit> </VRPTx:pdbx_bond_distance_limits> </VRPTx:pdbx_bond_distance_limitsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_bond_distance_limits.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_bond_distance_limits (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	lower_limit DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	upper_limit DECIMAL ,
-- ATTRIBUTE
	atom_type_1 TEXT NOT NULL ,
-- ATTRIBUTE
	atom_type_2 TEXT NOT NULL
);

--
-- (quoted from pdbx_branch_schemeType)
-- The PDBX_BRANCH_SCHEME category provides residue level nomenclature mapping for branch chain entities. Example 1 - <VRPTx:pdbx_branch_schemeCategory> <VRPTx:pdbx_branch_scheme asym_id="B" entity_id="2" mon_id="NAG" num="1"> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_mon_id>NAG</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>1592</VRPTx:auth_seq_num> <VRPTx:hetero>n</VRPTx:hetero> <VRPTx:pdb_asym_id>B</VRPTx:pdb_asym_id> <VRPTx:pdb_mon_id>NAG</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>1</VRPTx:pdb_seq_num> </VRPTx:pdbx_branch_scheme> <VRPTx:pdbx_branch_scheme asym_id="B" entity_id="2" mon_id="GAL" num="2"> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_mon_id>GAL</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>1591</VRPTx:auth_seq_num> <VRPTx:hetero>n</VRPTx:hetero> <VRPTx:pdb_asym_id>B</VRPTx:pdb_asym_id> <VRPTx:pdb_mon_id>GAL</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>2</VRPTx:pdb_seq_num> </VRPTx:pdbx_branch_scheme> <VRPTx:pdbx_branch_scheme asym_id="B" entity_id="2" mon_id="FUC" num="3"> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_mon_id>FUC</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>1590</VRPTx:auth_seq_num> <VRPTx:hetero>n</VRPTx:hetero> <VRPTx:pdb_asym_id>B</VRPTx:pdb_asym_id> <VRPTx:pdb_mon_id>FUC</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>3</VRPTx:pdb_seq_num> </VRPTx:pdbx_branch_scheme> <VRPTx:pdbx_branch_scheme asym_id="B" entity_id="2" mon_id="FUC" num="4"> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_mon_id>FUC</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>1593</VRPTx:auth_seq_num> <VRPTx:hetero>n</VRPTx:hetero> <VRPTx:pdb_asym_id>B</VRPTx:pdb_asym_id> <VRPTx:pdb_mon_id>FUC</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>4</VRPTx:pdb_seq_num> </VRPTx:pdbx_branch_scheme> </VRPTx:pdbx_branch_schemeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_branch_scheme.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_branch_scheme_hetero CASCADE;
CREATE TYPE ENUM_pdbx_branch_scheme_hetero AS ENUM ( 'no', 'n', 'yes', 'y' );
CREATE TABLE pdbx_branch_scheme (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
	auth_mon_id TEXT ,
	auth_seq_num TEXT ,
	hetero ENUM_pdbx_branch_scheme_hetero ,
	pdb_asym_id TEXT ,
	pdb_ins_code TEXT ,
	pdb_mon_id TEXT ,
	pdb_seq_num TEXT ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	mon_id TEXT NOT NULL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="1"
	num INTEGER CHECK ( num >= 1 ) NOT NULL
);

--
-- (quoted from pdbx_coordinate_modelType)
-- The details of the composition of the coordinate model. Example 1 - <VRPTx:pdbx_coordinate_modelCategory> <VRPTx:pdbx_coordinate_model asym_id="A"> <VRPTx:type>CA ATOMS ONLY</VRPTx:type> </VRPTx:pdbx_coordinate_model> <VRPTx:pdbx_coordinate_model asym_id="B"> <VRPTx:type>CA ATOMS ONLY</VRPTx:type> </VRPTx:pdbx_coordinate_model> <VRPTx:pdbx_coordinate_model asym_id="X"> <VRPTx:type>P ATOMS ONLY</VRPTx:type> </VRPTx:pdbx_coordinate_model> <VRPTx:pdbx_coordinate_model asym_id="Y"> <VRPTx:type>P ATOMS ONLY</VRPTx:type> </VRPTx:pdbx_coordinate_model> </VRPTx:pdbx_coordinate_modelCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_coordinate_model.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_coordinate_model_type CASCADE;
CREATE TYPE ENUM_pdbx_coordinate_model_type AS ENUM ( 'CA ATOMS ONLY', 'P ATOMS ONLY' );
CREATE TABLE pdbx_coordinate_model (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	type ENUM_pdbx_coordinate_model_type ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL
);

--
-- (quoted from pdbx_database_relatedType)
-- Data items in PDBX_DATABASE_RELATED contain references to entries that are related to the this entry. <VRPTx:pdbx_database_relatedCategory> <VRPTx:pdbx_database_related content_type="native structure" db_id="1ABC" db_name="PDB"></VRPTx:pdbx_database_related> </VRPTx:pdbx_database_relatedCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_database_related.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_database_related_content_type CASCADE;
CREATE TYPE ENUM_pdbx_database_related_content_type AS ENUM ( 'minimized average structure', 'representative structure', 'ensemble', 'derivative structure', 'native structure', 'associated EM volume', 'other EM volume', 'associated NMR restraints', 'associated structure factors', 'associated SAS data', 'protein target sequence and/or protocol data', 'split', 're-refinement', 'complete structure', 'unspecified', 'other' );
CREATE TABLE pdbx_database_related (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- ATTRIBUTE
	content_type ENUM_pdbx_database_related_content_type NOT NULL ,
-- ATTRIBUTE
	db_id TEXT NOT NULL ,
-- ATTRIBUTE
	db_name TEXT NOT NULL
);

--
-- (quoted from pdbx_database_statusType)
-- These are internal RCSB records to keep track of data processing and status of the entry. <VRPTx:pdbx_database_statusCategory> <VRPTx:pdbx_database_status entry_id="1ABC"> <VRPTx:deposit_site>RCSB</VRPTx:deposit_site> <VRPTx:process_site>RCSB</VRPTx:process_site> <VRPTx:status_code>REL</VRPTx:status_code> </VRPTx:pdbx_database_status> </VRPTx:pdbx_database_statusCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_database_status.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_database_status_SG_entry CASCADE;
CREATE TYPE ENUM_pdbx_database_status_SG_entry AS ENUM ( 'Y', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_deposit_site CASCADE;
CREATE TYPE ENUM_pdbx_database_status_deposit_site AS ENUM ( 'NDB', 'RCSB', 'PDBE', 'PDBJ', 'BMRB', 'BNL', 'PDBC' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_methods_development_category CASCADE;
CREATE TYPE ENUM_pdbx_database_status_methods_development_category AS ENUM ( 'CAPRI', 'CASP', 'CASD-NMR', 'FoldIt', 'GPCR Dock', 'D3R', 'RNA-Puzzles' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_pdb_format_compatible CASCADE;
CREATE TYPE ENUM_pdbx_database_status_pdb_format_compatible AS ENUM ( 'Y', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_process_site CASCADE;
CREATE TYPE ENUM_pdbx_database_status_process_site AS ENUM ( 'NDB', 'RCSB', 'PDBE', 'PDBJ', 'BNL', 'PDBC' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_status_code CASCADE;
CREATE TYPE ENUM_pdbx_database_status_status_code AS ENUM ( 'PROC', 'WAIT', 'REL', 'HOLD', 'HPUB', 'REFI', 'OBS', 'WDRN', 'AUTH', 'POLC', 'REPL', 'AUCO', 'TRSF', 'RMVD', 'DEL', 'REV', 'UPD', 'BIB' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_status_code_cs CASCADE;
CREATE TYPE ENUM_pdbx_database_status_status_code_cs AS ENUM ( 'PROC', 'WAIT', 'AUTH', 'POLC', 'REPL', 'AUCO', 'REL', 'HOLD', 'HPUB', 'OBS', 'RMVD', 'WDRN' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_status_code_mr CASCADE;
CREATE TYPE ENUM_pdbx_database_status_status_code_mr AS ENUM ( 'PROC', 'WAIT', 'REL', 'HOLD', 'HPUB', 'OBS', 'WDRN', 'AUTH', 'POLC', 'REPL', 'AUCO', 'RMVD' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_status_code_nmr_data CASCADE;
CREATE TYPE ENUM_pdbx_database_status_status_code_nmr_data AS ENUM ( 'PROC', 'WAIT', 'AUTH', 'POLC', 'REPL', 'REL', 'HOLD', 'HPUB', 'OBS', 'RMVD', 'WDRN' );
DROP TYPE IF EXISTS ENUM_pdbx_database_status_status_code_sf CASCADE;
CREATE TYPE ENUM_pdbx_database_status_status_code_sf AS ENUM ( 'PROC', 'WAIT', 'REL', 'HOLD', 'HPUB', 'OBS', 'WDRN', 'AUTH', 'POLC', 'REPL', 'RMVD' );
CREATE TABLE pdbx_database_status (
	"SG_entry" ENUM_pdbx_database_status_SG_entry ,
	deposit_site ENUM_pdbx_database_status_deposit_site ,
	methods_development_category ENUM_pdbx_database_status_methods_development_category ,
	pdb_format_compatible ENUM_pdbx_database_status_pdb_format_compatible ,
	process_site ENUM_pdbx_database_status_process_site ,
-- map XSD date (xsd:date) to SQL DATE
	recvd_initial_deposition_date DATE ,
	status_code ENUM_pdbx_database_status_status_code ,
	status_code_cs ENUM_pdbx_database_status_status_code_cs ,
	status_code_mr ENUM_pdbx_database_status_status_code_mr ,
	status_code_nmr_data ENUM_pdbx_database_status_status_code_nmr_data ,
	status_code_sf ENUM_pdbx_database_status_status_code_sf ,
-- map XSD date (xsd:date) to SQL DATE
	validation_created_date DATE ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_densityType)
-- Data items in the category record various overall metrics calculated by DCC and various wrapped programs (such as Xtriage, pointless, REFMAC ...).
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_density.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_density (
	"B_babinet" DECIMAL ,
	"B_solvent" DECIMAL ,
	"B_wilson" DECIMAL ,
	"B_wilson_scale" DECIMAL ,
	"Biso_max" DECIMAL ,
	"Biso_mean" DECIMAL ,
	"Biso_min" DECIMAL ,
	"Bmean-Bwilson" DECIMAL ,
	"Cruickshank_dpi_xyz" DECIMAL ,
	"DCC_version" TEXT ,
	"I_over_sigI_diff" DECIMAL ,
	"I_over_sigI_mean" DECIMAL ,
	"I_over_sigI_resh" DECIMAL ,
	"K_babinet" DECIMAL ,
	"K_solvent" DECIMAL ,
	"Matthew_coeff" DECIMAL ,
	"Padilla-Yeates_L2_mean" DECIMAL ,
	"Padilla-Yeates_L2_mean_pointless" DECIMAL ,
	"Padilla-Yeates_L_mean" DECIMAL ,
	"R_value_R_free" DECIMAL ,
	"R_value_R_work" DECIMAL ,
	"Rfree-Rwork" DECIMAL ,
	"TLS_refinement_reported" TEXT ,
	"Z-score" DECIMAL ,
	"Z_score_L_test" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B11" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B12" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B13" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B22" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B23" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B33" DECIMAL ,
	anisotropy DECIMAL ,
	correlation_overall DECIMAL ,
	"dpi_free_R" DECIMAL ,
	error TEXT ,
	fom DECIMAL ,
	free_set_count INTEGER ,
	ice_ring TEXT ,
	"iso_B_value_type" TEXT ,
	ls_d_res_high DECIMAL ,
	ls_d_res_high_sf DECIMAL ,
	ls_d_res_low DECIMAL ,
	ls_d_res_low_sf DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	"ls_number_reflns_R_free" INTEGER CHECK ( "ls_number_reflns_R_free" >= 0 ) ,
	"ls_percent_reflns_R_free" DECIMAL ,
	ls_percent_reflns_obs DECIMAL ,
	"mFo-DFc-3sigma_negative" INTEGER ,
	"mFo-DFc-3sigma_positive" INTEGER ,
	"mFo-DFc-6sigma_negative" INTEGER ,
	"mFo-DFc-6sigma_positive" INTEGER ,
	"mean_E2_1_abs" DECIMAL ,
	"mean_F_square_over_mean_F2" DECIMAL ,
	"mean_I2_over_mean_I_square" DECIMAL ,
	mtrix_number INTEGER ,
	ncs_group_number INTEGER ,
	occupancy_max DECIMAL ,
	occupancy_mean DECIMAL ,
	occupancy_min DECIMAL ,
	"partial_B_value_correction_attempted" TEXT ,
	"partial_B_value_correction_success" TEXT ,
	pdbtype TEXT ,
	prob_peak_value DECIMAL ,
	"real_space_R_overall" DECIMAL ,
	reflection_status_archived TEXT ,
	reflection_status_used TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_number_obs INTEGER CHECK ( reflns_number_obs >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_outlier_acentric INTEGER CHECK ( reflns_outlier_acentric >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_outlier_centric INTEGER CHECK ( reflns_outlier_centric >= 0 ) ,
	reflns_twin TEXT ,
	solvent_content DECIMAL ,
	"space_group_name_H-M" TEXT ,
	space_group_pointless TEXT ,
	tls_group_number INTEGER ,
	translational_pseudo_symmetry TEXT ,
	"twin_Rfactor" DECIMAL ,
	twin_by_xtriage TEXT ,
	twin_fraction TEXT ,
	twin_fraction_xtriage TEXT ,
	twin_operator TEXT ,
	twin_operator_xtriage TEXT ,
	twin_type TEXT ,
	unit_cell TEXT ,
	wavelength DECIMAL ,
	working_set_count INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_density_corrType)
-- Data items in the category record calculated metrics from various programs (such as phenix, refmac, cns, sfcheck).
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_density_corr.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_density_corr (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	correlation DECIMAL ,
	"correlation_coeff_Fo_to_Fc" DECIMAL ,
	details TEXT ,
	"ls_R_factor_R_all" DECIMAL ,
	"ls_R_factor_R_free" DECIMAL ,
	"ls_R_factor_R_work" DECIMAL ,
	ls_d_res_high DECIMAL ,
	ls_d_res_low DECIMAL ,
	"ls_number_reflns_R_free" INTEGER ,
	ls_number_reflns_obs INTEGER ,
	"ls_percent_reflns_R_free" DECIMAL ,
	ls_percent_reflns_obs DECIMAL ,
	program TEXT ,
	"real_space_R" DECIMAL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_dcc_entity_geometryType)
-- Data items in the category record the deviations about geometry (such as bond length, angle, dihedral, chirality, planarity) of each entity.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_entity_geometry (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	angle_overall_rmsz DECIMAL ,
	auth_asym_id TEXT ,
	bond_overall_rmsz DECIMAL ,
	entity_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_angles INTEGER CHECK ( number_angles >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_bonds INTEGER CHECK ( number_bonds >= 0 ) ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL ,
-- ATTRIBUTE
	label_asym_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_geometryType)
-- Data items in the category record the overall deviations about geometry (such as bond length, angle, dihedral, chirality, planarity). These data are calculated with the phenix module model_vs_data.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_geometry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_geometry (
	"RNA_suiteness_score" DECIMAL ,
	"Ramachandran_allowed_number" INTEGER ,
	"Ramachandran_allowed_percent" DECIMAL ,
	"Ramachandran_favored_number" INTEGER ,
	"Ramachandran_favored_percent" DECIMAL ,
	"Ramachandran_outlier_number" INTEGER ,
	"Ramachandran_outlier_percent" DECIMAL ,
	"Ramachandran_outlier_percent_nmr_well_formed" DECIMAL ,
	all_atom_clashscore DECIMAL ,
	all_atom_clashscore_nmr_well_formed DECIMAL ,
	angle_ligand_max DECIMAL ,
	angle_ligand_rms DECIMAL ,
	angle_overall_max DECIMAL ,
	angle_overall_rms DECIMAL ,
	angle_overall_rmsz DECIMAL ,
	bond_ligand_max DECIMAL ,
	bond_ligand_rms DECIMAL ,
	bond_overall_max DECIMAL ,
	bond_overall_rms DECIMAL ,
	bond_overall_rmsz DECIMAL ,
	cbeta_deviations INTEGER ,
	chirality_overall_max DECIMAL ,
	chirality_overall_rms DECIMAL ,
	dihedral_overall_max DECIMAL ,
	dihedral_overall_rms DECIMAL ,
	"non-bonded_rms" DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	number_angles INTEGER CHECK ( number_angles >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_bonds INTEGER CHECK ( number_bonds >= 0 ) ,
	overall_score DECIMAL ,
	planarity_overall_max DECIMAL ,
	planarity_overall_rms DECIMAL ,
	rotamer_outliers_number INTEGER ,
	rotamer_outliers_percent DECIMAL ,
	rotamer_outliers_percent_nmr_well_formed DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_mapType)
-- Data items in the category record residual map properties such as Real Space electron density Correlation Coefficient (RSCC), real space R factors (RSR) and the Z scores for each residue, the main/side chains.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_map.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_dcc_map_LLDFZ_outlier_flag CASCADE;
CREATE TYPE ENUM_pdbx_dcc_map_LLDFZ_outlier_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_dcc_map (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"Biso_mean" DECIMAL ,
	"Biso_mean_main_chain" DECIMAL ,
	"Biso_mean_phosphate_group" DECIMAL ,
	"Biso_mean_side_chain" DECIMAL ,
	"LLDF" DECIMAL ,
	"LLDFZ" DECIMAL ,
	"LLDFZ_outlier_flag" ENUM_pdbx_dcc_map_LLDFZ_outlier_flag ,
	"LLDF_name" TEXT ,
	"LLDF_number_residues_total" INTEGER ,
	"LLDF_sigma" DECIMAL ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	"RSCC" DECIMAL ,
	"RSCC_main_chain" DECIMAL ,
	"RSCC_phosphate_group" DECIMAL ,
	"RSCC_side_chain" DECIMAL ,
	"RSR" DECIMAL ,
	"RSRZ" DECIMAL ,
	"RSRZ_main_chain" DECIMAL ,
	"RSRZ_phosphate_group" DECIMAL ,
	"RSRZ_side_chain" DECIMAL ,
	"RSR_main_chain" DECIMAL ,
	"RSR_phosphate_group" DECIMAL ,
	"RSR_side_chain" DECIMAL ,
	"RSZD" DECIMAL ,
	"RSZD_main_chain" DECIMAL ,
	"RSZD_phosphate_group" DECIMAL ,
	"RSZD_side_chain" DECIMAL ,
	"RSZO" DECIMAL ,
	"RSZO_Zscore" DECIMAL ,
	"RSZO_main_chain" DECIMAL ,
	"RSZO_phosphate_group" DECIMAL ,
	"RSZO_side_chain" DECIMAL ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	density_connectivity DECIMAL ,
	density_index_main_chain DECIMAL ,
	density_index_side_chain DECIMAL ,
	label_alt_id TEXT ,
	occupancy_mean DECIMAL ,
	occupancy_mean_main_chain DECIMAL ,
	occupancy_mean_phosphate_group DECIMAL ,
	occupancy_mean_side_chain DECIMAL ,
	quality_indicator TEXT ,
	shift DECIMAL ,
	shift_main_chain DECIMAL ,
	shift_side_chain DECIMAL ,
	"wRSRZ_main_chain" DECIMAL ,
	"wRSRZ_phosphate_group" DECIMAL ,
	"wRSRZ_side_chain" DECIMAL ,
	"wRSR_main_chain" DECIMAL ,
	"wRSR_phosphate_group" DECIMAL ,
	"wRSR_side_chain" DECIMAL ,
	"weighted_RSR" DECIMAL ,
	"weighted_RSRZ" DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_dcc_map_overallType)
-- Data items in the category record statistics of each entry for residual map properties such as Real Space electron density Correlation Coefficient (RSCC), real space R factors (RSR) and the Z scores.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_map_overall (
	"RSRZ_outliers_percent" DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_mapmanType)
-- Data items in the category record details from the output of mapman used by the DCC program.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_mapman.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_mapman (
	details TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_dcc_mon_geometryType)
-- Data items in the category record the deviations about geometry (such as bond length, angle, dihedral, chirality, planarity) of each monomer.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_dcc_mon_geometry_LLDFZ_outlier_flag CASCADE;
CREATE TYPE ENUM_pdbx_dcc_mon_geometry_LLDFZ_outlier_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_dcc_mon_geometry (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"LLDFZ_outlier_flag" ENUM_pdbx_dcc_mon_geometry_LLDFZ_outlier_flag ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	angle_overall_rmsz DECIMAL ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	bond_overall_rmsz DECIMAL ,
	label_alt_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_angles INTEGER CHECK ( number_angles >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_bonds INTEGER CHECK ( number_bonds >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_dcc_rscc_mapmanType)
-- Data items in this category record residual map properties such as correlation, real space Rfactors and the Z score calculated from refmac and mapman.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_rscc_mapman.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_rscc_mapman (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"Biso_mean" DECIMAL ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	correlation DECIMAL ,
	flag TEXT ,
	label_alt_id TEXT ,
	label_ins_code TEXT ,
	model_id TEXT ,
	occupancy_mean DECIMAL ,
	"real_space_R" DECIMAL ,
	"real_space_Zscore" DECIMAL ,
	"weighted_real_space_R" DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_dcc_rscc_mapman_overallType)
-- Data items in the category record overall map properties such as correlation, real space Rfactors and the Z score calculated from refmac and mapman.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_dcc_rscc_mapman_overall.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_dcc_rscc_mapman_overall (
	correlation DECIMAL ,
	correlation_sigma DECIMAL ,
	"real_space_R" DECIMAL ,
	"real_space_R_sigma" DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_diffrn_reflns_shellType)
-- Data items in the DIFFRN_REFLNS_SHELL category record details about the reflection data set within shells of resolution. Example 1 - diffraction properties with shells <VRPTx:pdbx_diffrn_reflns_shellCategory> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="5.18" d_res_low="50.00" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.029</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.154</VRPTx:chi_squared> <VRPTx:number_obs>11791</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="4.11" d_res_low="5.18" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.033</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.098</VRPTx:chi_squared> <VRPTx:number_obs>11717</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="3.59" d_res_low="4.11" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.043</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.044</VRPTx:chi_squared> <VRPTx:number_obs>11792</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="3.26" d_res_low="3.59" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.059</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.104</VRPTx:chi_squared> <VRPTx:number_obs>11718</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="3.03" d_res_low="3.26" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.087</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.160</VRPTx:chi_squared> <VRPTx:number_obs>11753</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="2.85" d_res_low="3.03" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.130</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.169</VRPTx:chi_squared> <VRPTx:number_obs>11811</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="2.71" d_res_low="2.85" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.174</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.170</VRPTx:chi_squared> <VRPTx:number_obs>11752</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> <VRPTx:pdbx_diffrn_reflns_shell d_res_high="2.59" d_res_low="2.71" diffrn_id="1"> <VRPTx:Rmerge_I_obs>0.227</VRPTx:Rmerge_I_obs> <VRPTx:chi_squared>1.165</VRPTx:chi_squared> <VRPTx:number_obs>11767</VRPTx:number_obs> <VRPTx:percent_possible_obs>100.000</VRPTx:percent_possible_obs> </VRPTx:pdbx_diffrn_reflns_shell> </VRPTx:pdbx_diffrn_reflns_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_diffrn_reflns_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_diffrn_reflns_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"Rmerge_I_obs" DECIMAL ,
	"Rsym_value" DECIMAL ,
	chi_squared DECIMAL ,
	number_obs INTEGER ,
	percent_possible_obs DECIMAL ,
	redundancy DECIMAL ,
	rejects INTEGER ,
-- ATTRIBUTE
	d_res_high DECIMAL NOT NULL ,
-- ATTRIBUTE
	d_res_low DECIMAL NOT NULL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL
);

--
-- (quoted from pdbx_distant_solvent_atomsType)
-- Data items in the PDBX_DISTANT_SOLVENT_ATOMS category list the solvent atoms remote from any macromolecule. Example 1 - <VRPTx:pdbx_distant_solvent_atomsCategory> <VRPTx:pdbx_distant_solvent_atoms id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>W</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>O</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>HOH</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:neighbor_ligand_distance xsi:nil="true" /> <VRPTx:neighbor_macromolecule_distance>7.3</VRPTx:neighbor_macromolecule_distance> </VRPTx:pdbx_distant_solvent_atoms> <VRPTx:pdbx_distant_solvent_atoms id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>W</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>O</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>HOH</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>413</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:neighbor_ligand_distance xsi:nil="true" /> <VRPTx:neighbor_macromolecule_distance>8.4</VRPTx:neighbor_macromolecule_distance> </VRPTx:pdbx_distant_solvent_atoms> <VRPTx:pdbx_distant_solvent_atoms id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>W</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>O</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>HOH</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>414</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:neighbor_ligand_distance xsi:nil="true" /> <VRPTx:neighbor_macromolecule_distance>7.2</VRPTx:neighbor_macromolecule_distance> </VRPTx:pdbx_distant_solvent_atoms> <VRPTx:pdbx_distant_solvent_atoms id="4"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>W</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>O</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>HOH</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>415</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:neighbor_ligand_distance xsi:nil="true" /> <VRPTx:neighbor_macromolecule_distance>8.3</VRPTx:neighbor_macromolecule_distance> </VRPTx:pdbx_distant_solvent_atoms> </VRPTx:pdbx_distant_solvent_atomsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_distant_solvent_atoms.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_distant_solvent_atoms (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_atom_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
-- omit an attribute having a fixed value: @units="angstroms"
	neighbor_ligand_distance DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	neighbor_macromolecule_distance DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_domain_rangeType)
-- Data items in the PDBX_DOMAIN_RANGE category identify the beginning and ending points of polypeptide chain segments that form all or part of a domain. Example 1 - <VRPTx:pdbx_domain_rangeCategory> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="A" beg_label_comp_id="PRO" beg_label_seq_id="1" domain_id="d1" end_label_alt_id="A" end_label_asym_id="A" end_label_comp_id="GLY" end_label_seq_id="29"></VRPTx:pdbx_domain_range> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="B" beg_label_comp_id="PRO" beg_label_seq_id="31" domain_id="d1" end_label_alt_id="A" end_label_asym_id="B" end_label_comp_id="GLY" end_label_seq_id="59"></VRPTx:pdbx_domain_range> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="C" beg_label_comp_id="PRO" beg_label_seq_id="61" domain_id="d1" end_label_alt_id="A" end_label_asym_id="B" end_label_comp_id="GLY" end_label_seq_id="89"></VRPTx:pdbx_domain_range> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="D" beg_label_comp_id="PRO" beg_label_seq_id="91" domain_id="d2" end_label_alt_id="A" end_label_asym_id="D" end_label_comp_id="GLY" end_label_seq_id="119"></VRPTx:pdbx_domain_range> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="E" beg_label_comp_id="PRO" beg_label_seq_id="121" domain_id="d2" end_label_alt_id="A" end_label_asym_id="E" end_label_comp_id="GLY" end_label_seq_id="149"></VRPTx:pdbx_domain_range> <VRPTx:pdbx_domain_range beg_label_alt_id="A" beg_label_asym_id="F" beg_label_comp_id="PRO" beg_label_seq_id="151" domain_id="d2" end_label_alt_id="A" end_label_asym_id="F" end_label_comp_id="GLY" end_label_seq_id="179"></VRPTx:pdbx_domain_range> </VRPTx:pdbx_domain_rangeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_domain_range.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_domain_range (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
-- ATTRIBUTE
	beg_label_alt_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	domain_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_alt_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_seq_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_atom_inclusion_markerType)
-- Data items in the category record atom inclusion plot. Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_atom_inclusion_markerCategory> <VRPTx:pdbx_em_atom_inclusion_marker ordinal="1" plot_id="1"> <VRPTx:atom_inclusion>1</VRPTx:atom_inclusion> <VRPTx:contour_level>-0.097199</VRPTx:contour_level> </VRPTx:pdbx_em_atom_inclusion_marker> <VRPTx:pdbx_em_atom_inclusion_marker ordinal="2" plot_id="1"> <VRPTx:atom_inclusion>1</VRPTx:atom_inclusion> <VRPTx:contour_level>-0.095008</VRPTx:contour_level> </VRPTx:pdbx_em_atom_inclusion_marker> <VRPTx:pdbx_em_atom_inclusion_marker ordinal="3" plot_id="1"> <VRPTx:atom_inclusion>1</VRPTx:atom_inclusion> <VRPTx:contour_level>-0.092817</VRPTx:contour_level> </VRPTx:pdbx_em_atom_inclusion_marker> <VRPTx:pdbx_em_atom_inclusion_marker ordinal="4" plot_id="1"> <VRPTx:atom_inclusion>1</VRPTx:atom_inclusion> <VRPTx:contour_level>-0.090626</VRPTx:contour_level> </VRPTx:pdbx_em_atom_inclusion_marker> <VRPTx:pdbx_em_atom_inclusion_marker ordinal="5" plot_id="1"> <VRPTx:atom_inclusion>1</VRPTx:atom_inclusion> <VRPTx:contour_level>-0.088435</VRPTx:contour_level> </VRPTx:pdbx_em_atom_inclusion_marker> </VRPTx:pdbx_em_atom_inclusion_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_atom_inclusion_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	atom_inclusion DECIMAL CHECK ( atom_inclusion >= 0.0 AND atom_inclusion <= 1.0 ) ,
	contour_level DECIMAL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_density_distribution_markerType)
-- Data items in the category record map-value distribution plot of the primary EM volume. Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_density_distribution_markerCategory> <VRPTx:pdbx_em_density_distribution_marker ordinal="1" plot_id="1"> <VRPTx:map_value>-0.0971993208</VRPTx:map_value> <VRPTx:voxel_count>1.6812412374</VRPTx:voxel_count> </VRPTx:pdbx_em_density_distribution_marker> <VRPTx:pdbx_em_density_distribution_marker ordinal="2" plot_id="1"> <VRPTx:map_value>-0.0949910375</VRPTx:map_value> <VRPTx:voxel_count>0</VRPTx:voxel_count> </VRPTx:pdbx_em_density_distribution_marker> <VRPTx:pdbx_em_density_distribution_marker ordinal="3" plot_id="1"> <VRPTx:map_value>-0.0927827541</VRPTx:map_value> <VRPTx:voxel_count>1.3802112417</VRPTx:voxel_count> </VRPTx:pdbx_em_density_distribution_marker> <VRPTx:pdbx_em_density_distribution_marker ordinal="4" plot_id="1"> <VRPTx:map_value>-0.0905744708</VRPTx:map_value> <VRPTx:voxel_count>0</VRPTx:voxel_count> </VRPTx:pdbx_em_density_distribution_marker> <VRPTx:pdbx_em_density_distribution_marker ordinal="5" plot_id="1"> <VRPTx:map_value>-0.0883661875</VRPTx:map_value> <VRPTx:voxel_count>1.8573324964</VRPTx:voxel_count> </VRPTx:pdbx_em_density_distribution_marker> </VRPTx:pdbx_em_density_distribution_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_density_distribution_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	map_value DOUBLE PRECISION ,
	voxel_count DECIMAL ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_fsc_curve_markerType)
-- Data items in the category record row data to plot Fourier-Shell Correlation (FSC) curve. Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_fsc_curve_markerCategory> <VRPTx:pdbx_em_fsc_curve_marker ordinal="1" plot_id="1"> <VRPTx:correlation_coef>1</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_curve_marker> <VRPTx:pdbx_em_fsc_curve_marker ordinal="2" plot_id="1"> <VRPTx:correlation_coef>0.9999</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0046</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_curve_marker> <VRPTx:pdbx_em_fsc_curve_marker ordinal="3" plot_id="1"> <VRPTx:correlation_coef>1</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0091</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_curve_marker> <VRPTx:pdbx_em_fsc_curve_marker ordinal="4" plot_id="1"> <VRPTx:correlation_coef>1</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0137</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_curve_marker> <VRPTx:pdbx_em_fsc_curve_marker ordinal="5" plot_id="1"> <VRPTx:correlation_coef>0.9999</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0182</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_curve_marker> </VRPTx:pdbx_em_fsc_curve_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_fsc_curve_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	correlation_coef DECIMAL CHECK ( correlation_coef >= -1.0 AND correlation_coef <= 1.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	spatial_frequency DECIMAL CHECK ( spatial_frequency >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_fsc_cutoff_curve_markerType)
-- Data items in the category record row data to plot Fourier-Shell Correlation (FSC) cut-off curve that represents a given criterion. Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory> <VRPTx:pdbx_em_fsc_cutoff_curve_marker ordinal="1" plot_id="1"> <VRPTx:correlation_coef>1</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_cutoff_curve_marker> <VRPTx:pdbx_em_fsc_cutoff_curve_marker ordinal="2" plot_id="1"> <VRPTx:correlation_coef>0.607</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0046</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_cutoff_curve_marker> <VRPTx:pdbx_em_fsc_cutoff_curve_marker ordinal="3" plot_id="1"> <VRPTx:correlation_coef>0.5135</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0091</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_cutoff_curve_marker> <VRPTx:pdbx_em_fsc_cutoff_curve_marker ordinal="4" plot_id="1"> <VRPTx:correlation_coef>0.4674</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0137</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_cutoff_curve_marker> <VRPTx:pdbx_em_fsc_cutoff_curve_marker ordinal="5" plot_id="1"> <VRPTx:correlation_coef>0.4401</VRPTx:correlation_coef> <VRPTx:spatial_frequency>0.0182</VRPTx:spatial_frequency> </VRPTx:pdbx_em_fsc_cutoff_curve_marker> </VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_fsc_cutoff_curve_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	correlation_coef DECIMAL CHECK ( correlation_coef >= -1.0 AND correlation_coef <= 1.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	spatial_frequency DECIMAL CHECK ( spatial_frequency >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_fsc_resolutionType)
-- Data items in the category record estimated global resolutions from Fourier-Shell Correlation (FSC) curve using various criteria for single-particle and subtomogram averaging methods. Ref: User guide to the wwPDB EM validation reports 8. FSC validation 8.1 Resolution estimate Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_fsc_resolutionCategory> <VRPTx:pdbx_em_fsc_resolution criterion="one-bit" source="calculated_fsc"> <VRPTx:correlation_coef>0.3396</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>1</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.69</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.3715</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.143" source="calculated_fsc"> <VRPTx:correlation_coef>0.143</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>2</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.38</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4195</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.5" source="calculated_fsc"> <VRPTx:correlation_coef>0.5</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>3</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.79</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.3587</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.333" source="calculated_fsc"> <VRPTx:correlation_coef>0.333</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>4</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.65</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.3768</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="half-bit" source="calculated_fsc"> <VRPTx:correlation_coef>0.178</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>5</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.48</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4039</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="3sigma" source="calculated_fsc"> <VRPTx:correlation_coef>0.0116</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>1</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>6</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.16</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4636</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="3sigma" source="author_provided_fsc"> <VRPTx:correlation_coef>0.0108</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>7</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.01</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.498</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="one-bit" source="author_provided_fsc"> <VRPTx:correlation_coef>0.3387</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>8</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.32</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4304</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.143" source="author_provided_fsc"> <VRPTx:correlation_coef>0.143</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>9</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.15</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4648</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.5" source="author_provided_fsc"> <VRPTx:correlation_coef>0.5</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>10</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.48</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4027</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="0.333" source="author_provided_fsc"> <VRPTx:correlation_coef>0.333</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>11</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.32</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.431</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> <VRPTx:pdbx_em_fsc_resolution criterion="half-bit" source="author_provided_fsc"> <VRPTx:correlation_coef>0.1772</VRPTx:correlation_coef> <VRPTx:fsc_curve_id>2</VRPTx:fsc_curve_id> <VRPTx:fsc_cutoff_curve_id>12</VRPTx:fsc_cutoff_curve_id> <VRPTx:resolution>2.16</VRPTx:resolution> <VRPTx:resolution_unit>A</VRPTx:resolution_unit> <VRPTx:spatial_frequency>0.4625</VRPTx:spatial_frequency> <VRPTx:spatial_frequency_unit>1/A</VRPTx:spatial_frequency_unit> </VRPTx:pdbx_em_fsc_resolution> </VRPTx:pdbx_em_fsc_resolutionCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_fsc_resolution (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	correlation_coef DECIMAL CHECK ( correlation_coef >= -1.0 AND correlation_coef <= 1.0 ) ,
	fsc_curve_id INTEGER ,
	fsc_cutoff_curve_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	resolution DECIMAL CHECK ( resolution >= 0.0 ) ,
	resolution_unit TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	spatial_frequency DECIMAL CHECK ( spatial_frequency >= 0.0 ) ,
	spatial_frequency_unit TEXT ,
-- ATTRIBUTE
	criterion TEXT NOT NULL ,
-- ATTRIBUTE
	source TEXT NOT NULL
);

--
-- (quoted from pdbx_em_raps_markerType)
-- Data items in the category record Rotationally Averaged Power Spectrum (RAPS) plot for the primary EM volume (map). Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_raps_markerCategory> <VRPTx:pdbx_em_raps_marker ordinal="1" plot_id="1"> <VRPTx:power>5.0361312138</VRPTx:power> <VRPTx:spatial_frequency>0</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raps_marker> <VRPTx:pdbx_em_raps_marker ordinal="2" plot_id="1"> <VRPTx:power>4.6874764273</VRPTx:power> <VRPTx:spatial_frequency>0.0045551653</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raps_marker> <VRPTx:pdbx_em_raps_marker ordinal="3" plot_id="1"> <VRPTx:power>4.0158584907</VRPTx:power> <VRPTx:spatial_frequency>0.0091103306</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raps_marker> <VRPTx:pdbx_em_raps_marker ordinal="4" plot_id="1"> <VRPTx:power>3.3080813094</VRPTx:power> <VRPTx:spatial_frequency>0.0136654959</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raps_marker> <VRPTx:pdbx_em_raps_marker ordinal="5" plot_id="1"> <VRPTx:power>3.3633413357</VRPTx:power> <VRPTx:spatial_frequency>0.0182206612</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raps_marker> </VRPTx:pdbx_em_raps_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_raps_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	power DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	spatial_frequency DECIMAL CHECK ( spatial_frequency >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_raw_raps_markerType)
-- Data items in the category record Rotationally Averaged Power Spectrum (RAPS) plot for raw EM volume (map). Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_raw_raps_markerCategory> <VRPTx:pdbx_em_raw_raps_marker ordinal="1" plot_id="1"> <VRPTx:power>5.0361312138</VRPTx:power> <VRPTx:spatial_frequency>0</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raw_raps_marker> <VRPTx:pdbx_em_raw_raps_marker ordinal="2" plot_id="1"> <VRPTx:power>4.6874764273</VRPTx:power> <VRPTx:spatial_frequency>0.0045551653</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raw_raps_marker> <VRPTx:pdbx_em_raw_raps_marker ordinal="3" plot_id="1"> <VRPTx:power>4.0158584907</VRPTx:power> <VRPTx:spatial_frequency>0.0091103306</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raw_raps_marker> <VRPTx:pdbx_em_raw_raps_marker ordinal="4" plot_id="1"> <VRPTx:power>3.3080813094</VRPTx:power> <VRPTx:spatial_frequency>0.0136654959</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raw_raps_marker> <VRPTx:pdbx_em_raw_raps_marker ordinal="5" plot_id="1"> <VRPTx:power>3.3633413357</VRPTx:power> <VRPTx:spatial_frequency>0.0182206612</VRPTx:spatial_frequency> </VRPTx:pdbx_em_raw_raps_marker> </VRPTx:pdbx_em_raw_raps_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_raw_raps_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	power DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	spatial_frequency DECIMAL CHECK ( spatial_frequency >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_validate_map_modelType)
-- Data items in the category record EM map-model validation for each residue Ref: User guide to the wwPDB EM validation reports 9. Map-Model fit 9.3 Atom inclusion by residue
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_validate_map_model (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"Q_score" DECIMAL CHECK ( "Q_score" >= 0.0 AND "Q_score" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	atom_inclusion_all DECIMAL CHECK ( atom_inclusion_all >= 0.0 AND atom_inclusion_all <= 1.0 ) ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_em_validate_map_model_entityType)
-- Data items in the category record EM map-model validation for each entity Ref: User guide to the wwPDB EM validation reports 9. Map-Model fit 9.2 Atom inclusion
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_validate_map_model_entity (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"average_Q_score" DECIMAL CHECK ( "average_Q_score" >= 0.0 AND "average_Q_score" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	average_atom_inclusion_all DECIMAL CHECK ( average_atom_inclusion_all >= 0.0 AND average_atom_inclusion_all <= 1.0 ) ,
	entity_id TEXT ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL ,
-- ATTRIBUTE
	label_asym_id TEXT NOT NULL
);

--
-- (quoted from pdbx_em_validate_map_model_overallType)
-- Data items in the category record overall EM map-model validation of each entry. Ref: User guide to the wwPDB EM validation reports 7. Map analysis 7.2 Volume estimate by contour -> recommended_contour_level 9. Map-Model fit 9.2 Q-score mapped to coordinate model -> Q-score 9.4 Atom inclusion -> atom_inclusion_main, atom_inclusion_all
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_validate_map_model_overall (
	"Q_score" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	atom_inclusion_all DECIMAL CHECK ( atom_inclusion_all >= 0.0 AND atom_inclusion_all <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	atom_inclusion_main DECIMAL CHECK ( atom_inclusion_main >= 0.0 AND atom_inclusion_main <= 1.0 ) ,
	recommended_contour_level DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_em_volume_estimate_markerType)
-- Data items in the category record volume estimation plot of the primary EM volume. Example 1 - based on PDB entry 6RJH. <VRPTx:pdbx_em_volume_estimate_markerCategory> <VRPTx:pdbx_em_volume_estimate_marker ordinal="1" plot_id="1"> <VRPTx:contour_level>-0.0971993208</VRPTx:contour_level> <VRPTx:enclosed_volume>10768.9715137</VRPTx:enclosed_volume> </VRPTx:pdbx_em_volume_estimate_marker> <VRPTx:pdbx_em_volume_estimate_marker ordinal="2" plot_id="1"> <VRPTx:contour_level>-0.0950082897</VRPTx:contour_level> <VRPTx:enclosed_volume>10768.9583621</VRPTx:enclosed_volume> </VRPTx:pdbx_em_volume_estimate_marker> <VRPTx:pdbx_em_volume_estimate_marker ordinal="3" plot_id="1"> <VRPTx:contour_level>-0.0928172586</VRPTx:contour_level> <VRPTx:enclosed_volume>10768.9583621</VRPTx:enclosed_volume> </VRPTx:pdbx_em_volume_estimate_marker> <VRPTx:pdbx_em_volume_estimate_marker ordinal="4" plot_id="1"> <VRPTx:contour_level>-0.0906262274</VRPTx:contour_level> <VRPTx:enclosed_volume>10768.9517863</VRPTx:enclosed_volume> </VRPTx:pdbx_em_volume_estimate_marker> <VRPTx:pdbx_em_volume_estimate_marker ordinal="5" plot_id="1"> <VRPTx:contour_level>-0.0884351963</VRPTx:contour_level> <VRPTx:enclosed_volume>10768.9517863</VRPTx:enclosed_volume> </VRPTx:pdbx_em_volume_estimate_marker> </VRPTx:pdbx_em_volume_estimate_markerCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_em_volume_estimate_marker (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	contour_level DECIMAL ,
	enclosed_volume DOUBLE PRECISION ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	plot_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_entity_assemblyType)
-- The PDBX_ENTITY_ASSEMBLY category provides a chemical description of the biological assembly studied in terms of its constituent entities. A complex composed of one copy of entities 1 and 2. <VRPTx:pdbx_entity_assemblyCategory> <VRPTx:pdbx_entity_assembly entity_id="1" id="1"> <VRPTx:biol_id>1</VRPTx:biol_id> <VRPTx:num_copies>1</VRPTx:num_copies> </VRPTx:pdbx_entity_assembly> <VRPTx:pdbx_entity_assembly entity_id="2" id="1"> <VRPTx:biol_id>1</VRPTx:biol_id> <VRPTx:num_copies>1</VRPTx:num_copies> </VRPTx:pdbx_entity_assembly> </VRPTx:pdbx_entity_assemblyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_assembly.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_entity_assembly (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	biol_id TEXT ,
	num_copies INTEGER ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_entity_branchType)
-- Data items in the PDBX_ENTITY_BRANCH category specify the list of branched entities and the type. Example 1 - <VRPTx:pdbx_entity_branchCategory> <VRPTx:pdbx_entity_branch entity_id="2"> <VRPTx:type>oligosaccharide</VRPTx:type> </VRPTx:pdbx_entity_branch> </VRPTx:pdbx_entity_branchCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_branch.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_type CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_type AS ENUM ( 'oligosaccharide' );
CREATE TABLE pdbx_entity_branch (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	type ENUM_pdbx_entity_branch_type ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL
);

--
-- (quoted from pdbx_entity_branch_descriptorType)
-- Data items in the PDBX_ENTITY_BRANCH_DESCRIPTOR category provide string descriptors of entity chemical structure. Example 1 - <VRPTx:pdbx_entity_branch_descriptorCategory> <VRPTx:pdbx_entity_branch_descriptor ordinal="1"> <VRPTx:descriptor>[][Asn]{[(4+1)][b-D-GlcpNAc]{[(4+1)][b-D-GlcpNAc]{[(4+1)][b-D-Manp]{[(3+1)][a-D-Manp]{[(2+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}}[(6+1)][a-D-Manp]{[(3+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}[(6+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}}}}}}</VRPTx:descriptor> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:program>PDB-CARE</VRPTx:program> <VRPTx:program_version>Beta</VRPTx:program_version> <VRPTx:type>LINUCS</VRPTx:type> </VRPTx:pdbx_entity_branch_descriptor> </VRPTx:pdbx_entity_branch_descriptorCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_branch_descriptor.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_descriptor_type CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_descriptor_type AS ENUM ( 'LINUCS', 'Glycam Condensed Sequence', 'Glycam Condensed Core Sequence', 'WURCS' );
CREATE TABLE pdbx_entity_branch_descriptor (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	descriptor TEXT ,
	entity_id TEXT ,
	program TEXT ,
	program_version TEXT ,
	type ENUM_pdbx_entity_branch_descriptor_type ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_entity_branch_linkType)
-- Data items in the PDBX_ENTITY_BRANCH_LINK category give details about the linkages between components within a branched entity. Example 1 - base on PDB entry 2WMG <VRPTx:pdbx_entity_branch_linkCategory> <VRPTx:pdbx_entity_branch_link link_id="1"> <VRPTx:atom_id_1>O4</VRPTx:atom_id_1> <VRPTx:atom_id_2>C1</VRPTx:atom_id_2> <VRPTx:atom_stereo_config_2>R</VRPTx:atom_stereo_config_2> <VRPTx:comp_id_1>NAG</VRPTx:comp_id_1> <VRPTx:comp_id_2>GAL</VRPTx:comp_id_2> <VRPTx:entity_branch_list_num_1>1</VRPTx:entity_branch_list_num_1> <VRPTx:entity_branch_list_num_2>2</VRPTx:entity_branch_list_num_2> <VRPTx:entity_id>2</VRPTx:entity_id> <VRPTx:leaving_atom_id_1>HO4</VRPTx:leaving_atom_id_1> <VRPTx:leaving_atom_id_2>O1</VRPTx:leaving_atom_id_2> <VRPTx:value_order>sing</VRPTx:value_order> </VRPTx:pdbx_entity_branch_link> <VRPTx:pdbx_entity_branch_link link_id="2"> <VRPTx:atom_id_1>O2</VRPTx:atom_id_1> <VRPTx:atom_id_2>C1</VRPTx:atom_id_2> <VRPTx:atom_stereo_config_2>R</VRPTx:atom_stereo_config_2> <VRPTx:comp_id_1>GAL</VRPTx:comp_id_1> <VRPTx:comp_id_2>FUC</VRPTx:comp_id_2> <VRPTx:entity_branch_list_num_1>2</VRPTx:entity_branch_list_num_1> <VRPTx:entity_branch_list_num_2>3</VRPTx:entity_branch_list_num_2> <VRPTx:entity_id>2</VRPTx:entity_id> <VRPTx:leaving_atom_id_1>HO2</VRPTx:leaving_atom_id_1> <VRPTx:leaving_atom_id_2>O1</VRPTx:leaving_atom_id_2> <VRPTx:value_order>sing</VRPTx:value_order> </VRPTx:pdbx_entity_branch_link> <VRPTx:pdbx_entity_branch_link link_id="3"> <VRPTx:atom_id_1>O3</VRPTx:atom_id_1> <VRPTx:atom_id_2>C1</VRPTx:atom_id_2> <VRPTx:atom_stereo_config_2>R</VRPTx:atom_stereo_config_2> <VRPTx:comp_id_1>NAG</VRPTx:comp_id_1> <VRPTx:comp_id_2>FUC</VRPTx:comp_id_2> <VRPTx:entity_branch_list_num_1>1</VRPTx:entity_branch_list_num_1> <VRPTx:entity_branch_list_num_2>4</VRPTx:entity_branch_list_num_2> <VRPTx:entity_id>2</VRPTx:entity_id> <VRPTx:leaving_atom_id_1>HO3</VRPTx:leaving_atom_id_1> <VRPTx:leaving_atom_id_2>O1</VRPTx:leaving_atom_id_2> <VRPTx:value_order>sing</VRPTx:value_order> </VRPTx:pdbx_entity_branch_link> </VRPTx:pdbx_entity_branch_linkCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_branch_link.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_link_atom_stereo_config_1 CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_link_atom_stereo_config_1 AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_link_atom_stereo_config_2 CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_link_atom_stereo_config_2 AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_link_value_order CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_link_value_order AS ENUM ( 'sing', 'doub', 'trip', 'quad', 'arom', 'poly', 'delo', 'pi' );
CREATE TABLE pdbx_entity_branch_link (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	atom_id_1 TEXT ,
	atom_id_2 TEXT ,
	atom_stereo_config_1 ENUM_pdbx_entity_branch_link_atom_stereo_config_1 ,
	atom_stereo_config_2 ENUM_pdbx_entity_branch_link_atom_stereo_config_2 ,
	comp_id_1 TEXT ,
	comp_id_2 TEXT ,
	details TEXT ,
	entity_branch_list_num_1 INTEGER ,
	entity_branch_list_num_2 INTEGER ,
	entity_id TEXT ,
	leaving_atom_id_1 TEXT ,
	leaving_atom_id_2 TEXT ,
	value_order ENUM_pdbx_entity_branch_link_value_order ,
-- ATTRIBUTE
	link_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_entity_branch_listType)
-- Data items in the PDBX_ENTITY_BRANCH_LIST category specify the list of monomers in a branched entity. Allowance is made for the possibility of microheterogeneity in a sample by allowing a given sequence number to be correlated with more than one monomer ID. The corresponding ATOM_SITE entries should reflect this heterogeneity. Example 1 - <VRPTx:pdbx_entity_branch_listCategory> <VRPTx:pdbx_entity_branch_list comp_id="NAG" entity_id="2" num="1"> <VRPTx:hetero>n</VRPTx:hetero> </VRPTx:pdbx_entity_branch_list> <VRPTx:pdbx_entity_branch_list comp_id="GAL" entity_id="2" num="2"> <VRPTx:hetero>n</VRPTx:hetero> </VRPTx:pdbx_entity_branch_list> <VRPTx:pdbx_entity_branch_list comp_id="FUC" entity_id="2" num="3"> <VRPTx:hetero>n</VRPTx:hetero> </VRPTx:pdbx_entity_branch_list> <VRPTx:pdbx_entity_branch_list comp_id="FUC" entity_id="2" num="4"> <VRPTx:hetero>n</VRPTx:hetero> </VRPTx:pdbx_entity_branch_list> </VRPTx:pdbx_entity_branch_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_branch_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_branch_list_hetero CASCADE;
CREATE TYPE ENUM_pdbx_entity_branch_list_hetero AS ENUM ( 'no', 'n', 'yes', 'y' );
CREATE TABLE pdbx_entity_branch_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	hetero ENUM_pdbx_entity_branch_list_hetero ,
-- ATTRIBUTE
	comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="1"
	num INTEGER CHECK ( num >= 1 ) NOT NULL
);

--
-- (quoted from pdbx_entity_descriptorType)
-- Data items in the PDBX_ENTITY_DESCRIPTOR category provide string descriptors of entity chemical structure. Example 1 - <VRPTx:pdbx_entity_descriptorCategory> <VRPTx:pdbx_entity_descriptor ordinal="1"> <VRPTx:descriptor>[][Asn]{[(4+1)][b-D-GlcpNAc]{[(4+1)][b-D-GlcpNAc]{[(4+1)][b-D-Manp]{[(3+1)][a-D-Manp]{[(2+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}}[(6+1)][a-D-Manp]{[(3+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}[(6+1)][a-D-Manp]{[(2+1)][a-D-Manp]{}}}}}}}</VRPTx:descriptor> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:program>PDB-CARE</VRPTx:program> <VRPTx:program_version>Beta</VRPTx:program_version> <VRPTx:type>LINUCS</VRPTx:type> </VRPTx:pdbx_entity_descriptor> </VRPTx:pdbx_entity_descriptorCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_descriptor_type CASCADE;
CREATE TYPE ENUM_pdbx_entity_descriptor_type AS ENUM ( 'LINUCS', 'Glycam Condensed Sequence', 'Glycam Condensed Core Sequence' );
CREATE TABLE pdbx_entity_descriptor (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	descriptor TEXT ,
	entity_id TEXT ,
	program TEXT ,
	program_version TEXT ,
	type ENUM_pdbx_entity_descriptor_type ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_entity_nonpolyType)
-- The PDBX_ENTITY_NONPOLY category provides a mapping between entity and the nonpolymer component Example 1 - based on PDB entry 3LTQ <VRPTx:pdbx_entity_nonpolyCategory> <VRPTx:pdbx_entity_nonpoly entity_id="2"> <VRPTx:comp_id>TB</VRPTx:comp_id> <VRPTx:name>TERBIUM(III) ION</VRPTx:name> </VRPTx:pdbx_entity_nonpoly> <VRPTx:pdbx_entity_nonpoly entity_id="3"> <VRPTx:comp_id>ACT</VRPTx:comp_id> <VRPTx:name>ACETATE ION</VRPTx:name> </VRPTx:pdbx_entity_nonpoly> <VRPTx:pdbx_entity_nonpoly entity_id="4"> <VRPTx:comp_id>SO4</VRPTx:comp_id> <VRPTx:name>SULFATE ION</VRPTx:name> </VRPTx:pdbx_entity_nonpoly> <VRPTx:pdbx_entity_nonpoly entity_id="5"> <VRPTx:comp_id>HOH</VRPTx:comp_id> <VRPTx:name>water</VRPTx:name> </VRPTx:pdbx_entity_nonpoly> </VRPTx:pdbx_entity_nonpolyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_nonpoly.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_entity_nonpoly (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	comp_id TEXT ,
	name TEXT ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL
);

--
-- (quoted from pdbx_entity_poly_comp_link_listType)
-- Data items in the PDBX_ENTITY_POLY_COMP_LINK_LIST category enumerate the linkages between components within the polymer entity. Example 1 - <VRPTx:pdbx_entity_poly_comp_link_listCategory> <VRPTx:pdbx_entity_poly_comp_link_list link_id="1"> <VRPTx:atom_id_1 xsi:nil="true" /> <VRPTx:atom_id_2 xsi:nil="true" /> <VRPTx:atom_stereo_config_1 xsi:nil="true" /> <VRPTx:atom_stereo_config_2 xsi:nil="true" /> <VRPTx:comp_id_1 xsi:nil="true" /> <VRPTx:comp_id_2 xsi:nil="true" /> <VRPTx:entity_comp_num_1>1</VRPTx:entity_comp_num_1> <VRPTx:entity_comp_num_2>2</VRPTx:entity_comp_num_2> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:leaving_atom_id_1 xsi:nil="true" /> <VRPTx:leaving_atom_id_2 xsi:nil="true" /> <VRPTx:value_order>sing</VRPTx:value_order> </VRPTx:pdbx_entity_poly_comp_link_list> </VRPTx:pdbx_entity_poly_comp_link_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entity_poly_comp_link_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_1 CASCADE;
CREATE TYPE ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_1 AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_2 CASCADE;
CREATE TYPE ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_2 AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_pdbx_entity_poly_comp_link_list_value_order CASCADE;
CREATE TYPE ENUM_pdbx_entity_poly_comp_link_list_value_order AS ENUM ( 'sing', 'doub', 'trip', 'quad', 'arom', 'poly', 'delo', 'pi' );
CREATE TABLE pdbx_entity_poly_comp_link_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	atom_id_1 TEXT ,
	atom_id_2 TEXT ,
	atom_stereo_config_1 ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_1 ,
	atom_stereo_config_2 ENUM_pdbx_entity_poly_comp_link_list_atom_stereo_config_2 ,
	comp_id_1 TEXT ,
	comp_id_2 TEXT ,
	details TEXT ,
	entity_comp_num_1 INTEGER ,
	entity_comp_num_2 INTEGER ,
	entity_id TEXT ,
	leaving_atom_id_1 TEXT ,
	leaving_atom_id_2 TEXT ,
	value_order ENUM_pdbx_entity_poly_comp_link_list_value_order ,
-- ATTRIBUTE
	link_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_entry_detailsType)
-- Data items in the PDBX_ENTRY_DETAILS category provide additional details about this entry. Example 1 - <VRPTx:pdbx_entry_detailsCategory> <VRPTx:pdbx_entry_details entry_id="1ABC"> <VRPTx:nonpolymer_details>Inhibitor VX4A in this entry adopts a highly strained conformation about C32 inorder to fit into the cleft about the active site.</VRPTx:nonpolymer_details> </VRPTx:pdbx_entry_details> </VRPTx:pdbx_entry_detailsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_entry_details.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_entry_details_has_ligand_of_interest CASCADE;
CREATE TYPE ENUM_pdbx_entry_details_has_ligand_of_interest AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_entry_details (
	compound_details TEXT ,
	has_ligand_of_interest ENUM_pdbx_entry_details_has_ligand_of_interest ,
	nonpolymer_details TEXT ,
	sequence_details TEXT ,
	source_details TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_helical_symmetryType)
-- Data items in the PDBX_HELICAL_SYMMETRY category record details about the helical symmetry group associated with this entry. Example 1 - <VRPTx:pdbx_helical_symmetryCategory> <VRPTx:pdbx_helical_symmetry entry_id="1ABC"> <VRPTx:circular_symmetry>1</VRPTx:circular_symmetry> <VRPTx:dyad_axis>no</VRPTx:dyad_axis> <VRPTx:n_subunits_divisor>1</VRPTx:n_subunits_divisor> <VRPTx:number_of_operations>35</VRPTx:number_of_operations> <VRPTx:rise_per_n_subunits>6.10</VRPTx:rise_per_n_subunits> <VRPTx:rotation_per_n_subunits>131.84</VRPTx:rotation_per_n_subunits> </VRPTx:pdbx_helical_symmetry> </VRPTx:pdbx_helical_symmetryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_helical_symmetry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_helical_symmetry_dyad_axis CASCADE;
CREATE TYPE ENUM_pdbx_helical_symmetry_dyad_axis AS ENUM ( 'no', 'yes' );
CREATE TABLE pdbx_helical_symmetry (
-- xsd:restriction/xsd:minInclusive="1"
	circular_symmetry INTEGER CHECK ( circular_symmetry >= 1 ) ,
	dyad_axis ENUM_pdbx_helical_symmetry_dyad_axis ,
-- xsd:restriction/xsd:minInclusive="1"
	n_subunits_divisor INTEGER CHECK ( n_subunits_divisor >= 1 ) ,
-- xsd:restriction/xsd:minInclusive="1"
	number_of_operations INTEGER CHECK ( number_of_operations >= 1 ) ,
-- omit an attribute having a fixed value: @units="angstroms"
	rise_per_n_subunits DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	rotation_per_n_subunits DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_missing_nmr_star_itemType)
-- Items in the PDBX_MISSING_NMR_STAR_ITEM category provide information about required NMR-STAR V3 data items to parse assigned chemical shifts.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_missing_nmr_star_item (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	description TEXT ,
	name TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_chem_shift_annotationType)
-- Items in the PDBX_NMR_CHEM_SHIFT_ANNOTATION category provide information about various derived values from assigned chemical shifts. e.g. random coil index.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_chem_shift_annotation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	random_coil_index DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_chem_shift_completenessType)
-- Items in the PDBX_NMR_CHEM_SHIFT_COMPLETENESS category provide information about completeness of assigned chemical shifts.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_chem_shift_completeness (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_assigned_chem_shifts INTEGER CHECK ( number_assigned_chem_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_assigned_chem_shifts_well_formed INTEGER CHECK ( number_assigned_chem_shifts_well_formed >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_target_shifts INTEGER CHECK ( number_target_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_target_shifts_well_formed INTEGER CHECK ( number_target_shifts_well_formed >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_unassigned_chem_shifts INTEGER CHECK ( number_unassigned_chem_shifts >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_unassigned_chem_shifts_well_formed INTEGER CHECK ( number_unassigned_chem_shifts_well_formed >= 0 ) ,
-- ATTRIBUTE
	atom_group TEXT NOT NULL ,
-- ATTRIBUTE
	atom_type TEXT NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_chem_shift_re_offsetType)
-- Items in the PDBX_NMR_CHEM_SHIFT_RE_OFFSET category provide information about chemical shift reference correction based on assigned chemical shifts.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_chem_shift_re_offset (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	correction_val DECIMAL ,
	correction_val_err DECIMAL ,
	correction_val_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	number_chem_shifts INTEGER CHECK ( number_chem_shifts >= 0 ) ,
-- ATTRIBUTE
	atom_type TEXT NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_constraintsType)
-- This section provides a tabulation of constraint data. This example uses the data from the MCP-1 structure determination. Remember this is a dimer so there are intersubunit constraints as well as intrasubunit constraints. <VRPTx:pdbx_nmr_constraintsCategory> <VRPTx:pdbx_nmr_constraints entry_id="1ABC"> <VRPTx:NOE_constraints_total>4458</VRPTx:NOE_constraints_total> <VRPTx:NOE_intraresidue_total_count>1144</VRPTx:NOE_intraresidue_total_count> <VRPTx:NOE_long_range_total_count>1356</VRPTx:NOE_long_range_total_count> <VRPTx:NOE_medium_range_total_count>1004</VRPTx:NOE_medium_range_total_count> <VRPTx:NOE_sequential_total_count>272</VRPTx:NOE_sequential_total_count> <VRPTx:protein_phi_angle_constraints_total_count>96</VRPTx:protein_phi_angle_constraints_total_count> </VRPTx:pdbx_nmr_constraints> </VRPTx:pdbx_nmr_constraintsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_constraints.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_constraints (
	"NA_alpha-angle_constraints_total_count" INTEGER ,
	"NA_beta-angle_constraints_total_count" INTEGER ,
	"NA_chi-angle_constraints_total_count" INTEGER ,
	"NA_delta-angle_constraints_total_count" INTEGER ,
	"NA_epsilon-angle_constraints_total_count" INTEGER ,
	"NA_gamma-angle_constraints_total_count" INTEGER ,
	"NA_other-angle_constraints_total_count" INTEGER ,
	"NA_sugar_pucker_constraints_total_count" INTEGER ,
	"NOE_constraints_total" INTEGER ,
	"NOE_interentity_total_count" INTEGER ,
	"NOE_interproton_distance_evaluation" TEXT ,
	"NOE_intraresidue_total_count" INTEGER ,
	"NOE_long_range_total_count" INTEGER ,
	"NOE_medium_range_total_count" INTEGER ,
	"NOE_motional_averaging_correction" TEXT ,
	"NOE_pseudoatom_corrections" TEXT ,
	"NOE_sequential_total_count" INTEGER ,
	disulfide_bond_constraints_total_count INTEGER ,
	hydrogen_bond_constraints_total_count INTEGER ,
	protein_chi_angle_constraints_total_count INTEGER ,
	protein_other_angle_constraints_total_count INTEGER ,
	protein_phi_angle_constraints_total_count INTEGER ,
	protein_psi_angle_constraints_total_count INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_detailsType)
-- Experimental details of the NMR study that have not been described elsewhere in this deposition.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_details.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_details (
	text TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_dihedral_angle_violationType)
-- Data items in the category record all dihedral angle restraint violations of the ensemble. Ref: User guide to the wwPDB NMR validation reports 10. Dihedral-angle violation analysis 10.5 All violated dihedral-angle restraints
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_dihedral_angle_violation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_ins_code_3" TEXT ,
	"PDB_ins_code_4" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_atom_id_3 TEXT ,
	auth_atom_id_4 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_comp_id_3 TEXT ,
	auth_comp_id_4 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
	auth_seq_id_3 TEXT ,
	auth_seq_id_4 TEXT ,
	entity_id TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	label_alt_id_3 TEXT ,
	label_alt_id_4 TEXT ,
	label_asym_id TEXT ,
	label_seq_id_1 TEXT ,
	label_seq_id_2 TEXT ,
	label_seq_id_3 TEXT ,
	label_seq_id_4 TEXT ,
	list_id INTEGER ,
	restraint_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	violation DECIMAL CHECK ( violation >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_dihedral_angle_violation_ensembleType)
-- Data items in the category record violations of dihedral angle restraints for each virtual ensemble alternating the size of an ensemble. Ref: User guide to the wwPDB NMR validation reports 10. Dihedral-angle violation analysis 10.3 Dihedral-angle violation statistics for the ensemble
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_dihedral_angle_violation_ensemble (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	alpha_violations_count INTEGER CHECK ( alpha_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	beta_violations_count INTEGER CHECK ( beta_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi1_violations_count INTEGER CHECK ( chi1_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi21_violations_count INTEGER CHECK ( chi21_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi22_violations_count INTEGER CHECK ( chi22_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi2_violations_count INTEGER CHECK ( chi2_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi31_violations_count INTEGER CHECK ( chi31_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi32_violations_count INTEGER CHECK ( chi32_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi3_violations_count INTEGER CHECK ( chi3_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi42_violations_count INTEGER CHECK ( chi42_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi4_violations_count INTEGER CHECK ( chi4_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi5_violations_count INTEGER CHECK ( chi5_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	delta_violations_count INTEGER CHECK ( delta_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	epsilon_violations_count INTEGER CHECK ( epsilon_violations_count >= 0 ) ,
	fraction_ensemble_percent DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	gamma_violations_count INTEGER CHECK ( gamma_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu0_violations_count INTEGER CHECK ( nu0_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu1_violations_count INTEGER CHECK ( nu1_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu2_violations_count INTEGER CHECK ( nu2_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu3_violations_count INTEGER CHECK ( nu3_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu4_violations_count INTEGER CHECK ( nu4_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	omega_violations_count INTEGER CHECK ( omega_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	phi_violations_count INTEGER CHECK ( phi_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	psi_violations_count INTEGER CHECK ( psi_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	zeta_violations_count INTEGER CHECK ( zeta_violations_count >= 0 ) ,
-- ATTRIBUTE
	fraction_ensemble_size INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_dihedral_angle_violation_modelType)
-- Data items in the category record violations of dihedral angle restraints for each model. Ref: User guide to the wwPDB NMR validation reports 10. Dihedral-angle violation analysis 10.2 Dihedral-angle violation statistics for each model
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_dihedral_angle_violation_model (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	alpha_violations_count INTEGER CHECK ( alpha_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	average_violation DECIMAL CHECK ( average_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	beta_violations_count INTEGER CHECK ( beta_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi1_violations_count INTEGER CHECK ( chi1_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi21_violations_count INTEGER CHECK ( chi21_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi22_violations_count INTEGER CHECK ( chi22_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi2_violations_count INTEGER CHECK ( chi2_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi31_violations_count INTEGER CHECK ( chi31_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi32_violations_count INTEGER CHECK ( chi32_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi3_violations_count INTEGER CHECK ( chi3_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi42_violations_count INTEGER CHECK ( chi42_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi4_violations_count INTEGER CHECK ( chi4_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	chi5_violations_count INTEGER CHECK ( chi5_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	delta_violations_count INTEGER CHECK ( delta_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	epsilon_violations_count INTEGER CHECK ( epsilon_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	gamma_violations_count INTEGER CHECK ( gamma_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	maximum_violation DECIMAL CHECK ( maximum_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	median_violation DECIMAL CHECK ( median_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu0_violations_count INTEGER CHECK ( nu0_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu1_violations_count INTEGER CHECK ( nu1_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu2_violations_count INTEGER CHECK ( nu2_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu3_violations_count INTEGER CHECK ( nu3_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	nu4_violations_count INTEGER CHECK ( nu4_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	omega_violations_count INTEGER CHECK ( omega_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	phi_violations_count INTEGER CHECK ( phi_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	psi_violations_count INTEGER CHECK ( psi_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	standard_deviation DECIMAL CHECK ( standard_deviation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	zeta_violations_count INTEGER CHECK ( zeta_violations_count >= 0 ) ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_dihedral_angle_violation_pluralType)
-- Data items in the category record potentially severe violations of dihedral angle restraints, which occurred in multiple coordinate models of the ensemble. Ref: User guide to the wwPDB NMR validation reports 10. Dihedral-angle violation analysis 10.4 Most violated dihedral angle restraints in the ensemble
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_dihedral_angle_violation_plural (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_ins_code_3" TEXT ,
	"PDB_ins_code_4" TEXT ,
	auth_asym_id TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_atom_id_3 TEXT ,
	auth_atom_id_4 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_comp_id_3 TEXT ,
	auth_comp_id_4 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
	auth_seq_id_3 TEXT ,
	auth_seq_id_4 TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	average_violation DECIMAL CHECK ( average_violation >= 0.0 ) ,
	entity_id TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	label_alt_id_3 TEXT ,
	label_alt_id_4 TEXT ,
	label_asym_id TEXT ,
	label_seq_id_1 TEXT ,
	label_seq_id_2 TEXT ,
	label_seq_id_3 TEXT ,
	label_seq_id_4 TEXT ,
	list_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	median_violation DECIMAL CHECK ( median_violation >= 0.0 ) ,
	restraint_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	standard_deviation DECIMAL CHECK ( standard_deviation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="2"
	violation_models_count INTEGER CHECK ( violation_models_count >= 2 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_dihedral_angle_violation_summaryType)
-- Data items in the category record violations of dihedral angle restraints. Ref: User guide to the wwPDB NMR validation reports 10. Dihedral-angle violation analysis 10.1 Summary of dihedral-angle violations
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_dihedral_angle_violation_summary_type CASCADE;
CREATE TYPE ENUM_pdbx_nmr_dihedral_angle_violation_summary_type AS ENUM ( 'phi', 'psi', 'omega', 'chi1', 'chi2', 'chi3', 'chi4', 'chi5', 'alpha', 'beta', 'gamma', 'delta', 'epsilon', 'zeta', 'nu0', 'nu1', 'nu2', 'nu3', 'nu4', 'chi21', 'chi22', 'chi31', 'chi32', 'chi42', 'all' );
CREATE TABLE pdbx_nmr_dihedral_angle_violation_summary (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	consistent_violations_count INTEGER CHECK ( consistent_violations_count >= 0 ) ,
	consistent_violations_percent DECIMAL ,
	consistent_violations_percent_type DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	restraints_count INTEGER CHECK ( restraints_count >= 0 ) ,
	restraints_percent DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
	violations_percent DECIMAL ,
	violations_percent_type DECIMAL ,
-- ATTRIBUTE
	type ENUM_pdbx_nmr_dihedral_angle_violation_summary_type NOT NULL
);

--
-- (quoted from pdbx_nmr_distance_violationType)
-- Data items in the category record all distance restraint violations of the ensemble. Ref: User guide to the wwPDB NMR validation reports 9. Distance violation analysis 9.5 All violated distance restraints
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_distance_violation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
	entity_id_1 TEXT ,
	entity_id_2 TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	label_asym_id_1 TEXT ,
	label_asym_id_2 TEXT ,
	label_seq_id_1 TEXT ,
	label_seq_id_2 TEXT ,
	list_id INTEGER ,
	restraint_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	violation DECIMAL CHECK ( violation >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_distance_violation_ensembleType)
-- Data items in the category record violations of distance restraints for each virtual ensemble alternating the size of an ensemble. Ref: User guide to the wwPDB NMR validation reports 9. Distance violation analysis 9.3 Distance violation statistics for the ensemble
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_distance_violation_ensemble (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	fraction_ensemble_percent DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	interchain_violations_count INTEGER CHECK ( interchain_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	intraresidue_violations_count INTEGER CHECK ( intraresidue_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	long_range_violations_count INTEGER CHECK ( long_range_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	medium_range_violations_count INTEGER CHECK ( medium_range_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	sequential_violations_count INTEGER CHECK ( sequential_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
-- ATTRIBUTE
	fraction_ensemble_size INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_distance_violation_modelType)
-- Data items in the category record violations of distance restraints for each model. Ref: User guide to the wwPDB NMR validation reports 9. Distance violation analysis 9.2 Distance violation statistics for each model
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_distance_violation_model (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	average_violation DECIMAL CHECK ( average_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	interchain_violations_count INTEGER CHECK ( interchain_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	intraresidue_violations_count INTEGER CHECK ( intraresidue_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	long_range_violations_count INTEGER CHECK ( long_range_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	maximum_violation DECIMAL CHECK ( maximum_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	median_violation DECIMAL CHECK ( median_violation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	medium_range_violations_count INTEGER CHECK ( medium_range_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	sequential_violations_count INTEGER CHECK ( sequential_violations_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	standard_deviation DECIMAL CHECK ( standard_deviation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_distance_violation_pluralType)
-- Data items in the category record potentially severe violations of distance restraints, which occurred in multiple coordinate models of the ensemble. Ref: User guide to the wwPDB NMR validation reports 9. Distance violation analysis 9.4 Most violated distance restraints in the ensemble
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_distance_violation_plural (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	average_violation DECIMAL CHECK ( average_violation >= 0.0 ) ,
	entity_id_1 TEXT ,
	entity_id_2 TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	label_asym_id_1 TEXT ,
	label_asym_id_2 TEXT ,
	label_seq_id_1 TEXT ,
	label_seq_id_2 TEXT ,
	list_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	median_violation DECIMAL CHECK ( median_violation >= 0.0 ) ,
	restraint_id INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	standard_deviation DECIMAL CHECK ( standard_deviation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="2"
	violation_models_count INTEGER CHECK ( violation_models_count >= 2 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_distance_violation_summaryType)
-- Data items in the category record violations of distance restraints. Ref: User guide to the wwPDB NMR validation reports 9. Distance violation analysis 9.1 Summary of distance violations
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_distance_violation_summary_subtype CASCADE;
CREATE TYPE ENUM_pdbx_nmr_distance_violation_summary_subtype AS ENUM ( 'backbone_backbone', 'distance restraints between two backbone atoms', 'backbone_sidechain', 'distance restraints between backbone atom and side chaini atom', 'sidechain_sidechain', 'distance restraints between two side chain atoms', 'all', 'all distance restraints without backbone/side chain classificat' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_distance_violation_summary_type CASCADE;
CREATE TYPE ENUM_pdbx_nmr_distance_violation_summary_type AS ENUM ( 'intraresidue', 'sequential', 'medium_range', 'long_range', 'interchain', 'hydrogen_bond', 'disulfide_bond', 'all' );
CREATE TABLE pdbx_nmr_distance_violation_summary (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	consistent_violations_count INTEGER CHECK ( consistent_violations_count >= 0 ) ,
	consistent_violations_percent DECIMAL ,
	consistent_violations_percent_type DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	restraints_count INTEGER CHECK ( restraints_count >= 0 ) ,
	restraints_percent DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	violations_count INTEGER CHECK ( violations_count >= 0 ) ,
	violations_percent DECIMAL ,
	violations_percent_type DECIMAL ,
-- ATTRIBUTE
	subtype ENUM_pdbx_nmr_distance_violation_summary_subtype NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_nmr_distance_violation_summary_type NOT NULL
);

--
-- (quoted from pdbx_nmr_ensembleType)
-- This category contains the information that describes the ensemble of deposited structures. If only an average structure has been deposited skip this section. This example uses the data from the MCP-1 study. <VRPTx:pdbx_nmr_ensembleCategory> <VRPTx:pdbx_nmr_ensemble entry_id="1ABC"> <VRPTx:conformer_selection_criteria>structures with the least restraint violations</VRPTx:conformer_selection_criteria> <VRPTx:conformers_calculated_total_number>40</VRPTx:conformers_calculated_total_number> <VRPTx:conformers_submitted_total_number>20</VRPTx:conformers_submitted_total_number> <VRPTx:representative_conformer>1</VRPTx:representative_conformer> </VRPTx:pdbx_nmr_ensemble> </VRPTx:pdbx_nmr_ensembleCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_ensemble.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_ensemble_atom_consistency_flag CASCADE;
CREATE TYPE ENUM_pdbx_nmr_ensemble_atom_consistency_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_nmr_ensemble (
	atom_consistency_flag ENUM_pdbx_nmr_ensemble_atom_consistency_flag ,
	average_constraint_violations_per_residue INTEGER ,
	average_constraints_per_residue INTEGER ,
-- omit an attribute having a fixed value: @units="angstroms"
	average_distance_constraint_violation DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	average_torsion_angle_constraint_violation DECIMAL ,
	conformer_selection_criteria TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	conformers_calculated_total_number INTEGER CHECK ( conformers_calculated_total_number >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	conformers_submitted_total_number INTEGER CHECK ( conformers_submitted_total_number >= 0 ) ,
	distance_constraint_violation_method TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	maximum_distance_constraint_violation DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	maximum_lower_distance_constraint_violation DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	maximum_torsion_angle_constraint_violation DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	maximum_upper_distance_constraint_violation DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	representative_conformer INTEGER CHECK ( representative_conformer >= 0 ) ,
	torsion_angle_constraint_violation_method TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_ensemble_rmsType)
-- Structural statistics are derived from molecular dynamics and simulated annealing programs. This example is derived from the MCP-1 structure calculation statistics. For this structure the statistics were calculated over residues 5-69 for both the monomer and dimer . <VRPTx:pdbx_nmr_ensemble_rmsCategory> <VRPTx:pdbx_nmr_ensemble_rms entry_id="1ABC"> <VRPTx:atom_type>all heavy atoms</VRPTx:atom_type> <VRPTx:chain_range_begin>A</VRPTx:chain_range_begin> <VRPTx:chain_range_end>A</VRPTx:chain_range_end> <VRPTx:distance_rms_dev>0.22</VRPTx:distance_rms_dev> <VRPTx:distance_rms_dev_error>0.06</VRPTx:distance_rms_dev_error> <VRPTx:residue_range_begin>5</VRPTx:residue_range_begin> <VRPTx:residue_range_end>69</VRPTx:residue_range_end> </VRPTx:pdbx_nmr_ensemble_rms> </VRPTx:pdbx_nmr_ensemble_rmsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_ensemble_rms.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_ensemble_rms_atom_type CASCADE;
CREATE TYPE ENUM_pdbx_nmr_ensemble_rms_atom_type AS ENUM ( 'backbone heavy atoms', 'side chain heavy atoms', 'all heavy atoms', 'all atoms', 'all backbone atoms' );
CREATE TABLE pdbx_nmr_ensemble_rms (
	atom_type ENUM_pdbx_nmr_ensemble_rms_atom_type ,
-- omit an attribute having a fixed value: @units="degrees"
	bond_angle_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	bond_angle_rms_dev_error DECIMAL ,
	chain_range_begin TEXT ,
	chain_range_end TEXT ,
	coord_average_rmsd_method TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	covalent_bond_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	covalent_bond_rms_dev_error DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	dihedral_angles_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	dihedral_angles_rms_dev_error DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	distance_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	distance_rms_dev_error DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	improper_torsion_angle_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	improper_torsion_angle_rms_dev_error DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	peptide_planarity_rms_dev DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	peptide_planarity_rms_dev_error DECIMAL ,
	residue_range_begin INTEGER ,
	residue_range_end INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_exptlType)
-- In this section, enter information on those experiments that were used to generate constraint data. For each NMR experiment indicate which sample and which sample conditions were used for the experiment. This example was taken from the MCP-1 study. <VRPTx:pdbx_nmr_exptlCategory> <VRPTx:pdbx_nmr_exptl conditions_id="1" experiment_id="1" solution_id="3"> <VRPTx:type>3D_15N-separated_NOESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> <VRPTx:pdbx_nmr_exptl conditions_id="1" experiment_id="2" solution_id="1"> <VRPTx:type>3D_13C-separated_NOESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> <VRPTx:pdbx_nmr_exptl conditions_id="2" experiment_id="3" solution_id="1"> <VRPTx:type>4D_13C/15N-separated_NOESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> <VRPTx:pdbx_nmr_exptl conditions_id="1" experiment_id="4" solution_id="1"> <VRPTx:type>4D_13C-separated_NOESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> <VRPTx:pdbx_nmr_exptl conditions_id="1" experiment_id="5" solution_id="1"> <VRPTx:type>3D_15N-separated_ROESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> <VRPTx:pdbx_nmr_exptl conditions_id="1" experiment_id="6" solution_id="3"> <VRPTx:type>3D_13C-separated_ROESY</VRPTx:type> </VRPTx:pdbx_nmr_exptl> </VRPTx:pdbx_nmr_exptlCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_exptl.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_exptl_sample_state CASCADE;
CREATE TYPE ENUM_pdbx_nmr_exptl_sample_state AS ENUM ( 'isotropic', 'anisotropic' );
CREATE TABLE pdbx_nmr_exptl (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	sample_state ENUM_pdbx_nmr_exptl_sample_state ,
	spectrometer_id INTEGER ,
	type TEXT ,
-- ATTRIBUTE
	conditions_id TEXT NOT NULL ,
-- ATTRIBUTE
	experiment_id TEXT NOT NULL ,
-- ATTRIBUTE
	solution_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_exptl_sampleType)
-- The chemical constituents of each NMR sample. Each sample is identified by a number and each component in the sample is identified by name. Example 1 - This example was taken from the study of MCP-1 which is a dimer under the conditions studied. Three solutions with different isotope compositions were studied. <VRPTx:pdbx_nmr_exptl_sampleCategory> <VRPTx:pdbx_nmr_exptl_sample component="MCP-1" solution_id="1"> <VRPTx:concentration>2</VRPTx:concentration> <VRPTx:concentration_units>mM</VRPTx:concentration_units> <VRPTx:isotopic_labeling>U-15N,13C</VRPTx:isotopic_labeling> </VRPTx:pdbx_nmr_exptl_sample> <VRPTx:pdbx_nmr_exptl_sample component="H2O" solution_id="1"> <VRPTx:concentration>90</VRPTx:concentration> <VRPTx:concentration_units>&#37;</VRPTx:concentration_units> <VRPTx:isotopic_labeling xsi:nil="true" /> </VRPTx:pdbx_nmr_exptl_sample> <VRPTx:pdbx_nmr_exptl_sample component="D2O" solution_id="1"> <VRPTx:concentration>10</VRPTx:concentration> <VRPTx:concentration_units>&#37;</VRPTx:concentration_units> <VRPTx:isotopic_labeling xsi:nil="true" /> </VRPTx:pdbx_nmr_exptl_sample> </VRPTx:pdbx_nmr_exptl_sampleCategory> Example 2 - This example was taken from the study of MCP-1 which is a dimer under the conditions studied. Three solutions with different isotope compositions were studied. <VRPTx:pdbx_nmr_exptl_sampleCategory> <VRPTx:pdbx_nmr_exptl_sample component="MCP-1" solution_id="2"> <VRPTx:concentration>1</VRPTx:concentration> <VRPTx:concentration_units>mM</VRPTx:concentration_units> <VRPTx:isotopic_labeling>U-50&#37; 15N</VRPTx:isotopic_labeling> </VRPTx:pdbx_nmr_exptl_sample> <VRPTx:pdbx_nmr_exptl_sample component="H2O" solution_id="2"> <VRPTx:concentration>90</VRPTx:concentration> <VRPTx:concentration_units>&#37;</VRPTx:concentration_units> <VRPTx:isotopic_labeling xsi:nil="true" /> </VRPTx:pdbx_nmr_exptl_sample> <VRPTx:pdbx_nmr_exptl_sample component="D2O" solution_id="2"> <VRPTx:concentration>10</VRPTx:concentration> <VRPTx:concentration_units>&#37;</VRPTx:concentration_units> <VRPTx:isotopic_labeling xsi:nil="true" /> </VRPTx:pdbx_nmr_exptl_sample> </VRPTx:pdbx_nmr_exptl_sampleCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_exptl_sample.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_exptl_sample_concentration_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_exptl_sample_concentration_units AS ENUM ( '%', 'mM', 'mg/mL', 'nM', 'pM', 'M', 'g/L', 'ug/mL', 'mg', 'mg/L', 'mg/uL', 'ug/uL', 'uM', 'v/v', 'w/v', 'w/w', '% w/v', '% w/w', '% v/v', 'saturated', 'na' );
CREATE TABLE pdbx_nmr_exptl_sample (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	concentration DECIMAL CHECK ( concentration >= 0.0 ) ,
	concentration_range TEXT ,
	concentration_units ENUM_pdbx_nmr_exptl_sample_concentration_units ,
	isotopic_labeling TEXT ,
-- ATTRIBUTE
	component TEXT NOT NULL ,
-- ATTRIBUTE
	solution_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_exptl_sample_conditionsType)
-- The experimental conditions used to for each sample. Each set of conditions is identified by a numerical code. This example was taken from a pH stability study. <VRPTx:pdbx_nmr_exptl_sample_conditionsCategory> <VRPTx:pdbx_nmr_exptl_sample_conditions conditions_id="1"> <VRPTx:ionic_strength>25mM NaCl</VRPTx:ionic_strength> <VRPTx:pH>7</VRPTx:pH> <VRPTx:pressure>ambient</VRPTx:pressure> <VRPTx:temperature>298</VRPTx:temperature> </VRPTx:pdbx_nmr_exptl_sample_conditions> <VRPTx:pdbx_nmr_exptl_sample_conditions conditions_id="2"> <VRPTx:ionic_strength>25mM NaCl</VRPTx:ionic_strength> <VRPTx:pH>3</VRPTx:pH> <VRPTx:pressure>ambient</VRPTx:pressure> <VRPTx:temperature>298</VRPTx:temperature> </VRPTx:pdbx_nmr_exptl_sample_conditions> </VRPTx:pdbx_nmr_exptl_sample_conditionsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_exptl_sample_conditions.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_exptl_sample_conditions_ionic_strength_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_exptl_sample_conditions_ionic_strength_units AS ENUM ( 'M', 'mM', 'Not defined' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_exptl_sample_conditions_pH_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_exptl_sample_conditions_pH_units AS ENUM ( 'pH', 'pD', 'pH*', 'Not defined' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_exptl_sample_conditions_temperature_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_exptl_sample_conditions_temperature_units AS ENUM ( 'K', 'C', 'Not defined' );
CREATE TABLE pdbx_nmr_exptl_sample_conditions (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	ionic_strength TEXT ,
	ionic_strength_err DECIMAL ,
	ionic_strength_units ENUM_pdbx_nmr_exptl_sample_conditions_ionic_strength_units ,
	label TEXT ,
	"pH" TEXT ,
	"pH_err" DECIMAL ,
	"pH_units" ENUM_pdbx_nmr_exptl_sample_conditions_pH_units ,
	pressure TEXT ,
	pressure_err DECIMAL ,
	pressure_units TEXT ,
	temperature TEXT ,
	temperature_err DECIMAL ,
	temperature_units ENUM_pdbx_nmr_exptl_sample_conditions_temperature_units ,
-- ATTRIBUTE
	conditions_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_force_constantsType)
-- The final force constants, including units, employed for the various experimental constraints, covalent geometry constraints, and the non-bonded interaction terms in the target function used for simulated annealing. This example is taken from a study of BAF, a dimeric DNA binding protein. The final force constants in the target function used for simulated annealing are: Experimental Constraint terms: Distance (NOE,H-bonds), Torsion angles, J coupling, 13C shifts, 1H shifts, Dipolar coupling, D isotope shifts Covalent Geometry Constraint terms: Bond lengths, Angles, Impropers Non-bonded Interaction terms: van der Waals, Type of van der Waals term, Conformational database potential, Radius of gyration. <VRPTx:pdbx_nmr_force_constantsCategory> <VRPTx:pdbx_nmr_force_constants entry_id="1ABC"> <VRPTx:covalent_geom_bond_term>1000.</VRPTx:covalent_geom_bond_term> <VRPTx:covalent_geom_bond_term_units>kcal/mol/A**2</VRPTx:covalent_geom_bond_term_units> <VRPTx:exptl_13C_shift_term>0.5</VRPTx:exptl_13C_shift_term> <VRPTx:exptl_13C_shift_term_units>kcal/mol/ppm**2</VRPTx:exptl_13C_shift_term_units> <VRPTx:exptl_1H_shift_term>7.5</VRPTx:exptl_1H_shift_term> <VRPTx:exptl_1H_shift_term_units>kcal/mol/ppm**2</VRPTx:exptl_1H_shift_term_units> <VRPTx:exptl_J_coupling_term>1.</VRPTx:exptl_J_coupling_term> <VRPTx:exptl_J_coupling_term_units>kcal/mol/Hz**2</VRPTx:exptl_J_coupling_term_units> <VRPTx:exptl_distance_term>30.</VRPTx:exptl_distance_term> <VRPTx:exptl_distance_term_units>kcal/mol/A**2</VRPTx:exptl_distance_term_units> <VRPTx:exptl_torsion_angles_term>200.</VRPTx:exptl_torsion_angles_term> <VRPTx:exptl_torsion_angles_term_units>kcal/mol/rad**2</VRPTx:exptl_torsion_angles_term_units> <VRPTx:non-bonded_inter_van_der_Waals_term_type>4.</VRPTx:non-bonded_inter_van_der_Waals_term_type> <VRPTx:non-bonded_inter_van_der_Waals_term_units>kcal/mol/A**4</VRPTx:non-bonded_inter_van_der_Waals_term_units> </VRPTx:pdbx_nmr_force_constants> </VRPTx:pdbx_nmr_force_constantsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_force_constants.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_covalent_geom_angles_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_covalent_geom_angles_term_units AS ENUM ( 'kcal/mol/rad**2', 'kJ/mol/rad**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_covalent_geom_bond_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_covalent_geom_bond_term_units AS ENUM ( 'kcal/mol/A**2', 'kJ/mol/nm**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_covalent_geom_impropers_term_unit CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_covalent_geom_impropers_term_unit AS ENUM ( 'kcal/mol/rad**2', 'kJ/mol/rad**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_13C_shift_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_13C_shift_term_units AS ENUM ( 'kcal/mol/ppm**2', 'kJ/mol/ppm**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_1H_shift_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_1H_shift_term_units AS ENUM ( 'kcal/mol/ppm**2', 'kJ/mol/ppm**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_D_isotope_shift_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_D_isotope_shift_term_units AS ENUM ( 'kcal/mol/ppb**2', 'kJ/mol/ppb**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_J_coupling_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_J_coupling_term_units AS ENUM ( 'kcal/mol/Hz**2', 'kJ/mol/Hz**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_dipolar_coupling_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_dipolar_coupling_term_units AS ENUM ( 'kcal/mol/Hz**2', 'kJ/mol/Hz**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_distance_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_distance_term_units AS ENUM ( 'kcal/mol/A**2', 'kJ/mol/nm**2', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_exptl_torsion_angles_term_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_exptl_torsion_angles_term_units AS ENUM ( 'kcal/mol/rad**2', 'kJ/mol/rad**2', 'author' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_non_bonded_inter_radius_of_gyrati CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_non_bonded_inter_radius_of_gyrati AS ENUM ( 'kcal/mol/ A**2', 'kJ/mol/ nm**4', 'other' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_force_constants_non_bonded_inter_van_der_Waals_te CASCADE;
CREATE TYPE ENUM_pdbx_nmr_force_constants_non_bonded_inter_van_der_Waals_te AS ENUM ( 'quartic', 'other' );
CREATE TABLE pdbx_nmr_force_constants (
	covalent_geom_angles_term DECIMAL ,
	covalent_geom_angles_term_units ENUM_pdbx_nmr_force_constants_covalent_geom_angles_term_units ,
	covalent_geom_bond_term DECIMAL ,
	covalent_geom_bond_term_units ENUM_pdbx_nmr_force_constants_covalent_geom_bond_term_units ,
	covalent_geom_impropers_term DECIMAL ,
	covalent_geom_impropers_term_units ENUM_pdbx_nmr_force_constants_covalent_geom_impropers_term_unit ,
	"exptl_13C_shift_term" DECIMAL ,
	"exptl_13C_shift_term_units" ENUM_pdbx_nmr_force_constants_exptl_13C_shift_term_units ,
	"exptl_1H_shift_term" DECIMAL ,
	"exptl_1H_shift_term_units" ENUM_pdbx_nmr_force_constants_exptl_1H_shift_term_units ,
	"exptl_D_isotope_shift_term" DECIMAL ,
	"exptl_D_isotope_shift_term_units" ENUM_pdbx_nmr_force_constants_exptl_D_isotope_shift_term_units ,
	"exptl_J_coupling_term" DECIMAL ,
	"exptl_J_coupling_term_units" ENUM_pdbx_nmr_force_constants_exptl_J_coupling_term_units ,
	exptl_dipolar_coupling_term DECIMAL ,
	exptl_dipolar_coupling_term_units ENUM_pdbx_nmr_force_constants_exptl_dipolar_coupling_term_units ,
	exptl_distance_term DECIMAL ,
	exptl_distance_term_units ENUM_pdbx_nmr_force_constants_exptl_distance_term_units ,
	exptl_torsion_angles_term DECIMAL ,
	exptl_torsion_angles_term_units ENUM_pdbx_nmr_force_constants_exptl_torsion_angles_term_units ,
	"non-bonded_inter_conf_db_potential_term" DECIMAL ,
	"non-bonded_inter_radius_of_gyration_term" DECIMAL ,
	"non-bonded_inter_radius_of_gyration_term_units" ENUM_pdbx_nmr_force_constants_non_bonded_inter_radius_of_gyrati ,
	"non-bonded_inter_van_der_Waals_term" DECIMAL ,
	"non-bonded_inter_van_der_Waals_term_type" ENUM_pdbx_nmr_force_constants_non_bonded_inter_van_der_Waals_te ,
	"non-bonded_inter_van_der_Waals_term_units" ENUM_pdbx_nmr_force_constants_non_bonded_inter_van_der_Waals_te ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_refineType)
-- Describe the method and details of the refinement of the deposited structure. This example is drawn from the MCP-1 structure. <VRPTx:pdbx_nmr_refineCategory> <VRPTx:pdbx_nmr_refine entry_id="1ABC" software_ordinal="1"> <VRPTx:method>torsion angle dynamics</VRPTx:method> </VRPTx:pdbx_nmr_refine> </VRPTx:pdbx_nmr_refineCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_refine.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_refine (
	details TEXT ,
	method TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	software_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_representativeType)
-- An average structure is often calculated in addition to the ensemble, or one of the ensemble is selected as a representative structure. This section describes selection of the representative structure. This example is drawn from the MCP-1 structure. <VRPTx:pdbx_nmr_representativeCategory> <VRPTx:pdbx_nmr_representative entry_id="1ABC"> <VRPTx:conformer_id>15</VRPTx:conformer_id> <VRPTx:selection_criteria>lowest energy</VRPTx:selection_criteria> </VRPTx:pdbx_nmr_representative> </VRPTx:pdbx_nmr_representativeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_representative.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_representative (
	conformer_id TEXT ,
	selection_criteria TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_restraint_listType)
-- Items in the PDBX_NMR_RESTRAINT_LIST category provide information about a list of NMR restraints.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_restraint_list_type CASCADE;
CREATE TYPE ENUM_pdbx_nmr_restraint_list_type AS ENUM ( 'distance', 'dihedral_angle', 'RDC' );
CREATE TABLE pdbx_nmr_restraint_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	label TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_nmr_restraint_list_type NOT NULL
);

--
-- (quoted from pdbx_nmr_restraint_summaryType)
-- Data items in the category record NMR restraints analysis. Ref: User guide to the wwPDB NMR validation reports 8. NMR restraints analysis 8.1 Conformationally restricting restraints
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_restraint_summary (
-- xsd:restriction/xsd:minInclusive="0"
	dihedral_angle_restraints_total INTEGER CHECK ( dihedral_angle_restraints_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	distance_restraints_total INTEGER CHECK ( distance_restraints_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	disulfide_bond_restraints_total INTEGER CHECK ( disulfide_bond_restraints_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	hydrogen_bond_restraints_total INTEGER CHECK ( hydrogen_bond_restraints_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	interchain_total_count INTEGER CHECK ( interchain_total_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	intraresidue_total_count INTEGER CHECK ( intraresidue_total_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	long_range_restraints_per_residue DECIMAL CHECK ( long_range_restraints_per_residue >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	long_range_total_count INTEGER CHECK ( long_range_total_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	medium_range_total_count INTEGER CHECK ( medium_range_total_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	restraints_per_residue DECIMAL CHECK ( restraints_per_residue >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	sequential_total_count INTEGER CHECK ( sequential_total_count >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	unmapped_restraints_total INTEGER CHECK ( unmapped_restraints_total >= 0 ) ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_restraint_violationType)
-- Data items in the category record residual violations of conformationally restricting restraints in different bins based on its magnitude of violation. Ref: User guide to the wwPDB NMR validation reports 8. NMR restraints analysis 8.2 Residual restraint violations
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_restraint_violation_bin_units CASCADE;
CREATE TYPE ENUM_pdbx_nmr_restraint_violation_bin_units AS ENUM ( 'A', 'degrees', 'Hz' );
DROP TYPE IF EXISTS ENUM_pdbx_nmr_restraint_violation_type CASCADE;
CREATE TYPE ENUM_pdbx_nmr_restraint_violation_type AS ENUM ( 'distance', 'dihedral_angle', 'RDC' );
CREATE TABLE pdbx_nmr_restraint_violation (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	bin_units ENUM_pdbx_nmr_restraint_violation_bin_units ,
-- xsd:restriction/xsd:minInclusive="0.0"
	limit_bin_max DECIMAL CHECK ( limit_bin_max >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	limit_bin_min DECIMAL CHECK ( limit_bin_min >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	maximum_violation_in_bin DECIMAL CHECK ( maximum_violation_in_bin >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	violations_per_model DECIMAL CHECK ( violations_per_model >= 0.0 ) ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_nmr_restraint_violation_type NOT NULL
);

--
-- (quoted from pdbx_nmr_softwareType)
-- Description of the software that was used for data collection, data processing, data analysis, structure calculations and refinement. The description should include the name of the software, the author of the software and the version used. This example describes the software used in the MCP-1 study. <VRPTx:pdbx_nmr_softwareCategory> <VRPTx:pdbx_nmr_software ordinal="1"> <VRPTx:authors>Bruker</VRPTx:authors> <VRPTx:classification>collection</VRPTx:classification> <VRPTx:name>UXNMR</VRPTx:name> <VRPTx:version>940501.3</VRPTx:version> </VRPTx:pdbx_nmr_software> <VRPTx:pdbx_nmr_software ordinal="2"> <VRPTx:authors>Hare</VRPTx:authors> <VRPTx:classification>processing</VRPTx:classification> <VRPTx:name>FELIX</VRPTx:name> <VRPTx:version>1.1</VRPTx:version> </VRPTx:pdbx_nmr_software> <VRPTx:pdbx_nmr_software ordinal="3"> <VRPTx:authors>Kraulis</VRPTx:authors> <VRPTx:classification>data analysis</VRPTx:classification> <VRPTx:name>ANSIG</VRPTx:name> <VRPTx:version>3.0</VRPTx:version> </VRPTx:pdbx_nmr_software> <VRPTx:pdbx_nmr_software ordinal="4"> <VRPTx:authors>Brunger</VRPTx:authors> <VRPTx:classification>structure calculation</VRPTx:classification> <VRPTx:name>X-PLOR</VRPTx:name> <VRPTx:version>3.8</VRPTx:version> </VRPTx:pdbx_nmr_software> </VRPTx:pdbx_nmr_softwareCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_software.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_software (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	authors TEXT ,
	classification TEXT ,
	name TEXT ,
	version TEXT ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_spectrometerType)
-- The details about each spectrometer used to collect data for this deposition. The instruments described here are the ones used for the MCP-1 studies. <VRPTx:pdbx_nmr_spectrometerCategory> <VRPTx:pdbx_nmr_spectrometer spectrometer_id="1"> <VRPTx:field_strength>600</VRPTx:field_strength> <VRPTx:type>Bruker AMX</VRPTx:type> </VRPTx:pdbx_nmr_spectrometer> <VRPTx:pdbx_nmr_spectrometer spectrometer_id="2"> <VRPTx:field_strength>500</VRPTx:field_strength> <VRPTx:type>Bruker AMX</VRPTx:type> </VRPTx:pdbx_nmr_spectrometer> </VRPTx:pdbx_nmr_spectrometerCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nmr_spectrometer.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nmr_spectrometer (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	field_strength DECIMAL ,
	manufacturer TEXT ,
	model TEXT ,
	type TEXT ,
-- ATTRIBUTE
	spectrometer_id TEXT NOT NULL
);

--
-- (quoted from pdbx_nmr_unmapped_chem_shiftType)
-- Items in the PDBX_NMR_UNMAPPED_CHEM_SHIFT category provide information about assigned chemical shifts not mapped to atoms in the NMR structure.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_unmapped_chem_shift_ambiguity_code CASCADE;
CREATE TYPE ENUM_pdbx_nmr_unmapped_chem_shift_ambiguity_code AS ENUM ( '1', '2', '3', '4', '5', '6', '9' );
CREATE TABLE pdbx_nmr_unmapped_chem_shift (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ambiguity_code ENUM_pdbx_nmr_unmapped_chem_shift_ambiguity_code ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	details TEXT ,
	val DECIMAL ,
	val_err DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nmr_unparsed_chem_shiftType)
-- Items in the PDBX_NMR_UNPARSED_CHEM_SHIFT category provide information about assigned chemical shifts not parsed.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_nmr_unparsed_chem_shift_ambiguity_code CASCADE;
CREATE TYPE ENUM_pdbx_nmr_unparsed_chem_shift_ambiguity_code AS ENUM ( '1', '2', '3', '4', '5', '6', '9' );
CREATE TABLE pdbx_nmr_unparsed_chem_shift (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	ambiguity_code ENUM_pdbx_nmr_unparsed_chem_shift_ambiguity_code ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	chem_shift_id INTEGER ,
	details TEXT ,
	val DECIMAL ,
	val_err DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_nonpoly_schemeType)
-- The PDBX_NONPOLY_SCHEME category provides residue level nomenclature mapping for non-polymer entities. Example 1 - <VRPTx:pdbx_nonpoly_schemeCategory> <VRPTx:pdbx_nonpoly_scheme asym_id="C" ndb_seq_num="100"> <VRPTx:auth_mon_id>HOH</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>100</VRPTx:auth_seq_num> <VRPTx:entity_id>3</VRPTx:entity_id> <VRPTx:mon_id>HOH</VRPTx:mon_id> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>HOH</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>100</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>C</VRPTx:pdb_strand_id> </VRPTx:pdbx_nonpoly_scheme> </VRPTx:pdbx_nonpoly_schemeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_nonpoly_scheme.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_nonpoly_scheme (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_mon_id TEXT ,
	auth_seq_num TEXT ,
	entity_id TEXT ,
	mon_id TEXT ,
	pdb_ins_code TEXT ,
	pdb_mon_id TEXT ,
	pdb_seq_num TEXT ,
	pdb_strand_id TEXT ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	ndb_seq_num TEXT NOT NULL
);

--
-- (quoted from pdbx_percentile_entity_viewType)
-- Data items in the PDBX_PERCENTILE_ENTITY_VIEW category describe a percentile rank representation of defined validation metric for each entity in the wwPDB validation report. Example 1 - <VRPTx:pdbx_percentile_entity_viewCategory> <VRPTx:pdbx_percentile_entity_view conditions_id="1" label_asym_id="A" type="RSRZ_outliers_percent"> <VRPTx:conditions_label>absolute</VRPTx:conditions_label> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_entity_view> <VRPTx:pdbx_percentile_entity_view conditions_id="2" label_asym_id="A" type="RSRZ_outliers_percent"> <VRPTx:conditions_label>relative</VRPTx:conditions_label> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_entity_view> <VRPTx:pdbx_percentile_entity_view conditions_id="1" label_asym_id="B" type="RSRZ_outliers_percent"> <VRPTx:conditions_label>absolute</VRPTx:conditions_label> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_entity_view> <VRPTx:pdbx_percentile_entity_view conditions_id="2" label_asym_id="B" type="RSRZ_outliers_percent"> <VRPTx:conditions_label>relative</VRPTx:conditions_label> <VRPTx:entity_id>1</VRPTx:entity_id> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_entity_view> </VRPTx:pdbx_percentile_entity_viewCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_percentile_entity_view_conditions_label CASCADE;
CREATE TYPE ENUM_pdbx_percentile_entity_view_conditions_label AS ENUM ( 'absolute', 'relative' );
DROP TYPE IF EXISTS ENUM_pdbx_percentile_entity_view_type CASCADE;
CREATE TYPE ENUM_pdbx_percentile_entity_view_type AS ENUM ( 'RSRZ_outliers_percent', 'Ramachandran_outlier_percent', 'rotamer_outliers_percent' );
CREATE TABLE pdbx_percentile_entity_view (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
	conditions_label ENUM_pdbx_percentile_entity_view_conditions_label ,
	entity_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	rank DECIMAL CHECK ( rank >= 0.0 AND rank <= 100.0 ) ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL ,
-- ATTRIBUTE
	conditions_id INTEGER NOT NULL ,
-- ATTRIBUTE
	label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_percentile_entity_view_type NOT NULL
);

--
-- (quoted from pdbx_percentile_listType)
-- Data items in the PDBX_PERCENTILE_LIST category describe a set of percentile rank representations of each validation metric in the wwPDB validation report. Example 1 - <VRPTx:pdbx_percentile_listCategory> <VRPTx:pdbx_percentile_list entry_id="5U9B"> <VRPTx:name>all,1.8,xray</VRPTx:name> </VRPTx:pdbx_percentile_list> </VRPTx:pdbx_percentile_listCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_percentile_list (
	name TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_percentile_viewType)
-- Data items in the PDBX_PERCENTILE_VIEW category describe a percentile rank representation of defined validation metric in the wwPDB validation report. Example 1 - <VRPTx:pdbx_percentile_viewCategory> <VRPTx:pdbx_percentile_view conditions_id="1" entry_id="5B1L" type="&apos;all_atom_clashscore"> <VRPTx:conditions_label>absolute</VRPTx:conditions_label> <VRPTx:rank>66.9</VRPTx:rank> </VRPTx:pdbx_percentile_view> <VRPTx:pdbx_percentile_view conditions_id="1" entry_id="5B1L" type="&apos;RSRZ_outliers_percent"> <VRPTx:conditions_label>absolute</VRPTx:conditions_label> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_view> <VRPTx:pdbx_percentile_view conditions_id="2" entry_id="5B1L" type="&apos;all_atom_clashscore"> <VRPTx:conditions_label>relative</VRPTx:conditions_label> <VRPTx:rank>62.5</VRPTx:rank> </VRPTx:pdbx_percentile_view> <VRPTx:pdbx_percentile_view conditions_id="2" entry_id="5B1L" type="&apos;RSRZ_outliers_percent"> <VRPTx:conditions_label>relative</VRPTx:conditions_label> <VRPTx:rank>100.0</VRPTx:rank> </VRPTx:pdbx_percentile_view> </VRPTx:pdbx_percentile_viewCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_percentile_view_conditions_label CASCADE;
CREATE TYPE ENUM_pdbx_percentile_view_conditions_label AS ENUM ( 'absolute', 'relative' );
DROP TYPE IF EXISTS ENUM_pdbx_percentile_view_type CASCADE;
CREATE TYPE ENUM_pdbx_percentile_view_type AS ENUM ( 'R_value_R_free', 'RNA_suiteness_score', 'all_atom_clashscore', 'RSRZ_outliers_percent', 'Ramachandran_outlier_percent', 'rotamer_outliers_percent' );
CREATE TABLE pdbx_percentile_view (
	conditions_label ENUM_pdbx_percentile_view_conditions_label ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	rank DECIMAL CHECK ( rank >= 0.0 AND rank <= 100.0 ) ,
-- ATTRIBUTE
	conditions_id INTEGER NOT NULL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_percentile_view_type NOT NULL
);

--
-- (quoted from pdbx_phasing_MAD_setType)
-- Record details about each phasing set: (Note: the phasing set is different from data set. for example: if there are three data sets, the inflection point (IP), the peak (PK) and the high remote (HR), the combination of the phasing set will be IP_iso, PK_iso (the isomorphous repleacement with HR as 'native'), IP_ano, PK_ano and HR_ano (the anomalous difference with itself). Therefore, there are five set used for phasing. Example 1 - three wavelengths <VRPTx:pdbx_phasing_MAD_setCategory> <VRPTx:pdbx_phasing_MAD_set id="ISO_1"> <VRPTx:R_cullis_acentric>0.000</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5387</VRPTx:reflns_acentric> <VRPTx:reflns_centric>471</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> <VRPTx:pdbx_phasing_MAD_set id="ISO_2"> <VRPTx:R_cullis_acentric>0.803</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.718</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5365</VRPTx:reflns_acentric> <VRPTx:reflns_centric>469</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> <VRPTx:pdbx_phasing_MAD_set id="ISO_3"> <VRPTx:R_cullis_acentric>0.658</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.500</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5317</VRPTx:reflns_acentric> <VRPTx:reflns_centric>460</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> <VRPTx:pdbx_phasing_MAD_set id="ANO_1"> <VRPTx:R_cullis_acentric>0.841</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5278</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> <VRPTx:pdbx_phasing_MAD_set id="ANO_2"> <VRPTx:R_cullis_acentric>0.649</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5083</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> <VRPTx:pdbx_phasing_MAD_set id="ANO_3"> <VRPTx:R_cullis_acentric>0.829</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:d_res_high>2.00</VRPTx:d_res_high> <VRPTx:d_res_low>22.60</VRPTx:d_res_low> <VRPTx:reflns_acentric>5329</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set> </VRPTx:pdbx_phasing_MAD_setCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_MAD_set.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "pdbx_phasing_MAD_set" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"R_cullis" DECIMAL ,
	"R_cullis_acentric" DECIMAL ,
	"R_cullis_centric" DECIMAL ,
	"R_kraut" DECIMAL ,
	"R_kraut_acentric" DECIMAL ,
	"R_kraut_centric" DECIMAL ,
	d_res_high DECIMAL ,
	d_res_low DECIMAL ,
	fom DECIMAL ,
	fom_acentric DECIMAL ,
	fom_centric DECIMAL ,
	loc DECIMAL ,
	loc_acentric DECIMAL ,
	loc_centric DECIMAL ,
	number_of_sites INTEGER ,
	power DECIMAL ,
	power_acentric DECIMAL ,
	power_centric DECIMAL ,
	reflns INTEGER ,
	reflns_acentric INTEGER ,
	reflns_centric INTEGER ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_phasing_MAD_set_shellType)
-- The same as category pdbx_phasing_MAD_set, but broken into shells. Example 1 - three wavelengths (SHARP example) <VRPTx:pdbx_phasing_MAD_set_shellCategory> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="7.77" d_res_low="22.60" id="ISO_1"> <VRPTx:R_cullis_acentric>0.000</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>0.000</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>64</VRPTx:reflns_acentric> <VRPTx:reflns_centric>23</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="5.67" d_res_low="7.77" id="ISO_1"> <VRPTx:R_cullis_acentric>0.000</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>0.000</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>130</VRPTx:reflns_acentric> <VRPTx:reflns_centric>32</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="4.68" d_res_low="5.67" id="ISO_1"> <VRPTx:R_cullis_acentric>0.000</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>0.000</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>182</VRPTx:reflns_acentric> <VRPTx:reflns_centric>27</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="4.07" d_res_low="4.68" id="ISO_1"> <VRPTx:R_cullis_acentric>0.000</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>0.000</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>207</VRPTx:reflns_acentric> <VRPTx:reflns_centric>24</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="7.77" d_res_low="22.60" id="ANO_1"> <VRPTx:R_cullis_acentric>0.610</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>1.804</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>62</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="5.67" d_res_low="7.77" id="ANO_1"> <VRPTx:R_cullis_acentric>0.532</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>2.382</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>129</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="4.68" d_res_low="5.67" id="ANO_1"> <VRPTx:R_cullis_acentric>0.673</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>1.858</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>178</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> <VRPTx:pdbx_phasing_MAD_set_shell d_res_high="4.07" d_res_low="4.68" id="ANO_1"> <VRPTx:R_cullis_acentric>0.755</VRPTx:R_cullis_acentric> <VRPTx:R_cullis_centric>0.000</VRPTx:R_cullis_centric> <VRPTx:power_acentric>1.605</VRPTx:power_acentric> <VRPTx:power_centric>0.000</VRPTx:power_centric> <VRPTx:reflns_acentric>204</VRPTx:reflns_acentric> <VRPTx:reflns_centric>0</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_set_shell> </VRPTx:pdbx_phasing_MAD_set_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_MAD_set_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "pdbx_phasing_MAD_set_shell" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"R_cullis" DECIMAL ,
	"R_cullis_acentric" DECIMAL ,
	"R_cullis_centric" DECIMAL ,
	"R_kraut" DECIMAL ,
	"R_kraut_acentric" DECIMAL ,
	"R_kraut_centric" DECIMAL ,
	fom DECIMAL ,
	fom_acentric DECIMAL ,
	fom_centric DECIMAL ,
	loc DECIMAL ,
	loc_acentric DECIMAL ,
	loc_centric DECIMAL ,
	power DECIMAL ,
	power_acentric DECIMAL ,
	power_centric DECIMAL ,
	reflns INTEGER ,
	reflns_acentric INTEGER ,
	reflns_centric INTEGER ,
-- ATTRIBUTE
	d_res_high DECIMAL NOT NULL ,
-- ATTRIBUTE
	d_res_low DECIMAL NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_phasing_MAD_set_siteType)
-- Record the details (coordinates etc.) of anomalous scatters. Example 1 - anomalous scatters is Se <VRPTx:pdbx_phasing_MAD_set_siteCategory> <VRPTx:pdbx_phasing_MAD_set_site id="1"> <VRPTx:Cartn_x>25.9407</VRPTx:Cartn_x> <VRPTx:Cartn_y>-0.103471</VRPTx:Cartn_y> <VRPTx:Cartn_z>17.4094</VRPTx:Cartn_z> <VRPTx:atom_type_symbol>SE</VRPTx:atom_type_symbol> <VRPTx:b_iso>15.2561</VRPTx:b_iso> <VRPTx:occupancy>1</VRPTx:occupancy> </VRPTx:pdbx_phasing_MAD_set_site> <VRPTx:pdbx_phasing_MAD_set_site id="2"> <VRPTx:Cartn_x>30.6534</VRPTx:Cartn_x> <VRPTx:Cartn_y>6.62359</VRPTx:Cartn_y> <VRPTx:Cartn_z>9.93063</VRPTx:Cartn_z> <VRPTx:atom_type_symbol>SE</VRPTx:atom_type_symbol> <VRPTx:b_iso>12.9102</VRPTx:b_iso> <VRPTx:occupancy>1</VRPTx:occupancy> </VRPTx:pdbx_phasing_MAD_set_site> <VRPTx:pdbx_phasing_MAD_set_site id="3"> <VRPTx:Cartn_x>-3.26506</VRPTx:Cartn_x> <VRPTx:Cartn_y>15.5546</VRPTx:Cartn_y> <VRPTx:Cartn_z>53.9529</VRPTx:Cartn_z> <VRPTx:atom_type_symbol>SE</VRPTx:atom_type_symbol> <VRPTx:b_iso>30.5239</VRPTx:b_iso> <VRPTx:occupancy>1</VRPTx:occupancy> </VRPTx:pdbx_phasing_MAD_set_site> </VRPTx:pdbx_phasing_MAD_set_siteCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_MAD_set_site.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "pdbx_phasing_MAD_set_site" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"Cartn_x" DECIMAL ,
	"Cartn_x_esd" DECIMAL ,
	"Cartn_y" DECIMAL ,
	"Cartn_y_esd" DECIMAL ,
	"Cartn_z" DECIMAL ,
	"Cartn_z_esd" DECIMAL ,
	atom_type_symbol TEXT ,
	b_iso DECIMAL ,
	b_iso_esd DECIMAL ,
	fract_x DECIMAL ,
	fract_x_esd DECIMAL ,
	fract_y DECIMAL ,
	fract_y_esd DECIMAL ,
	fract_z DECIMAL ,
	fract_z_esd DECIMAL ,
	occupancy DECIMAL ,
	occupancy_esd DECIMAL ,
	occupancy_iso DECIMAL ,
	set_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_phasing_MAD_shellType)
-- Data items in the PDBX_PHASING_MAD_SHELL category record details about the phasing of the structure, when methods involving multiple anomalous dispersion techniques are involved (note: the values are overall, but broken down into shells of resolution) Example 1 - <VRPTx:pdbx_phasing_MAD_shellCategory> <VRPTx:pdbx_phasing_MAD_shell d_res_high="7.77" d_res_low="22.60"> <VRPTx:fom_acentric>0.886</VRPTx:fom_acentric> <VRPTx:fom_centric>0.641</VRPTx:fom_centric> <VRPTx:reflns_acentric>64</VRPTx:reflns_acentric> <VRPTx:reflns_centric>23</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> <VRPTx:pdbx_phasing_MAD_shell d_res_high="5.67" d_res_low="7.77"> <VRPTx:fom_acentric>0.863</VRPTx:fom_acentric> <VRPTx:fom_centric>0.642</VRPTx:fom_centric> <VRPTx:reflns_acentric>132</VRPTx:reflns_acentric> <VRPTx:reflns_centric>32</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> <VRPTx:pdbx_phasing_MAD_shell d_res_high="4.68" d_res_low="5.67"> <VRPTx:fom_acentric>0.842</VRPTx:fom_acentric> <VRPTx:fom_centric>0.737</VRPTx:fom_centric> <VRPTx:reflns_acentric>182</VRPTx:reflns_acentric> <VRPTx:reflns_centric>27</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> <VRPTx:pdbx_phasing_MAD_shell d_res_high="4.07" d_res_low="4.68"> <VRPTx:fom_acentric>0.789</VRPTx:fom_acentric> <VRPTx:fom_centric>0.682</VRPTx:fom_centric> <VRPTx:reflns_acentric>209</VRPTx:reflns_acentric> <VRPTx:reflns_centric>24</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> <VRPTx:pdbx_phasing_MAD_shell d_res_high="3.65" d_res_low="4.07"> <VRPTx:fom_acentric>0.772</VRPTx:fom_acentric> <VRPTx:fom_centric>0.633</VRPTx:fom_centric> <VRPTx:reflns_acentric>246</VRPTx:reflns_acentric> <VRPTx:reflns_centric>27</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> <VRPTx:pdbx_phasing_MAD_shell d_res_high="3.34" d_res_low="3.65"> <VRPTx:fom_acentric>0.752</VRPTx:fom_acentric> <VRPTx:fom_centric>0.700</VRPTx:fom_centric> <VRPTx:reflns_acentric>260</VRPTx:reflns_acentric> <VRPTx:reflns_centric>31</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_MAD_shell> </VRPTx:pdbx_phasing_MAD_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_MAD_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "pdbx_phasing_MAD_shell" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"R_cullis" DECIMAL ,
	"R_cullis_acentric" DECIMAL ,
	"R_cullis_centric" DECIMAL ,
	"R_kraut" DECIMAL ,
	"R_kraut_acentric" DECIMAL ,
	"R_kraut_centric" DECIMAL ,
	fom DECIMAL ,
	fom_acentric DECIMAL ,
	fom_centric DECIMAL ,
	loc DECIMAL ,
	loc_acentric DECIMAL ,
	loc_centric DECIMAL ,
	power DECIMAL ,
	power_acentric DECIMAL ,
	power_centric DECIMAL ,
	reflns INTEGER ,
	reflns_acentric DECIMAL ,
	reflns_centric INTEGER ,
-- ATTRIBUTE
	d_res_high DECIMAL NOT NULL ,
-- ATTRIBUTE
	d_res_low DECIMAL NOT NULL
);

--
-- (quoted from pdbx_phasing_MRType)
-- Data items in the PDBX_PHASING_MR category record details about molecular replacement. Example 1 - molecular replacement example from program CNS. <VRPTx:pdbx_phasing_MRCategory> <VRPTx:pdbx_phasing_MR entry_id="ABC001"> <VRPTx:correlation_coeff_Fo_to_Fc>0.586</VRPTx:correlation_coeff_Fo_to_Fc> <VRPTx:d_res_high_rotation>3.8</VRPTx:d_res_high_rotation> <VRPTx:d_res_high_translation>4.0</VRPTx:d_res_high_translation> <VRPTx:d_res_low_rotation>13.0</VRPTx:d_res_low_rotation> <VRPTx:d_res_low_translation>15.0</VRPTx:d_res_low_translation> <VRPTx:method_rotation>real-space rotation search</VRPTx:method_rotation> <VRPTx:method_translation>gerneral using PC-refinement= e2e2</VRPTx:method_translation> <VRPTx:packing>0.3086</VRPTx:packing> <VRPTx:reflns_percent_rotation>97.8</VRPTx:reflns_percent_rotation> <VRPTx:reflns_percent_translation>97.7</VRPTx:reflns_percent_translation> <VRPTx:sigma_F_rotation>1.0</VRPTx:sigma_F_rotation> <VRPTx:sigma_F_translation>0</VRPTx:sigma_F_translation> </VRPTx:pdbx_phasing_MR> </VRPTx:pdbx_phasing_MRCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_MR.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "pdbx_phasing_MR" (
	"R_factor" DECIMAL ,
	"R_rigid_body" DECIMAL ,
	"correlation_coeff_Fo_to_Fc" DECIMAL ,
	"correlation_coeff_Io_to_Ic" DECIMAL ,
	d_res_high_rotation DECIMAL ,
	d_res_high_translation DECIMAL ,
	d_res_low_rotation DECIMAL ,
	d_res_low_translation DECIMAL ,
	method_rotation TEXT ,
	method_translation TEXT ,
	model_details TEXT ,
	native_set_id TEXT ,
	packing DECIMAL ,
	reflns_percent_rotation DECIMAL ,
	reflns_percent_translation DECIMAL ,
	"sigma_F_rotation" DECIMAL ,
	"sigma_F_translation" DECIMAL ,
	"sigma_I_rotation" DECIMAL ,
	"sigma_I_translation" DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_phasing_dmType)
-- Data items in the PDBX_PHASING_DM category record details about density modification Example 1 - density modification from resolve <VRPTx:pdbx_phasing_dmCategory> <VRPTx:pdbx_phasing_dm entry_id="ABC001"> <VRPTx:fom>0.85</VRPTx:fom> <VRPTx:fom_acentric>0.85</VRPTx:fom_acentric> <VRPTx:fom_centric>0.79</VRPTx:fom_centric> <VRPTx:reflns>12486</VRPTx:reflns> <VRPTx:reflns_acentric>11351</VRPTx:reflns_acentric> <VRPTx:reflns_centric>1135</VRPTx:reflns_centric> </VRPTx:pdbx_phasing_dm> </VRPTx:pdbx_phasing_dmCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_dm.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_phasing_dm (
	delta_phi_final DECIMAL ,
	delta_phi_initial DECIMAL ,
	fom DECIMAL ,
	fom_acentric DECIMAL ,
	fom_centric DECIMAL ,
	mask_type TEXT ,
	method TEXT ,
	reflns INTEGER ,
	reflns_acentric INTEGER ,
	reflns_centric INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_phasing_dm_shellType)
-- Data items in the PDBX_PHASING_DM_SHELL category record details about density modification in resolution shell. Example 1 - density modification with shells <VRPTx:pdbx_phasing_dm_shellCategory> <VRPTx:pdbx_phasing_dm_shell d_res_high="7.73" d_res_low="100.00"> <VRPTx:delta_phi_final>24.7</VRPTx:delta_phi_final> <VRPTx:fom>0.879</VRPTx:fom> <VRPTx:reflns>502</VRPTx:reflns> </VRPTx:pdbx_phasing_dm_shell> <VRPTx:pdbx_phasing_dm_shell d_res_high="6.24" d_res_low="7.73"> <VRPTx:delta_phi_final>29.2</VRPTx:delta_phi_final> <VRPTx:fom>0.857</VRPTx:fom> <VRPTx:reflns>506</VRPTx:reflns> </VRPTx:pdbx_phasing_dm_shell> <VRPTx:pdbx_phasing_dm_shell d_res_high="5.50" d_res_low="6.24"> <VRPTx:delta_phi_final>29.2</VRPTx:delta_phi_final> <VRPTx:fom>0.838</VRPTx:fom> <VRPTx:reflns>504</VRPTx:reflns> </VRPTx:pdbx_phasing_dm_shell> <VRPTx:pdbx_phasing_dm_shell d_res_high="5.02" d_res_low="5.50"> <VRPTx:delta_phi_final>25.3</VRPTx:delta_phi_final> <VRPTx:fom>0.851</VRPTx:fom> <VRPTx:reflns>502</VRPTx:reflns> </VRPTx:pdbx_phasing_dm_shell> <VRPTx:pdbx_phasing_dm_shell d_res_high="4.67" d_res_low="5.02"> <VRPTx:delta_phi_final>22.7</VRPTx:delta_phi_final> <VRPTx:fom>0.831</VRPTx:fom> <VRPTx:reflns>503</VRPTx:reflns> </VRPTx:pdbx_phasing_dm_shell> </VRPTx:pdbx_phasing_dm_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_phasing_dm_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_phasing_dm_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	delta_phi_final DECIMAL ,
	delta_phi_initial DECIMAL ,
	fom DECIMAL ,
	fom_acentric DECIMAL ,
	fom_centric DECIMAL ,
	reflns INTEGER ,
	reflns_acentric INTEGER ,
	reflns_centric INTEGER ,
-- ATTRIBUTE
	d_res_high DECIMAL NOT NULL ,
-- ATTRIBUTE
	d_res_low DECIMAL NOT NULL
);

--
-- (quoted from pdbx_point_symmetryType)
-- Data items in the PDBX_POINT_SYMMETRY category record details about the point symmetry group associated with this entry. Example 1 - <VRPTx:pdbx_point_symmetryCategory> <VRPTx:pdbx_point_symmetry entry_id="1ABC"> <VRPTx:H-M_notation>532</VRPTx:H-M_notation> <VRPTx:Schoenflies_symbol>I</VRPTx:Schoenflies_symbol> </VRPTx:pdbx_point_symmetry> </VRPTx:pdbx_point_symmetryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_point_symmetry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_point_symmetry_Schoenflies_symbol CASCADE;
CREATE TYPE ENUM_pdbx_point_symmetry_Schoenflies_symbol AS ENUM ( 'I', 'O', 'T', 'C', 'D' );
CREATE TABLE pdbx_point_symmetry (
	"H-M_notation" TEXT ,
	"Schoenflies_symbol" ENUM_pdbx_point_symmetry_Schoenflies_symbol ,
-- xsd:restriction/xsd:minInclusive="1"
	circular_symmetry INTEGER CHECK ( circular_symmetry >= 1 ) ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_poly_seq_schemeType)
-- The PDBX_POLY_SEQ_SCHEME category provides residue level nomenclature mapping for polymer entities. Example 1 - based on NDB entry DDFB25 <VRPTx:pdbx_poly_seq_schemeCategory> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DC" seq_id="1"> <VRPTx:auth_mon_id>DC</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>1</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>1</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DC</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>1</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DG" seq_id="2"> <VRPTx:auth_mon_id>DG</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>2</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>2</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DG</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>2</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DT" seq_id="3"> <VRPTx:auth_mon_id>DT</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>3</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>3</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DT</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>3</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DA" seq_id="4"> <VRPTx:auth_mon_id>DA</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>4</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>4</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DA</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>4</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DC" seq_id="5"> <VRPTx:auth_mon_id>DC</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>5</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>5</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DC</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>5</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> <VRPTx:pdbx_poly_seq_scheme asym_id="A" entity_id="1" mon_id="DG" seq_id="6"> <VRPTx:auth_mon_id>DG</VRPTx:auth_mon_id> <VRPTx:auth_seq_num>6</VRPTx:auth_seq_num> <VRPTx:ndb_seq_num>6</VRPTx:ndb_seq_num> <VRPTx:pdb_ins_code xsi:nil="true" /> <VRPTx:pdb_mon_id>DG</VRPTx:pdb_mon_id> <VRPTx:pdb_seq_num>6</VRPTx:pdb_seq_num> <VRPTx:pdb_strand_id>A</VRPTx:pdb_strand_id> </VRPTx:pdbx_poly_seq_scheme> </VRPTx:pdbx_poly_seq_schemeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_poly_seq_scheme.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_poly_seq_scheme_hetero CASCADE;
CREATE TYPE ENUM_pdbx_poly_seq_scheme_hetero AS ENUM ( 'no', 'n', 'yes', 'y' );
CREATE TABLE pdbx_poly_seq_scheme (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_mon_id TEXT ,
	auth_seq_num TEXT ,
	hetero ENUM_pdbx_poly_seq_scheme_hetero ,
	ndb_seq_num INTEGER ,
	pdb_ins_code TEXT ,
	pdb_mon_id TEXT ,
	pdb_seq_num TEXT ,
	pdb_strand_id TEXT ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	mon_id TEXT NOT NULL ,
-- ATTRIBUTE
	seq_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_re_refinementType)
-- Describes the origin of the experimental data used in this entry. Example 1 - <VRPTx:pdbx_re_refinementCategory> <VRPTx:pdbx_re_refinement entry_id="1ABC"> <VRPTx:citation_id>2</VRPTx:citation_id> <VRPTx:details>Re-refinement of data from entry 1ABC</VRPTx:details> </VRPTx:pdbx_re_refinement> </VRPTx:pdbx_re_refinementCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_re_refinement.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_re_refinement (
	citation_id TEXT ,
	details TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_refineType)
-- Data items in the PDBX_REFINE category record details about additional structure refinement parameters which are needed to complete legacy REMARK 3 refinement templates in PDB format files. Example 1 - PDB placeholders for refinement program SHELX <VRPTx:pdbx_refineCategory> <VRPTx:pdbx_refine entry_id="ABC001" pdbx_refine_id="x-ray"> <VRPTx:R_factor_all_4sig_cutoff>0.174</VRPTx:R_factor_all_4sig_cutoff> <VRPTx:R_factor_obs_4sig_cutoff>0.169</VRPTx:R_factor_obs_4sig_cutoff> <VRPTx:free_R_factor_4sig_cutoff>0.216</VRPTx:free_R_factor_4sig_cutoff> <VRPTx:free_R_val_test_set_ct_4sig_cutoff>164</VRPTx:free_R_val_test_set_ct_4sig_cutoff> <VRPTx:free_R_val_test_set_size_perc_4sig_cutoff>1.29</VRPTx:free_R_val_test_set_size_perc_4sig_cutoff> <VRPTx:number_reflns_obs_4sig_cutoff>1263</VRPTx:number_reflns_obs_4sig_cutoff> </VRPTx:pdbx_refine> </VRPTx:pdbx_refineCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_refine.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_refine (
	"R_factor_all_4sig_cutoff" DECIMAL ,
	"R_factor_all_no_cutoff" DECIMAL ,
	"R_factor_obs_4sig_cutoff" DECIMAL ,
	"R_factor_obs_no_cutoff" DECIMAL ,
	"free_R_error_no_cutoff" DECIMAL ,
	"free_R_factor_4sig_cutoff" DECIMAL ,
	"free_R_factor_no_cutoff" DECIMAL ,
	"free_R_val_4sig_cutoff" DECIMAL ,
	"free_R_val_test_set_ct_4sig_cutoff" DECIMAL ,
	"free_R_val_test_set_ct_no_cutoff" DECIMAL ,
	"free_R_val_test_set_size_perc_4sig_cutoff" DECIMAL ,
	"free_R_val_test_set_size_perc_no_cutoff" DECIMAL ,
	number_reflns_obs_4sig_cutoff DECIMAL ,
	number_reflns_obs_no_cutoff DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from pdbx_refine_componentType)
-- Data items in the PDBX_REFINE_COMPONENT category record statistics of the final model relative to the density map. Example 1 -
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_refine_component.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_refine_component (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"B_iso" DECIMAL ,
	"B_iso_main_chain" DECIMAL ,
	"B_iso_side_chain" DECIMAL ,
	"PDB_ins_code" TEXT ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	connect DECIMAL ,
	correlation DECIMAL ,
	correlation_main_chain DECIMAL ,
	correlation_side_chain DECIMAL ,
	density_index DECIMAL ,
	density_index_main_chain DECIMAL ,
	density_index_side_chain DECIMAL ,
	density_ratio DECIMAL ,
	density_ratio_main_chain DECIMAL ,
	density_ratio_side_chain DECIMAL ,
	"real_space_R" DECIMAL ,
	"real_space_R_main_chain" DECIMAL ,
	"real_space_R_side_chain" DECIMAL ,
	shift DECIMAL ,
	shift_main_chain DECIMAL ,
	shift_side_chain DECIMAL ,
-- ATTRIBUTE
	label_alt_id TEXT NOT NULL ,
-- ATTRIBUTE
	label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	label_seq_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_refine_tls_groupType)
-- Data items in the PDBX_REFINE_TLS_GROUP category record details about a fragment of a TLS group. Properties of the TLS group are recorded in PDBX_REFINE_TLS
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_refine_tls_group.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_refine_tls_group (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"beg_PDB_ins_code" TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_seq_id TEXT ,
	beg_label_asym_id TEXT ,
	beg_label_seq_id INTEGER ,
	"end_PDB_ins_code" TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_seq_id TEXT ,
	end_label_asym_id TEXT ,
	end_label_seq_id INTEGER ,
	pdbx_refine_id TEXT ,
	refine_tls_id TEXT ,
	selection TEXT ,
	selection_details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_refln_signal_binningType)
-- The binning of the per-reflection signal generated by the software specified by attribute pdbx_signal_software_id. in category reflns If any reflections have a signal >= to the highest threshold specified, an additional bin should be inferred to hold them. Examples 1 - based on an internal STARANISO run <VRPTx:pdbx_refln_signal_binningCategory> <VRPTx:pdbx_refln_signal_binning ordinal="1"> <VRPTx:upper_threshold>1.20</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="2"> <VRPTx:upper_threshold>7.22</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="3"> <VRPTx:upper_threshold>19.00</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="4"> <VRPTx:upper_threshold>36.81</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="5"> <VRPTx:upper_threshold>48.87</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="6"> <VRPTx:upper_threshold>53.84</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> <VRPTx:pdbx_refln_signal_binning ordinal="7"> <VRPTx:upper_threshold>57.69</VRPTx:upper_threshold> </VRPTx:pdbx_refln_signal_binning> </VRPTx:pdbx_refln_signal_binningCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_refln_signal_binning.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_refln_signal_binning (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	upper_threshold DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0"
	ordinal INTEGER CHECK ( ordinal >= 0 ) NOT NULL
);

--
-- (quoted from pdbx_reflns_twinType)
-- Details decribing crystallographic twinning. Example 1 - <VRPTx:pdbx_reflns_twinCategory> <VRPTx:pdbx_reflns_twin crystal_id="1" diffrn_id="1" operator="h,-h-k,-l"> <VRPTx:fraction>.43</VRPTx:fraction> <VRPTx:mean_F_square_over_mean_F2>.84</VRPTx:mean_F_square_over_mean_F2> <VRPTx:mean_I2_over_mean_I_square>1.3</VRPTx:mean_I2_over_mean_I_square> <VRPTx:type>merohedral</VRPTx:type> </VRPTx:pdbx_reflns_twin> </VRPTx:pdbx_reflns_twinCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_reflns_twin.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_reflns_twin_type CASCADE;
CREATE TYPE ENUM_pdbx_reflns_twin_type AS ENUM ( 'merohedral', 'hemihedral', 'non-merohedral', 'pseudo-merohedral', 'epitaxial', 'tetartohedral' );
CREATE TABLE pdbx_reflns_twin (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	domain_id TEXT ,
	fraction DECIMAL ,
	"mean_F_square_over_mean_F2" DECIMAL ,
	"mean_I2_over_mean_I_square" DECIMAL ,
	type ENUM_pdbx_reflns_twin_type ,
-- ATTRIBUTE
	crystal_id TEXT NOT NULL ,
-- ATTRIBUTE
	diffrn_id TEXT NOT NULL ,
-- ATTRIBUTE
	operator TEXT NOT NULL
);

--
-- (quoted from pdbx_sequence_rangeType)
-- Data items in the PDBX_SEQUENCE_RANGE category identify the beginning and ending points of polypeptide sequence segments. Example 1 - <VRPTx:pdbx_sequence_rangeCategory> <VRPTx:pdbx_sequence_range beg_label_alt_id="A" beg_label_asym_id="A" beg_label_comp_id="PRO" beg_label_seq_id="1" end_label_alt_id="A" end_label_asym_id="A" end_label_comp_id="GLY" end_label_seq_id="29" seq_range_id="s1"></VRPTx:pdbx_sequence_range> <VRPTx:pdbx_sequence_range beg_label_alt_id="A" beg_label_asym_id="D" beg_label_comp_id="PRO" beg_label_seq_id="91" end_label_alt_id="A" end_label_asym_id="D" end_label_comp_id="GLY" end_label_seq_id="119" seq_range_id="s2"></VRPTx:pdbx_sequence_range> </VRPTx:pdbx_sequence_rangeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_sequence_range.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_sequence_range (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
-- ATTRIBUTE
	beg_label_alt_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	beg_label_seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	end_label_alt_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_comp_id TEXT NOT NULL ,
-- ATTRIBUTE
	end_label_seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	seq_range_id TEXT NOT NULL
);

--
-- (quoted from pdbx_sifts_unp_segmentsType)
-- pdbx_sifts_unp_segments describes residue-range based cross-references specific to UniProt. Example 1 - <VRPTx:pdbx_sifts_unp_segmentsCategory> <VRPTx:pdbx_sifts_unp_segments asym_id="A" entity_id="1" instance_id="1" segment_id="1" unp_acc="A0A5J6CYR6"> <VRPTx:best_mapping>Y</VRPTx:best_mapping> <VRPTx:identity>0.95</VRPTx:identity> <VRPTx:seq_id_end>260</VRPTx:seq_id_end> <VRPTx:seq_id_start>26</VRPTx:seq_id_start> <VRPTx:unp_end>238</VRPTx:unp_end> <VRPTx:unp_start>2</VRPTx:unp_start> </VRPTx:pdbx_sifts_unp_segments> </VRPTx:pdbx_sifts_unp_segmentsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_sifts_unp_segments.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_sifts_unp_segments_best_mapping CASCADE;
CREATE TYPE ENUM_pdbx_sifts_unp_segments_best_mapping AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_sifts_unp_segments (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	best_mapping ENUM_pdbx_sifts_unp_segments_best_mapping ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	identity DECIMAL CHECK ( identity >= 0.0 AND identity <= 1.0 ) ,
	seq_id_end INTEGER ,
	seq_id_start INTEGER ,
	unp_end INTEGER ,
	unp_start INTEGER ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	instance_id INTEGER NOT NULL ,
-- ATTRIBUTE
	segment_id INTEGER NOT NULL ,
-- ATTRIBUTE
	unp_acc TEXT NOT NULL
);

--
-- (quoted from pdbx_sifts_xref_dbType)
-- pdbx_sifts_xref_db describes residue-level cross-references to external databases. Example 1 - <VRPTx:pdbx_sifts_xref_dbCategory> <VRPTx:pdbx_sifts_xref_db asym_id="A" entity_id="1" seq_id="254" seq_id_ordinal="1"> <VRPTx:mh_id>1</VRPTx:mh_id> <VRPTx:mon_id>ILE</VRPTx:mon_id> <VRPTx:mon_id_one_letter_code>I</VRPTx:mon_id_one_letter_code> <VRPTx:observed>1</VRPTx:observed> <VRPTx:res_type xsi:nil="true" /> <VRPTx:unp_acc>P00720</VRPTx:unp_acc> <VRPTx:unp_instance_id>1</VRPTx:unp_instance_id> <VRPTx:unp_num>50</VRPTx:unp_num> <VRPTx:unp_res>I</VRPTx:unp_res> <VRPTx:unp_segment_id>1</VRPTx:unp_segment_id> <VRPTx:xref_db_acc>PF14843</VRPTx:xref_db_acc> <VRPTx:xref_db_instance_id>1</VRPTx:xref_db_instance_id> <VRPTx:xref_db_name>Pfam</VRPTx:xref_db_name> <VRPTx:xref_db_segment_id>1</VRPTx:xref_db_segment_id> <VRPTx:xref_domain_name xsi:nil="true" /> </VRPTx:pdbx_sifts_xref_db> </VRPTx:pdbx_sifts_xref_dbCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_sifts_xref_db.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_sifts_xref_db_observed CASCADE;
CREATE TYPE ENUM_pdbx_sifts_xref_db_observed AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_sifts_xref_db (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	mh_id INTEGER ,
	mon_id TEXT ,
	mon_id_one_letter_code TEXT ,
	observed ENUM_pdbx_sifts_xref_db_observed ,
	res_type TEXT ,
	unp_acc TEXT ,
	unp_instance_id INTEGER ,
	unp_num INTEGER ,
	unp_res TEXT ,
	unp_segment_id INTEGER ,
	xref_db_acc TEXT ,
	xref_db_instance_id INTEGER ,
	xref_db_name TEXT ,
	xref_db_segment_id INTEGER ,
	xref_domain_name TEXT ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	seq_id INTEGER NOT NULL ,
-- ATTRIBUTE
	seq_id_ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_sifts_xref_db_segmentsType)
-- pdbx_sifts_xref_db_segments describes residue-range based cross-references to external databases. Example 1 - <VRPTx:pdbx_sifts_xref_db_segmentsCategory> <VRPTx:pdbx_sifts_xref_db_segments asym_id="A" entity_id="1" instance_id="1" segment_id="1" seq_id_end="252" seq_id_start="26" xref_db="SCOP2B" xref_db_acc="8102030"> <VRPTx:domain_name>SF</VRPTx:domain_name> </VRPTx:pdbx_sifts_xref_db_segments> </VRPTx:pdbx_sifts_xref_db_segmentsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_sifts_xref_db_segments.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_sifts_xref_db_segments (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	domain_name TEXT ,
-- ATTRIBUTE
	asym_id TEXT NOT NULL ,
-- ATTRIBUTE
	entity_id TEXT NOT NULL ,
-- ATTRIBUTE
	instance_id INTEGER NOT NULL ,
-- ATTRIBUTE
	segment_id INTEGER NOT NULL ,
-- ATTRIBUTE
	seq_id_end INTEGER NOT NULL ,
-- ATTRIBUTE
	seq_id_start INTEGER NOT NULL ,
-- ATTRIBUTE
	xref_db TEXT NOT NULL ,
-- ATTRIBUTE
	xref_db_acc TEXT NOT NULL
);

--
-- (quoted from pdbx_soln_scatterType)
-- Data items in the PDBX_SOLN_SCATTER category record details about a solution scattering experiment Example 1 - based on PDB entry 1HAQ <VRPTx:pdbx_soln_scatterCategory> <VRPTx:pdbx_soln_scatter entry_id="1HAQ" id="1"> <VRPTx:buffer_name>tris</VRPTx:buffer_name> <VRPTx:concentration_range>0.7 - 14</VRPTx:concentration_range> <VRPTx:detector_specific xsi:nil="true" /> <VRPTx:detector_type>500-channel quadrant</VRPTx:detector_type> <VRPTx:max_mean_cross_sectional_radii_gyration>1.7</VRPTx:max_mean_cross_sectional_radii_gyration> <VRPTx:max_mean_cross_sectional_radii_gyration_esd>0.1</VRPTx:max_mean_cross_sectional_radii_gyration_esd> <VRPTx:mean_guiner_radius>11.1</VRPTx:mean_guiner_radius> <VRPTx:mean_guiner_radius_esd>0.4</VRPTx:mean_guiner_radius_esd> <VRPTx:min_mean_cross_sectional_radii_gyration>4.4</VRPTx:min_mean_cross_sectional_radii_gyration> <VRPTx:min_mean_cross_sectional_radii_gyration_esd>0.2</VRPTx:min_mean_cross_sectional_radii_gyration_esd> <VRPTx:num_time_frames>10</VRPTx:num_time_frames> <VRPTx:protein_length>40</VRPTx:protein_length> <VRPTx:sample_pH xsi:nil="true" /> <VRPTx:source_beamline>2.1</VRPTx:source_beamline> <VRPTx:source_beamline_instrument xsi:nil="true" /> <VRPTx:source_class>synchrotron</VRPTx:source_class> <VRPTx:source_type>SRS BEAMLINE 2.1</VRPTx:source_type> <VRPTx:temperature>288</VRPTx:temperature> <VRPTx:type>x-ray</VRPTx:type> </VRPTx:pdbx_soln_scatter> <VRPTx:pdbx_soln_scatter entry_id="1HAQ" id="2"> <VRPTx:buffer_name>PBS in 99.9&#37; D2O</VRPTx:buffer_name> <VRPTx:concentration_range>0.4 - 9.6</VRPTx:concentration_range> <VRPTx:detector_specific xsi:nil="true" /> <VRPTx:detector_type>area</VRPTx:detector_type> <VRPTx:max_mean_cross_sectional_radii_gyration>1.51</VRPTx:max_mean_cross_sectional_radii_gyration> <VRPTx:max_mean_cross_sectional_radii_gyration_esd>0.06</VRPTx:max_mean_cross_sectional_radii_gyration_esd> <VRPTx:mean_guiner_radius>11.3</VRPTx:mean_guiner_radius> <VRPTx:mean_guiner_radius_esd>0.4</VRPTx:mean_guiner_radius_esd> <VRPTx:min_mean_cross_sectional_radii_gyration>3.9</VRPTx:min_mean_cross_sectional_radii_gyration> <VRPTx:min_mean_cross_sectional_radii_gyration_esd>0.2</VRPTx:min_mean_cross_sectional_radii_gyration_esd> <VRPTx:num_time_frames xsi:nil="true" /> <VRPTx:protein_length>37.0 - 39.0</VRPTx:protein_length> <VRPTx:sample_pH xsi:nil="true" /> <VRPTx:source_beamline xsi:nil="true" /> <VRPTx:source_beamline_instrument>D11, D22</VRPTx:source_beamline_instrument> <VRPTx:source_class>neutron source</VRPTx:source_class> <VRPTx:source_type>ILL</VRPTx:source_type> <VRPTx:temperature xsi:nil="true" /> <VRPTx:type>neutron</VRPTx:type> </VRPTx:pdbx_soln_scatter> <VRPTx:pdbx_soln_scatter entry_id="1HAQ" id="3"> <VRPTx:buffer_name>PBS in 99.9&#37; D2O</VRPTx:buffer_name> <VRPTx:concentration_range>3.7, 6.1</VRPTx:concentration_range> <VRPTx:detector_specific xsi:nil="true" /> <VRPTx:detector_type>AREA (TIME-OF-FLIGHT)</VRPTx:detector_type> <VRPTx:max_mean_cross_sectional_radii_gyration xsi:nil="true" /> <VRPTx:max_mean_cross_sectional_radii_gyration_esd xsi:nil="true" /> <VRPTx:mean_guiner_radius>11.7</VRPTx:mean_guiner_radius> <VRPTx:mean_guiner_radius_esd>0.5</VRPTx:mean_guiner_radius_esd> <VRPTx:min_mean_cross_sectional_radii_gyration xsi:nil="true" /> <VRPTx:min_mean_cross_sectional_radii_gyration_esd xsi:nil="true" /> <VRPTx:num_time_frames xsi:nil="true" /> <VRPTx:protein_length>40.0</VRPTx:protein_length> <VRPTx:sample_pH xsi:nil="true" /> <VRPTx:source_beamline>Pulsed Neutron</VRPTx:source_beamline> <VRPTx:source_beamline_instrument>LOQ</VRPTx:source_beamline_instrument> <VRPTx:source_class>neutron source</VRPTx:source_class> <VRPTx:source_type>ISIS</VRPTx:source_type> <VRPTx:temperature xsi:nil="true" /> <VRPTx:type>neutron</VRPTx:type> </VRPTx:pdbx_soln_scatter> </VRPTx:pdbx_soln_scatterCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_soln_scatter.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_soln_scatter_type CASCADE;
CREATE TYPE ENUM_pdbx_soln_scatter_type AS ENUM ( 'x-ray', 'neutron', 'modelling' );
CREATE TABLE pdbx_soln_scatter (
	buffer_name TEXT ,
-- omit an attribute having a fixed value: @units="mg_per_ml"
	concentration_range TEXT ,
	data_analysis_software_list TEXT ,
	data_reduction_software_list TEXT ,
	detector_specific TEXT ,
	detector_type TEXT ,
-- omit an attribute having a fixed value: @units="nanometres"
	max_mean_cross_sectional_radii_gyration DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometres"
	max_mean_cross_sectional_radii_gyration_esd DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometres"
	mean_guiner_radius DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometres"
	mean_guiner_radius_esd DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometres"
	min_mean_cross_sectional_radii_gyration DECIMAL ,
-- omit an attribute having a fixed value: @units="nanometres"
	min_mean_cross_sectional_radii_gyration_esd DECIMAL ,
	num_time_frames INTEGER ,
	protein_length TEXT ,
	"sample_pH" DECIMAL ,
	source_beamline TEXT ,
	source_beamline_instrument TEXT ,
	source_class TEXT ,
	source_type TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	temperature DECIMAL CHECK ( temperature >= 0.0 ) ,
	type ENUM_pdbx_soln_scatter_type ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_soln_scatter_modelType)
-- Data items in the PDBX_SOLN_SCATTER_MODEL category record details about the homology model fitting to the solution scatter data.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_soln_scatter_model.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_soln_scatter_model (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	conformer_selection_criteria TEXT ,
	details TEXT ,
	entry_fitting_list TEXT ,
	method TEXT ,
	num_conformers_calculated INTEGER ,
	num_conformers_submitted INTEGER ,
	representative_conformer INTEGER ,
	software_author_list TEXT ,
	software_list TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	scatter_id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_assembly_genType)
-- Data items in the PDBX_STRUCT_ASSEMBLY_GEN category record details about the generation of each macromolecular assemblies. The PDBX_STRUCT_ASSEMBLY_GEN data items provide the specifications of the components that constitute that assembly in terms of cartesian transformations. Example 1 - <VRPTx:pdbx_struct_assembly_genCategory> <VRPTx:pdbx_struct_assembly_gen assembly_id="1" asym_id_list="A" oper_expression="1"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="1" asym_id_list="B" oper_expression="1"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="2" asym_id_list="A" oper_expression="2"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="2" asym_id_list="B" oper_expression="2"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="2" asym_id_list="C" oper_expression="2"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="3" asym_id_list="A" oper_expression="3"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="3" asym_id_list="B" oper_expression="3"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="3" asym_id_list="D" oper_expression="3"></VRPTx:pdbx_struct_assembly_gen> </VRPTx:pdbx_struct_assembly_genCategory> Example 2 - <VRPTx:pdbx_struct_assembly_genCategory> <VRPTx:pdbx_struct_assembly_gen assembly_id="1" asym_id_list="A,B" oper_expression="1"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="2" asym_id_list="A,B,C" oper_expression="2"></VRPTx:pdbx_struct_assembly_gen> <VRPTx:pdbx_struct_assembly_gen assembly_id="3" asym_id_list="A,B,D" oper_expression="3"></VRPTx:pdbx_struct_assembly_gen> </VRPTx:pdbx_struct_assembly_genCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_assembly_gen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_assembly_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id_list TEXT ,
	entity_inst_id TEXT ,
-- ATTRIBUTE
	assembly_id TEXT NOT NULL ,
-- ATTRIBUTE
	asym_id_list TEXT NOT NULL ,
-- ATTRIBUTE
	oper_expression TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_assembly_propType)
-- Properties and features of structural assemblies. Example 1 - <VRPTx:pdbx_struct_assembly_propCategory> <VRPTx:pdbx_struct_assembly_prop biol_id="1" type="ABSA"> <VRPTx:details> </VRPTx:details> <VRPTx:value>1456.7</VRPTx:value> </VRPTx:pdbx_struct_assembly_prop> </VRPTx:pdbx_struct_assembly_propCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_assembly_prop.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_assembly_prop_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_assembly_prop_type AS ENUM ( 'ABSA (A^2)', 'SSA (A^2)', 'MORE' );
CREATE TABLE pdbx_struct_assembly_prop (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	value TEXT ,
-- ATTRIBUTE
	biol_id TEXT NOT NULL ,
-- ATTRIBUTE
	type ENUM_pdbx_struct_assembly_prop_type NOT NULL
);

--
-- (quoted from pdbx_struct_asym_genType)
-- Data items in the PDBX_STRUCT_ASYM_GEN category record details about the generation of the crystallographic asymmetric unit. The PDBX_STRUCT_ASYM_GEN data items provide the specifications of the components that constitute the asymmetric unit in terms of cartesian transformations of deposited coordinates. Example 1 - <VRPTx:pdbx_struct_asym_genCategory> <VRPTx:pdbx_struct_asym_gen entity_inst_id="A" oper_expression="1"> <VRPTx:asym_id>A</VRPTx:asym_id> </VRPTx:pdbx_struct_asym_gen> <VRPTx:pdbx_struct_asym_gen entity_inst_id="B" oper_expression="1"> <VRPTx:asym_id>B</VRPTx:asym_id> </VRPTx:pdbx_struct_asym_gen> </VRPTx:pdbx_struct_asym_genCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_asym_gen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_asym_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	asym_id TEXT ,
-- ATTRIBUTE
	entity_inst_id TEXT NOT NULL ,
-- ATTRIBUTE
	oper_expression TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_chem_comp_diagnosticsType)
-- Data items in the PDBX_STRUCT_CHEM_COMP_DIAGNOSTICS category provides structural diagnostics in chemical components instances. Example 1 - <VRPTx:pdbx_struct_chem_comp_diagnosticsCategory> <VRPTx:pdbx_struct_chem_comp_diagnostics ordinal="1"> <VRPTx:asym_id>Q</VRPTx:asym_id> <VRPTx:auth_comp_id>Q20</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>10</VRPTx:auth_seq_id> <VRPTx:details>Strained geometry. Long carbonyl bond at C10.</VRPTx:details> <VRPTx:pdb_strand_id>Q</VRPTx:pdb_strand_id> <VRPTx:seq_num xsi:nil="true" /> <VRPTx:type>GEOMETRY</VRPTx:type> </VRPTx:pdbx_struct_chem_comp_diagnostics> </VRPTx:pdbx_struct_chem_comp_diagnosticsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_chem_comp_diagnostics.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_chem_comp_diagnostics_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_chem_comp_diagnostics_type AS ENUM ( 'MISSING_ATOM', 'STEREOCHEMISTRY', 'VALENCE', 'GEOMETRY', 'LABELING', 'OTHER' );
CREATE TABLE pdbx_struct_chem_comp_diagnostics (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	details TEXT ,
	pdb_ins_code TEXT ,
	pdb_strand_id TEXT ,
	seq_num INTEGER ,
	type ENUM_pdbx_struct_chem_comp_diagnostics_type ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_conn_angleType)
-- Data items in the PDBX_STRUCT_CONN_ANGLE category record the angles in connections between portions of the structure. Example 1 - PDB entry 2v8d <VRPTx:pdbx_struct_conn_angleCategory> <VRPTx:pdbx_struct_conn_angle id="1"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>114</VRPTx:ptnr3_label_seq_id> <VRPTx:value>104.7</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="2"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>226</VRPTx:ptnr3_label_seq_id> <VRPTx:value>91.3</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="3"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>114</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>226</VRPTx:ptnr3_label_seq_id> <VRPTx:value>120.6</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="4"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>2041</VRPTx:ptnr3_label_seq_id> <VRPTx:value>172.5</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="5"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>114</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>2041</VRPTx:ptnr3_label_seq_id> <VRPTx:value>80.0</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="6"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>226</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>2041</VRPTx:ptnr3_label_seq_id> <VRPTx:value>91.3</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="7"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>76.9</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="8"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>114</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>112.3</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="9"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>226</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>127.0</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="10"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>O</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HOH</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>2041</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>95.9</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="11"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>OE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>GLU</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>160</VRPTx:ptnr3_label_seq_id> <VRPTx:value>89.8</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="12"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>95.5</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="13"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>GLU</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>160</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>O</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HOH</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>3001</VRPTx:ptnr3_label_seq_id> <VRPTx:value>109.4</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="14"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>421</VRPTx:ptnr3_label_seq_id> <VRPTx:value>90.4</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="15"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>GLU</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>160</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>421</VRPTx:ptnr3_label_seq_id> <VRPTx:value>111.3</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="16"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>O</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HOH</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>3001</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>A</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>421</VRPTx:ptnr3_label_seq_id> <VRPTx:value>138.9</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="17"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>O</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HOH</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>3001</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>114</VRPTx:ptnr3_label_seq_id> <VRPTx:value>106.4</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="18"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>O</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HOH</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>3001</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>OD</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>ASP</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>125</VRPTx:ptnr3_label_seq_id> <VRPTx:value>100.5</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="19"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>114</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>OD</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>ASP</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>125</VRPTx:ptnr3_label_seq_id> <VRPTx:value>115.6</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="20"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>O</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HOH</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>3001</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>226</VRPTx:ptnr3_label_seq_id> <VRPTx:value>123.2</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="21"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>HIS</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>114</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>226</VRPTx:ptnr3_label_seq_id> <VRPTx:value>123.2</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="22"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OD</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ASP</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>125</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>500</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>NE</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>HIS</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>226</VRPTx:ptnr3_label_seq_id> <VRPTx:value>82.7</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> <VRPTx:pdbx_struct_conn_angle id="23"> <VRPTx:ptnr1_PDB_ins_code xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>OE</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>GLU</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>160</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr2_PDB_ins_code>ZN</VRPTx:ptnr2_PDB_ins_code> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id xsi:nil="true" /> <VRPTx:ptnr2_label_comp_id>ZN</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>501</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr3_PDB_ins_code>OD</VRPTx:ptnr3_PDB_ins_code> <VRPTx:ptnr3_label_asym_id>B</VRPTx:ptnr3_label_asym_id> <VRPTx:ptnr3_label_atom_id xsi:nil="true" /> <VRPTx:ptnr3_label_comp_id>ASP</VRPTx:ptnr3_label_comp_id> <VRPTx:ptnr3_label_seq_id>125</VRPTx:ptnr3_label_seq_id> <VRPTx:value>148.6</VRPTx:value> </VRPTx:pdbx_struct_conn_angle> </VRPTx:pdbx_struct_conn_angleCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_conn_angle.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_conn_angle (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"ptnr1_PDB_ins_code" TEXT ,
	ptnr1_auth_alt_id TEXT ,
	ptnr1_auth_asym_id TEXT ,
	ptnr1_auth_atom_id TEXT ,
	ptnr1_auth_comp_id TEXT ,
	ptnr1_auth_seq_id TEXT ,
	ptnr1_label_alt_id TEXT ,
	ptnr1_label_asym_id TEXT ,
	ptnr1_label_atom_id TEXT ,
	ptnr1_label_comp_id TEXT ,
	ptnr1_label_seq_id INTEGER ,
	ptnr1_symmetry TEXT ,
	"ptnr2_PDB_ins_code" TEXT ,
	ptnr2_auth_alt_id TEXT ,
	ptnr2_auth_asym_id TEXT ,
	ptnr2_auth_atom_id TEXT ,
	ptnr2_auth_comp_id TEXT ,
	ptnr2_auth_seq_id TEXT ,
	ptnr2_label_alt_id TEXT ,
	ptnr2_label_asym_id TEXT ,
	ptnr2_label_atom_id TEXT ,
	ptnr2_label_comp_id TEXT ,
	ptnr2_label_seq_id INTEGER ,
	ptnr2_symmetry TEXT ,
	"ptnr3_PDB_ins_code" TEXT ,
	ptnr3_auth_alt_id TEXT ,
	ptnr3_auth_asym_id TEXT ,
	ptnr3_auth_atom_id TEXT ,
	ptnr3_auth_comp_id TEXT ,
	ptnr3_auth_seq_id TEXT ,
	ptnr3_label_alt_id TEXT ,
	ptnr3_label_asym_id TEXT ,
	ptnr3_label_atom_id TEXT ,
	ptnr3_label_comp_id TEXT ,
	ptnr3_label_seq_id INTEGER ,
	ptnr3_symmetry TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	value DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	value_esd DECIMAL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_group_component_rangeType)
-- Data items in the PDBX_STRUCT_GROUP_COMPONENT_RANGE category define a structural group as a continuous span chemical components. Example 1 - <VRPTx:pdbx_struct_group_component_rangeCategory> <VRPTx:pdbx_struct_group_component_range ordinal="1"> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:beg_PDB_ins_code xsi:nil="true" /> <VRPTx:beg_auth_asym_id>A</VRPTx:beg_auth_asym_id> <VRPTx:beg_auth_comp_id>MLU</VRPTx:beg_auth_comp_id> <VRPTx:beg_auth_seq_id>1</VRPTx:beg_auth_seq_id> <VRPTx:end_PDB_ins_code xsi:nil="true" /> <VRPTx:end_auth_asym_id>A</VRPTx:end_auth_asym_id> <VRPTx:end_auth_comp_id>RAM</VRPTx:end_auth_comp_id> <VRPTx:end_auth_seq_id>10</VRPTx:end_auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_component_range> </VRPTx:pdbx_struct_group_component_rangeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_group_component_range.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_group_component_range (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_model_num" INTEGER ,
	"beg_PDB_ins_code" TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	beg_label_alt_id TEXT ,
	beg_label_asym_id TEXT ,
	beg_label_comp_id TEXT ,
	beg_label_seq_id INTEGER ,
	"end_PDB_ins_code" TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
	end_label_alt_id TEXT ,
	end_label_asym_id TEXT ,
	end_label_comp_id TEXT ,
	end_label_seq_id INTEGER ,
	struct_group_id TEXT ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_group_componentsType)
-- Data items in the PDBX_STRUCT_GROUP_COMPONENTS category list component-level group assignments within the entry. Groups are defined and described in category PDBX_STRUCT_GROUP_LIST. Example 1 - <VRPTx:pdbx_struct_group_componentsCategory> <VRPTx:pdbx_struct_group_components ordinal="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>MLU</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>1</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>OMZ</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>2</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>ASN</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="4"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>GHP</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>4</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="5"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>GHP</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>5</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="6"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>OMX</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>6</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="7"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>3FG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>7</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="8"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>ERE</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>8</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="9"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>BGC</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>9</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> <VRPTx:pdbx_struct_group_components ordinal="10"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>RAM</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>10</VRPTx:auth_seq_id> <VRPTx:struct_group_id>1</VRPTx:struct_group_id> </VRPTx:pdbx_struct_group_components> </VRPTx:pdbx_struct_group_componentsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_group_components.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_group_components (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
	struct_group_id TEXT ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_infoType)
-- Special features of this structural entry. Example 1 - <VRPTx:pdbx_struct_infoCategory> <VRPTx:pdbx_struct_info type="nonpolymer_zero_occupancy_flag" value="Y"></VRPTx:pdbx_struct_info> <VRPTx:pdbx_struct_info type="polymer_zero_occupancy_flag" value="Y"></VRPTx:pdbx_struct_info> <VRPTx:pdbx_struct_info type="multiple_model_flag" value="Y"></VRPTx:pdbx_struct_info> <VRPTx:pdbx_struct_info type="multiple_model_details" value="Model 3 missing ligand ACX"></VRPTx:pdbx_struct_info> <VRPTx:pdbx_struct_info type="nonpolymer_details" value="Disordered ligand geometry for C34 with missing pyridine ring"></VRPTx:pdbx_struct_info> <VRPTx:pdbx_struct_info type="missing atoms in alternate conformations" value="Y"></VRPTx:pdbx_struct_info> </VRPTx:pdbx_struct_infoCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_info.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_info_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_info_type AS ENUM ( 'nonpolymer_zero_occupancy_flag', 'polymer_zero_occupancy_flag', 'multiple_model_flag', 'multiple_model_details', 'nonpolymer_details', 'missing atoms in alternate conformations' );
CREATE TABLE pdbx_struct_info (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
-- ATTRIBUTE
	type ENUM_pdbx_struct_info_type NOT NULL ,
-- ATTRIBUTE
	value TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_legacy_oper_listType)
-- Data items in the PDBX_STRUCT_LEGACY_OPER_LIST category describe Cartesian rotation and translation operations required to generate or transform the coordinates deposited with this entry. This category provides a container for matrices used to construct icosahedral assemblies in legacy entries. Example 1 - <VRPTx:pdbx_struct_legacy_oper_listCategory> <VRPTx:pdbx_struct_legacy_oper_list id="2"> <VRPTx:matrix11>0.247</VRPTx:matrix11> <VRPTx:matrix12>0.935</VRPTx:matrix12> <VRPTx:matrix13>0.256</VRPTx:matrix13> <VRPTx:matrix21>0.929</VRPTx:matrix21> <VRPTx:matrix22>0.153</VRPTx:matrix22> <VRPTx:matrix23>0.337</VRPTx:matrix23> <VRPTx:matrix31>0.276</VRPTx:matrix31> <VRPTx:matrix32>0.321</VRPTx:matrix32> <VRPTx:matrix33>-0.906</VRPTx:matrix33> <VRPTx:vector1>-8.253</VRPTx:vector1> <VRPTx:vector2>-11.743</VRPTx:vector2> <VRPTx:vector3>-1.782</VRPTx:vector3> </VRPTx:pdbx_struct_legacy_oper_list> </VRPTx:pdbx_struct_legacy_oper_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_legacy_oper_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_legacy_oper_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	matrix11 DECIMAL ,
	matrix12 DECIMAL ,
	matrix13 DECIMAL ,
	matrix21 DECIMAL ,
	matrix22 DECIMAL ,
	matrix23 DECIMAL ,
	matrix31 DECIMAL ,
	matrix32 DECIMAL ,
	matrix33 DECIMAL ,
	name TEXT ,
	vector1 DECIMAL ,
	vector2 DECIMAL ,
	vector3 DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_mod_residueType)
-- Data items in the PDBX_STRUCT_MOD_RESIDUE category list the modified polymer components in the entry and provide some details describing the nature of the modification. Example 1 - <VRPTx:pdbx_struct_mod_residueCategory> <VRPTx:pdbx_struct_mod_residue id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>CRW</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>66</VRPTx:auth_seq_id> <VRPTx:details>CIRCULARIZED TRI-PEPTIDE CHROMOPHORE</VRPTx:details> <VRPTx:parent_comp_id>ALA</VRPTx:parent_comp_id> </VRPTx:pdbx_struct_mod_residue> <VRPTx:pdbx_struct_mod_residue id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>CRW</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>66</VRPTx:auth_seq_id> <VRPTx:details>CIRCULARIZED TRI-PEPTIDE CHROMOPHORE</VRPTx:details> <VRPTx:parent_comp_id>SER</VRPTx:parent_comp_id> </VRPTx:pdbx_struct_mod_residue> <VRPTx:pdbx_struct_mod_residue id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>CRW</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>66</VRPTx:auth_seq_id> <VRPTx:details>CIRCULARIZED TRI-PEPTIDE CHROMOPHORE</VRPTx:details> <VRPTx:parent_comp_id>GLY</VRPTx:parent_comp_id> </VRPTx:pdbx_struct_mod_residue> </VRPTx:pdbx_struct_mod_residueCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_mod_residue.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_mod_residue (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	details TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
	parent_comp_id TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_msym_genType)
-- Data items in the PDBX_STRUCT_MSYM_GEN category record details about the generation of the minimal asymmetric unit. For instance, this category can be used to provide this information for helical and point symmetry systems. The PDBX_STRUCT_MSYM_GEN data items provide the specifications of the components that constitute the asymmetric unit in terms of cartesian transformations of deposited coordinates. Example 1 - <VRPTx:pdbx_struct_msym_genCategory> <VRPTx:pdbx_struct_msym_gen entity_inst_id="A" msym_id="A" oper_expression="3"></VRPTx:pdbx_struct_msym_gen> <VRPTx:pdbx_struct_msym_gen entity_inst_id="B" msym_id="B" oper_expression="4"></VRPTx:pdbx_struct_msym_gen> <VRPTx:pdbx_struct_msym_gen entity_inst_id="B" msym_id="C" oper_expression="5"></VRPTx:pdbx_struct_msym_gen> </VRPTx:pdbx_struct_msym_genCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_msym_gen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_msym_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- ATTRIBUTE
	entity_inst_id TEXT NOT NULL ,
-- ATTRIBUTE
	msym_id TEXT NOT NULL ,
-- ATTRIBUTE
	oper_expression TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_nmr_ens_clustType)
-- Data items in the PDBX_STRUCT_NMR_ENS_CLUST category record information about cluster analysis of the NMR ensemble structure. Example 1 - <VRPTx:pdbx_struct_nmr_ens_clustCategory> <VRPTx:pdbx_struct_nmr_ens_clust entry_id="5UB9"> <VRPTx:clusters_total_number>4</VRPTx:clusters_total_number> <VRPTx:conformers_total_number>20</VRPTx:conformers_total_number> <VRPTx:error>success</VRPTx:error> <VRPTx:outliers_total_number>2</VRPTx:outliers_total_number> </VRPTx:pdbx_struct_nmr_ens_clust> </VRPTx:pdbx_struct_nmr_ens_clustCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_nmr_ens_clust (
-- xsd:restriction/xsd:minInclusive="0"
	clusters_total_number INTEGER CHECK ( clusters_total_number >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	conformers_total_number INTEGER CHECK ( conformers_total_number >= 0 ) ,
	error TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	outliers_total_number INTEGER CHECK ( outliers_total_number >= 0 ) ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_nmr_ens_clust_genType)
-- Data items in the PDBX_STRUCT_NMR_ENS_CLUST_GEN category records generation of clusters (group of conformers) by cluster analysis of the NMR ensemble structure. Example 1 - <VRPTx:pdbx_struct_nmr_ens_clust_genCategory> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="1"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="2"> <VRPTx:cluster_id>3</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="3"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>Y</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="4"> <VRPTx:cluster_id>3</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="5"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>Y</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="6"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="7"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="8"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="9"> <VRPTx:cluster_id>outlier</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="10"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="11"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="12"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="13"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>Y</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="14"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="15"> <VRPTx:cluster_id>2</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="16"> <VRPTx:cluster_id>1</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="17"> <VRPTx:cluster_id>4</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="18"> <VRPTx:cluster_id>3</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="19"> <VRPTx:cluster_id>outlier</VRPTx:cluster_id> <VRPTx:medoid_conformer>N</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> <VRPTx:pdbx_struct_nmr_ens_clust_gen PDB_model_num="20"> <VRPTx:cluster_id>4</VRPTx:cluster_id> <VRPTx:medoid_conformer>Y</VRPTx:medoid_conformer> </VRPTx:pdbx_struct_nmr_ens_clust_gen> </VRPTx:pdbx_struct_nmr_ens_clust_genCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_nmr_ens_clust_gen_medoid_conformer CASCADE;
CREATE TYPE ENUM_pdbx_struct_nmr_ens_clust_gen_medoid_conformer AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_struct_nmr_ens_clust_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	cluster_id TEXT ,
	medoid_conformer ENUM_pdbx_struct_nmr_ens_clust_gen_medoid_conformer ,
-- ATTRIBUTE
	"PDB_model_num" INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_nmr_ens_dom_limType)
-- Data items in the PDBX_STRUCT_NMR_ENS_DOM_LIM category identify the start and end points of generated polypeptide chain segments (domains) of the NMR ensemble structure. Example 1 - <VRPTx:pdbx_struct_nmr_ens_dom_limCategory> <VRPTx:pdbx_struct_nmr_ens_dom_lim component_id="1" dom_id="1"> <VRPTx:beg_auth_asym_id>A</VRPTx:beg_auth_asym_id> <VRPTx:beg_auth_comp_id>THR</VRPTx:beg_auth_comp_id> <VRPTx:beg_auth_seq_id>515</VRPTx:beg_auth_seq_id> <VRPTx:end_auth_asym_id>A</VRPTx:end_auth_asym_id> <VRPTx:end_auth_comp_id>THR</VRPTx:end_auth_comp_id> <VRPTx:end_auth_seq_id>525</VRPTx:end_auth_seq_id> </VRPTx:pdbx_struct_nmr_ens_dom_lim> <VRPTx:pdbx_struct_nmr_ens_dom_lim component_id="2" dom_id="1"> <VRPTx:beg_auth_asym_id>A</VRPTx:beg_auth_asym_id> <VRPTx:beg_auth_comp_id>ASN</VRPTx:beg_auth_comp_id> <VRPTx:beg_auth_seq_id>530</VRPTx:beg_auth_seq_id> <VRPTx:end_auth_asym_id>A</VRPTx:end_auth_asym_id> <VRPTx:end_auth_comp_id>LYS</VRPTx:end_auth_comp_id> <VRPTx:end_auth_seq_id>555</VRPTx:end_auth_seq_id> </VRPTx:pdbx_struct_nmr_ens_dom_lim> <VRPTx:pdbx_struct_nmr_ens_dom_lim component_id="3" dom_id="1"> <VRPTx:beg_auth_asym_id>A</VRPTx:beg_auth_asym_id> <VRPTx:beg_auth_comp_id>ASP</VRPTx:beg_auth_comp_id> <VRPTx:beg_auth_seq_id>560</VRPTx:beg_auth_seq_id> <VRPTx:end_auth_asym_id>A</VRPTx:end_auth_asym_id> <VRPTx:end_auth_comp_id>ARG</VRPTx:end_auth_comp_id> <VRPTx:end_auth_seq_id>616</VRPTx:end_auth_seq_id> </VRPTx:pdbx_struct_nmr_ens_dom_lim> </VRPTx:pdbx_struct_nmr_ens_dom_limCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_nmr_ens_dom_lim (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
-- ATTRIBUTE
	component_id INTEGER NOT NULL ,
-- ATTRIBUTE
	dom_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_struct_oper_listType)
-- Data items in the PDBX_STRUCT_OPER_LIST category describe Cartesian rotation and translation operations required to generate or transform the coordinates deposited with this entry. Example 1 - <VRPTx:pdbx_struct_oper_listCategory> <VRPTx:pdbx_struct_oper_list id="2"> <VRPTx:matrix11>0.247</VRPTx:matrix11> <VRPTx:matrix12>0.935</VRPTx:matrix12> <VRPTx:matrix13>0.256</VRPTx:matrix13> <VRPTx:matrix21>0.929</VRPTx:matrix21> <VRPTx:matrix22>0.153</VRPTx:matrix22> <VRPTx:matrix23>0.337</VRPTx:matrix23> <VRPTx:matrix31>0.276</VRPTx:matrix31> <VRPTx:matrix32>0.321</VRPTx:matrix32> <VRPTx:matrix33>-0.906</VRPTx:matrix33> <VRPTx:type>point symmetry operation</VRPTx:type> <VRPTx:vector1>-8.253</VRPTx:vector1> <VRPTx:vector2>-11.743</VRPTx:vector2> <VRPTx:vector3>-1.782</VRPTx:vector3> </VRPTx:pdbx_struct_oper_list> </VRPTx:pdbx_struct_oper_listCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_oper_list.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_struct_oper_list_type CASCADE;
CREATE TYPE ENUM_pdbx_struct_oper_list_type AS ENUM ( 'identity operation', 'point symmetry operation', 'helical symmetry operation', 'crystal symmetry operation', '3D crystal symmetry operation', '2D crystal symmetry operation', 'transform to point frame', 'transform to helical frame', 'transform to crystal frame', 'transform to 2D crystal frame', 'transform to 3D crystal frame', 'build point asymmetric unit', 'build helical asymmetric unit', 'build 2D crystal asymmetric unit', 'build 3D crystal asymmetric unit' );
CREATE TABLE pdbx_struct_oper_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	matrix11 DECIMAL ,
	matrix12 DECIMAL ,
	matrix13 DECIMAL ,
	matrix21 DECIMAL ,
	matrix22 DECIMAL ,
	matrix23 DECIMAL ,
	matrix31 DECIMAL ,
	matrix32 DECIMAL ,
	matrix33 DECIMAL ,
	name TEXT ,
	symmetry_operation TEXT ,
	type ENUM_pdbx_struct_oper_list_type ,
	vector1 DECIMAL ,
	vector2 DECIMAL ,
	vector3 DECIMAL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_ref_seq_deletionType)
-- Data items in the PDBX_STRUCT_REF_SEQ_INSERTION category annotate deletions in the sequence of the entity described in the referenced database entry. Example 1 - <VRPTx:pdbx_struct_ref_seq_deletionCategory> <VRPTx:pdbx_struct_ref_seq_deletion id="1"> <VRPTx:asym_id>A</VRPTx:asym_id> <VRPTx:comp_id>LEU</VRPTx:comp_id> <VRPTx:db_code>P15456</VRPTx:db_code> <VRPTx:db_name>UNP</VRPTx:db_name> <VRPTx:db_seq_id>23</VRPTx:db_seq_id> <VRPTx:details xsi:nil="true" /> </VRPTx:pdbx_struct_ref_seq_deletion> <VRPTx:pdbx_struct_ref_seq_deletion id="1"> <VRPTx:asym_id>A</VRPTx:asym_id> <VRPTx:comp_id>THR</VRPTx:comp_id> <VRPTx:db_code>P15456</VRPTx:db_code> <VRPTx:db_name>UNP</VRPTx:db_name> <VRPTx:db_seq_id>24</VRPTx:db_seq_id> <VRPTx:details xsi:nil="true" /> </VRPTx:pdbx_struct_ref_seq_deletion> <VRPTx:pdbx_struct_ref_seq_deletion id="1"> <VRPTx:asym_id>A</VRPTx:asym_id> <VRPTx:comp_id>GLN</VRPTx:comp_id> <VRPTx:db_code>P15456</VRPTx:db_code> <VRPTx:db_name>UNP</VRPTx:db_name> <VRPTx:db_seq_id>25</VRPTx:db_seq_id> <VRPTx:details xsi:nil="true" /> </VRPTx:pdbx_struct_ref_seq_deletion> </VRPTx:pdbx_struct_ref_seq_deletionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_ref_seq_deletion.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_ref_seq_deletion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	asym_id TEXT ,
	comp_id TEXT ,
	db_code TEXT ,
	db_name TEXT ,
	db_seq_id INTEGER ,
	details TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_ref_seq_insertionType)
-- Data items in the PDBX_STRUCT_REF_SEQ_INSERTION category annotate insertions in the sequence of the entity described in the referenced database entry. Example 1 - <VRPTx:pdbx_struct_ref_seq_insertionCategory> <VRPTx:pdbx_struct_ref_seq_insertion id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:asym_id>A</VRPTx:asym_id> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_seq_id>104</VRPTx:auth_seq_id> <VRPTx:comp_id>GLY</VRPTx:comp_id> <VRPTx:db_code>P00752</VRPTx:db_code> <VRPTx:db_name>UNP</VRPTx:db_name> <VRPTx:details>INSERTION</VRPTx:details> <VRPTx:seq_id>102</VRPTx:seq_id> </VRPTx:pdbx_struct_ref_seq_insertion> <VRPTx:pdbx_struct_ref_seq_insertion id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:asym_id>A</VRPTx:asym_id> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_seq_id>105</VRPTx:auth_seq_id> <VRPTx:comp_id>TRP</VRPTx:comp_id> <VRPTx:db_code>P00752</VRPTx:db_code> <VRPTx:db_name>UNP</VRPTx:db_name> <VRPTx:details>INSERTION</VRPTx:details> <VRPTx:seq_id>103</VRPTx:seq_id> </VRPTx:pdbx_struct_ref_seq_insertion> </VRPTx:pdbx_struct_ref_seq_insertionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_ref_seq_insertion.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_ref_seq_insertion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	asym_id TEXT ,
	auth_asym_id TEXT ,
	auth_seq_id TEXT ,
	comp_id TEXT ,
	db_code TEXT ,
	db_name TEXT ,
	details TEXT ,
	seq_id INTEGER ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_sheet_hbondType)
-- Data items in the PDBX_STRUCT_SHEET_HBOND category record details about the hydrogen bonding between residue ranges in a beta sheet. This category is provided for cases where only a single hydrogen bond is used to register the two residue ranges. Category STRUCT_SHEET_HBOND should be used when the initial and terminal hydrogen bonds for strand pair are known.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_sheet_hbond.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_sheet_hbond (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"range_1_PDB_ins_code" TEXT ,
	range_1_auth_asym_id TEXT ,
	range_1_auth_atom_id TEXT ,
	range_1_auth_comp_id TEXT ,
	range_1_auth_seq_id TEXT ,
	range_1_label_asym_id TEXT ,
	range_1_label_atom_id TEXT ,
	range_1_label_comp_id TEXT ,
	range_1_label_seq_id INTEGER ,
	"range_2_PDB_ins_code" TEXT ,
	range_2_auth_asym_id TEXT ,
	range_2_auth_atom_id TEXT ,
	range_2_auth_comp_id TEXT ,
	range_2_auth_seq_id TEXT ,
	range_2_label_asym_id TEXT ,
	range_2_label_atom_id TEXT ,
	range_2_label_comp_id TEXT ,
	range_2_label_seq_id INTEGER ,
-- ATTRIBUTE
	range_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	range_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	sheet_id TEXT NOT NULL
);

--
-- (quoted from pdbx_struct_special_symmetryType)
-- Data items in the PDBX_STRUCT_SPECIAL_SYMMETRY category list the molecular components that lie on special symmetry positions. Example 1 - <VRPTx:pdbx_struct_special_symmetryCategory> <VRPTx:pdbx_struct_special_symmetry id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>Q</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>ATP</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> </VRPTx:pdbx_struct_special_symmetry> </VRPTx:pdbx_struct_special_symmetryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_struct_special_symmetry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_struct_special_symmetry (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_unobs_or_zero_occ_atomsType)
-- Data items in the PDBX_UNOBS_OR_ZERO_OCC_ATOMS category list the atoms within the entry that are either unobserved or have zero occupancy/ Example 1 - <VRPTx:pdbx_unobs_or_zero_occ_atomsCategory> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>CG</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>CD</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>NE</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="4"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>CZ</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="5"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>NH1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> <VRPTx:pdbx_unobs_or_zero_occ_atoms id="6"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>NH2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>412</VRPTx:auth_seq_id> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_atoms> </VRPTx:pdbx_unobs_or_zero_occ_atomsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_unobs_or_zero_occ_atoms.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_unobs_or_zero_occ_atoms_occupancy_flag CASCADE;
CREATE TYPE ENUM_pdbx_unobs_or_zero_occ_atoms_occupancy_flag AS ENUM ( '1', '0' );
DROP TYPE IF EXISTS ENUM_pdbx_unobs_or_zero_occ_atoms_polymer_flag CASCADE;
CREATE TYPE ENUM_pdbx_unobs_or_zero_occ_atoms_polymer_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_unobs_or_zero_occ_atoms (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_atom_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
	occupancy_flag ENUM_pdbx_unobs_or_zero_occ_atoms_occupancy_flag ,
	polymer_flag ENUM_pdbx_unobs_or_zero_occ_atoms_polymer_flag ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_unobs_or_zero_occ_residuesType)
-- Data items in the PDBX_UNOBS_OR_ZERO_OCC_RESIDUES category list the residues within the entry that are not observed or have zero occupancy. Example 1 - <VRPTx:pdbx_unobs_or_zero_occ_residuesCategory> <VRPTx:pdbx_unobs_or_zero_occ_residues id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>VAL</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>36</VRPTx:auth_seq_id> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_residues> <VRPTx:pdbx_unobs_or_zero_occ_residues id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>ARG</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>108</VRPTx:auth_seq_id> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>Y</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_residues> <VRPTx:pdbx_unobs_or_zero_occ_residues id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>D</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>PPI</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>438</VRPTx:auth_seq_id> <VRPTx:occupancy_flag>1</VRPTx:occupancy_flag> <VRPTx:polymer_flag>N</VRPTx:polymer_flag> </VRPTx:pdbx_unobs_or_zero_occ_residues> </VRPTx:pdbx_unobs_or_zero_occ_residuesCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_unobs_or_zero_occ_residues.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_pdbx_unobs_or_zero_occ_residues_occupancy_flag CASCADE;
CREATE TYPE ENUM_pdbx_unobs_or_zero_occ_residues_occupancy_flag AS ENUM ( '1', '0' );
DROP TYPE IF EXISTS ENUM_pdbx_unobs_or_zero_occ_residues_polymer_flag CASCADE;
CREATE TYPE ENUM_pdbx_unobs_or_zero_occ_residues_polymer_flag AS ENUM ( 'Y', 'N' );
CREATE TABLE pdbx_unobs_or_zero_occ_residues (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id INTEGER ,
	occupancy_flag ENUM_pdbx_unobs_or_zero_occ_residues_occupancy_flag ,
	polymer_flag ENUM_pdbx_unobs_or_zero_occ_residues_polymer_flag ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_chiralType)
-- Data items in the PDBX_VALIDATE_CHIRAL category list the residues that contain unexpected configuration of chiral centers. IMPROPER HA N C CB chirality CA IMPROPER HB1 HB2 CA CG stereo CB as this number approaches (+) or (-) 180.0, then the error in predicting the true chirality of the center increases. Improper dihedrals are a measure of the chirality/planarity of the structure at a specific atom. Values around -35 or +35 are expected for chiral atoms, and values around 0 for planar atoms. HERE improper C---N----CA---CB done expected answer is around -120 mean -122.52 D-amino acid is +120.0 Example 1 - <VRPTx:pdbx_validate_chiralCategory> <VRPTx:pdbx_validate_chiral id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>ASP</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>B</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>405</VRPTx:auth_seq_id> <VRPTx:details>ALPHA-CARBON</VRPTx:details> <VRPTx:omega>150.48</VRPTx:omega> </VRPTx:pdbx_validate_chiral> </VRPTx:pdbx_validate_chiralCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_chiral.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_chiral (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	details TEXT ,
	label_alt_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="-180.0"
	omega DECIMAL CHECK ( omega >= -180.0 AND omega <= 180.0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_close_contactType)
-- Data items in the PDBX_VALIDATE_CLOSE_CONTACT category list the atoms within the entry that are in close contact with regard the distances expected from either covalent bonding or closest approach by van der Waals contacts. Contacts within the asymmetric unit are considered. For those contacts not involving hydrogen a limit of 2.2 angstroms is used. For contacts involving a hydrogen atom a cutoff of 1.6 angstroms is used. Example 1 - <VRPTx:pdbx_validate_close_contactCategory> <VRPTx:pdbx_validate_close_contact id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>B</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>B</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1 xsi:nil="true" /> <VRPTx:auth_atom_id_2 xsi:nil="true" /> <VRPTx:auth_comp_id_1>VAL</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>ARG</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>36</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>108</VRPTx:auth_seq_id_2> <VRPTx:dist>2.16</VRPTx:dist> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> </VRPTx:pdbx_validate_close_contact> <VRPTx:pdbx_validate_close_contact id="2"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>B</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>B</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1 xsi:nil="true" /> <VRPTx:auth_atom_id_2 xsi:nil="true" /> <VRPTx:auth_comp_id_1>ARG</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>VAL</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>108</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>36</VRPTx:auth_seq_id_2> <VRPTx:dist>2.16</VRPTx:dist> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> </VRPTx:pdbx_validate_close_contact> </VRPTx:pdbx_validate_close_contactCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_close_contact.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_close_contact (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	clash_magnitude DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	dist DECIMAL ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	symm_as_xyz_1 TEXT ,
	symm_as_xyz_2 TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_main_chain_planeType)
-- Data items in the PDBX_VALIDATE_MAIN_CHAIN_PLANE category list the residues that contain unexpected deviations from planes for main chain atoms as defined by the improper torsion angle describing planarity: PLANARITY = C(i-1) - CA(i-1) - N(i) - O(i-1) ==> planar < 5 as a pseudo torsion Example 1 - <VRPTx:pdbx_validate_main_chain_planeCategory> <VRPTx:pdbx_validate_main_chain_plane id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>G</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>TRP</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>20</VRPTx:auth_seq_id> <VRPTx:improper_torsion_angle>29.901</VRPTx:improper_torsion_angle> </VRPTx:pdbx_validate_main_chain_plane> <VRPTx:pdbx_validate_main_chain_plane id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>G</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>TRP</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>21</VRPTx:auth_seq_id> <VRPTx:improper_torsion_angle>-42.450</VRPTx:improper_torsion_angle> </VRPTx:pdbx_validate_main_chain_plane> </VRPTx:pdbx_validate_main_chain_planeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_main_chain_plane.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_main_chain_plane (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	improper_torsion_angle DECIMAL ,
	label_alt_id TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_nmr_chem_shiftType)
-- Items in the PDBX_VALIDATE_NMR_CHEM_SHIFT category provide information about assigned chemical shifts that deviate from expected BMRB standards by 5 * the expected RMSD.
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_nmr_chem_shift (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"Zscore" DECIMAL ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	method TEXT ,
	target_val DECIMAL ,
	val DECIMAL ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	list_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_peptide_omegaType)
-- Data items in the PDBX_VALIDATE_PEPTIDE_OMEGA category list the residues that contain peptide bonds deviate significantly from both cis and trans conformation. cis bonds, if any, are listed on cispep records. trans is defined as 180 +/- 30 and cis is defined as 0 +/- 30 degrees. Example 1 - <VRPTx:pdbx_validate_peptide_omegaCategory> <VRPTx:pdbx_validate_peptide_omega id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>ASP</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>ARG</VRPTx:auth_asym_id_2> <VRPTx:auth_comp_id_1>A</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>A</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>414</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>413</VRPTx:auth_seq_id_2> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:omega>147.84</VRPTx:omega> </VRPTx:pdbx_validate_peptide_omega> <VRPTx:pdbx_validate_peptide_omega id="2"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>ASN</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>ALA</VRPTx:auth_asym_id_2> <VRPTx:auth_comp_id_1>B</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>B</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>289</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>288</VRPTx:auth_seq_id_2> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:omega>-39.12</VRPTx:omega> </VRPTx:pdbx_validate_peptide_omega> </VRPTx:pdbx_validate_peptide_omegaCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_peptide_omega.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_peptide_omega (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="-180.0"
	omega DECIMAL CHECK ( omega >= -180.0 AND omega <= 180.0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_planes_atomType)
-- Data items in the PDBX_VALIDATE_PLANES_ATOM category list the residues that contain unexpected deviations from planes centers. Example 1 - <VRPTx:pdbx_validate_planes_atomCategory> <VRPTx:pdbx_validate_planes_atom id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.003</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.011</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="3"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.074</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="4"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.005</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N3</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="5"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.010</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C4</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="6"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.029</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C5</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="7"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.039</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="8"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.074</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>O6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="9"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.050</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N7</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="10"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.129</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C8</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="11"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.033</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N9</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="12"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.147</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DG</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C1&apos;</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>3</VRPTx:auth_seq_id> <VRPTx:plane_id>1</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> <VRPTx:pdbx_validate_planes_atom id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:atom_deviation>0.069</VRPTx:atom_deviation> <VRPTx:auth_asym_id>DT</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>N1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>A</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>4</VRPTx:auth_seq_id> <VRPTx:plane_id>2</VRPTx:plane_id> </VRPTx:pdbx_validate_planes_atom> </VRPTx:pdbx_validate_planes_atomCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_planes_atom.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_planes_atom (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	atom_deviation DECIMAL ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	plane_id INTEGER ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_polymer_linkageType)
-- Data items in the PDBX_VALIDATE_POLYMER_LINKAGE category list the polymer linkages within the entry that are outside of typical covalent distances. Example 1 - <VRPTx:pdbx_validate_polymer_linkageCategory> <VRPTx:pdbx_validate_polymer_linkage id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>B</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>B</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1 xsi:nil="true" /> <VRPTx:auth_atom_id_2 xsi:nil="true" /> <VRPTx:auth_comp_id_1>VAL</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>ARG</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>107</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>108</VRPTx:auth_seq_id_2> <VRPTx:dist>3.16</VRPTx:dist> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> </VRPTx:pdbx_validate_polymer_linkage> <VRPTx:pdbx_validate_polymer_linkage id="2"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>B</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>B</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1 xsi:nil="true" /> <VRPTx:auth_atom_id_2 xsi:nil="true" /> <VRPTx:auth_comp_id_1>ARG</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>LYS</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>110</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>110</VRPTx:auth_seq_id_2> <VRPTx:dist>2.95</VRPTx:dist> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> </VRPTx:pdbx_validate_polymer_linkage> </VRPTx:pdbx_validate_polymer_linkageCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_polymer_linkage.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_polymer_linkage (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	dist DECIMAL ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_angleType)
-- Data items in the PDBX_VALIDATE_RMSD_ANGLE category list the covalent bond angles found in an entry that have values which deviate from expected values by more than 6*rmsd for the particular entry from the expected standard value Example 1 - <VRPTx:pdbx_validate_rmsd_angleCategory> <VRPTx:pdbx_validate_rmsd_angle id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_ins_code_3 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:angle_deviation>-3.14</VRPTx:angle_deviation> <VRPTx:angle_value>117.16</VRPTx:angle_value> <VRPTx:auth_asym_id_1>A</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>A</VRPTx:auth_asym_id_2> <VRPTx:auth_asym_id_3>A</VRPTx:auth_asym_id_3> <VRPTx:auth_atom_id_1>NE</VRPTx:auth_atom_id_1> <VRPTx:auth_atom_id_2>CZ</VRPTx:auth_atom_id_2> <VRPTx:auth_atom_id_3>NH2</VRPTx:auth_atom_id_3> <VRPTx:auth_comp_id_1>ARG</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>ARG</VRPTx:auth_comp_id_2> <VRPTx:auth_comp_id_3>ARG</VRPTx:auth_comp_id_3> <VRPTx:auth_seq_id_1>35</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>35</VRPTx:auth_seq_id_2> <VRPTx:auth_seq_id_3>35</VRPTx:auth_seq_id_3> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:label_alt_id_3 xsi:nil="true" /> <VRPTx:linker_flag>N</VRPTx:linker_flag> </VRPTx:pdbx_validate_rmsd_angle> <VRPTx:pdbx_validate_rmsd_angle id="2"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_ins_code_3 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:angle_deviation>34.68</VRPTx:angle_deviation> <VRPTx:angle_value>148.88</VRPTx:angle_value> <VRPTx:auth_asym_id_1>A</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>A</VRPTx:auth_asym_id_2> <VRPTx:auth_asym_id_3>A</VRPTx:auth_asym_id_3> <VRPTx:auth_atom_id_1>CB</VRPTx:auth_atom_id_1> <VRPTx:auth_atom_id_2>CG</VRPTx:auth_atom_id_2> <VRPTx:auth_atom_id_3>CD</VRPTx:auth_atom_id_3> <VRPTx:auth_comp_id_1>GLU</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>GLU</VRPTx:auth_comp_id_2> <VRPTx:auth_comp_id_3>GLU</VRPTx:auth_comp_id_3> <VRPTx:auth_seq_id_1>166</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>166</VRPTx:auth_seq_id_2> <VRPTx:auth_seq_id_3>166</VRPTx:auth_seq_id_3> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:label_alt_id_3 xsi:nil="true" /> <VRPTx:linker_flag>N</VRPTx:linker_flag> </VRPTx:pdbx_validate_rmsd_angle> </VRPTx:pdbx_validate_rmsd_angleCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_rmsd_angle.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_angle (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_ins_code_3" TEXT ,
	"PDB_model_num" INTEGER ,
	"Zscore" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_deviation DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_minimum_diff_to_kb DECIMAL CHECK ( angle_minimum_diff_to_kb >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	angle_standard_deviation DECIMAL CHECK ( angle_standard_deviation >= 0.0 ) ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_target_value DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	angle_value DECIMAL ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_asym_id_3 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_atom_id_3 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_comp_id_3 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
	auth_seq_id_3 TEXT ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	label_alt_id_3 TEXT ,
	linker_flag TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_angles_in_kb INTEGER CHECK ( number_angles_in_kb >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_bondType)
-- Data items in the PDBX_VALIDATE_RMSD_BOND category list the covalent bonds that have values which deviate from expected values by more than 6*rmsd. Example 1 - <VRPTx:pdbx_validate_rmsd_bondCategory> <VRPTx:pdbx_validate_rmsd_bond id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>A</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>A</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1>CD</VRPTx:auth_atom_id_1> <VRPTx:auth_atom_id_2>CE</VRPTx:auth_atom_id_2> <VRPTx:auth_comp_id_1>LYS</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>LYS</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>152</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>152</VRPTx:auth_seq_id_2> <VRPTx:bond_deviation>-0.372</VRPTx:bond_deviation> <VRPTx:bond_value>1.136</VRPTx:bond_value> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:linker_flag>N</VRPTx:linker_flag> </VRPTx:pdbx_validate_rmsd_bond> <VRPTx:pdbx_validate_rmsd_bond id="2"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>0</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1>A</VRPTx:auth_asym_id_1> <VRPTx:auth_asym_id_2>A</VRPTx:auth_asym_id_2> <VRPTx:auth_atom_id_1>CG</VRPTx:auth_atom_id_1> <VRPTx:auth_atom_id_2>CD</VRPTx:auth_atom_id_2> <VRPTx:auth_comp_id_1>GLU</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>GLU</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>166</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>166</VRPTx:auth_seq_id_2> <VRPTx:bond_deviation>-0.622</VRPTx:bond_deviation> <VRPTx:bond_value>0.893</VRPTx:bond_value> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:linker_flag>N</VRPTx:linker_flag> </VRPTx:pdbx_validate_rmsd_bond> </VRPTx:pdbx_validate_rmsd_bondCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_rmsd_bond.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_bond (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	"Zscore" DECIMAL ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	bond_deviation DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	bond_minimum_diff_to_kb DECIMAL CHECK ( bond_minimum_diff_to_kb >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	bond_standard_deviation DECIMAL CHECK ( bond_standard_deviation >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	bond_target_value DECIMAL CHECK ( bond_target_value >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	bond_value DECIMAL CHECK ( bond_value >= 0.0 ) ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	linker_flag TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_bonds_in_kb INTEGER CHECK ( number_bonds_in_kb >= 0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_rings_atomType)
-- Data items in the PDBX_VALIDATE_RMSD_RINGS_ATOM category list the atoms involved in outlier ring conformations instanced in the PDBX_VALIDATE_RMSD_RING category. The values are computed by Mogul. Mogul finds the similar ring conformations from small-molecule structures in the Cambridge Structural Database (CSD). Example 1 - <VRPTx:pdbx_validate_rmsd_rings_atomCategory> <VRPTx:pdbx_validate_rmsd_rings_atom id="1" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="2" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="3" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C3</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="4" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="5" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C5</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="6" ring_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="1" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="2" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="3" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C3</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="4" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="5" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C5</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> <VRPTx:pdbx_validate_rmsd_rings_atom id="6" ring_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_rings_atom> </VRPTx:pdbx_validate_rmsd_rings_atomCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_rings_atom (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	ring_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_rmsd_torsions_atomType)
-- Data items in the PDBX_VALIDATE_RMSD_TORSIONS_ATOM category list the atoms involved in outlier conformations instanced in the PDBX_VALIDATE_RMSD_TORSION category. The values are computed by Mogul. Mogul finds the similar conformations from small-molecule structures in the Cambridge Structural Database (CSD). Example 1 - <VRPTx:pdbx_validate_rmsd_torsions_atomCategory> <VRPTx:pdbx_validate_rmsd_torsions_atom id="1" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="2" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="3" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C3</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="4" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="5" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C5</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="6" torsion_id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="1" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C1</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="2" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C2</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="3" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C3</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="4" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="5" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C5</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> <VRPTx:pdbx_validate_rmsd_torsions_atom id="6" torsion_id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>B</VRPTx:auth_asym_id> <VRPTx:auth_atom_id>C6</VRPTx:auth_atom_id> <VRPTx:auth_comp_id>BBA</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>250</VRPTx:auth_seq_id> </VRPTx:pdbx_validate_rmsd_torsions_atom> </VRPTx:pdbx_validate_rmsd_torsions_atomCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_rmsd_torsions_atom (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL ,
-- ATTRIBUTE
	torsion_id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_symm_contactType)
-- Data items in the PDBX_VALIDATE_SYMM_CONTACT category list the atoms within the entry that are in close contact with regard the distances expected from either covalent bonding or closest approach by van der Waals contacts. Contacts with for symmetry related contacts are considered. For those contacts not involving hydrogen a limit of 2.2 angstroms is used. For contacts involving a hydrogen atom a cutoff of 1.6 angstrom is used. Example 1 - <VRPTx:pdbx_validate_symm_contactCategory> <VRPTx:pdbx_validate_symm_contact id="1"> <VRPTx:PDB_ins_code_1 xsi:nil="true" /> <VRPTx:PDB_ins_code_2 xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id_1 xsi:nil="true" /> <VRPTx:auth_asym_id_2 xsi:nil="true" /> <VRPTx:auth_atom_id_1>O</VRPTx:auth_atom_id_1> <VRPTx:auth_atom_id_2>O</VRPTx:auth_atom_id_2> <VRPTx:auth_comp_id_1>HOH</VRPTx:auth_comp_id_1> <VRPTx:auth_comp_id_2>HOH</VRPTx:auth_comp_id_2> <VRPTx:auth_seq_id_1>70</VRPTx:auth_seq_id_1> <VRPTx:auth_seq_id_2>70</VRPTx:auth_seq_id_2> <VRPTx:dist>2.05</VRPTx:dist> <VRPTx:label_alt_id_1 xsi:nil="true" /> <VRPTx:label_alt_id_2 xsi:nil="true" /> <VRPTx:site_symmetry_1>1555</VRPTx:site_symmetry_1> <VRPTx:site_symmetry_2>7555</VRPTx:site_symmetry_2> </VRPTx:pdbx_validate_symm_contact> </VRPTx:pdbx_validate_symm_contactCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_symm_contact.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_symm_contact (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code_1" TEXT ,
	"PDB_ins_code_2" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id_1 TEXT ,
	auth_asym_id_2 TEXT ,
	auth_atom_id_1 TEXT ,
	auth_atom_id_2 TEXT ,
	auth_comp_id_1 TEXT ,
	auth_comp_id_2 TEXT ,
	auth_seq_id_1 TEXT ,
	auth_seq_id_2 TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	clash_magnitude DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	dist DECIMAL ,
	label_alt_id_1 TEXT ,
	label_alt_id_2 TEXT ,
	site_symmetry_1 TEXT ,
	site_symmetry_2 TEXT ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validate_torsionType)
-- Data items in the PDBX_VALIDATE_TORSION category list the residues with torsion angles outside the expected Ramachandran regions Example 1 - <VRPTx:pdbx_validate_torsionCategory> <VRPTx:pdbx_validate_torsion id="1"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>SER</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>12</VRPTx:auth_seq_id> <VRPTx:phi>-64.75</VRPTx:phi> <VRPTx:psi>2.02</VRPTx:psi> </VRPTx:pdbx_validate_torsion> <VRPTx:pdbx_validate_torsion id="2"> <VRPTx:PDB_ins_code xsi:nil="true" /> <VRPTx:PDB_model_num>1</VRPTx:PDB_model_num> <VRPTx:auth_asym_id>A</VRPTx:auth_asym_id> <VRPTx:auth_comp_id>THR</VRPTx:auth_comp_id> <VRPTx:auth_seq_id>22</VRPTx:auth_seq_id> <VRPTx:phi>-116.30</VRPTx:phi> <VRPTx:psi>61.44</VRPTx:psi> </VRPTx:pdbx_validate_torsion> </VRPTx:pdbx_validate_torsionCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/pdbx_validate_torsion.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validate_torsion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_ins_code" TEXT ,
	"PDB_model_num" INTEGER ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="-180.0"
	phi DECIMAL CHECK ( phi >= -180.0 AND phi <= 180.0 ) ,
-- xsd:restriction/xsd:maxInclusive="180.0"
-- xsd:restriction/xsd:minInclusive="-180.0"
	psi DECIMAL CHECK ( psi >= -180.0 AND psi <= 180.0 ) ,
-- ATTRIBUTE
	id INTEGER NOT NULL
);

--
-- (quoted from pdbx_validation_softwareType)
-- Description of the software that was used for wwPDB validation pipeline. The description should include the name of the software and the version used. This example describes the software used in wwPDB validation pipeline. <VRPTx:pdbx_validation_softwareCategory> <VRPTx:pdbx_validation_software ordinal="1"> <VRPTx:classification>refinement package</VRPTx:classification> <VRPTx:details xsi:nil="true" /> <VRPTx:name>EDS</VRPTx:name> <VRPTx:version>trunk28620</VRPTx:version> </VRPTx:pdbx_validation_software> <VRPTx:pdbx_validation_software ordinal="2"> <VRPTx:classification>refinement package</VRPTx:classification> <VRPTx:details xsi:nil="true" /> <VRPTx:name>DCC</VRPTx:name> <VRPTx:version>2.18 (2016-06-28)</VRPTx:version> </VRPTx:pdbx_validation_software> <VRPTx:pdbx_validation_software ordinal="3"> <VRPTx:classification>geometric validation</VRPTx:classification> <VRPTx:details xsi:nil="true" /> <VRPTx:name>Mogul</VRPTx:name> <VRPTx:version>1.7.2 (RC1), CSD as538be (2017)</VRPTx:version> </VRPTx:pdbx_validation_software> <VRPTx:pdbx_validation_software ordinal="4"> <VRPTx:classification>phasing,refinement</VRPTx:classification> <VRPTx:details xsi:nil="true" /> <VRPTx:name>Xtriage</VRPTx:name> <VRPTx:version>1.9-1692</VRPTx:version> </VRPTx:pdbx_validation_software> </VRPTx:pdbx_validation_softwareCategory>
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE pdbx_validation_software (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	classification TEXT ,
	details TEXT ,
	name TEXT ,
	version TEXT ,
-- ATTRIBUTE
	ordinal INTEGER NOT NULL
);

--
-- (quoted from phasingType)
-- Data items in the PHASING category record details about the phasing of the structure, listing the various methods used in the phasing process. Details about the application of each method are listed in the appropriate subcategories. Example 1 - hypothetical example. <VRPTx:phasingCategory> <VRPTx:phasing method="mir"></VRPTx:phasing> <VRPTx:phasing method="averaging"></VRPTx:phasing> </VRPTx:phasingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE phasing (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- ATTRIBUTE
	method TEXT NOT NULL
);

--
-- (quoted from phasing_MADType)
-- Data items in the PHASING_MAD category record details about the phasing of the structure where methods involving multiple-wavelength anomalous-dispersion techniques are involved. Example 1 - based on a paper by Shapiro et al. [Nature (London) (1995), 374, 327-337]. <VRPTx:phasing_MADCategory> <VRPTx:phasing_MAD entry_id="NCAD"></VRPTx:phasing_MAD> </VRPTx:phasing_MADCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MAD.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MAD" (
	details TEXT ,
	method TEXT ,
	"pdbx_R_cullis" DECIMAL ,
	"pdbx_R_cullis_acentric" DECIMAL ,
	"pdbx_R_cullis_centric" DECIMAL ,
	"pdbx_R_kraut" DECIMAL ,
	"pdbx_R_kraut_acentric" DECIMAL ,
	"pdbx_R_kraut_centric" DECIMAL ,
	pdbx_anom_scat_method TEXT ,
	pdbx_d_res_high DECIMAL ,
	pdbx_d_res_low DECIMAL ,
	pdbx_fom DECIMAL ,
	pdbx_fom_acentric DECIMAL ,
	pdbx_fom_centric DECIMAL ,
	pdbx_loc DECIMAL ,
	pdbx_loc_acentric DECIMAL ,
	pdbx_loc_centric DECIMAL ,
	pdbx_number_data_sets INTEGER ,
	pdbx_power DECIMAL ,
	pdbx_power_acentric DECIMAL ,
	pdbx_power_centric DECIMAL ,
	pdbx_reflns INTEGER ,
	pdbx_reflns_acentric INTEGER ,
	pdbx_reflns_centric INTEGER ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from phasing_MAD_clustType)
-- Data items in the PHASING_MAD_CLUST category record details about a cluster of experiments that contributed to the generation of a set of phases. Example 1 - based on a paper by Shapiro et al. [Nature (London) (1995), 374, 327-337]. <VRPTx:phasing_MAD_clustCategory> <VRPTx:phasing_MAD_clust expt_id="1" id="4 wavelength"> <VRPTx:number_set>4</VRPTx:number_set> </VRPTx:phasing_MAD_clust> <VRPTx:phasing_MAD_clust expt_id="1" id="5 wavelength"> <VRPTx:number_set>5</VRPTx:number_set> </VRPTx:phasing_MAD_clust> <VRPTx:phasing_MAD_clust expt_id="2" id="5 wavelength"> <VRPTx:number_set>5</VRPTx:number_set> </VRPTx:phasing_MAD_clust> </VRPTx:phasing_MAD_clustCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MAD_clust.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MAD_clust" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	number_set INTEGER ,
-- ATTRIBUTE
	expt_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from phasing_MAD_ratioType)
-- Data items in the PHASING_MAD_RATIO category record the ratios of phasing statistics between pairs of data sets in a MAD phasing experiment, in given shells of resolution. Example 1 - based on a paper by Shapiro et al. [Nature (London) (1995), 374, 327-337]. <VRPTx:phasing_MAD_ratioCategory> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.4013"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.084</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.076</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3857"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.067</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3852"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.051</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.044</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3857"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.110</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.049</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3852"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.049</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.067</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3852"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.149</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.072</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.039</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.102</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.071</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.4013"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.114</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.111</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3857"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.089</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.086</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.4013" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.077</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3857"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.140</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.127</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.085</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.089</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.155</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.119</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.082</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="4 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.124</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.120</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3857"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.075</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.027</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3852"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.041</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.060</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3784"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.057</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.2862"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.072</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3852"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.105</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.032</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.036</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3784"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.044</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.2862"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.065</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.072</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.031</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3784"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.040</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.2862"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.059</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3784" wavelength_2="1.3784"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.059</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.032</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3784" wavelength_2="1.2862"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.059</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.2862" wavelength_2="1.3847"> <VRPTx:d_res_high>4.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.058</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.028</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3857"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.078</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.075</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.059</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.067</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.3784"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.084</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3857" wavelength_2="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.073</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.101</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.088</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.066</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.3784"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.082</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3852" wavelength_2="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.085</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.097</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.074</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.3784"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.081</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3847" wavelength_2="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.085</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3784" wavelength_2="1.3784"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.114</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.089</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.3784" wavelength_2="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.103</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="1" wavelength_1="1.2862" wavelength_2="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>4.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.062</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.060</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7263"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.035</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.026</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7251"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.028</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7284"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.023</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7246"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.025</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7217"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.026</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7251"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.060</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.026</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7284"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.029</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7246"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.031</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7217"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.035</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7284"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.075</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.030</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7246"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.023</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7217"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.027</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7246" wavelength_2="0.7246"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.069</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.026</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7246" wavelength_2="0.7217"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.024</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7217" wavelength_2="0.7284"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.060</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.028</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7263"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.060</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.050</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7251"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.056</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7284"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.055</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7246"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.053</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7263" wavelength_2="0.7217"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.056</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7251"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.089</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.050</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7284"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.054</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7246"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.058</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7251" wavelength_2="0.7217"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.063</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7284"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.104</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.057</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7246"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.052</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7284" wavelength_2="0.7217"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.057</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7246" wavelength_2="0.7246"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.098</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.052</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7246" wavelength_2="0.7217"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl xsi:nil="true" /> <VRPTx:ratio_one_wl_centric xsi:nil="true" /> <VRPTx:ratio_two_wl>0.054</VRPTx:ratio_two_wl> </VRPTx:phasing_MAD_ratio> <VRPTx:phasing_MAD_ratio clust_id="5 wavelength" expt_id="2" wavelength_1="0.7217" wavelength_2="0.7284"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>3.00</VRPTx:d_res_low> <VRPTx:ratio_one_wl>0.089</VRPTx:ratio_one_wl> <VRPTx:ratio_one_wl_centric>0.060</VRPTx:ratio_one_wl_centric> <VRPTx:ratio_two_wl xsi:nil="true" /> </VRPTx:phasing_MAD_ratio> </VRPTx:phasing_MAD_ratioCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MAD_ratio.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MAD_ratio" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	d_res_high DECIMAL ,
	d_res_low DECIMAL ,
	ratio_one_wl DECIMAL ,
	ratio_one_wl_centric DECIMAL ,
	ratio_two_wl DECIMAL ,
-- ATTRIBUTE
	clust_id TEXT NOT NULL ,
-- ATTRIBUTE
	expt_id TEXT NOT NULL ,
-- ATTRIBUTE
	wavelength_1 DECIMAL NOT NULL ,
-- ATTRIBUTE
	wavelength_2 DECIMAL NOT NULL
);

--
-- (quoted from phasing_MAD_setType)
-- Data items in the PHASING_MAD_SET category record details about the individual data sets used in a MAD phasing experiment. Example 1 - based on a paper by Shapiro et al. [Nature (London) (1995), 374, 327-337]. <VRPTx:phasing_MAD_setCategory> <VRPTx:phasing_MAD_set clust_id="4 wavelength" expt_id="1" set_id="aa" wavelength="1.4013"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>3.80</VRPTx:f_double_prime> <VRPTx:f_prime>-12.48</VRPTx:f_prime> <VRPTx:wavelength_details>pre-edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="4 wavelength" expt_id="1" set_id="bb" wavelength="1.3857"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>17.20</VRPTx:f_double_prime> <VRPTx:f_prime>-31.22</VRPTx:f_prime> <VRPTx:wavelength_details>peak</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="4 wavelength" expt_id="1" set_id="cc" wavelength="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>29.17</VRPTx:f_double_prime> <VRPTx:f_prime>-13.97</VRPTx:f_prime> <VRPTx:wavelength_details>edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="4 wavelength" expt_id="1" set_id="dd" wavelength="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>17.34</VRPTx:f_double_prime> <VRPTx:f_prime>-6.67</VRPTx:f_prime> <VRPTx:wavelength_details>remote</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="1" set_id="ee" wavelength="1.3857"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>14.84</VRPTx:f_double_prime> <VRPTx:f_prime>-28.33</VRPTx:f_prime> <VRPTx:wavelength_details>ascending edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="1" set_id="ff" wavelength="1.3852"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>30.23</VRPTx:f_double_prime> <VRPTx:f_prime>-21.50</VRPTx:f_prime> <VRPTx:wavelength_details>peak</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="1" set_id="gg" wavelength="1.3847"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>20.35</VRPTx:f_double_prime> <VRPTx:f_prime>-10.71</VRPTx:f_prime> <VRPTx:wavelength_details>descending edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="1" set_id="hh" wavelength="1.3784"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>11.84</VRPTx:f_double_prime> <VRPTx:f_prime>-14.45</VRPTx:f_prime> <VRPTx:wavelength_details>remote 1</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="1" set_id="ii" wavelength="1.2862"> <VRPTx:d_res_high>3.00</VRPTx:d_res_high> <VRPTx:d_res_low>20.00</VRPTx:d_res_low> <VRPTx:f_double_prime>9.01</VRPTx:f_double_prime> <VRPTx:f_prime>-9.03</VRPTx:f_prime> <VRPTx:wavelength_details>remote 2</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="2" set_id="jj" wavelength="0.7263"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:f_double_prime>4.08</VRPTx:f_double_prime> <VRPTx:f_prime>-21.10</VRPTx:f_prime> <VRPTx:wavelength_details>pre-edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="2" set_id="kk" wavelength="0.7251"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:f_double_prime>7.92</VRPTx:f_double_prime> <VRPTx:f_prime>-34.72</VRPTx:f_prime> <VRPTx:wavelength_details>edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="2" set_id="ll" wavelength="0.7248"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:f_double_prime>10.30</VRPTx:f_double_prime> <VRPTx:f_prime>-24.87</VRPTx:f_prime> <VRPTx:wavelength_details>peak</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="2" set_id="mm" wavelength="0.7246"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:f_double_prime>9.62</VRPTx:f_double_prime> <VRPTx:f_prime>-17.43</VRPTx:f_prime> <VRPTx:wavelength_details>descending edge</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> <VRPTx:phasing_MAD_set clust_id="5 wavelength" expt_id="2" set_id="nn" wavelength="0.7217"> <VRPTx:d_res_high>1.90</VRPTx:d_res_high> <VRPTx:d_res_low>15.00</VRPTx:d_res_low> <VRPTx:f_double_prime>8.40</VRPTx:f_double_prime> <VRPTx:f_prime>-13.26</VRPTx:f_prime> <VRPTx:wavelength_details>remote</VRPTx:wavelength_details> </VRPTx:phasing_MAD_set> </VRPTx:phasing_MAD_setCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MAD_set.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MAD_set" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	d_res_high DECIMAL ,
	d_res_low DECIMAL ,
	f_double_prime DECIMAL ,
	f_prime DECIMAL ,
	pdbx_atom_type TEXT ,
	pdbx_f_double_prime_refined DECIMAL ,
	pdbx_f_prime_refined DECIMAL ,
	wavelength_details TEXT ,
-- ATTRIBUTE
	clust_id TEXT NOT NULL ,
-- ATTRIBUTE
	expt_id TEXT NOT NULL ,
-- ATTRIBUTE
	set_id TEXT NOT NULL ,
-- ATTRIBUTE
	wavelength DECIMAL NOT NULL
);

--
-- (quoted from phasing_MIRType)
-- Data items in the PHASING_MIR category record details about the phasing of the structure where methods involving isomorphous replacement are involved. All isomorphous-replacement-based techniques are covered by this category, including single isomorphous replacement (SIR), multiple isomorphous replacement (MIR) and single or multiple isomorphous replacement plus anomalous scattering (SIRAS, MIRAS). Example 1 - based on a paper by Zanotti et al. [J. Biol. Chem. (1993), 268, 10728-10738]. <VRPTx:phasing_MIRCategory> <VRPTx:phasing_MIR entry_id="1ABC"> <VRPTx:method> Standard phase refinement (Blow &amp; Crick, 1959)</VRPTx:method> </VRPTx:phasing_MIR> </VRPTx:phasing_MIRCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR" (
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM" DECIMAL CHECK ( "FOM" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM_acentric" DECIMAL CHECK ( "FOM_acentric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM_centric" DECIMAL CHECK ( "FOM_centric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	details TEXT ,
	method TEXT ,
	pdbx_number_derivatives INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns INTEGER CHECK ( reflns >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_acentric INTEGER CHECK ( reflns_acentric >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_centric INTEGER CHECK ( reflns_centric >= 0 ) ,
	reflns_criterion TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from phasing_MIR_der_reflnType)
-- Data items in the PHASING_MIR_DER_REFLN category record details about the calculated structure factors obtained in an MIR phasing experiment. This list may contain information from a number of different derivatives; attribute der_id in category phasing_MIR_der_refln indicates to which derivative a given record corresponds. (A derivative in this context does not necessarily equate with a data set; see the definition of the PHASING_MIR_DER category for a discussion of the meaning of derivative.) It is not necessary for the data items describing the measured value of F to appear in this list, as they will be given in the PHASING_SET_REFLN category. However, these items can also be listed here for completeness. Example 1 - based on laboratory records for the 6,1,25 reflection of an Hg/Pt derivative of protein NS1. <VRPTx:phasing_MIR_der_reflnCategory> <VRPTx:phasing_MIR_der_refln der_id="HGPT1" index_h="6" index_k="1" index_l="25" set_id="NS1-96"> <VRPTx:F_calc_au>106.66</VRPTx:F_calc_au> <VRPTx:F_meas_au>204.67</VRPTx:F_meas_au> <VRPTx:F_meas_sigma>6.21</VRPTx:F_meas_sigma> <VRPTx:HL_A_iso>-3.15</VRPTx:HL_A_iso> <VRPTx:HL_B_iso>-0.76</VRPTx:HL_B_iso> <VRPTx:HL_C_iso>0.65</VRPTx:HL_C_iso> <VRPTx:HL_D_iso>0.23</VRPTx:HL_D_iso> <VRPTx:phase_calc>194.48</VRPTx:phase_calc> </VRPTx:phasing_MIR_der_refln> </VRPTx:phasing_MIR_der_reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR_der_refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR_der_refln" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_calc" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_calc_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas_sigma" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_sigma_au" DECIMAL ,
	"HL_A_iso" DECIMAL ,
	"HL_B_iso" DECIMAL ,
	"HL_C_iso" DECIMAL ,
	"HL_D_iso" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	phase_calc DECIMAL ,
-- ATTRIBUTE
	der_id TEXT NOT NULL ,
-- ATTRIBUTE
	index_h INTEGER NOT NULL ,
-- ATTRIBUTE
	index_k INTEGER NOT NULL ,
-- ATTRIBUTE
	index_l INTEGER NOT NULL ,
-- ATTRIBUTE
	set_id TEXT NOT NULL
);

--
-- (quoted from phasing_MIR_der_shellType)
-- Data items in the PHASING_MIR_DER_SHELL category record statistics, broken down into shells of resolution, for an MIR phasing experiment. This list may contain information from a number of different derivatives; attribute der_id in category phasing_MIR_der_shell indicates to which derivative a given record corresponds. (A derivative in this context does not necessarily equate with a data set; see the definition of the PHASING_MIR_DER category for a discussion of the meaning of derivative.) Example 1 - based on a paper by Zanotti et al. [J. Biol. Chem. (1993), 268, 10728-10738] with addition of an arbitrary low-resolution limit. <VRPTx:phasing_MIR_der_shellCategory> <VRPTx:phasing_MIR_der_shell d_res_high="8.3" d_res_low="15.0" der_id="KAu(CN)2"> <VRPTx:ha_ampl>54</VRPTx:ha_ampl> <VRPTx:loc>26</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="6.4" d_res_low="8.3" der_id="KAu(CN)2"> <VRPTx:ha_ampl>54</VRPTx:ha_ampl> <VRPTx:loc>20</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="5.2" d_res_low="6.4" der_id="KAu(CN)2"> <VRPTx:ha_ampl>50</VRPTx:ha_ampl> <VRPTx:loc>20</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="4.4" d_res_low="5.2" der_id="KAu(CN)2"> <VRPTx:ha_ampl>44</VRPTx:ha_ampl> <VRPTx:loc>23</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.8" d_res_low="4.4" der_id="KAu(CN)2"> <VRPTx:ha_ampl>39</VRPTx:ha_ampl> <VRPTx:loc>23</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.4" d_res_low="3.8" der_id="KAu(CN)2"> <VRPTx:ha_ampl>33</VRPTx:ha_ampl> <VRPTx:loc>21</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="3.4" der_id="KAu(CN)2"> <VRPTx:ha_ampl>28</VRPTx:ha_ampl> <VRPTx:loc>17</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="15.0" der_id="KAu(CN)2"> <VRPTx:ha_ampl>38</VRPTx:ha_ampl> <VRPTx:loc>21</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="8.3" d_res_low="15.0" der_id="K2HgI4"> <VRPTx:ha_ampl>149</VRPTx:ha_ampl> <VRPTx:loc>87</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="6.4" d_res_low="8.3" der_id="K2HgI4"> <VRPTx:ha_ampl>121</VRPTx:ha_ampl> <VRPTx:loc>73</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="5.2" d_res_low="6.4" der_id="K2HgI4"> <VRPTx:ha_ampl>95</VRPTx:ha_ampl> <VRPTx:loc>61</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="4.4" d_res_low="5.2" der_id="K2HgI4"> <VRPTx:ha_ampl>80</VRPTx:ha_ampl> <VRPTx:loc>60</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.8" d_res_low="4.4" der_id="K2HgI4"> <VRPTx:ha_ampl>73</VRPTx:ha_ampl> <VRPTx:loc>63</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.4" d_res_low="3.8" der_id="K2HgI4"> <VRPTx:ha_ampl>68</VRPTx:ha_ampl> <VRPTx:loc>57</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="3.4" der_id="K2HgI4"> <VRPTx:ha_ampl>63</VRPTx:ha_ampl> <VRPTx:loc>46</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="15.0" der_id="K2HgI4"> <VRPTx:ha_ampl>79</VRPTx:ha_ampl> <VRPTx:loc>58</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="8.3" d_res_low="15.0" der_id="K3IrCl6"> <VRPTx:ha_ampl>33</VRPTx:ha_ampl> <VRPTx:loc>27</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="6.4" d_res_low="8.3" der_id="K3IrCl6"> <VRPTx:ha_ampl>40</VRPTx:ha_ampl> <VRPTx:loc>23</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="5.2" d_res_low="6.4" der_id="K3IrCl6"> <VRPTx:ha_ampl>31</VRPTx:ha_ampl> <VRPTx:loc>22</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="4.4" d_res_low="5.2" der_id="K3IrCl6"> <VRPTx:ha_ampl>27</VRPTx:ha_ampl> <VRPTx:loc>23</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.8" d_res_low="4.4" der_id="K3IrCl6"> <VRPTx:ha_ampl>22</VRPTx:ha_ampl> <VRPTx:loc>23</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.4" d_res_low="3.8" der_id="K3IrCl6"> <VRPTx:ha_ampl>19</VRPTx:ha_ampl> <VRPTx:loc>20</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="3.4" der_id="K3IrCl6"> <VRPTx:ha_ampl>16</VRPTx:ha_ampl> <VRPTx:loc>20</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> <VRPTx:phasing_MIR_der_shell d_res_high="3.0" d_res_low="15.0" der_id="K3IrCl6"> <VRPTx:ha_ampl>23</VRPTx:ha_ampl> <VRPTx:loc>21</VRPTx:loc> </VRPTx:phasing_MIR_der_shell> </VRPTx:phasing_MIR_der_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR_der_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR_der_shell" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_cullis" DECIMAL CHECK ( "R_cullis" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_kraut" DECIMAL CHECK ( "R_kraut" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	fom DECIMAL CHECK ( fom >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ha_ampl DECIMAL CHECK ( ha_ampl >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	loc DECIMAL CHECK ( loc >= 0.0 ) ,
	"pdbx_R_cullis_acentric" DECIMAL ,
	"pdbx_R_cullis_centric" DECIMAL ,
	"pdbx_R_kraut_acentric" DECIMAL ,
	"pdbx_R_kraut_centric" DECIMAL ,
	pdbx_fom_acentric DECIMAL ,
	pdbx_fom_centric DECIMAL ,
	pdbx_loc_acentric DECIMAL ,
	pdbx_loc_centric DECIMAL ,
	pdbx_power_acentric DECIMAL ,
	pdbx_power_centric DECIMAL ,
	pdbx_reflns_acentric INTEGER ,
	pdbx_reflns_centric DECIMAL ,
	phase DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	power DECIMAL CHECK ( power >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns INTEGER CHECK ( reflns >= 0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) NOT NULL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) NOT NULL ,
-- ATTRIBUTE
	der_id TEXT NOT NULL
);

--
-- (quoted from phasing_MIR_der_siteType)
-- Data items in the PHASING_MIR_DER_SITE category record details about the heavy-atom sites in an MIR phasing experiment. This list may contain information from a number of different derivatives; attribute der_id in category phasing_MIR_der_site indicates to which derivative a given record corresponds. (A derivative in this context does not necessarily equate with a data set; see the definition of the PHASING_MIR_DER category for a discussion of the meaning of derivative.) Example 1 - based on a paper by Zanotti et al. [J. Biol. Chem. (1993), 268, 10728-10738] with occupancies converted from electrons to fractional. <VRPTx:phasing_MIR_der_siteCategory> <VRPTx:phasing_MIR_der_site der_id="KAu(CN)2" id="1"> <VRPTx:B_iso>33.0</VRPTx:B_iso> <VRPTx:atom_type_symbol>Au</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.082</VRPTx:fract_x> <VRPTx:fract_y>0.266</VRPTx:fract_y> <VRPTx:fract_z>0.615</VRPTx:fract_z> <VRPTx:occupancy>0.40</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="KAu(CN)2" id="2"> <VRPTx:B_iso>25.9</VRPTx:B_iso> <VRPTx:atom_type_symbol>Au</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.607</VRPTx:fract_x> <VRPTx:fract_y>0.217</VRPTx:fract_y> <VRPTx:fract_z>0.816</VRPTx:fract_z> <VRPTx:occupancy>0.03</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="KAu(CN)2" id="3"> <VRPTx:B_iso>15.7</VRPTx:B_iso> <VRPTx:atom_type_symbol>Au</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.263</VRPTx:fract_x> <VRPTx:fract_y>0.782</VRPTx:fract_y> <VRPTx:fract_z>0.906</VRPTx:fract_z> <VRPTx:occupancy>0.02</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="1"> <VRPTx:B_iso>33.7</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.048</VRPTx:fract_x> <VRPTx:fract_y>0.286</VRPTx:fract_y> <VRPTx:fract_z>0.636</VRPTx:fract_z> <VRPTx:occupancy>0.63</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="2"> <VRPTx:B_iso>36.7</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.913</VRPTx:fract_x> <VRPTx:fract_y>0.768</VRPTx:fract_y> <VRPTx:fract_z>0.889</VRPTx:fract_z> <VRPTx:occupancy>0.34</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="3"> <VRPTx:B_iso>24.2</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.974</VRPTx:fract_x> <VRPTx:fract_y>0.455</VRPTx:fract_y> <VRPTx:fract_z>0.974</VRPTx:fract_z> <VRPTx:occupancy>0.23</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="4"> <VRPTx:B_iso>14.7</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.903</VRPTx:fract_x> <VRPTx:fract_y>0.836</VRPTx:fract_y> <VRPTx:fract_z>0.859</VRPTx:fract_z> <VRPTx:occupancy>0.28</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="5"> <VRPTx:B_iso>6.4</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.489</VRPTx:fract_x> <VRPTx:fract_y>0.200</VRPTx:fract_y> <VRPTx:fract_z>0.885</VRPTx:fract_z> <VRPTx:occupancy>0.07</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K2HgI4" id="6"> <VRPTx:B_iso>32.9</VRPTx:B_iso> <VRPTx:atom_type_symbol>Hg</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.162</VRPTx:fract_x> <VRPTx:fract_y>0.799</VRPTx:fract_y> <VRPTx:fract_z>0.889</VRPTx:fract_z> <VRPTx:occupancy>0.07</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K3IrCl6" id="1"> <VRPTx:B_iso>40.8</VRPTx:B_iso> <VRPTx:atom_type_symbol>Ir</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.209</VRPTx:fract_x> <VRPTx:fract_y>0.739</VRPTx:fract_y> <VRPTx:fract_z>0.758</VRPTx:fract_z> <VRPTx:occupancy>0.26</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> <VRPTx:phasing_MIR_der_site der_id="K3IrCl6" id="2"> <VRPTx:B_iso>24.9</VRPTx:B_iso> <VRPTx:atom_type_symbol>Ir</VRPTx:atom_type_symbol> <VRPTx:fract_x>0.279</VRPTx:fract_x> <VRPTx:fract_y>0.613</VRPTx:fract_y> <VRPTx:fract_z>0.752</VRPTx:fract_z> <VRPTx:occupancy>0.05</VRPTx:occupancy> </VRPTx:phasing_MIR_der_site> </VRPTx:phasing_MIR_der_siteCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR_der_site.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR_der_site" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	"B_iso" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"B_iso_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_x" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_x_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_y" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_y_esd" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_z" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Cartn_z_esd" DECIMAL ,
	atom_type_symbol TEXT ,
	details TEXT ,
	fract_x DECIMAL ,
	fract_x_esd DECIMAL ,
	fract_y DECIMAL ,
	fract_y_esd DECIMAL ,
	fract_z DECIMAL ,
	fract_z_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	occupancy DECIMAL CHECK ( occupancy >= 0.0 ) ,
	occupancy_anom DECIMAL ,
	occupancy_anom_su DECIMAL ,
	occupancy_iso DECIMAL ,
	occupancy_iso_su DECIMAL ,
-- ATTRIBUTE
	der_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from phasing_MIR_shellType)
-- Data items in the PHASING_MIR_SHELL category record statistics for an isomorphous replacement phasing experiment.broken down into shells of resolution. Example 1 - based on a paper by Zanotti et al. [J. Biol. Chem. (1993), 268, 10728-10738] with addition of an arbitrary low-resolution limit. <VRPTx:phasing_MIR_shellCategory> <VRPTx:phasing_MIR_shell d_res_high="8.3" d_res_low="15.0"> <VRPTx:FOM>0.69</VRPTx:FOM> <VRPTx:reflns>80</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="6.4" d_res_low="8.3"> <VRPTx:FOM>0.73</VRPTx:FOM> <VRPTx:reflns>184</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="5.2" d_res_low="6.4"> <VRPTx:FOM>0.72</VRPTx:FOM> <VRPTx:reflns>288</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="4.4" d_res_low="5.2"> <VRPTx:FOM>0.65</VRPTx:FOM> <VRPTx:reflns>406</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="3.8" d_res_low="4.4"> <VRPTx:FOM>0.54</VRPTx:FOM> <VRPTx:reflns>554</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="3.4" d_res_low="3.8"> <VRPTx:FOM>0.53</VRPTx:FOM> <VRPTx:reflns>730</VRPTx:reflns> </VRPTx:phasing_MIR_shell> <VRPTx:phasing_MIR_shell d_res_high="3.0" d_res_low="3.4"> <VRPTx:FOM>0.50</VRPTx:FOM> <VRPTx:reflns>939</VRPTx:reflns> </VRPTx:phasing_MIR_shell> </VRPTx:phasing_MIR_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_MIR_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "phasing_MIR_shell" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM" DECIMAL CHECK ( "FOM" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM_acentric" DECIMAL CHECK ( "FOM_acentric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"FOM_centric" DECIMAL CHECK ( "FOM_centric" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_cullis" DECIMAL CHECK ( "R_cullis" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_kraut" DECIMAL CHECK ( "R_kraut" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	loc DECIMAL CHECK ( loc >= 0.0 ) ,
	mean_phase DECIMAL ,
	"pdbx_R_cullis_acentric" DECIMAL ,
	"pdbx_R_cullis_centric" DECIMAL ,
	"pdbx_R_kraut_acentric" DECIMAL ,
	"pdbx_R_kraut_centric" DECIMAL ,
	pdbx_loc_acentric DECIMAL ,
	pdbx_loc_centric DECIMAL ,
	pdbx_power_acentric DECIMAL ,
	pdbx_power_centric DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	power DECIMAL CHECK ( power >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns INTEGER CHECK ( reflns >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_acentric INTEGER CHECK ( reflns_acentric >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_anomalous INTEGER CHECK ( reflns_anomalous >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	reflns_centric INTEGER CHECK ( reflns_centric >= 0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) NOT NULL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) NOT NULL
);

--
-- (quoted from phasing_averagingType)
-- Data items in the PHASING_AVERAGING category record details about the phasing of the structure where methods involving averaging of multiple observations of the molecule in the asymmetric unit are involved. Example 1 - hypothetical example. <VRPTx:phasing_averagingCategory> <VRPTx:phasing_averaging entry_id="EXAMHYPO"> <VRPTx:details> The position of the threefold axis was redetermined every five cycles.</VRPTx:details> <VRPTx:method> Iterative threefold averaging alternating with phase extensions by 0.5 reciprocal lattice units per cycle.</VRPTx:method> </VRPTx:phasing_averaging> </VRPTx:phasing_averagingCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_averaging.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE phasing_averaging (
	details TEXT ,
	method TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from phasing_isomorphousType)
-- Data items in the PHASING_ISOMORPHOUS category record details about the phasing of the structure where a model isomorphous to the structure being phased was used to generate the initial phases. Example 1 - based on PDB entry 4PHV and laboratory records for the structure corresponding to PDB entry 4PHV. <VRPTx:phasing_isomorphousCategory> <VRPTx:phasing_isomorphous entry_id="1ABC"> <VRPTx:details> The inhibitor and all solvent atoms were removed from the parent structure before beginning refinement. All static disorder present in the parent structure was also removed.</VRPTx:details> <VRPTx:parent>PDB entry 5HVP</VRPTx:parent> </VRPTx:phasing_isomorphous> </VRPTx:phasing_isomorphousCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_isomorphous.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE phasing_isomorphous (
	details TEXT ,
	method TEXT ,
	parent TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from phasing_set_reflnType)
-- Data items in the PHASING_SET_REFLN category record the values of the measured structure factors used in a phasing experiment. This list may contain information from a number of different data sets; attribute set_id in category phasing_set_refln indicates the data set to which a given record corresponds. Example 1 - based on laboratory records for the 15,15,32 reflection of an Hg/Pt derivative of protein NS1. <VRPTx:phasing_set_reflnCategory> <VRPTx:phasing_set_refln index_h="15" index_k="15" index_l="32" set_id="NS1-96"> <VRPTx:F_meas_au>181.79</VRPTx:F_meas_au> <VRPTx:F_meas_sigma_au>3.72</VRPTx:F_meas_sigma_au> </VRPTx:phasing_set_refln> </VRPTx:phasing_set_reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/phasing_set_refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE phasing_set_refln (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas_sigma" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_sigma_au" DECIMAL ,
-- ATTRIBUTE
	index_h INTEGER NOT NULL ,
-- ATTRIBUTE
	index_k INTEGER NOT NULL ,
-- ATTRIBUTE
	index_l INTEGER NOT NULL ,
-- ATTRIBUTE
	set_id TEXT NOT NULL
);

--
-- (quoted from refineType)
-- Data items in the REFINE category record details about the structure-refinement parameters. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refineCategory> <VRPTx:refine entry_id="5HVP" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:ls_R_factor_obs>0.176</VRPTx:ls_R_factor_obs> <VRPTx:ls_number_parameters>7032</VRPTx:ls_number_parameters> <VRPTx:ls_number_reflns_obs>12901</VRPTx:ls_number_reflns_obs> <VRPTx:ls_number_restraints>6609</VRPTx:ls_number_restraints> <VRPTx:ls_weighting_details> Sigdel model of Konnert-Hendrickson: Sigdel: Afsig + Bfsig*(sin(theta)/lambda-1/6) Afsig = 22.0, Bfsig = -150.0 at beginning of refinement Afsig = 15.5, Bfsig = -50.0 at end of refinement</VRPTx:ls_weighting_details> <VRPTx:ls_weighting_scheme>calc</VRPTx:ls_weighting_scheme> </VRPTx:refine> </VRPTx:refineCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:refineCategory> <VRPTx:refine entry_id="TOZ" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:details>sfls:_F_calc_weight_full_matrix</VRPTx:details> <VRPTx:diff_density_max>.131</VRPTx:diff_density_max> <VRPTx:diff_density_min>-.108</VRPTx:diff_density_min> <VRPTx:ls_R_factor_all>.038</VRPTx:ls_R_factor_all> <VRPTx:ls_R_factor_obs>.034</VRPTx:ls_R_factor_obs> <VRPTx:ls_abs_structure_Flack>0</VRPTx:ls_abs_structure_Flack> <VRPTx:ls_abs_structure_details> The absolute configuration was assigned to agree with the known chirality at C3 arising from its precursor l-leucine.</VRPTx:ls_abs_structure_details> <VRPTx:ls_extinction_coef>3514</VRPTx:ls_extinction_coef> <VRPTx:ls_extinction_expression> Larson, A. C. (1970). &quot;Crystallographic Computing&quot;, edited by F. R. Ahmed. Eq. (22) p. 292. Copenhagen: Munksgaard.</VRPTx:ls_extinction_expression> <VRPTx:ls_extinction_method>Zachariasen</VRPTx:ls_extinction_method> <VRPTx:ls_goodness_of_fit_all>1.462</VRPTx:ls_goodness_of_fit_all> <VRPTx:ls_goodness_of_fit_obs>1.515</VRPTx:ls_goodness_of_fit_obs> <VRPTx:ls_hydrogen_treatment>refxyz except H332B noref</VRPTx:ls_hydrogen_treatment> <VRPTx:ls_matrix_type>full</VRPTx:ls_matrix_type> <VRPTx:ls_number_constraints>0</VRPTx:ls_number_constraints> <VRPTx:ls_number_parameters>272</VRPTx:ls_number_parameters> <VRPTx:ls_number_reflns_obs>1408</VRPTx:ls_number_reflns_obs> <VRPTx:ls_number_restraints>0</VRPTx:ls_number_restraints> <VRPTx:ls_shift_over_esd_max>.535</VRPTx:ls_shift_over_esd_max> <VRPTx:ls_shift_over_esd_mean>.044</VRPTx:ls_shift_over_esd_mean> <VRPTx:ls_structure_factor_coef>F</VRPTx:ls_structure_factor_coef> <VRPTx:ls_wR_factor_all>.044</VRPTx:ls_wR_factor_all> <VRPTx:ls_wR_factor_obs>.042</VRPTx:ls_wR_factor_obs> <VRPTx:ls_weighting_details>w=1/(\s^2^(F)+0.0004F^2^)</VRPTx:ls_weighting_details> <VRPTx:ls_weighting_scheme>calc</VRPTx:ls_weighting_scheme> </VRPTx:refine> </VRPTx:refineCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_refine_ls_hydrogen_treatment CASCADE;
CREATE TYPE ENUM_refine_ls_hydrogen_treatment AS ENUM ( 'refall', 'refxyz', 'refU', 'noref', 'constr', 'mixed', 'undef' );
DROP TYPE IF EXISTS ENUM_refine_ls_matrix_type CASCADE;
CREATE TYPE ENUM_refine_ls_matrix_type AS ENUM ( 'full', 'fullcycle', 'atomblock', 'userblock', 'diagonal', 'sparse' );
DROP TYPE IF EXISTS ENUM_refine_ls_structure_factor_coef CASCADE;
CREATE TYPE ENUM_refine_ls_structure_factor_coef AS ENUM ( 'F', 'Fsqd', 'Inet' );
DROP TYPE IF EXISTS ENUM_refine_ls_weighting_scheme CASCADE;
CREATE TYPE ENUM_refine_ls_weighting_scheme AS ENUM ( 'sigma', 'unit', 'calc' );
DROP TYPE IF EXISTS ENUM_refine_pdbx_TLS_residual_ADP_flag CASCADE;
CREATE TYPE ENUM_refine_pdbx_TLS_residual_ADP_flag AS ENUM ( 'LIKELY RESIDUAL', 'UNVERIFIED' );
CREATE TABLE refine (
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"B_iso_max" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"B_iso_mean" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"B_iso_min" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B11" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B12" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B13" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B22" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B23" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"aniso_B33" DECIMAL ,
	"correlation_coeff_Fo_to_Fc" DECIMAL ,
	"correlation_coeff_Fo_to_Fc_free" DECIMAL ,
	details TEXT ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_max DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_max_esd DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_min DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_min_esd DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_rms DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_per_angstroms_cubed"
	diff_density_rms_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_Fsqd_factor_obs" DECIMAL CHECK ( "ls_R_Fsqd_factor_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_I_factor_obs" DECIMAL CHECK ( "ls_R_I_factor_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_factor_R_free" DECIMAL CHECK ( "ls_R_factor_R_free" >= 0.0 AND "ls_R_factor_R_free" <= 1.0 ) ,
	"ls_R_factor_R_free_error" DECIMAL ,
	"ls_R_factor_R_free_error_details" TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_factor_R_work" DECIMAL CHECK ( "ls_R_factor_R_work" >= 0.0 AND "ls_R_factor_R_work" <= 1.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_factor_all" DECIMAL CHECK ( "ls_R_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_factor_gt" DECIMAL CHECK ( "ls_R_factor_gt" >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_R_factor_obs" DECIMAL CHECK ( "ls_R_factor_obs" >= 0.0 AND "ls_R_factor_obs" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_abs_structure_Flack" DECIMAL CHECK ( "ls_abs_structure_Flack" >= 0.0 AND "ls_abs_structure_Flack" <= 1.0 ) ,
	"ls_abs_structure_Flack_esd" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"ls_abs_structure_Rogers" DECIMAL CHECK ( "ls_abs_structure_Rogers" >= -1.0 AND "ls_abs_structure_Rogers" <= 1.0 ) ,
	"ls_abs_structure_Rogers_esd" DECIMAL ,
	ls_abs_structure_details TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_d_res_high DECIMAL CHECK ( ls_d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_d_res_low DECIMAL CHECK ( ls_d_res_low >= 0.0 ) ,
	ls_extinction_coef DECIMAL ,
	ls_extinction_coef_esd DECIMAL ,
	ls_extinction_expression TEXT ,
	ls_extinction_method TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_goodness_of_fit_all DECIMAL CHECK ( ls_goodness_of_fit_all >= 0.0 ) ,
	ls_goodness_of_fit_all_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_goodness_of_fit_gt DECIMAL CHECK ( ls_goodness_of_fit_gt >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_goodness_of_fit_obs DECIMAL CHECK ( ls_goodness_of_fit_obs >= 0.0 ) ,
	ls_goodness_of_fit_obs_esd DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_goodness_of_fit_ref DECIMAL CHECK ( ls_goodness_of_fit_ref >= 0.0 ) ,
	ls_hydrogen_treatment ENUM_refine_ls_hydrogen_treatment ,
	ls_matrix_type ENUM_refine_ls_matrix_type ,
-- xsd:restriction/xsd:minInclusive="0"
	ls_number_constraints INTEGER CHECK ( ls_number_constraints >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	ls_number_parameters INTEGER CHECK ( ls_number_parameters >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"ls_number_reflns_R_free" INTEGER CHECK ( "ls_number_reflns_R_free" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"ls_number_reflns_R_work" INTEGER CHECK ( "ls_number_reflns_R_work" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	ls_number_reflns_all INTEGER CHECK ( ls_number_reflns_all >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	ls_number_reflns_obs INTEGER CHECK ( ls_number_reflns_obs >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	ls_number_restraints INTEGER CHECK ( ls_number_restraints >= 0 ) ,
	"ls_percent_reflns_R_free" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="100"
-- xsd:restriction/xsd:minInclusive="0"
	ls_percent_reflns_obs DECIMAL CHECK ( ls_percent_reflns_obs >= 0 AND ls_percent_reflns_obs <= 100 ) ,
	ls_redundancy_reflns_all DECIMAL ,
	ls_redundancy_reflns_obs DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_restrained_S_all" DECIMAL CHECK ( "ls_restrained_S_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_restrained_S_obs" DECIMAL CHECK ( "ls_restrained_S_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_esd_max DECIMAL CHECK ( ls_shift_over_esd_max >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_esd_mean DECIMAL CHECK ( ls_shift_over_esd_mean >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_su_max DECIMAL CHECK ( ls_shift_over_su_max >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_su_max_lt DECIMAL CHECK ( ls_shift_over_su_max_lt >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_su_mean DECIMAL CHECK ( ls_shift_over_su_mean >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	ls_shift_over_su_mean_lt DECIMAL CHECK ( ls_shift_over_su_mean_lt >= 0.0 ) ,
	ls_structure_factor_coef ENUM_refine_ls_structure_factor_coef ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_wR_factor_R_free" DECIMAL CHECK ( "ls_wR_factor_R_free" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_wR_factor_R_work" DECIMAL CHECK ( "ls_wR_factor_R_work" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_wR_factor_all" DECIMAL CHECK ( "ls_wR_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"ls_wR_factor_obs" DECIMAL CHECK ( "ls_wR_factor_obs" >= 0.0 ) ,
	ls_weighting_details TEXT ,
	ls_weighting_scheme ENUM_refine_ls_weighting_scheme ,
-- xsd:restriction/xsd:minInclusive="0.0"
	occupancy_max DECIMAL CHECK ( occupancy_max >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	occupancy_min DECIMAL CHECK ( occupancy_min >= 0.0 ) ,
	"overall_FOM_free_R_set" DECIMAL ,
	"overall_FOM_work_R_set" DECIMAL ,
	"overall_SU_B" DECIMAL ,
	"overall_SU_ML" DECIMAL ,
	"overall_SU_R_Cruickshank_DPI" DECIMAL ,
	"overall_SU_R_free" DECIMAL ,
	"pdbx_R_Free_selection_details" TEXT ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_R_complete" DECIMAL CHECK ( "pdbx_R_complete" >= 0.0 AND "pdbx_R_complete" <= 1.0 ) ,
	"pdbx_TLS_residual_ADP_flag" ENUM_refine_pdbx_TLS_residual_ADP_flag ,
	pdbx_average_fsc_free DECIMAL ,
	pdbx_average_fsc_overall DECIMAL ,
	pdbx_average_fsc_work DECIMAL ,
	"pdbx_data_cutoff_high_absF" DECIMAL ,
	"pdbx_data_cutoff_high_rms_absF" DECIMAL ,
	"pdbx_data_cutoff_low_absF" DECIMAL ,
	pdbx_density_correlation DECIMAL ,
	pdbx_diffrn_id TEXT ,
	pdbx_isotropic_thermal_model TEXT ,
	pdbx_ls_cross_valid_method TEXT ,
	"pdbx_ls_sigma_F" DECIMAL ,
	"pdbx_ls_sigma_Fsqd" DECIMAL ,
	"pdbx_ls_sigma_I" DECIMAL ,
	pdbx_method_to_determine_struct TEXT ,
	"pdbx_overall_ESU_R" DECIMAL ,
	"pdbx_overall_ESU_R_Free" DECIMAL ,
	"pdbx_overall_SU_R_Blow_DPI" DECIMAL ,
	"pdbx_overall_SU_R_free_Blow_DPI" DECIMAL ,
	"pdbx_overall_SU_R_free_Cruickshank_DPI" DECIMAL ,
	pdbx_overall_phase_error DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_pd_Fsqrd_R_factor" DECIMAL CHECK ( "pdbx_pd_Fsqrd_R_factor" >= 0.0 ) ,
	"pdbx_pd_Marquardt_correlation_coeff" DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_pd_ls_matrix_band_width INTEGER CHECK ( pdbx_pd_ls_matrix_band_width >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_pd_meas_number_of_points INTEGER CHECK ( pdbx_pd_meas_number_of_points >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_pd_number_of_points INTEGER CHECK ( pdbx_pd_number_of_points >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_pd_number_of_powder_patterns INTEGER CHECK ( pdbx_pd_number_of_powder_patterns >= 0 ) ,
	"pdbx_pd_proc_ls_prof_R_factor" DECIMAL ,
	"pdbx_pd_proc_ls_prof_wR_factor" DECIMAL ,
	"pdbx_real_space_R" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	pdbx_solvent_ion_probe_radii DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	pdbx_solvent_shrinkage_radii DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	pdbx_solvent_vdw_probe_radii DECIMAL ,
	pdbx_starting_model TEXT ,
	pdbx_stereochem_target_val_spec_case TEXT ,
	pdbx_stereochemistry_target_values TEXT ,
	solvent_model_details TEXT ,
	solvent_model_param_bsol DECIMAL ,
	solvent_model_param_ksol DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from refine_B_isoType)
-- Data items in the REFINE_B_ISO category record details about the treatment of isotropic B factors (displacement parameters) during refinement. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refine_B_isoCategory> <VRPTx:refine_B_iso class="protein" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:treatment>isotropic</VRPTx:treatment> </VRPTx:refine_B_iso> <VRPTx:refine_B_iso class="solvent" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:treatment>isotropic</VRPTx:treatment> </VRPTx:refine_B_iso> <VRPTx:refine_B_iso class="inhibitor" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:treatment>isotropic</VRPTx:treatment> </VRPTx:refine_B_iso> </VRPTx:refine_B_isoCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_B_iso.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_refine_B_iso_treatment CASCADE;
CREATE TYPE ENUM_refine_B_iso_treatment AS ENUM ( 'fixed', 'isotropic', 'anisotropic' );
CREATE TABLE "refine_B_iso" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	treatment ENUM_refine_B_iso_treatment ,
-- omit an attribute having a fixed value: @units="degrees"
	value DECIMAL ,
-- ATTRIBUTE
	class TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from refine_analyzeType)
-- Data items in the REFINE_ANALYZE category record details about the refined structure that are often used to analyze the refinement and assess its quality. A given computer program may or may not produce values corresponding to these data names. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refine_analyzeCategory> <VRPTx:refine_analyze entry_id="5HVP" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:Luzzati_coordinate_error_obs>0.056</VRPTx:Luzzati_coordinate_error_obs> <VRPTx:Luzzati_d_res_low_obs>2.51</VRPTx:Luzzati_d_res_low_obs> </VRPTx:refine_analyze> </VRPTx:refine_analyzeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_analyze.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_analyze (
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_coordinate_error_free" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_coordinate_error_obs" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_d_res_low_free" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_d_res_low_obs" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_sigma_a_free" DECIMAL ,
	"Luzzati_sigma_a_free_details" TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	"Luzzati_sigma_a_obs" DECIMAL ,
	"Luzzati_sigma_a_obs_details" TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"RG_d_res_high" DECIMAL CHECK ( "RG_d_res_high" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"RG_d_res_low" DECIMAL CHECK ( "RG_d_res_low" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"RG_free" DECIMAL CHECK ( "RG_free" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"RG_free_work_ratio" DECIMAL CHECK ( "RG_free_work_ratio" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"RG_work" DECIMAL CHECK ( "RG_work" >= 0.0 ) ,
	number_disordered_residues DECIMAL ,
	occupancy_sum_hydrogen DECIMAL ,
	occupancy_sum_non_hydrogen DECIMAL ,
	"pdbx_Luzzati_d_res_high_obs" DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from refine_funct_minimizedType)
-- Data items in the REFINE_FUNCT_MINIMIZED category record details about the individual terms of the function minimized during refinement. Example 1 - based on RESTRAIN refinement for the CCP4 test data set toxd. <VRPTx:refine_funct_minimizedCategory> <VRPTx:refine_funct_minimized pdbx_refine_id="X-RAY DIFFRACTION" type="sum(W*Delta(Amplitude)^2"> <VRPTx:number_terms>3009</VRPTx:number_terms> <VRPTx:residual>1621.3</VRPTx:residual> </VRPTx:refine_funct_minimized> <VRPTx:refine_funct_minimized pdbx_refine_id="X-RAY DIFFRACTION" type="sum(W*Delta(Plane+Rigid)^2"> <VRPTx:number_terms>85</VRPTx:number_terms> <VRPTx:residual>56.68</VRPTx:residual> </VRPTx:refine_funct_minimized> <VRPTx:refine_funct_minimized pdbx_refine_id="X-RAY DIFFRACTION" type="sum(W*Delta(Distance)^2"> <VRPTx:number_terms>1219</VRPTx:number_terms> <VRPTx:residual>163.59</VRPTx:residual> </VRPTx:refine_funct_minimized> <VRPTx:refine_funct_minimized pdbx_refine_id="X-RAY DIFFRACTION" type="sum(W*Delta(U-tempfactors)^2"> <VRPTx:number_terms>1192</VRPTx:number_terms> <VRPTx:residual>69.338</VRPTx:residual> </VRPTx:refine_funct_minimized> </VRPTx:refine_funct_minimizedCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_funct_minimized.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_funct_minimized (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_terms INTEGER CHECK ( number_terms >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	residual DECIMAL CHECK ( residual >= 0.0 ) ,
	weight DECIMAL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL ,
-- ATTRIBUTE
	type TEXT NOT NULL
);

--
-- (quoted from refine_histType)
-- Data items in the REFINE_HIST category record details about the steps during the refinement of the structure. These data items are not meant to be as thorough a description of the refinement as is provided for the final model in other categories; rather, these data items provide a mechanism for sketching out the progress of the refinement, supported by a small set of representative statistics. Example 1 - based on laboratory records for the collagen-like peptide [(POG)4 EKG (POG)5]3. <VRPTx:refine_histCategory> <VRPTx:refine_hist cycle_id="C134" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_R_free>.274</VRPTx:R_factor_R_free> <VRPTx:R_factor_R_work>.160</VRPTx:R_factor_R_work> <VRPTx:R_factor_all>.265</VRPTx:R_factor_all> <VRPTx:R_factor_obs>.195</VRPTx:R_factor_obs> <VRPTx:d_res_high>1.85</VRPTx:d_res_high> <VRPTx:d_res_low>20.0</VRPTx:d_res_low> <VRPTx:details> Add majority of solvent molecules. B factors refined by group. Continued to remove misplaced water molecules.</VRPTx:details> <VRPTx:number_atoms_solvent>217</VRPTx:number_atoms_solvent> <VRPTx:number_atoms_total>808</VRPTx:number_atoms_total> <VRPTx:number_reflns_R_free>476</VRPTx:number_reflns_R_free> <VRPTx:number_reflns_R_work>4410</VRPTx:number_reflns_R_work> <VRPTx:number_reflns_all>6174</VRPTx:number_reflns_all> <VRPTx:number_reflns_obs>4886</VRPTx:number_reflns_obs> </VRPTx:refine_hist> </VRPTx:refine_histCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_hist.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_hist (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_R_free" DECIMAL CHECK ( "R_factor_R_free" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_R_work" DECIMAL CHECK ( "R_factor_R_work" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_all" DECIMAL CHECK ( "R_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_obs" DECIMAL CHECK ( "R_factor_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	details TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_atoms_solvent INTEGER CHECK ( number_atoms_solvent >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_atoms_total INTEGER CHECK ( number_atoms_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"number_reflns_R_free" INTEGER CHECK ( "number_reflns_R_free" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"number_reflns_R_work" INTEGER CHECK ( "number_reflns_R_work" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_reflns_all INTEGER CHECK ( number_reflns_all >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_reflns_obs INTEGER CHECK ( number_reflns_obs >= 0 ) ,
	"pdbx_B_iso_mean_ligand" DECIMAL ,
	"pdbx_B_iso_mean_solvent" DECIMAL ,
	pdbx_number_atoms_carb INTEGER ,
	pdbx_number_atoms_ligand INTEGER ,
	pdbx_number_atoms_lipid INTEGER ,
	pdbx_number_atoms_nucleic_acid INTEGER ,
	pdbx_number_atoms_protein INTEGER ,
	pdbx_number_residues_total INTEGER ,
	pdbx_pseudo_atom_details TEXT ,
-- ATTRIBUTE
	cycle_id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from refine_ls_classType)
-- Data items in the REFINE_LS_CLASS category record details about the reflections used for the structure refinement for each reflection class separately. Example 1 - data for a modulated structure from van Smaalen [J. Phys. Condens. Matter (1991), 3, 1247-1263]. <VRPTx:refine_ls_classCategory> <VRPTx:refine_ls_class code="Main"> <VRPTx:R_factor_gt>0.057</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> <VRPTx:refine_ls_class code="Com"> <VRPTx:R_factor_gt>0.074</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> <VRPTx:refine_ls_class code="NbRefls"> <VRPTx:R_factor_gt>0.064</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> <VRPTx:refine_ls_class code="LaRefls"> <VRPTx:R_factor_gt>0.046</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> <VRPTx:refine_ls_class code="Sat1"> <VRPTx:R_factor_gt>0.112</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> <VRPTx:refine_ls_class code="Sat2"> <VRPTx:R_factor_gt>0.177</VRPTx:R_factor_gt> </VRPTx:refine_ls_class> </VRPTx:refine_ls_classCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_ls_class.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_ls_class (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_Fsqd_factor" DECIMAL CHECK ( "R_Fsqd_factor" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_I_factor" DECIMAL CHECK ( "R_I_factor" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_all" DECIMAL CHECK ( "R_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_gt" DECIMAL CHECK ( "R_factor_gt" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_all" DECIMAL CHECK ( "wR_factor_all" >= 0.0 ) ,
-- ATTRIBUTE
	code TEXT NOT NULL
);

--
-- (quoted from refine_ls_restrType)
-- Data items in the REFINE_LS_RESTR category record details about the restraints applied to various classes of parameters during the least-squares refinement. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refine_ls_restrCategory> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="bond_d"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.018</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.020</VRPTx:dev_ideal_target> <VRPTx:number>1654</VRPTx:number> <VRPTx:rejects>22</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="angle_d"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.038</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.030</VRPTx:dev_ideal_target> <VRPTx:number>2246</VRPTx:number> <VRPTx:rejects>139</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="planar_d"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.043</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.040</VRPTx:dev_ideal_target> <VRPTx:number>498</VRPTx:number> <VRPTx:rejects>21</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="planar"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.015</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.020</VRPTx:dev_ideal_target> <VRPTx:number>270</VRPTx:number> <VRPTx:rejects>1</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="chiral"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.177</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.150</VRPTx:dev_ideal_target> <VRPTx:number>278</VRPTx:number> <VRPTx:rejects>2</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="singtor_nbd"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.216</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.500</VRPTx:dev_ideal_target> <VRPTx:number>582</VRPTx:number> <VRPTx:rejects>0</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="multtor_nbd"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.207</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.500</VRPTx:dev_ideal_target> <VRPTx:number>419</VRPTx:number> <VRPTx:rejects>0</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="xyhbond_nbd"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>0.245</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.500</VRPTx:dev_ideal_target> <VRPTx:number>149</VRPTx:number> <VRPTx:rejects>0</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="planar_tor"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>2.6</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>3.0</VRPTx:dev_ideal_target> <VRPTx:number>203</VRPTx:number> <VRPTx:rejects>9</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="staggered_tor"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>17.4</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>15.0</VRPTx:dev_ideal_target> <VRPTx:number>298</VRPTx:number> <VRPTx:rejects>31</VRPTx:rejects> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr pdbx_refine_id="X-RAY DIFFRACTION" type="orthonormal_tor"> <VRPTx:criterion>&gt; 2\s</VRPTx:criterion> <VRPTx:dev_ideal>18.1</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>20.0</VRPTx:dev_ideal_target> <VRPTx:number>12</VRPTx:number> <VRPTx:rejects>1</VRPTx:rejects> </VRPTx:refine_ls_restr> </VRPTx:refine_ls_restrCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_ls_restr.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_ls_restr (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	criterion TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dev_ideal DECIMAL CHECK ( dev_ideal >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	dev_ideal_target DECIMAL CHECK ( dev_ideal_target >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number INTEGER CHECK ( number >= 0 ) ,
	pdbx_restraint_function TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	rejects INTEGER CHECK ( rejects >= 0 ) ,
	weight DECIMAL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL ,
-- ATTRIBUTE
	type TEXT NOT NULL
);

--
-- (quoted from refine_ls_restr_ncsType)
-- Data items in the REFINE_LS_RESTR_NCS category record details about the restraints applied to atom positions in domains related by noncrystallographic symmetry during least-squares refinement, and also about the deviation of the restrained atomic parameters at the end of the refinement. It is expected that these values will only be reported once for each set of restrained domains. Example 1 - based on laboratory records for the collagen-like peptide, HYP-. <VRPTx:refine_ls_restr_ncsCategory> <VRPTx:refine_ls_restr_ncs pdbx_ordinal="1"> <VRPTx:dom_id>d2</VRPTx:dom_id> <VRPTx:ncs_model_details> NCS restraint for pseudo-twofold symmetry between domains d1 and d2. Position weight coefficient given in Kcal/(mol \&#37;A^2^) and isotropic B weight coefficient given in \&#37;A^2^.</VRPTx:ncs_model_details> <VRPTx:pdbx_asym_id>A</VRPTx:pdbx_asym_id> <VRPTx:pdbx_ens_id>1</VRPTx:pdbx_ens_id> <VRPTx:pdbx_refine_id>X-RAY DIFFRACTION</VRPTx:pdbx_refine_id> <VRPTx:pdbx_type>medium positional</VRPTx:pdbx_type> <VRPTx:rms_dev_B_iso>0.16</VRPTx:rms_dev_B_iso> <VRPTx:rms_dev_position>0.09</VRPTx:rms_dev_position> <VRPTx:weight_B_iso>2.0</VRPTx:weight_B_iso> <VRPTx:weight_position>300.0</VRPTx:weight_position> </VRPTx:refine_ls_restr_ncs> </VRPTx:refine_ls_restr_ncsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_ls_restr_ncs.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_ls_restr_ncs (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	dom_id TEXT ,
	ncs_model_details TEXT ,
	pdbx_asym_id TEXT ,
	pdbx_auth_asym_id TEXT ,
	pdbx_ens_id TEXT ,
	pdbx_number INTEGER ,
	pdbx_refine_id TEXT ,
	pdbx_rms DECIMAL ,
	pdbx_type TEXT ,
	pdbx_weight DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"rms_dev_B_iso" DECIMAL CHECK ( "rms_dev_B_iso" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	rms_dev_position DECIMAL CHECK ( rms_dev_position >= 0.0 ) ,
	"weight_B_iso" DECIMAL ,
	weight_position DECIMAL ,
-- ATTRIBUTE
	pdbx_ordinal INTEGER NOT NULL
);

--
-- (quoted from refine_ls_restr_typeType)
-- Data items in the REFINE_LS_RESTR_TYPE category record details about the restraint types used in the least-squares refinement. Example 1 - based on RESTRAIN refinement for the CCP4 test data set toxd. <VRPTx:refine_ls_restrCategory> <VRPTx:refine_ls_restr type="RESTRAIN_Distances &lt; 2.12"> <VRPTx:dev_ideal>0.005</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.022</VRPTx:dev_ideal_target> <VRPTx:number>509</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_Distances 2.12 &lt; D &lt; 2.625"> <VRPTx:dev_ideal>0.016</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.037</VRPTx:dev_ideal_target> <VRPTx:number>671</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_Distances &gt; 2.625"> <VRPTx:dev_ideal>0.034</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.043</VRPTx:dev_ideal_target> <VRPTx:number>39</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_Peptide Planes"> <VRPTx:dev_ideal>0.002</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.010</VRPTx:dev_ideal_target> <VRPTx:number>59</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_Ring and other planes"> <VRPTx:dev_ideal>0.014</VRPTx:dev_ideal> <VRPTx:dev_ideal_target>0.010</VRPTx:dev_ideal_target> <VRPTx:number>26</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist 1.2-1.4"> <VRPTx:dev_ideal>0.106</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>212</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist 1.4-1.6"> <VRPTx:dev_ideal>0.101</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>288</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist 1.8-2.0"> <VRPTx:dev_ideal>0.077</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>6</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist 2.0-2.2"> <VRPTx:dev_ideal>0.114</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>10</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist 2.2-2.4"> <VRPTx:dev_ideal>0.119</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>215</VRPTx:number> </VRPTx:refine_ls_restr> <VRPTx:refine_ls_restr type="RESTRAIN_rms diffs for Uiso atoms at dist &gt;2.4"> <VRPTx:dev_ideal>0.106</VRPTx:dev_ideal> <VRPTx:dev_ideal_target xsi:nil="true" /> <VRPTx:number>461</VRPTx:number> </VRPTx:refine_ls_restr> </VRPTx:refine_ls_restrCategory> <VRPTx:refine_ls_restr_typeCategory> <VRPTx:refine_ls_restr_type type="RESTRAIN_Distances &lt; 2.12"> <VRPTx:distance_cutoff_high>2.12</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low xsi:nil="true" /> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_Distances 2.12 &lt; D &lt; 2.625"> <VRPTx:distance_cutoff_high>2.625</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>2.12</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_Distances &gt; 2.625"> <VRPTx:distance_cutoff_high xsi:nil="true" /> <VRPTx:distance_cutoff_low>2.625</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_Peptide Planes"> <VRPTx:distance_cutoff_high xsi:nil="true" /> <VRPTx:distance_cutoff_low xsi:nil="true" /> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_Ring and other planes"> <VRPTx:distance_cutoff_high xsi:nil="true" /> <VRPTx:distance_cutoff_low xsi:nil="true" /> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist 1.2-1.4"> <VRPTx:distance_cutoff_high>1.4</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>1.2</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist 1.4-1.6"> <VRPTx:distance_cutoff_high>1.6</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>1.4</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist 1.8-2.0"> <VRPTx:distance_cutoff_high>2.0</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>1.8</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist 2.0-2.2"> <VRPTx:distance_cutoff_high>2.2</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>2.0</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist 2.2-2.4"> <VRPTx:distance_cutoff_high>2.4</VRPTx:distance_cutoff_high> <VRPTx:distance_cutoff_low>2.2</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> <VRPTx:refine_ls_restr_type type="RESTRAIN_rms diffs for Uiso atoms at dist &gt;2.4"> <VRPTx:distance_cutoff_high xsi:nil="true" /> <VRPTx:distance_cutoff_low>2.4</VRPTx:distance_cutoff_low> </VRPTx:refine_ls_restr_type> </VRPTx:refine_ls_restr_typeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_ls_restr_type.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_ls_restr_type (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	distance_cutoff_high DECIMAL CHECK ( distance_cutoff_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	distance_cutoff_low DECIMAL CHECK ( distance_cutoff_low >= 0.0 ) ,
-- ATTRIBUTE
	type TEXT NOT NULL
);

--
-- (quoted from refine_ls_shellType)
-- Data items in the REFINE_LS_SHELL category record details about the results of the least-squares refinement broken down into shells of resolution. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refine_ls_shellCategory> <VRPTx:refine_ls_shell d_res_high="4.51" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.196</VRPTx:R_factor_obs> <VRPTx:d_res_low>8.00</VRPTx:d_res_low> <VRPTx:number_reflns_obs>1226</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="3.48" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.146</VRPTx:R_factor_obs> <VRPTx:d_res_low>4.51</VRPTx:d_res_low> <VRPTx:number_reflns_obs>1679</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="2.94" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.160</VRPTx:R_factor_obs> <VRPTx:d_res_low>3.48</VRPTx:d_res_low> <VRPTx:number_reflns_obs>2014</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="2.59" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.182</VRPTx:R_factor_obs> <VRPTx:d_res_low>2.94</VRPTx:d_res_low> <VRPTx:number_reflns_obs>2147</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="2.34" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.193</VRPTx:R_factor_obs> <VRPTx:d_res_low>2.59</VRPTx:d_res_low> <VRPTx:number_reflns_obs>2127</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="2.15" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.203</VRPTx:R_factor_obs> <VRPTx:d_res_low>2.34</VRPTx:d_res_low> <VRPTx:number_reflns_obs>2061</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> <VRPTx:refine_ls_shell d_res_high="2.00" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:R_factor_obs>0.188</VRPTx:R_factor_obs> <VRPTx:d_res_low>2.15</VRPTx:d_res_low> <VRPTx:number_reflns_obs>1647</VRPTx:number_reflns_obs> </VRPTx:refine_ls_shell> </VRPTx:refine_ls_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_ls_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refine_ls_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_R_free" DECIMAL CHECK ( "R_factor_R_free" >= 0.0 ) ,
	"R_factor_R_free_error" DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_R_work" DECIMAL CHECK ( "R_factor_R_work" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_all" DECIMAL CHECK ( "R_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_obs" DECIMAL CHECK ( "R_factor_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"number_reflns_R_free" INTEGER CHECK ( "number_reflns_R_free" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	"number_reflns_R_work" INTEGER CHECK ( "number_reflns_R_work" >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_reflns_all INTEGER CHECK ( number_reflns_all >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_reflns_obs INTEGER CHECK ( number_reflns_obs >= 0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_R_complete" DECIMAL CHECK ( "pdbx_R_complete" >= 0.0 AND "pdbx_R_complete" <= 1.0 ) ,
	pdbx_fsc_free DECIMAL ,
	pdbx_fsc_work DECIMAL ,
	pdbx_phase_error DECIMAL ,
	pdbx_total_number_of_bins_used INTEGER ,
	"percent_reflns_R_free" DECIMAL ,
	percent_reflns_obs DECIMAL ,
	redundancy_reflns_all DECIMAL ,
	redundancy_reflns_obs DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_R_free" DECIMAL CHECK ( "wR_factor_R_free" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_R_work" DECIMAL CHECK ( "wR_factor_R_work" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_all" DECIMAL CHECK ( "wR_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_obs" DECIMAL CHECK ( "wR_factor_obs" >= 0.0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from refine_occupancyType)
-- Data items in the REFINE_OCCUPANCY category record details about the treatment of atom occupancies during refinement. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:refine_occupancyCategory> <VRPTx:refine_occupancy class="protein" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:details xsi:nil="true" /> <VRPTx:treatment>fix</VRPTx:treatment> <VRPTx:value>1.00</VRPTx:value> </VRPTx:refine_occupancy> <VRPTx:refine_occupancy class="solvent" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:details xsi:nil="true" /> <VRPTx:treatment>fix</VRPTx:treatment> <VRPTx:value>1.00</VRPTx:value> </VRPTx:refine_occupancy> <VRPTx:refine_occupancy class="inhibitor orientation 1" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:details xsi:nil="true" /> <VRPTx:treatment>fix</VRPTx:treatment> <VRPTx:value>0.65</VRPTx:value> </VRPTx:refine_occupancy> <VRPTx:refine_occupancy class="inhibitor orientation 2" pdbx_refine_id="X-RAY DIFFRACTION"> <VRPTx:details> The inhibitor binds to the enzyme in two alternative conformations. The occupancy of each conformation was adjusted so as to result in approximately equal mean thermal factors for the atoms in each conformation.</VRPTx:details> <VRPTx:treatment>fix</VRPTx:treatment> <VRPTx:value>0.35</VRPTx:value> </VRPTx:refine_occupancy> </VRPTx:refine_occupancyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refine_occupancy.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_refine_occupancy_treatment CASCADE;
CREATE TYPE ENUM_refine_occupancy_treatment AS ENUM ( 'fix', 'ref' );
CREATE TABLE refine_occupancy (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	treatment ENUM_refine_occupancy_treatment ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	value DECIMAL CHECK ( value >= 0.0 AND value <= 1.0 ) ,
-- ATTRIBUTE
	class TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_refine_id TEXT NOT NULL
);

--
-- (quoted from reflnType)
-- Data items in the REFLN category record details about the reflection data used to determine the ATOM_SITE data items. The REFLN data items refer to individual reflections and must be included in looped lists. The REFLNS data items specify the parameters that apply to all reflections. The REFLNS data items are not looped. Example 1 - based on data set fetod of Todres, Yanovsky, Ermekov & Struchkov [Acta Cryst. (1993), C49, 1352-1354]. <VRPTx:reflnCategory> <VRPTx:refln index_h="2" index_k="0" index_l="0"> <VRPTx:F_squared_calc>85.57</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>58.90</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>1.45</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="3" index_k="0" index_l="0"> <VRPTx:F_squared_calc>15718.18</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>15631.06</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>30.40</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="4" index_k="0" index_l="0"> <VRPTx:F_squared_calc>55613.11</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>49840.09</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>61.86</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="5" index_k="0" index_l="0"> <VRPTx:F_squared_calc>246.85</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>241.86</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>10.02</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="6" index_k="0" index_l="0"> <VRPTx:F_squared_calc>82.16</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>69.97</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>1.93</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="7" index_k="0" index_l="0"> <VRPTx:F_squared_calc>1133.62</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>947.79</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>11.78</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="8" index_k="0" index_l="0"> <VRPTx:F_squared_calc>2558.04</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>2453.33</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>20.44</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="9" index_k="0" index_l="0"> <VRPTx:F_squared_calc>283.88</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>393.66</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>7.79</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> <VRPTx:refln index_h="10" index_k="0" index_l="0"> <VRPTx:F_squared_calc>283.70</VRPTx:F_squared_calc> <VRPTx:F_squared_meas>171.98</VRPTx:F_squared_meas> <VRPTx:F_squared_sigma>4.26</VRPTx:F_squared_sigma> <VRPTx:status>o</VRPTx:status> </VRPTx:refln> </VRPTx:reflnCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refln.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_refln_include_status CASCADE;
CREATE TYPE ENUM_refln_include_status AS ENUM ( 'o', '<', '-', 'x', 'h', 'l' );
DROP TYPE IF EXISTS ENUM_refln_pdbx_signal_status CASCADE;
CREATE TYPE ENUM_refln_pdbx_signal_status AS ENUM ( 'm', 'o', 'u' );
DROP TYPE IF EXISTS ENUM_refln_refinement_status CASCADE;
CREATE TYPE ENUM_refln_refinement_status AS ENUM ( 'incl', 'excl', 'extn' );
DROP TYPE IF EXISTS ENUM_refln_status CASCADE;
CREATE TYPE ENUM_refln_status AS ENUM ( 'o', '<', '-', 'x', 'h', 'l', 'f' );
CREATE TABLE refln (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="electrons"
	"A_calc" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"A_calc_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"A_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"A_meas_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"B_calc" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"B_calc_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"B_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"B_meas_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_calc" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_calc_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons"
	"F_meas_sigma" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"F_meas_sigma_au" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_squared"
	"F_squared_calc" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_squared"
	"F_squared_meas" DECIMAL ,
-- omit an attribute having a fixed value: @units="electrons_squared"
	"F_squared_sigma" DECIMAL ,
	class_code TEXT ,
	crystal_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_spacing DECIMAL CHECK ( d_spacing >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	fom DECIMAL CHECK ( fom >= 0.0 ) ,
	include_status ENUM_refln_include_status ,
	intensity_calc DECIMAL ,
	intensity_meas DECIMAL ,
	intensity_sigma DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	mean_path_length_tbar DECIMAL CHECK ( mean_path_length_tbar >= 0.0 ) ,
	"pdbx_DELFWT" DECIMAL ,
	"pdbx_DELPHWT" DECIMAL ,
	"pdbx_FWT" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"pdbx_F_calc_part_solvent" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"pdbx_F_calc_with_solvent" DECIMAL ,
	"pdbx_F_minus" DECIMAL ,
	"pdbx_F_minus_sigma" DECIMAL ,
	"pdbx_F_plus" DECIMAL ,
	"pdbx_F_plus_sigma" DECIMAL ,
	"pdbx_HL_A_iso" DECIMAL ,
	"pdbx_HL_B_iso" DECIMAL ,
	"pdbx_HL_C_iso" DECIMAL ,
	"pdbx_HL_D_iso" DECIMAL ,
	"pdbx_I_minus" DECIMAL ,
	"pdbx_I_minus_sigma" DECIMAL ,
	"pdbx_I_plus" DECIMAL ,
	"pdbx_I_plus_sigma" DECIMAL ,
	"pdbx_PHWT" DECIMAL ,
	pdbx_anom_difference DECIMAL ,
	pdbx_anom_difference_sigma DECIMAL ,
	pdbx_diffrn_id TEXT ,
	"pdbx_fiber_F_meas_au" DECIMAL ,
	pdbx_fiber_coordinate DECIMAL ,
	pdbx_fiber_layer INTEGER ,
-- omit an attribute having a fixed value: @units="degrees"
	pdbx_phase_calc_part_solvent DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	pdbx_phase_calc_with_solvent DECIMAL ,
	pdbx_r_free_flag INTEGER ,
	pdbx_signal DECIMAL ,
	pdbx_signal_status ENUM_refln_pdbx_signal_status ,
-- omit an attribute having a fixed value: @units="degrees"
	phase_calc DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	phase_meas DECIMAL ,
	refinement_status ENUM_refln_refinement_status ,
	scale_group_code TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	sint_over_lambda DECIMAL CHECK ( sint_over_lambda >= 0.0 ) ,
	status ENUM_refln_status ,
-- xsd:restriction/xsd:maxInclusive="48"
-- xsd:restriction/xsd:minInclusive="1"
	symmetry_epsilon INTEGER CHECK ( symmetry_epsilon >= 1 AND symmetry_epsilon <= 48 ) ,
-- xsd:restriction/xsd:maxInclusive="48"
-- xsd:restriction/xsd:minInclusive="1"
	symmetry_multiplicity INTEGER CHECK ( symmetry_multiplicity >= 1 AND symmetry_multiplicity <= 48 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	wavelength DECIMAL CHECK ( wavelength >= 0.0 ) ,
	wavelength_id TEXT ,
-- ATTRIBUTE
	index_h INTEGER NOT NULL ,
-- ATTRIBUTE
	index_k INTEGER NOT NULL ,
-- ATTRIBUTE
	index_l INTEGER NOT NULL
);

--
-- (quoted from refln_sys_absType)
-- Data items in the REFLN_SYS_ABS category record details about the reflection data that should be systematically absent, given the designated space group. Example 1 - hypothetical example. <VRPTx:refln_sys_absCategory> <VRPTx:refln_sys_abs index_h="0" index_k="3" index_l="0"> <VRPTx:I>28.32</VRPTx:I> <VRPTx:I_over_sigmaI>1.23</VRPTx:I_over_sigmaI> <VRPTx:sigmaI>22.95</VRPTx:sigmaI> </VRPTx:refln_sys_abs> <VRPTx:refln_sys_abs index_h="0" index_k="5" index_l="0"> <VRPTx:I>14.11</VRPTx:I> <VRPTx:I_over_sigmaI>0.86</VRPTx:I_over_sigmaI> <VRPTx:sigmaI>16.38</VRPTx:sigmaI> </VRPTx:refln_sys_abs> <VRPTx:refln_sys_abs index_h="0" index_k="7" index_l="0"> <VRPTx:I>114.81</VRPTx:I> <VRPTx:I_over_sigmaI>5.67</VRPTx:I_over_sigmaI> <VRPTx:sigmaI>20.22</VRPTx:sigmaI> </VRPTx:refln_sys_abs> <VRPTx:refln_sys_abs index_h="0" index_k="9" index_l="0"> <VRPTx:I>32.99</VRPTx:I> <VRPTx:I_over_sigmaI>1.35</VRPTx:I_over_sigmaI> <VRPTx:sigmaI>24.51</VRPTx:sigmaI> </VRPTx:refln_sys_abs> </VRPTx:refln_sys_absCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/refln_sys_abs.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE refln_sys_abs (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"I" DECIMAL ,
	"I_over_sigmaI" DECIMAL ,
-- omit an attribute having a fixed value: @units="arbitrary"
	"sigmaI" DECIMAL ,
-- ATTRIBUTE
	index_h INTEGER NOT NULL ,
-- ATTRIBUTE
	index_k INTEGER NOT NULL ,
-- ATTRIBUTE
	index_l INTEGER NOT NULL
);

--
-- (quoted from reflnsType)
-- Data items in the REFLNS category record details about the reflection data used to determine the ATOM_SITE data items. The REFLN data items refer to individual reflections and must be included in looped lists. The REFLNS data items specify the parameters that apply to all reflections. The REFLNS data items are not looped. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:reflnsCategory> <VRPTx:reflns pdbx_ordinal="1"> <VRPTx:d_resolution_high>2.00</VRPTx:d_resolution_high> <VRPTx:d_resolution_low>8.00</VRPTx:d_resolution_low> <VRPTx:data_reduction_details> Merging and scaling based on only those reflections with I &gt; \s(I).</VRPTx:data_reduction_details> <VRPTx:data_reduction_method> Xengen program scalei. Anomalous pairs were merged. Scaling proceeded in several passes, beginning with 1-parameter fit and ending with 3-parameter fit.</VRPTx:data_reduction_method> <VRPTx:details>none</VRPTx:details> <VRPTx:entry_id>5HVP</VRPTx:entry_id> <VRPTx:limit_h_max>22</VRPTx:limit_h_max> <VRPTx:limit_h_min>0</VRPTx:limit_h_min> <VRPTx:limit_k_max>46</VRPTx:limit_k_max> <VRPTx:limit_k_min>0</VRPTx:limit_k_min> <VRPTx:limit_l_max>57</VRPTx:limit_l_max> <VRPTx:limit_l_min>0</VRPTx:limit_l_min> <VRPTx:number_obs>7228</VRPTx:number_obs> <VRPTx:observed_criterion>&gt; 1 \s(I)</VRPTx:observed_criterion> <VRPTx:pdbx_diffrn_id>1</VRPTx:pdbx_diffrn_id> </VRPTx:reflns> </VRPTx:reflnsCategory> Example 2 - based on data set TOZ of Willis, Beckwith & Tozer [Acta Cryst. (1991), C47, 2276-2277]. <VRPTx:reflnsCategory> <VRPTx:reflns pdbx_ordinal="1"> <VRPTx:d_resolution_high>0.8733</VRPTx:d_resolution_high> <VRPTx:d_resolution_low>11.9202</VRPTx:d_resolution_low> <VRPTx:entry_id>1TOZ</VRPTx:entry_id> <VRPTx:limit_h_max>6</VRPTx:limit_h_max> <VRPTx:limit_h_min>0</VRPTx:limit_h_min> <VRPTx:limit_k_max>17</VRPTx:limit_k_max> <VRPTx:limit_k_min>0</VRPTx:limit_k_min> <VRPTx:limit_l_max>22</VRPTx:limit_l_max> <VRPTx:limit_l_min>0</VRPTx:limit_l_min> <VRPTx:number_all>1592</VRPTx:number_all> <VRPTx:number_obs>1408</VRPTx:number_obs> <VRPTx:observed_criterion>F_&gt;_6.0_\s(F)</VRPTx:observed_criterion> <VRPTx:pdbx_diffrn_id>1</VRPTx:pdbx_diffrn_id> </VRPTx:reflns> </VRPTx:reflnsCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/reflns.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_reflns_pdbx_orthogonalization_convention CASCADE;
CREATE TYPE ENUM_reflns_pdbx_orthogonalization_convention AS ENUM ( 'pdb' );
DROP TYPE IF EXISTS ENUM_reflns_pdbx_signal_type CASCADE;
CREATE TYPE ENUM_reflns_pdbx_signal_type AS ENUM ( 'local <I/sigmaI>', 'local wCC_half' );
CREATE TABLE reflns (
-- omit an attribute having a fixed value: @units="angstroms_squared"
	"B_iso_Wilson_estimate" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"Friedel_coverage" DECIMAL CHECK ( "Friedel_coverage" >= 0.0 AND "Friedel_coverage" <= 1.0 ) ,
	"R_free_details" TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_F_all" DECIMAL CHECK ( "Rmerge_F_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_F_obs" DECIMAL CHECK ( "Rmerge_F_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_resolution_high DECIMAL CHECK ( d_resolution_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_resolution_low DECIMAL CHECK ( d_resolution_low >= 0.0 ) ,
	data_reduction_details TEXT ,
	data_reduction_method TEXT ,
	details TEXT ,
-- IN-PLACE DOCUMENT KEY
	entry_id TEXT ,
	limit_h_max INTEGER ,
	limit_h_min INTEGER ,
	limit_k_max INTEGER ,
	limit_k_min INTEGER ,
	limit_l_max INTEGER ,
	limit_l_min INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number_all INTEGER CHECK ( number_all >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_gt INTEGER CHECK ( number_gt >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_obs INTEGER CHECK ( number_obs >= 0 ) ,
	observed_criterion TEXT ,
	"observed_criterion_F_max" DECIMAL ,
	"observed_criterion_F_min" DECIMAL ,
	"observed_criterion_I_max" DECIMAL ,
	"observed_criterion_I_min" DECIMAL ,
	"observed_criterion_sigma_F" DECIMAL ,
	"observed_criterion_sigma_I" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="1"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_CC_half" DECIMAL CHECK ( "pdbx_CC_half" >= 0 AND "pdbx_CC_half" <= 1 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_CC_half_anomalous" DECIMAL CHECK ( "pdbx_CC_half_anomalous" >= -1.0 AND "pdbx_CC_half_anomalous" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_CC_star" DECIMAL CHECK ( "pdbx_CC_star" >= 0 AND "pdbx_CC_star" <= 1 ) ,
-- xsd:restriction/xsd:maxInclusive="2"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_R_split" DECIMAL CHECK ( "pdbx_R_split" >= 0 AND "pdbx_R_split" <= 2 ) ,
	"pdbx_Rmerge_I_all" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="10.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rmerge_I_obs" DECIMAL CHECK ( "pdbx_Rmerge_I_obs" >= 0.0 AND "pdbx_Rmerge_I_obs" <= 10.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rpim_I_all" DECIMAL CHECK ( "pdbx_Rpim_I_all" >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="5.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rrim_I_all" DECIMAL CHECK ( "pdbx_Rrim_I_all" >= 0.0 AND "pdbx_Rrim_I_all" <= 5.0 ) ,
	"pdbx_Rsym_value" DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_absDiff_over_sigma_anomalous" DECIMAL CHECK ( "pdbx_absDiff_over_sigma_anomalous" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_aniso_B_tensor_eigenvalue_1" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvalue_1" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_aniso_B_tensor_eigenvalue_2" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvalue_2" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_aniso_B_tensor_eigenvalue_3" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvalue_3" >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_1_ortho1" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_1_ortho1" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_1_ortho1" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_1_ortho2" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_1_ortho2" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_1_ortho2" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_1_ortho3" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_1_ortho3" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_1_ortho3" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_2_ortho1" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_2_ortho1" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_2_ortho1" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_2_ortho2" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_2_ortho2" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_2_ortho2" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_2_ortho3" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_2_ortho3" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_2_ortho3" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_3_ortho1" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_3_ortho1" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_3_ortho1" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_3_ortho2" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_3_ortho2" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_3_ortho2" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_aniso_B_tensor_eigenvector_3_ortho3" DECIMAL CHECK ( "pdbx_aniso_B_tensor_eigenvector_3_ortho3" >= -1.0 AND "pdbx_aniso_B_tensor_eigenvector_3_ortho3" <= 1.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_aniso_diffraction_limit_1 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_1 >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_aniso_diffraction_limit_2 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_2 >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_aniso_diffraction_limit_3 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_3 >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_1_ortho1 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_1_ortho1 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_1_ortho1 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_1_ortho2 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_1_ortho2 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_1_ortho2 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_1_ortho3 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_1_ortho3 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_1_ortho3 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_2_ortho1 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_2_ortho1 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_2_ortho1 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_2_ortho2 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_2_ortho2 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_2_ortho2 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_2_ortho3 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_2_ortho3 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_2_ortho3 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_3_ortho1 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_3_ortho1 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_3_ortho1 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_3_ortho2 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_3_ortho2 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_3_ortho2 <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	pdbx_aniso_diffraction_limit_axis_3_ortho3 DECIMAL CHECK ( pdbx_aniso_diffraction_limit_axis_3_ortho3 >= -1.0 AND pdbx_aniso_diffraction_limit_axis_3_ortho3 <= 1.0 ) ,
	pdbx_chi_squared DECIMAL ,
	pdbx_d_opt DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_d_res_high_opt DECIMAL CHECK ( pdbx_d_res_high_opt >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_d_res_low_opt DECIMAL CHECK ( pdbx_d_res_low_opt >= 0.0 ) ,
	pdbx_d_res_opt_method TEXT ,
	pdbx_diffrn_id TEXT ,
	"pdbx_netI_over_av_sigmaI" DECIMAL ,
	"pdbx_netI_over_sigmaI" DECIMAL ,
-- xsd:restriction/xsd:minInclusive="0"
	pdbx_number_measured_all INTEGER CHECK ( pdbx_number_measured_all >= 0 ) ,
	pdbx_observed_signal_threshold DECIMAL ,
	pdbx_orthogonalization_convention ENUM_reflns_pdbx_orthogonalization_convention ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_anomalous DECIMAL CHECK ( pdbx_percent_possible_anomalous >= 0.0 AND pdbx_percent_possible_anomalous <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_ellipsoidal DECIMAL CHECK ( pdbx_percent_possible_ellipsoidal >= 0.0 AND pdbx_percent_possible_ellipsoidal <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_ellipsoidal_anomalous DECIMAL CHECK ( pdbx_percent_possible_ellipsoidal_anomalous >= 0.0 AND pdbx_percent_possible_ellipsoidal_anomalous <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_spherical DECIMAL CHECK ( pdbx_percent_possible_spherical >= 0.0 AND pdbx_percent_possible_spherical <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_spherical_anomalous DECIMAL CHECK ( pdbx_percent_possible_spherical_anomalous >= 0.0 AND pdbx_percent_possible_spherical_anomalous <= 100.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_redundancy DECIMAL CHECK ( pdbx_redundancy >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="1.0"
	pdbx_redundancy_anomalous DECIMAL CHECK ( pdbx_redundancy_anomalous >= 1.0 ) ,
-- omit an attribute having a fixed value: @units="angstroms"
	"pdbx_res_netI_over_av_sigmaI_2" DECIMAL ,
-- omit an attribute having a fixed value: @units="angstroms"
	"pdbx_res_netI_over_sigmaI_2" DECIMAL ,
	pdbx_scaling_rejects INTEGER ,
	pdbx_signal_details TEXT ,
	pdbx_signal_software_id TEXT ,
	pdbx_signal_type ENUM_reflns_pdbx_signal_type ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_possible_obs DECIMAL CHECK ( percent_possible_obs >= 0.0 AND percent_possible_obs <= 100.0 ) ,
	phase_calculation_details TEXT ,
	threshold_expression TEXT ,
-- ATTRIBUTE
	pdbx_ordinal INTEGER NOT NULL
);

--
-- (quoted from reflns_classType)
-- Data items in the REFLNS_CLASS category record details of the reflections used to determine the structural parameters for each reflection class. Example 1 - example corresponding to the one-dimensional incommensurately modulated structure of K~2~SeO~4~. <VRPTx:reflns_classCategory> <VRPTx:reflns_class code="Main"> <VRPTx:number_gt>584</VRPTx:number_gt> </VRPTx:reflns_class> <VRPTx:reflns_class code="Sat1"> <VRPTx:number_gt>226</VRPTx:number_gt> </VRPTx:reflns_class> <VRPTx:reflns_class code="Sat2"> <VRPTx:number_gt>50</VRPTx:number_gt> </VRPTx:reflns_class> </VRPTx:reflns_classCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/reflns_class.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE reflns_class (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_Fsqd_factor" DECIMAL CHECK ( "R_Fsqd_factor" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_I_factor" DECIMAL CHECK ( "R_I_factor" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_all" DECIMAL CHECK ( "R_factor_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"R_factor_gt" DECIMAL CHECK ( "R_factor_gt" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	description TEXT ,
-- xsd:restriction/xsd:minInclusive="0"
	number_gt INTEGER CHECK ( number_gt >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0"
	number_total INTEGER CHECK ( number_total >= 0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"wR_factor_all" DECIMAL CHECK ( "wR_factor_all" >= 0.0 ) ,
-- ATTRIBUTE
	code TEXT NOT NULL
);

--
-- (quoted from reflns_scaleType)
-- Data items in the REFLNS_SCALE category record details about the structure-factor scales. They are referenced from within the REFLN list through attribute scale_group_code in category refln. Example 1 - based on laboratory records for the collagen-like peptide [(POG)4 EKG (POG)5]3. <VRPTx:reflns_scaleCategory> <VRPTx:reflns_scale group_code="SG1"> <VRPTx:meas_F>4.0</VRPTx:meas_F> </VRPTx:reflns_scale> </VRPTx:reflns_scaleCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/reflns_scale.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE reflns_scale (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"meas_F" DECIMAL CHECK ( "meas_F" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"meas_F_squared" DECIMAL CHECK ( "meas_F_squared" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	meas_intensity DECIMAL CHECK ( meas_intensity >= 0.0 ) ,
-- ATTRIBUTE
	group_code TEXT NOT NULL
);

--
-- (quoted from reflns_shellType)
-- Data items in the REFLNS_SHELL category record details about the reflection data used to determine the ATOM_SITE data items broken down into shells of resolution. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:reflns_shellCategory> <VRPTx:reflns_shell pdbx_ordinal="1"> <VRPTx:Rmerge_F_obs>1.98</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>31.38</VRPTx:d_res_high> <VRPTx:d_res_low>3.82</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>69.8</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>9024</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>2540</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>96.8</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> <VRPTx:reflns_shell pdbx_ordinal="2"> <VRPTx:Rmerge_F_obs>3.85</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>3.82</VRPTx:d_res_high> <VRPTx:d_res_low>3.03</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>26.1</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>7413</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>2364</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>95.1</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> <VRPTx:reflns_shell pdbx_ordinal="3"> <VRPTx:Rmerge_F_obs>6.37</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>3.03</VRPTx:d_res_high> <VRPTx:d_res_low>2.65</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>10.5</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>5640</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>2123</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>86.2</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> <VRPTx:reflns_shell pdbx_ordinal="4"> <VRPTx:Rmerge_F_obs>8.01</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>2.65</VRPTx:d_res_high> <VRPTx:d_res_low>2.41</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>6.4</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>4322</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>1882</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>76.8</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> <VRPTx:reflns_shell pdbx_ordinal="5"> <VRPTx:Rmerge_F_obs>9.86</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>2.41</VRPTx:d_res_high> <VRPTx:d_res_low>2.23</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>4.3</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>3247</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>1714</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>70.4</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> <VRPTx:reflns_shell pdbx_ordinal="6"> <VRPTx:Rmerge_F_obs>13.99</VRPTx:Rmerge_F_obs> <VRPTx:d_res_high>2.23</VRPTx:d_res_high> <VRPTx:d_res_low>2.10</VRPTx:d_res_low> <VRPTx:meanI_over_sigI_obs>3.1</VRPTx:meanI_over_sigI_obs> <VRPTx:number_measured_obs>1140</VRPTx:number_measured_obs> <VRPTx:number_unique_obs>812</VRPTx:number_unique_obs> <VRPTx:percent_possible_obs>33.3</VRPTx:percent_possible_obs> </VRPTx:reflns_shell> </VRPTx:reflns_shellCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/reflns_shell.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE reflns_shell (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_F_all" DECIMAL CHECK ( "Rmerge_F_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_F_gt" DECIMAL CHECK ( "Rmerge_F_gt" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_F_obs" DECIMAL CHECK ( "Rmerge_F_obs" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_I_all" DECIMAL CHECK ( "Rmerge_I_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_I_gt" DECIMAL CHECK ( "Rmerge_I_gt" >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="145.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	"Rmerge_I_obs" DECIMAL CHECK ( "Rmerge_I_obs" >= 0.0 AND "Rmerge_I_obs" <= 145.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_high DECIMAL CHECK ( d_res_high >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	d_res_low DECIMAL CHECK ( d_res_low >= 0.0 ) ,
	"meanI_over_sigI_all" DECIMAL ,
	"meanI_over_sigI_gt" DECIMAL ,
	"meanI_over_sigI_obs" DECIMAL ,
	"meanI_over_uI_all" DECIMAL ,
	"meanI_over_uI_gt" DECIMAL ,
	number_measured_all INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number_measured_gt INTEGER CHECK ( number_measured_gt >= 0 ) ,
	number_measured_obs INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number_possible INTEGER CHECK ( number_possible >= 0 ) ,
	number_unique_all INTEGER ,
-- xsd:restriction/xsd:minInclusive="0"
	number_unique_gt INTEGER CHECK ( number_unique_gt >= 0 ) ,
	number_unique_obs INTEGER ,
-- xsd:restriction/xsd:maxInclusive="1"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_CC_half" DECIMAL CHECK ( "pdbx_CC_half" >= 0 AND "pdbx_CC_half" <= 1 ) ,
-- xsd:restriction/xsd:maxInclusive="1.0"
-- xsd:restriction/xsd:minInclusive="-1.0"
	"pdbx_CC_half_anomalous" DECIMAL CHECK ( "pdbx_CC_half_anomalous" >= -1.0 AND "pdbx_CC_half_anomalous" <= 1.0 ) ,
-- xsd:restriction/xsd:maxInclusive="1"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_CC_star" DECIMAL CHECK ( "pdbx_CC_star" >= 0 AND "pdbx_CC_star" <= 1 ) ,
-- xsd:restriction/xsd:maxInclusive="10"
-- xsd:restriction/xsd:minInclusive="0"
	"pdbx_R_split" DECIMAL CHECK ( "pdbx_R_split" >= 0 AND "pdbx_R_split" <= 10 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rpim_I_all" DECIMAL CHECK ( "pdbx_Rpim_I_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rrim_I_all" DECIMAL CHECK ( "pdbx_Rrim_I_all" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_Rsym_value" DECIMAL CHECK ( "pdbx_Rsym_value" >= 0.0 ) ,
-- xsd:restriction/xsd:minInclusive="0.0"
	"pdbx_absDiff_over_sigma_anomalous" DECIMAL CHECK ( "pdbx_absDiff_over_sigma_anomalous" >= 0.0 ) ,
	pdbx_chi_squared DECIMAL ,
	pdbx_diffrn_id TEXT ,
	"pdbx_netI_over_sigmaI_all" DECIMAL ,
	"pdbx_netI_over_sigmaI_obs" DECIMAL ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_anomalous DECIMAL CHECK ( pdbx_percent_possible_anomalous >= 0.0 AND pdbx_percent_possible_anomalous <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_ellipsoidal DECIMAL CHECK ( pdbx_percent_possible_ellipsoidal >= 0.0 AND pdbx_percent_possible_ellipsoidal <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_ellipsoidal_anomalous DECIMAL CHECK ( pdbx_percent_possible_ellipsoidal_anomalous >= 0.0 AND pdbx_percent_possible_ellipsoidal_anomalous <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_spherical DECIMAL CHECK ( pdbx_percent_possible_spherical >= 0.0 AND pdbx_percent_possible_spherical <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	pdbx_percent_possible_spherical_anomalous DECIMAL CHECK ( pdbx_percent_possible_spherical_anomalous >= 0.0 AND pdbx_percent_possible_spherical_anomalous <= 100.0 ) ,
	pdbx_redundancy DECIMAL ,
-- xsd:restriction/xsd:minInclusive="1.0"
	pdbx_redundancy_anomalous DECIMAL CHECK ( pdbx_redundancy_anomalous >= 1.0 ) ,
	pdbx_rejects INTEGER ,
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_possible_all DECIMAL CHECK ( percent_possible_all >= 0.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_possible_gt DECIMAL CHECK ( percent_possible_gt >= 0.0 AND percent_possible_gt <= 100.0 ) ,
-- xsd:restriction/xsd:maxInclusive="100.0"
-- xsd:restriction/xsd:minInclusive="0.0"
	percent_possible_obs DECIMAL CHECK ( percent_possible_obs >= 0.0 AND percent_possible_obs <= 100.0 ) ,
-- ATTRIBUTE
	pdbx_ordinal INTEGER NOT NULL
);

--
-- (quoted from space_groupType)
-- Contains all the data items that refer to the space group as a whole, such as its name or crystal system. They may be looped, for example, in a list of space groups and their properties. Only a subset of the SPACE_GROUP category items appear in this dictionary. The remainder are found in the symmetry CIF dictionary. Space-group types are identified by their number as given in International Tables for Crystallography Vol. A. Specific settings of the space groups can be identified either by their Hall symbol or by specifying their symmetry operations. The commonly used Hermann-Mauguin symbol determines the space-group type uniquely but several different Hermann-Mauguin symbols may refer to the same space-group type. A Hermann-Mauguin symbol contains information on the choice of the basis, but not on the choice of origin. Different formats for the Hermann-Mauguin symbol are found in the symmetry CIF dictionary. Example 1 - the monoclinic space group No. 15 with unique axis b. <VRPTx:space_groupCategory> <VRPTx:space_group id="1"> <VRPTx:IT_number>15</VRPTx:IT_number> <VRPTx:crystal_system>monoclinic</VRPTx:crystal_system> <VRPTx:name_H-M_alt>C 2/c</VRPTx:name_H-M_alt> <VRPTx:name_Hall>-C 2yc</VRPTx:name_Hall> </VRPTx:space_group> </VRPTx:space_groupCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/space_group.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_space_group_crystal_system CASCADE;
CREATE TYPE ENUM_space_group_crystal_system AS ENUM ( 'triclinic', 'monoclinic', 'orthorhombic', 'tetragonal', 'trigonal', 'hexagonal', 'cubic' );
CREATE TABLE space_group (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- xsd:restriction/xsd:maxInclusive="230"
-- xsd:restriction/xsd:minInclusive="1"
	"IT_number" INTEGER CHECK ( "IT_number" >= 1 AND "IT_number" <= 230 ) ,
	crystal_system ENUM_space_group_crystal_system ,
	"name_H-M_alt" TEXT ,
	"name_Hall" TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from space_group_symopType)
-- Contains information about the symmetry operations of the space group. Example 1 - The symmetry operations for the space group P21/c. <VRPTx:space_group_symopCategory> <VRPTx:space_group_symop id="1"> <VRPTx:operation_xyz>x,y,z</VRPTx:operation_xyz> </VRPTx:space_group_symop> <VRPTx:space_group_symop id="2"> <VRPTx:operation_xyz>-x,-y,-z</VRPTx:operation_xyz> </VRPTx:space_group_symop> <VRPTx:space_group_symop id="3"> <VRPTx:operation_xyz>-x,1/2+y,1/2-z</VRPTx:operation_xyz> </VRPTx:space_group_symop> <VRPTx:space_group_symop id="4"> <VRPTx:operation_xyz>x,1/2-y,1/2+z</VRPTx:operation_xyz> </VRPTx:space_group_symop> </VRPTx:space_group_symopCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/space_group_symop.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE space_group_symop (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	operation_xyz TEXT ,
	sg_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from structType)
-- Data items in the STRUCT category record details about the description of the crystallographic structure. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:structCategory> <VRPTx:struct entry_id="5HVP"> <VRPTx:title> HIV-1 protease complex with acetyl-pepstatin</VRPTx:title> </VRPTx:struct> </VRPTx:structCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_pdbx_CASP_flag CASCADE;
CREATE TYPE ENUM_struct_pdbx_CASP_flag AS ENUM ( 'Y', 'N' );
DROP TYPE IF EXISTS ENUM_struct_pdbx_structure_determination_methodology CASCADE;
CREATE TYPE ENUM_struct_pdbx_structure_determination_methodology AS ENUM ( 'experimental', 'integrative', 'computational' );
CREATE TABLE struct (
	"pdbx_CASP_flag" ENUM_struct_pdbx_CASP_flag ,
	pdbx_descriptor TEXT ,
-- xsd:restriction/xsd:minInclusive="1.0"
	pdbx_formula_weight DECIMAL CHECK ( pdbx_formula_weight >= 1.0 ) ,
	pdbx_formula_weight_method TEXT ,
	pdbx_model_details TEXT ,
	pdbx_model_type_details TEXT ,
	pdbx_structure_determination_methodology ENUM_struct_pdbx_structure_determination_methodology ,
	title TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from struct_biol_viewType)
-- Data items in the STRUCT_BIOL_VIEW category record details about how to draw and annotate an informative view of the biological structure. Example 1 - based on NDB structure GDL001 by Coll, Aymami, Van Der Marel, Van Boom, Rich & Wang [Biochemistry, (1989), 28, 310-320]. <VRPTx:struct_biol_viewCategory> <VRPTx:struct_biol_view biol_id="c1" id="1"> <VRPTx:details> This view highlights the ATAT-Netropsin interaction in the DNA-drug complex.</VRPTx:details> <VRPTx:rot_matrix11>0.132</VRPTx:rot_matrix11> <VRPTx:rot_matrix12>0.922</VRPTx:rot_matrix12> <VRPTx:rot_matrix13>-0.363</VRPTx:rot_matrix13> <VRPTx:rot_matrix21>0.131</VRPTx:rot_matrix21> <VRPTx:rot_matrix22>-0.380</VRPTx:rot_matrix22> <VRPTx:rot_matrix23>-0.916</VRPTx:rot_matrix23> <VRPTx:rot_matrix31>-0.982</VRPTx:rot_matrix31> <VRPTx:rot_matrix32>0.073</VRPTx:rot_matrix32> <VRPTx:rot_matrix33>-0.172</VRPTx:rot_matrix33> </VRPTx:struct_biol_view> </VRPTx:struct_biol_viewCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_biol_view.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_biol_view (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	rot_matrix11 DECIMAL ,
	rot_matrix12 DECIMAL ,
	rot_matrix13 DECIMAL ,
	rot_matrix21 DECIMAL ,
	rot_matrix22 DECIMAL ,
	rot_matrix23 DECIMAL ,
	rot_matrix31 DECIMAL ,
	rot_matrix32 DECIMAL ,
	rot_matrix33 DECIMAL ,
-- ATTRIBUTE
	biol_id TEXT NOT NULL ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_confType)
-- Data items in the STRUCT_CONF category record details about the backbone conformation of a segment of polymer. Data items in the STRUCT_CONF_TYPE category define the criteria used to identify the backbone conformations. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_confCategory> <VRPTx:struct_conf id="HELX1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ARG</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>87</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>HELX_RH_AL_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLN</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>92</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="HELX2"> <VRPTx:beg_label_asym_id>B</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ARG</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>287</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>HELX_RH_AL_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>B</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLN</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>292</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="STRN1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>1</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>STRN_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>LEU</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>5</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="STRN2"> <VRPTx:beg_label_asym_id>B</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>CYS</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>295</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>STRN_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>B</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>PHE</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>299</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="STRN3"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>CYS</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>95</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>STRN_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>PHE</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>299</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="STRN4"> <VRPTx:beg_label_asym_id>B</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>201</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>STRN_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>B</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>LEU</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>205</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="TURN1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ILE</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>15</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>TURN_TY1P_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLN</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>18</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="TURN2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>GLY</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>49</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>TURN_TY2_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>52</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="TURN3"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ILE</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>55</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>TURN_TY1P_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>HIS</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>69</VRPTx:end_label_seq_id> </VRPTx:struct_conf> <VRPTx:struct_conf id="TURN4"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>THR</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>91</VRPTx:beg_label_seq_id> <VRPTx:conf_type_id>TURN_TY1_P</VRPTx:conf_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>94</VRPTx:end_label_seq_id> </VRPTx:struct_conf> </VRPTx:struct_confCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_conf.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_conf (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	beg_label_asym_id TEXT ,
	beg_label_comp_id TEXT ,
	beg_label_seq_id TEXT ,
	conf_type_id TEXT ,
	details TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
	end_label_asym_id TEXT ,
	end_label_comp_id TEXT ,
	end_label_seq_id TEXT ,
	"pdbx_PDB_helix_class" TEXT ,
	"pdbx_PDB_helix_id" TEXT ,
	"pdbx_PDB_helix_length" INTEGER ,
	"pdbx_beg_PDB_ins_code" TEXT ,
	"pdbx_end_PDB_ins_code" TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_connType)
-- Data items in the STRUCT_CONN category record details about the connections between portions of the structure. These can be hydrogen bonds, salt bridges, disulfide bridges and so on. The STRUCT_CONN_TYPE records define the criteria used to identify these connections. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_connCategory> <VRPTx:struct_conn id="C1"> <VRPTx:conn_type_id>saltbr</VRPTx:conn_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>A</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>NZ1</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ARG</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>87</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr1_role>positive</VRPTx:ptnr1_role> <VRPTx:ptnr1_symmetry>1_555</VRPTx:ptnr1_symmetry> <VRPTx:ptnr2_label_asym_id>A</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id>OE1</VRPTx:ptnr2_label_atom_id> <VRPTx:ptnr2_label_comp_id>GLU</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>92</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr2_role>negative</VRPTx:ptnr2_role> <VRPTx:ptnr2_symmetry>1_555</VRPTx:ptnr2_symmetry> </VRPTx:struct_conn> <VRPTx:struct_conn id="C2"> <VRPTx:conn_type_id>hydrog</VRPTx:conn_type_id> <VRPTx:details xsi:nil="true" /> <VRPTx:ptnr1_label_asym_id>B</VRPTx:ptnr1_label_asym_id> <VRPTx:ptnr1_label_atom_id>N</VRPTx:ptnr1_label_atom_id> <VRPTx:ptnr1_label_comp_id>ARG</VRPTx:ptnr1_label_comp_id> <VRPTx:ptnr1_label_seq_id>287</VRPTx:ptnr1_label_seq_id> <VRPTx:ptnr1_role>donor</VRPTx:ptnr1_role> <VRPTx:ptnr1_symmetry>1_555</VRPTx:ptnr1_symmetry> <VRPTx:ptnr2_label_asym_id>B</VRPTx:ptnr2_label_asym_id> <VRPTx:ptnr2_label_atom_id>O</VRPTx:ptnr2_label_atom_id> <VRPTx:ptnr2_label_comp_id>GLY</VRPTx:ptnr2_label_comp_id> <VRPTx:ptnr2_label_seq_id>292</VRPTx:ptnr2_label_seq_id> <VRPTx:ptnr2_role>acceptor</VRPTx:ptnr2_role> <VRPTx:ptnr2_symmetry>1_555</VRPTx:ptnr2_symmetry> </VRPTx:struct_conn> </VRPTx:struct_connCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_conn.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_conn_conn_type_id CASCADE;
CREATE TYPE ENUM_struct_conn_conn_type_id AS ENUM ( 'covale', 'disulf', 'metalc', 'hydrog' );
DROP TYPE IF EXISTS ENUM_struct_conn_pdbx_leaving_atom_flag CASCADE;
CREATE TYPE ENUM_struct_conn_pdbx_leaving_atom_flag AS ENUM ( 'both', 'one', 'none' );
DROP TYPE IF EXISTS ENUM_struct_conn_pdbx_ptnr1_atom_stereo_config CASCADE;
CREATE TYPE ENUM_struct_conn_pdbx_ptnr1_atom_stereo_config AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_struct_conn_pdbx_ptnr2_atom_stereo_config CASCADE;
CREATE TYPE ENUM_struct_conn_pdbx_ptnr2_atom_stereo_config AS ENUM ( 'R', 'S', 'N' );
DROP TYPE IF EXISTS ENUM_struct_conn_pdbx_role CASCADE;
CREATE TYPE ENUM_struct_conn_pdbx_role AS ENUM ( 'N-Glycosylation', 'O-Glycosylation', 'S-Glycosylation', 'C-Mannosylation' );
DROP TYPE IF EXISTS ENUM_struct_conn_pdbx_value_order CASCADE;
CREATE TYPE ENUM_struct_conn_pdbx_value_order AS ENUM ( 'sing', 'doub', 'trip', 'quad' );
CREATE TABLE struct_conn (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	conn_type_id ENUM_struct_conn_conn_type_id ,
	details TEXT ,
	"pdbx_PDB_id" TEXT ,
-- omit an attribute having a fixed value: @units="angstroms"
	pdbx_dist_value DECIMAL ,
	pdbx_leaving_atom_flag ENUM_struct_conn_pdbx_leaving_atom_flag ,
	"pdbx_ptnr1_PDB_ins_code" TEXT ,
	pdbx_ptnr1_atom_stereo_config ENUM_struct_conn_pdbx_ptnr1_atom_stereo_config ,
	pdbx_ptnr1_auth_alt_id TEXT ,
	pdbx_ptnr1_label_alt_id TEXT ,
	pdbx_ptnr1_leaving_atom_id TEXT ,
	pdbx_ptnr1_standard_comp_id TEXT ,
	"pdbx_ptnr2_PDB_ins_code" TEXT ,
	pdbx_ptnr2_atom_stereo_config ENUM_struct_conn_pdbx_ptnr2_atom_stereo_config ,
	pdbx_ptnr2_auth_alt_id TEXT ,
	pdbx_ptnr2_label_alt_id TEXT ,
	pdbx_ptnr2_leaving_atom_id TEXT ,
	"pdbx_ptnr3_PDB_ins_code" TEXT ,
	pdbx_ptnr3_auth_alt_id TEXT ,
	pdbx_ptnr3_auth_asym_id TEXT ,
	pdbx_ptnr3_auth_atom_id TEXT ,
	pdbx_ptnr3_auth_comp_id TEXT ,
	pdbx_ptnr3_auth_seq_id TEXT ,
	pdbx_ptnr3_label_alt_id TEXT ,
	pdbx_ptnr3_label_asym_id TEXT ,
	pdbx_ptnr3_label_atom_id TEXT ,
	pdbx_ptnr3_label_comp_id TEXT ,
	pdbx_ptnr3_label_seq_id INTEGER ,
	pdbx_role ENUM_struct_conn_pdbx_role ,
	pdbx_value_order ENUM_struct_conn_pdbx_value_order ,
	ptnr1_auth_asym_id TEXT ,
	ptnr1_auth_atom_id TEXT ,
	ptnr1_auth_comp_id TEXT ,
	ptnr1_auth_seq_id TEXT ,
	ptnr1_label_alt_id TEXT ,
	ptnr1_label_asym_id TEXT ,
	ptnr1_label_atom_id TEXT ,
	ptnr1_label_comp_id TEXT ,
	ptnr1_label_seq_id TEXT ,
	ptnr1_role TEXT ,
	ptnr1_symmetry TEXT ,
	ptnr2_auth_asym_id TEXT ,
	ptnr2_auth_atom_id TEXT ,
	ptnr2_auth_comp_id TEXT ,
	ptnr2_auth_seq_id TEXT ,
	ptnr2_label_alt_id TEXT ,
	ptnr2_label_asym_id TEXT ,
	ptnr2_label_atom_id TEXT ,
	ptnr2_label_comp_id TEXT ,
	ptnr2_label_seq_id TEXT ,
	ptnr2_role TEXT ,
	ptnr2_symmetry TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from struct_conn_typeType)
-- Data items in the STRUCT_CONN_TYPE category record details about the criteria used to identify interactions between portions of the structure. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_conn_typeCategory> <VRPTx:struct_conn_type id="saltbr"> <VRPTx:criteria>negative to positive distance &gt; 2.5 \&#37;A, &lt; 3.2 \&#37;A</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conn_type> <VRPTx:struct_conn_type id="hydrog"> <VRPTx:criteria>NO distance &gt; 2.5\&#37;A, &lt; 3.5\&#37;A, NOC angle &lt; 120 degrees</VRPTx:criteria> <VRPTx:reference xsi:nil="true" /> </VRPTx:struct_conn_type> </VRPTx:struct_conn_typeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_conn_type.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_conn_type_id CASCADE;
CREATE TYPE ENUM_struct_conn_type_id AS ENUM ( 'covale', 'disulf', 'hydrog', 'metalc', 'mismat', 'saltbr', 'modres', 'covale_base', 'covale_sugar', 'covale_phosphate' );
CREATE TABLE struct_conn_type (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	criteria TEXT ,
	reference TEXT ,
-- ATTRIBUTE
	id ENUM_struct_conn_type_id NOT NULL
);

--
-- (quoted from struct_mon_detailsType)
-- Data items in the STRUCT_MON_DETAILS category record details about specifics of calculations summarized in data items in the STRUCT_MON_PROT and STRUCT_MON_NUCL categories. These can include the coefficients used in map calculations, the radii used for including points in a calculation and so on.
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_mon_details.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_mon_details (
	"RSCC" TEXT ,
	"RSR" TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	prot_cis DECIMAL ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from struct_mon_nuclType)
-- Data items in the STRUCT_MON_NUCL category record details about structural properties of a nucleic acid when analyzed at the monomer level. Analogous data items for proteins are given in the STRUCT_MON_PROT category. For items where the value of the property depends on the method employed to calculate it, details of the method of calculation are given using data items in the STRUCT_MON_DETAILS category. Example 1 - based on NDB structure BDL028. <VRPTx:struct_mon_nuclCategory> <VRPTx:struct_mon_nucl pdbx_id="1"> <VRPTx:alpha xsi:nil="true" /> <VRPTx:beta xsi:nil="true" /> <VRPTx:delta>131.9</VRPTx:delta> <VRPTx:epsilon>222.1</VRPTx:epsilon> <VRPTx:gamma>29.9</VRPTx:gamma> <VRPTx:label_alt_id>A</VRPTx:label_alt_id> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>C</VRPTx:label_comp_id> <VRPTx:label_seq_id>1</VRPTx:label_seq_id> <VRPTx:zeta>174.2</VRPTx:zeta> </VRPTx:struct_mon_nucl> <VRPTx:struct_mon_nucl pdbx_id="2"> <VRPTx:alpha>334.0</VRPTx:alpha> <VRPTx:beta>130.6</VRPTx:beta> <VRPTx:delta>125.6</VRPTx:delta> <VRPTx:epsilon>167.6</VRPTx:epsilon> <VRPTx:gamma>33.1</VRPTx:gamma> <VRPTx:label_alt_id>A</VRPTx:label_alt_id> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>G</VRPTx:label_comp_id> <VRPTx:label_seq_id>2</VRPTx:label_seq_id> <VRPTx:zeta>270.9</VRPTx:zeta> </VRPTx:struct_mon_nucl> <VRPTx:struct_mon_nucl pdbx_id="3"> <VRPTx:alpha>258.2</VRPTx:alpha> <VRPTx:beta>178.7</VRPTx:beta> <VRPTx:delta>114.6</VRPTx:delta> <VRPTx:epsilon>216.6</VRPTx:epsilon> <VRPTx:gamma>101.0</VRPTx:gamma> <VRPTx:label_alt_id>A</VRPTx:label_alt_id> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>T</VRPTx:label_comp_id> <VRPTx:label_seq_id>3</VRPTx:label_seq_id> <VRPTx:zeta>259.3</VRPTx:zeta> </VRPTx:struct_mon_nucl> </VRPTx:struct_mon_nuclCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_mon_nucl.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_mon_nucl_pdbx_RNA_pucker_outlier_flag CASCADE;
CREATE TYPE ENUM_struct_mon_nucl_pdbx_RNA_pucker_outlier_flag AS ENUM ( 'Y', 'N' );
DROP TYPE IF EXISTS ENUM_struct_mon_nucl_pdbx_RNA_suite CASCADE;
CREATE TYPE ENUM_struct_mon_nucl_pdbx_RNA_suite AS ENUM ( 'NonRotameric', 'Rotameric', 'Triaged/NotBinned' );
CREATE TABLE struct_mon_nucl (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	"P" DECIMAL ,
	"PDB_model_num" INTEGER ,
	"RSCC_all" DECIMAL ,
	"RSCC_base" DECIMAL ,
	"RSCC_phos" DECIMAL ,
	"RSCC_sugar" DECIMAL ,
	"RSR_all" DECIMAL ,
	"RSR_base" DECIMAL ,
	"RSR_phos" DECIMAL ,
	"RSR_sugar" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	alpha DECIMAL ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	beta DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi1 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi2 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	delta DECIMAL ,
	details TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	epsilon DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	gamma DECIMAL ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id TEXT ,
	"mean_B_all" DECIMAL ,
	"mean_B_base" DECIMAL ,
	"mean_B_phos" DECIMAL ,
	"mean_B_sugar" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	nu0 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	nu1 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	nu2 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	nu3 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	nu4 DECIMAL ,
	"pdbx_RNA_pucker_outlier_flag" ENUM_struct_mon_nucl_pdbx_RNA_pucker_outlier_flag ,
	"pdbx_RNA_suite" ENUM_struct_mon_nucl_pdbx_RNA_suite ,
	"pdbx_RNA_suiteness_score" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tau0 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tau1 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tau2 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tau3 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	tau4 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	taum DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	zeta DECIMAL ,
-- ATTRIBUTE
	pdbx_id TEXT NOT NULL
);

--
-- (quoted from struct_mon_protType)
-- Data items in the STRUCT_MON_PROT category record details about structural properties of a protein when analyzed at the monomer level. Analogous data items for nucleic acids are given in the STRUCT_MON_NUCL category. For items where the value of the property depends on the method employed to calculate it, details of the method of calculation are given using data items in the STRUCT_MON_DETAILS category. Example 1 - based on laboratory records for protein NS1. This example provides details for residue ARG 35. <VRPTx:struct_mon_protCategory> <VRPTx:struct_mon_prot pdbx_id="1"> <VRPTx:RSCC_all>0.90</VRPTx:RSCC_all> <VRPTx:RSR_all>0.18</VRPTx:RSR_all> <VRPTx:chi1>-67.9</VRPTx:chi1> <VRPTx:chi2>-174.7</VRPTx:chi2> <VRPTx:chi3>-67.7</VRPTx:chi3> <VRPTx:chi4>-86.3</VRPTx:chi4> <VRPTx:chi5>4.2</VRPTx:chi5> <VRPTx:label_alt_id>A</VRPTx:label_alt_id> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>ARG</VRPTx:label_comp_id> <VRPTx:label_seq_id>35</VRPTx:label_seq_id> <VRPTx:mean_B_all>30.0</VRPTx:mean_B_all> <VRPTx:mean_B_main>25.0</VRPTx:mean_B_main> <VRPTx:mean_B_side>35.1</VRPTx:mean_B_side> <VRPTx:omega>180.1</VRPTx:omega> <VRPTx:phi>-60.3</VRPTx:phi> <VRPTx:psi>-46.0</VRPTx:psi> </VRPTx:struct_mon_prot> </VRPTx:struct_mon_protCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_mon_prot.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_mon_prot_pdbx_Ramachandran_region CASCADE;
CREATE TYPE ENUM_struct_mon_prot_pdbx_Ramachandran_region AS ENUM ( 'Favored', 'Allowed', 'OUTLIER' );
DROP TYPE IF EXISTS ENUM_struct_mon_prot_pdbx_flippable_side_chain CASCADE;
CREATE TYPE ENUM_struct_mon_prot_pdbx_flippable_side_chain AS ENUM ( 'Y', 'N' );
CREATE TABLE struct_mon_prot (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"PDB_model_num" INTEGER ,
	"RSCC_all" DECIMAL ,
	"RSCC_main" DECIMAL ,
	"RSCC_side" DECIMAL ,
	"RSR_all" DECIMAL ,
	"RSR_main" DECIMAL ,
	"RSR_side" DECIMAL ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	chi1 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi2 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi3 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi4 DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	chi5 DECIMAL ,
	details TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id TEXT ,
	"mean_B_all" DECIMAL ,
	"mean_B_main" DECIMAL ,
	"mean_B_side" DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	omega DECIMAL ,
	"pdbx_Ramachandran_region" ENUM_struct_mon_prot_pdbx_Ramachandran_region ,
	pdbx_flippable_side_chain ENUM_struct_mon_prot_pdbx_flippable_side_chain ,
	pdbx_rotamer TEXT ,
-- omit an attribute having a fixed value: @units="degrees"
	phi DECIMAL ,
-- omit an attribute having a fixed value: @units="degrees"
	psi DECIMAL ,
-- ATTRIBUTE
	pdbx_id TEXT NOT NULL
);

--
-- (quoted from struct_mon_prot_cisType)
-- Data items in the STRUCT_MON_PROT_CIS category identify monomers that have been found to have the peptide bond in the cis conformation. The criterion used to select residues to be designated as containing cis peptide bonds is given in attribute prot_cis in category struct_mon_details. Example 1 - based on PDB structure 1ACY of Ghiara, Stura, Stanfield, Profy & Wilson [Science (1994), 264, 82-85]. <VRPTx:struct_mon_prot_cisCategory> <VRPTx:struct_mon_prot_cis pdbx_id="1"> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:label_asym_id>L</VRPTx:label_asym_id> <VRPTx:label_comp_id>PRO</VRPTx:label_comp_id> <VRPTx:label_seq_id>8</VRPTx:label_seq_id> <VRPTx:pdbx_PDB_model_num>1</VRPTx:pdbx_PDB_model_num> </VRPTx:struct_mon_prot_cis> <VRPTx:struct_mon_prot_cis pdbx_id="2"> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:label_asym_id>L</VRPTx:label_asym_id> <VRPTx:label_comp_id>PRO</VRPTx:label_comp_id> <VRPTx:label_seq_id>77</VRPTx:label_seq_id> <VRPTx:pdbx_PDB_model_num>1</VRPTx:pdbx_PDB_model_num> </VRPTx:struct_mon_prot_cis> <VRPTx:struct_mon_prot_cis pdbx_id="3"> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:label_asym_id>L</VRPTx:label_asym_id> <VRPTx:label_comp_id>PRO</VRPTx:label_comp_id> <VRPTx:label_seq_id>95</VRPTx:label_seq_id> <VRPTx:pdbx_PDB_model_num>1</VRPTx:pdbx_PDB_model_num> </VRPTx:struct_mon_prot_cis> <VRPTx:struct_mon_prot_cis pdbx_id="4"> <VRPTx:label_alt_id xsi:nil="true" /> <VRPTx:label_asym_id>L</VRPTx:label_asym_id> <VRPTx:label_comp_id>PRO</VRPTx:label_comp_id> <VRPTx:label_seq_id>141</VRPTx:label_seq_id> <VRPTx:pdbx_PDB_model_num>1</VRPTx:pdbx_PDB_model_num> </VRPTx:struct_mon_prot_cis> </VRPTx:struct_mon_prot_cisCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_mon_prot_cis.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_mon_prot_cis (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id TEXT ,
	"pdbx_PDB_ins_code" TEXT ,
	"pdbx_PDB_ins_code_2" TEXT ,
	"pdbx_PDB_model_num" INTEGER ,
	pdbx_auth_asym_id_2 TEXT ,
	pdbx_auth_comp_id_2 TEXT ,
	pdbx_auth_seq_id_2 TEXT ,
	pdbx_label_asym_id_2 TEXT ,
	pdbx_label_comp_id_2 TEXT ,
	pdbx_label_seq_id_2 INTEGER ,
	pdbx_omega_angle TEXT ,
-- ATTRIBUTE
	pdbx_id TEXT NOT NULL
);

--
-- (quoted from struct_ncs_dom_limType)
-- Data items in the STRUCT_NCS_DOM_LIM category identify the start and end points of polypeptide chain segments that form all or part of a domain in an ensemble of domains related by noncrystallographic symmetry. Example 1 - based on laboratory records for the collagen-like peptide, HYP-. <VRPTx:struct_ncs_dom_limCategory> <VRPTx:struct_ncs_dom_lim dom_id="d1" pdbx_component_id="1" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>1</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>29</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> <VRPTx:struct_ncs_dom_lim dom_id="d1" pdbx_component_id="2" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>B</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>31</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>B</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>59</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> <VRPTx:struct_ncs_dom_lim dom_id="d1" pdbx_component_id="3" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>C</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>61</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>B</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>89</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> <VRPTx:struct_ncs_dom_lim dom_id="d2" pdbx_component_id="1" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>D</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>91</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>D</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>119</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> <VRPTx:struct_ncs_dom_lim dom_id="d2" pdbx_component_id="2" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>E</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>121</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>E</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>149</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> <VRPTx:struct_ncs_dom_lim dom_id="d2" pdbx_component_id="3" pdbx_ens_id="1"> <VRPTx:beg_label_alt_id xsi:nil="true" /> <VRPTx:beg_label_asym_id>F</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>PRO</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>151</VRPTx:beg_label_seq_id> <VRPTx:end_label_alt_id xsi:nil="true" /> <VRPTx:end_label_asym_id>F</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>GLY</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>179</VRPTx:end_label_seq_id> </VRPTx:struct_ncs_dom_lim> </VRPTx:struct_ncs_dom_limCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ncs_dom_lim.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ncs_dom_lim (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	beg_label_alt_id TEXT ,
	beg_label_asym_id TEXT ,
	beg_label_comp_id TEXT ,
	beg_label_seq_id INTEGER ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
	end_label_alt_id TEXT ,
	end_label_asym_id TEXT ,
	end_label_comp_id TEXT ,
	end_label_seq_id INTEGER ,
	pdbx_refine_code DECIMAL ,
	selection_details TEXT ,
-- ATTRIBUTE
	dom_id TEXT NOT NULL ,
-- ATTRIBUTE
	pdbx_component_id INTEGER NOT NULL ,
-- ATTRIBUTE
	pdbx_ens_id TEXT NOT NULL
);

--
-- (quoted from struct_ncs_ens_genType)
-- Data items in the STRUCT_NCS_ENS_GEN category list domains related by a noncrystallographic symmetry operation and identify the operator. Example 1 - based on laboratory records for the collagen-like peptide, HYP-. <VRPTx:struct_ncs_ens_genCategory> <VRPTx:struct_ncs_ens_gen dom_id_1="d1" dom_id_2="d2" ens_id="en1" oper_id="1"></VRPTx:struct_ncs_ens_gen> </VRPTx:struct_ncs_ens_genCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ncs_ens_gen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ncs_ens_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
-- ATTRIBUTE
	dom_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	dom_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	ens_id TEXT NOT NULL ,
-- ATTRIBUTE
	oper_id INTEGER NOT NULL
);

--
-- (quoted from struct_ref_seq_difType)
-- Data items in the STRUCT_REF_SEQ_DIF category provide a mechanism for indicating and annotating point differences between the sequence of the entity or biological unit described in the data block and the sequence of the referenced database entry. Example 1 - based on laboratory records for CAP-DNA complex. <VRPTx:struct_ref_seq_difCategory> <VRPTx:struct_ref_seq_dif pdbx_ordinal="1"> <VRPTx:align_id>algn2</VRPTx:align_id> <VRPTx:db_mon_id>GLU</VRPTx:db_mon_id> <VRPTx:details> A point mutation was introduced in the CAP at position 181 substituting PHE for GLU.</VRPTx:details> <VRPTx:mon_id>PHE</VRPTx:mon_id> <VRPTx:seq_num>181</VRPTx:seq_num> </VRPTx:struct_ref_seq_dif> </VRPTx:struct_ref_seq_difCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_ref_seq_dif.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_ref_seq_dif (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	align_id TEXT ,
	db_mon_id TEXT ,
	details TEXT ,
	mon_id TEXT ,
	pdbx_auth_seq_num TEXT ,
	pdbx_pdb_id_code TEXT ,
	pdbx_pdb_ins_code TEXT ,
	pdbx_pdb_strand_id TEXT ,
	pdbx_seq_db_accession_code TEXT ,
	pdbx_seq_db_name TEXT ,
	pdbx_seq_db_seq_num TEXT ,
	seq_num INTEGER ,
-- ATTRIBUTE
	pdbx_ordinal INTEGER NOT NULL
);

--
-- (quoted from struct_sheet_hbondType)
-- Data items in the STRUCT_SHEET_HBOND category record details about the hydrogen bonding between residue ranges in a beta- sheet. It is necessary to treat hydrogen bonding independently of the designation of ranges, because the hydrogen bonding may begin in different places for the interactions of a given strand with the one preceding it and the one following it in the sheet. Example 1 - simple beta-barrel. <VRPTx:struct_sheet_hbondCategory> <VRPTx:struct_sheet_hbond range_id_1="strand_a" range_id_2="strand_b" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>11</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>19</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>30</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>40</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_b" range_id_2="strand_c" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>31</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>39</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>50</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>60</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_c" range_id_2="strand_d" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>51</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>59</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>70</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>80</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_d" range_id_2="strand_e" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>71</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>89</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>90</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>100</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_e" range_id_2="strand_f" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>91</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>99</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>110</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>120</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_f" range_id_2="strand_g" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>111</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>119</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>130</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>140</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_g" range_id_2="strand_h" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>131</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>139</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>150</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>160</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_h" range_id_2="strand_a" sheet_id="sheet_1"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>151</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>159</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>10</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>180</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> </VRPTx:struct_sheet_hbondCategory> Example 2 - five stranded mixed-sense sheet with one two-piece strand. <VRPTx:struct_sheet_hbondCategory> <VRPTx:struct_sheet_hbond range_id_1="strand_a" range_id_2="strand_b" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>20</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>18</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>119</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>111</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_b" range_id_2="strand_c" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>110</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>N</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>118</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>33</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>O</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>41</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_c" range_id_2="strand_d1" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>38</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>40</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>52</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>50</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_c" range_id_2="strand_d2" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>30</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>36</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>96</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>90</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_d1" range_id_2="strand_e" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>51</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>51</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>80</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>80</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> <VRPTx:struct_sheet_hbond range_id_1="strand_d2" range_id_2="strand_e" sheet_id="sheet_2"> <VRPTx:range_1_beg_label_atom_id>N</VRPTx:range_1_beg_label_atom_id> <VRPTx:range_1_beg_label_seq_id>91</VRPTx:range_1_beg_label_seq_id> <VRPTx:range_1_end_label_atom_id>O</VRPTx:range_1_end_label_atom_id> <VRPTx:range_1_end_label_seq_id>97</VRPTx:range_1_end_label_seq_id> <VRPTx:range_2_beg_label_atom_id>O</VRPTx:range_2_beg_label_atom_id> <VRPTx:range_2_beg_label_seq_id>76</VRPTx:range_2_beg_label_seq_id> <VRPTx:range_2_end_label_atom_id>N</VRPTx:range_2_end_label_atom_id> <VRPTx:range_2_end_label_seq_id>70</VRPTx:range_2_end_label_seq_id> </VRPTx:struct_sheet_hbond> </VRPTx:struct_sheet_hbondCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_sheet_hbond.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_sheet_hbond (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"pdbx_range_1_beg_PDB_ins_code" TEXT ,
	pdbx_range_1_beg_auth_asym_id TEXT ,
	pdbx_range_1_beg_auth_comp_id TEXT ,
	pdbx_range_1_beg_label_asym_id TEXT ,
	pdbx_range_1_beg_label_comp_id TEXT ,
	"pdbx_range_1_end_PDB_ins_code" TEXT ,
	pdbx_range_1_end_auth_asym_id TEXT ,
	pdbx_range_1_end_auth_comp_id TEXT ,
	pdbx_range_1_end_label_asym_id TEXT ,
	pdbx_range_1_end_label_comp_id TEXT ,
	"pdbx_range_2_beg_PDB_ins_code" TEXT ,
	pdbx_range_2_beg_label_asym_id TEXT ,
	pdbx_range_2_beg_label_comp_id TEXT ,
	pdbx_range_2_end_label_asym_id TEXT ,
	pdbx_range_2_end_label_comp_id TEXT ,
	pdbx_range_2_end_label_ins_code TEXT ,
	range_1_beg_auth_atom_id TEXT ,
	range_1_beg_auth_seq_id TEXT ,
	range_1_beg_label_atom_id TEXT ,
	range_1_beg_label_seq_id TEXT ,
	range_1_end_auth_atom_id TEXT ,
	range_1_end_auth_seq_id TEXT ,
	range_1_end_label_atom_id TEXT ,
	range_1_end_label_seq_id TEXT ,
	range_2_beg_auth_atom_id TEXT ,
	range_2_beg_auth_seq_id TEXT ,
	range_2_beg_label_atom_id TEXT ,
	range_2_beg_label_seq_id TEXT ,
	range_2_end_auth_atom_id TEXT ,
	range_2_end_auth_seq_id TEXT ,
	range_2_end_label_atom_id TEXT ,
	range_2_end_label_seq_id TEXT ,
-- ATTRIBUTE
	range_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	range_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	sheet_id TEXT NOT NULL
);

--
-- (quoted from struct_sheet_orderType)
-- Data items in the STRUCT_SHEET_ORDER category record details about the order of the residue ranges that form a beta-sheet. All order links are pairwise and the specified pairs are assumed to be adjacent to one another in the sheet. These data items are an alternative to the STRUCT_SHEET_TOPOLOGY data items and they allow all manner of sheets to be described. Example 1 - simple beta-barrel. <VRPTx:struct_sheet_orderCategory> <VRPTx:struct_sheet_order range_id_1="strand_a" range_id_2="strand_b" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_b" range_id_2="strand_c" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_c" range_id_2="strand_d" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_d" range_id_2="strand_e" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_e" range_id_2="strand_f" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_f" range_id_2="strand_g" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_g" range_id_2="strand_h" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_h" range_id_2="strand_a" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> </VRPTx:struct_sheet_orderCategory> Example 2 - five stranded mixed-sense sheet with one two-piece strand. <VRPTx:struct_sheet_orderCategory> <VRPTx:struct_sheet_order range_id_1="strand_a" range_id_2="strand_b" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_b" range_id_2="strand_c" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_c" range_id_2="strand_d1" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_c" range_id_2="strand_d2" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_d1" range_id_2="strand_e" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_order> <VRPTx:struct_sheet_order range_id_1="strand_d2" range_id_2="strand_e" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_order> </VRPTx:struct_sheet_orderCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_sheet_order.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_sheet_order_sense CASCADE;
CREATE TYPE ENUM_struct_sheet_order_sense AS ENUM ( 'parallel', 'anti-parallel' );
CREATE TABLE struct_sheet_order (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"offset" INTEGER ,
	sense ENUM_struct_sheet_order_sense ,
-- ATTRIBUTE
	range_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	range_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	sheet_id TEXT NOT NULL
);

--
-- (quoted from struct_sheet_rangeType)
-- Data items in the STRUCT_SHEET_RANGE category record details about the residue ranges that form a beta-sheet. Residues are included in a range if they made beta-sheet-type hydrogen-bonding interactions with at least one adjacent strand and if there are at least two residues in the range. Example 1 - simple beta-barrel. <VRPTx:struct_sheet_rangeCategory> <VRPTx:struct_sheet_range id="strand_a" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>20</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>30</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_b" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>40</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>50</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_c" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>60</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>70</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_d" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>80</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>90</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_e" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>100</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>110</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_f" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>120</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>130</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_g" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>140</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>150</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_h" sheet_id="sheet_1"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>160</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>170</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> </VRPTx:struct_sheet_rangeCategory> Example 2 - five stranded mixed-sense sheet with one two-piece strand. <VRPTx:struct_sheet_rangeCategory> <VRPTx:struct_sheet_range id="strand_a" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>10</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>18</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_b" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>110</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>119</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_c" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>30</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>41</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_d1" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>50</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>52</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_d2" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>90</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>97</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> <VRPTx:struct_sheet_range id="strand_e" sheet_id="sheet_2"> <VRPTx:beg_label_asym_id>A</VRPTx:beg_label_asym_id> <VRPTx:beg_label_comp_id>ala</VRPTx:beg_label_comp_id> <VRPTx:beg_label_seq_id>70</VRPTx:beg_label_seq_id> <VRPTx:end_label_asym_id>A</VRPTx:end_label_asym_id> <VRPTx:end_label_comp_id>ala</VRPTx:end_label_comp_id> <VRPTx:end_label_seq_id>80</VRPTx:end_label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_sheet_range> </VRPTx:struct_sheet_rangeCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_sheet_range.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_sheet_range (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	beg_auth_asym_id TEXT ,
	beg_auth_comp_id TEXT ,
	beg_auth_seq_id TEXT ,
	beg_label_asym_id TEXT ,
	beg_label_comp_id TEXT ,
	beg_label_seq_id TEXT ,
	end_auth_asym_id TEXT ,
	end_auth_comp_id TEXT ,
	end_auth_seq_id TEXT ,
	end_label_asym_id TEXT ,
	end_label_comp_id TEXT ,
	end_label_seq_id TEXT ,
	"pdbx_beg_PDB_ins_code" TEXT ,
	"pdbx_end_PDB_ins_code" TEXT ,
	symmetry TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	sheet_id TEXT NOT NULL
);

--
-- (quoted from struct_sheet_topologyType)
-- Data items in the STRUCT_SHEET_TOPOLOGY category record details about the topology of the residue ranges that form a beta-sheet. All topology links are pairwise and the specified pairs are assumed to be successive in the amino-acid sequence. These data items are useful in describing various simple and complex folds, but they become inadequate when the strands in the sheet come from more than one chain. The STRUCT_SHEET_ORDER data items can be used to describe single- and multiple-chain-containing sheets. Example 1 - simple beta-barrel. <VRPTx:struct_sheet_topologyCategory> <VRPTx:struct_sheet_topology range_id_1="strand_a" range_id_2="strand_b" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_b" range_id_2="strand_c" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_c" range_id_2="strand_d" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_d" range_id_2="strand_e" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_e" range_id_2="strand_f" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_f" range_id_2="strand_g" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_g" range_id_2="strand_h" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_h" range_id_2="strand_a" sheet_id="sheet_1"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> </VRPTx:struct_sheet_topologyCategory> Example 2 - five stranded mixed-sense sheet with one two-piece strand. <VRPTx:struct_sheet_topologyCategory> <VRPTx:struct_sheet_topology range_id_1="strand_a" range_id_2="strand_c" sheet_id="sheet_2"> <VRPTx:offset>+2</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_c" range_id_2="strand_d1" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_d1" range_id_2="strand_e" sheet_id="sheet_2"> <VRPTx:offset>+1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_e" range_id_2="strand_d2" sheet_id="sheet_2"> <VRPTx:offset>-1</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> <VRPTx:struct_sheet_topology range_id_1="strand_d2" range_id_2="strand_b" sheet_id="sheet_2"> <VRPTx:offset>-2</VRPTx:offset> <VRPTx:sense>anti-parallel</VRPTx:sense> </VRPTx:struct_sheet_topology> </VRPTx:struct_sheet_topologyCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_sheet_topology.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_struct_sheet_topology_sense CASCADE;
CREATE TYPE ENUM_struct_sheet_topology_sense AS ENUM ( 'parallel', 'anti-parallel' );
CREATE TABLE struct_sheet_topology (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	"offset" INTEGER ,
	sense ENUM_struct_sheet_topology_sense ,
-- ATTRIBUTE
	range_id_1 TEXT NOT NULL ,
-- ATTRIBUTE
	range_id_2 TEXT NOT NULL ,
-- ATTRIBUTE
	sheet_id TEXT NOT NULL
);

--
-- (quoted from struct_site_genType)
-- Data items in the STRUCT_SITE_GEN category record details about the generation of portions of the structure that contribute to structurally relevant sites. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:struct_site_genCategory> <VRPTx:struct_site_gen id="1" site_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>VAL</VRPTx:label_comp_id> <VRPTx:label_seq_id>32</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="2" site_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>ILE</VRPTx:label_comp_id> <VRPTx:label_seq_id>47</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="3" site_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>VAL</VRPTx:label_comp_id> <VRPTx:label_seq_id>82</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="4" site_id="1"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>A</VRPTx:label_asym_id> <VRPTx:label_comp_id>ILE</VRPTx:label_comp_id> <VRPTx:label_seq_id>84</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="5" site_id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>B</VRPTx:label_asym_id> <VRPTx:label_comp_id>VAL</VRPTx:label_comp_id> <VRPTx:label_seq_id>232</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="6" site_id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>B</VRPTx:label_asym_id> <VRPTx:label_comp_id>ILE</VRPTx:label_comp_id> <VRPTx:label_seq_id>247</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="7" site_id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>B</VRPTx:label_asym_id> <VRPTx:label_comp_id>VAL</VRPTx:label_comp_id> <VRPTx:label_seq_id>282</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> <VRPTx:struct_site_gen id="8" site_id="2"> <VRPTx:details xsi:nil="true" /> <VRPTx:label_asym_id>B</VRPTx:label_asym_id> <VRPTx:label_comp_id>ILE</VRPTx:label_comp_id> <VRPTx:label_seq_id>284</VRPTx:label_seq_id> <VRPTx:symmetry>1_555</VRPTx:symmetry> </VRPTx:struct_site_gen> </VRPTx:struct_site_genCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_site_gen.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_site_gen (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	auth_asym_id TEXT ,
	auth_atom_id TEXT ,
	auth_comp_id TEXT ,
	auth_seq_id TEXT ,
	details TEXT ,
	label_alt_id TEXT ,
	label_asym_id TEXT ,
	label_atom_id TEXT ,
	label_comp_id TEXT ,
	label_seq_id TEXT ,
	pdbx_auth_ins_code TEXT ,
	pdbx_num_res INTEGER ,
	symmetry TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL ,
-- ATTRIBUTE
	site_id TEXT NOT NULL
);

--
-- (quoted from struct_site_viewType)
-- Data items in the STRUCT_SITE_VIEW category record details about how to draw and annotate an informative view of the site. Example 1 - based on NDB structure GDL001 by Coll, Aymami, Van Der Marel, Van Boom, Rich & Wang [Biochemistry (1989), 28, 310-320]. <VRPTx:struct_site_viewCategory> <VRPTx:struct_site_view id="1"> <VRPTx:details> This view highlights the site of ATAT-Netropsin interaction.</VRPTx:details> <VRPTx:rot_matrix11>0.132</VRPTx:rot_matrix11> <VRPTx:rot_matrix12>0.922</VRPTx:rot_matrix12> <VRPTx:rot_matrix13>-0.363</VRPTx:rot_matrix13> <VRPTx:rot_matrix21>0.131</VRPTx:rot_matrix21> <VRPTx:rot_matrix22>-0.380</VRPTx:rot_matrix22> <VRPTx:rot_matrix23>-0.916</VRPTx:rot_matrix23> <VRPTx:rot_matrix31>-0.982</VRPTx:rot_matrix31> <VRPTx:rot_matrix32>0.073</VRPTx:rot_matrix32> <VRPTx:rot_matrix33>-0.172</VRPTx:rot_matrix33> </VRPTx:struct_site_view> </VRPTx:struct_site_viewCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/struct_site_view.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE struct_site_view (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	details TEXT ,
	rot_matrix11 DECIMAL ,
	rot_matrix12 DECIMAL ,
	rot_matrix13 DECIMAL ,
	rot_matrix21 DECIMAL ,
	rot_matrix22 DECIMAL ,
	rot_matrix23 DECIMAL ,
	rot_matrix31 DECIMAL ,
	rot_matrix32 DECIMAL ,
	rot_matrix33 DECIMAL ,
	site_id TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

--
-- (quoted from symmetryType)
-- Data items in the SYMMETRY category record details about the space-group symmetry. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:symmetryCategory> <VRPTx:symmetry entry_id="5HVP"> <VRPTx:Int_Tables_number>18</VRPTx:Int_Tables_number> <VRPTx:cell_setting>orthorhombic</VRPTx:cell_setting> <VRPTx:space_group_name_H-M>P 21 21 2</VRPTx:space_group_name_H-M> </VRPTx:symmetry> </VRPTx:symmetryCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/symmetry.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_symmetry_cell_setting CASCADE;
CREATE TYPE ENUM_symmetry_cell_setting AS ENUM ( 'triclinic', 'monoclinic', 'orthorhombic', 'tetragonal', 'rhombohedral', 'trigonal', 'hexagonal', 'cubic' );
CREATE TABLE symmetry (
	"Int_Tables_number" INTEGER ,
	cell_setting ENUM_symmetry_cell_setting ,
	"pdbx_full_space_group_name_H-M" TEXT ,
	"space_group_name_H-M" TEXT ,
	"space_group_name_Hall" TEXT ,
-- ATTRIBUTE, IN-PLACE DOCUMENT KEY
	entry_id TEXT NOT NULL
);

--
-- (quoted from symmetry_equivType)
-- Data items in the SYMMETRY_EQUIV category list the symmetry-equivalent positions for the space group. Example 1 - based on PDB entry 5HVP and laboratory records for the structure corresponding to PDB entry 5HVP. <VRPTx:symmetry_equivCategory> <VRPTx:symmetry_equiv id="1"> <VRPTx:pos_as_xyz>+x,+y,+z</VRPTx:pos_as_xyz> </VRPTx:symmetry_equiv> <VRPTx:symmetry_equiv id="2"> <VRPTx:pos_as_xyz>-x,-y,z</VRPTx:pos_as_xyz> </VRPTx:symmetry_equiv> <VRPTx:symmetry_equiv id="3"> <VRPTx:pos_as_xyz>1/2+x,1/2-y,-z</VRPTx:pos_as_xyz> </VRPTx:symmetry_equiv> <VRPTx:symmetry_equiv id="4"> <VRPTx:pos_as_xyz>1/2-x,1/2+y,-z</VRPTx:pos_as_xyz> </VRPTx:symmetry_equiv> </VRPTx:symmetry_equivCategory>
-- URI-reference = http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/symmetry_equiv.html
-- xmlns: http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd (VRPTx), schema location: pdbx-validation-v4.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE symmetry_equiv (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	entry_id TEXT ,
	pos_as_xyz TEXT ,
-- ATTRIBUTE
	id TEXT NOT NULL
);

-- (derived from xsd:key[@name='diffrnKey_0'])
--ALTER TABLE diffrn ADD CONSTRAINT UNQ_diffrn UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='diffrn_attenuatorKey_0'])
--ALTER TABLE diffrn_attenuator ADD CONSTRAINT UNQ_diffrn_attenuator UNIQUE ( entry_id, code );

-- (derived from xsd:key[@name='diffrn_detectorKey_0'])
--ALTER TABLE diffrn_detector ADD CONSTRAINT UNQ_diffrn_detector UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_measurementKey_0'])
--ALTER TABLE diffrn_measurement ADD CONSTRAINT UNQ_diffrn_measurement UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_orient_matrixKey_0'])
--ALTER TABLE diffrn_orient_matrix ADD CONSTRAINT UNQ_diffrn_orient_matrix UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_orient_reflnKey_0'])
--ALTER TABLE diffrn_orient_refln ADD CONSTRAINT UNQ_diffrn_orient_refln UNIQUE ( entry_id, diffrn_id, index_h, index_k, index_l );

-- (derived from xsd:key[@name='diffrn_radiationKey_0'])
--ALTER TABLE diffrn_radiation ADD CONSTRAINT UNQ_diffrn_radiation UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_radiation_wavelengthKey_0'])
--ALTER TABLE diffrn_radiation_wavelength ADD CONSTRAINT UNQ_diffrn_radiation_wavelength UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='diffrn_reflnKey_0'])
--ALTER TABLE diffrn_refln ADD CONSTRAINT UNQ_diffrn_refln UNIQUE ( entry_id, diffrn_id, id );

-- (derived from xsd:key[@name='diffrn_reflnsKey_0'])
--ALTER TABLE diffrn_reflns ADD CONSTRAINT UNQ_diffrn_reflns UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_reflns_classKey_0'])
--ALTER TABLE diffrn_reflns_class ADD CONSTRAINT UNQ_diffrn_reflns_class UNIQUE ( entry_id, code );

-- (derived from xsd:key[@name='diffrn_scale_groupKey_0'])
--ALTER TABLE diffrn_scale_group ADD CONSTRAINT UNQ_diffrn_scale_group UNIQUE ( entry_id, code );

-- (derived from xsd:key[@name='diffrn_sourceKey_0'])
--ALTER TABLE diffrn_source ADD CONSTRAINT UNQ_diffrn_source UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='diffrn_standard_reflnKey_0'])
--ALTER TABLE diffrn_standard_refln ADD CONSTRAINT UNQ_diffrn_standard_refln UNIQUE ( entry_id, code, diffrn_id );

-- (derived from xsd:key[@name='diffrn_standardsKey_0'])
--ALTER TABLE diffrn_standards ADD CONSTRAINT UNQ_diffrn_standards UNIQUE ( entry_id, diffrn_id );

-- (derived from xsd:key[@name='em_2d_crystal_entityKey_0'])
--ALTER TABLE em_2d_crystal_entity ADD CONSTRAINT UNQ_em_2d_crystal_entity UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_3d_crystal_entityKey_0'])
--ALTER TABLE em_3d_crystal_entity ADD CONSTRAINT UNQ_em_3d_crystal_entity UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_3d_fittingKey_0'])
--ALTER TABLE em_3d_fitting ADD CONSTRAINT UNQ_em_3d_fitting UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_3d_fitting_listKey_0'])
--ALTER TABLE em_3d_fitting_list ADD CONSTRAINT UNQ_em_3d_fitting_list UNIQUE ( entry_id, _3d_fitting_id, id );

-- (derived from xsd:key[@name='em_3d_reconstructionKey_0'])
--ALTER TABLE em_3d_reconstruction ADD CONSTRAINT UNQ_em_3d_reconstruction UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_adminKey_0'])
--ALTER TABLE em_admin ADD CONSTRAINT UNQ_em_admin UNIQUE ( entry_id );

-- (derived from xsd:key[@name='em_bufferKey_0'])
--ALTER TABLE em_buffer ADD CONSTRAINT UNQ_em_buffer UNIQUE ( entry_id, id, specimen_id );

-- (derived from xsd:key[@name='em_buffer_componentKey_0'])
--ALTER TABLE em_buffer_component ADD CONSTRAINT UNQ_em_buffer_component UNIQUE ( entry_id, buffer_id, id );

-- (derived from xsd:key[@name='em_crystal_formationKey_0'])
--ALTER TABLE em_crystal_formation ADD CONSTRAINT UNQ_em_crystal_formation UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_ctf_correctionKey_0'])
--ALTER TABLE em_ctf_correction ADD CONSTRAINT UNQ_em_ctf_correction UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_diffractionKey_0'])
--ALTER TABLE em_diffraction ADD CONSTRAINT UNQ_em_diffraction UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_diffraction_shellKey_0'])
--ALTER TABLE em_diffraction_shell ADD CONSTRAINT UNQ_em_diffraction_shell UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_diffraction_statsKey_0'])
--ALTER TABLE em_diffraction_stats ADD CONSTRAINT UNQ_em_diffraction_stats UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_embeddingKey_0'])
--ALTER TABLE em_embedding ADD CONSTRAINT UNQ_em_embedding UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_entity_assemblyKey_0'])
--ALTER TABLE em_entity_assembly ADD CONSTRAINT UNQ_em_entity_assembly UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_entity_assembly_molwtKey_0'])
--ALTER TABLE em_entity_assembly_molwt ADD CONSTRAINT UNQ_em_entity_assembly_molwt UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_entity_assembly_naturalsourceKey_0'])
--ALTER TABLE em_entity_assembly_naturalsource ADD CONSTRAINT UNQ_em_entity_assembly_naturalsource UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_entity_assembly_recombinantKey_0'])
--ALTER TABLE em_entity_assembly_recombinant ADD CONSTRAINT UNQ_em_entity_assembly_recombinant UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_entity_assembly_syntheticKey_0'])
--ALTER TABLE em_entity_assembly_synthetic ADD CONSTRAINT UNQ_em_entity_assembly_synthetic UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_experimentKey_0'])
--ALTER TABLE em_experiment ADD CONSTRAINT UNQ_em_experiment UNIQUE ( entry_id );

-- (derived from xsd:key[@name='em_helical_entityKey_0'])
--ALTER TABLE em_helical_entity ADD CONSTRAINT UNQ_em_helical_entity UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_image_processingKey_0'])
--ALTER TABLE em_image_processing ADD CONSTRAINT UNQ_em_image_processing UNIQUE ( entry_id, id, image_recording_id );

-- (derived from xsd:key[@name='em_image_recordingKey_0'])
--ALTER TABLE em_image_recording ADD CONSTRAINT UNQ_em_image_recording UNIQUE ( entry_id, id, imaging_id );

-- (derived from xsd:key[@name='em_image_scansKey_0'])
--ALTER TABLE em_image_scans ADD CONSTRAINT UNQ_em_image_scans UNIQUE ( entry_id, id, image_recording_id );

-- (derived from xsd:key[@name='em_imagingKey_0'])
--ALTER TABLE em_imaging ADD CONSTRAINT UNQ_em_imaging UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_imaging_opticsKey_0'])
--ALTER TABLE em_imaging_optics ADD CONSTRAINT UNQ_em_imaging_optics UNIQUE ( entry_id, id, imaging_id );

-- (derived from xsd:key[@name='em_particle_selectionKey_0'])
--ALTER TABLE em_particle_selection ADD CONSTRAINT UNQ_em_particle_selection UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_single_particle_entityKey_0'])
--ALTER TABLE em_single_particle_entity ADD CONSTRAINT UNQ_em_single_particle_entity UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='em_softwareKey_0'])
--ALTER TABLE em_software ADD CONSTRAINT UNQ_em_software UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_specimenKey_0'])
--ALTER TABLE em_specimen ADD CONSTRAINT UNQ_em_specimen UNIQUE ( entry_id, experiment_id, id );

-- (derived from xsd:key[@name='em_stainingKey_0'])
--ALTER TABLE em_staining ADD CONSTRAINT UNQ_em_staining UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='em_virus_entityKey_0'])
--ALTER TABLE em_virus_entity ADD CONSTRAINT UNQ_em_virus_entity UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_virus_natural_hostKey_0'])
--ALTER TABLE em_virus_natural_host ADD CONSTRAINT UNQ_em_virus_natural_host UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_virus_shellKey_0'])
--ALTER TABLE em_virus_shell ADD CONSTRAINT UNQ_em_virus_shell UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_virus_syntheticKey_0'])
--ALTER TABLE em_virus_synthetic ADD CONSTRAINT UNQ_em_virus_synthetic UNIQUE ( entry_id, entity_assembly_id, id );

-- (derived from xsd:key[@name='em_vitrificationKey_0'])
--ALTER TABLE em_vitrification ADD CONSTRAINT UNQ_em_vitrification UNIQUE ( entry_id, id, specimen_id );

-- (derived from xsd:key[@name='em_volume_selectionKey_0'])
--ALTER TABLE em_volume_selection ADD CONSTRAINT UNQ_em_volume_selection UNIQUE ( entry_id, id, image_processing_id );

-- (derived from xsd:key[@name='entityKey_0'])
--ALTER TABLE entity ADD CONSTRAINT UNQ_entity UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='entity_name_comKey_0'])
--ALTER TABLE entity_name_com ADD CONSTRAINT UNQ_entity_name_com UNIQUE ( entry_id, entity_id );

-- (derived from xsd:key[@name='entity_name_sysKey_0'])
--ALTER TABLE entity_name_sys ADD CONSTRAINT UNQ_entity_name_sys UNIQUE ( entry_id, entity_id );

-- (derived from xsd:key[@name='entity_polyKey_0'])
--ALTER TABLE entity_poly ADD CONSTRAINT UNQ_entity_poly UNIQUE ( entry_id, entity_id );

-- (derived from xsd:key[@name='entity_poly_seqKey_0'])
--ALTER TABLE entity_poly_seq ADD CONSTRAINT UNQ_entity_poly_seq UNIQUE ( entry_id, entity_id, mon_id, num );

-- (derived from xsd:key[@name='entryKey_0'])
--ALTER TABLE entry ADD CONSTRAINT UNQ_entry UNIQUE ( id );

-- (derived from xsd:key[@name='entry_linkKey_0'])
--ALTER TABLE entry_link ADD CONSTRAINT UNQ_entry_link UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='exptlKey_0'])
--ALTER TABLE exptl ADD CONSTRAINT UNQ_exptl UNIQUE ( entry_id, method );

-- (derived from xsd:key[@name='ndb_struct_conf_naKey_0'])
--ALTER TABLE ndb_struct_conf_na ADD CONSTRAINT UNQ_ndb_struct_conf_na UNIQUE ( entry_id, feature );

-- (derived from xsd:key[@name='ndb_struct_na_base_pairKey_0'])
--ALTER TABLE ndb_struct_na_base_pair ADD CONSTRAINT UNQ_ndb_struct_na_base_pair UNIQUE ( entry_id, i_label_asym_id, i_label_comp_id, i_label_seq_id, i_symmetry, j_label_asym_id, j_label_comp_id, j_label_seq_id, j_symmetry, model_number );

-- (derived from xsd:key[@name='ndb_struct_na_base_pair_stepKey_0'])
--ALTER TABLE ndb_struct_na_base_pair_step ADD CONSTRAINT UNQ_ndb_struct_na_base_pair_step UNIQUE ( entry_id, i_label_asym_id_1, i_label_asym_id_2, i_label_comp_id_1, i_label_comp_id_2, i_label_seq_id_1, i_label_seq_id_2, i_symmetry_1, i_symmetry_2, j_label_asym_id_1, j_label_asym_id_2, j_label_comp_id_1, j_label_comp_id_2, j_label_seq_id_1, j_label_seq_id_2, j_symmetry_1, j_symmetry_2, model_number );

-- (derived from xsd:key[@name='pdbx_audit_authorKey_0'])
--ALTER TABLE pdbx_audit_author ADD CONSTRAINT UNQ_pdbx_audit_author UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_audit_revision_categoryKey_0'])
--ALTER TABLE pdbx_audit_revision_category ADD CONSTRAINT UNQ_pdbx_audit_revision_category UNIQUE ( entry_id, data_content_type, ordinal, revision_ordinal );

-- (derived from xsd:key[@name='pdbx_audit_revision_detailsKey_0'])
--ALTER TABLE pdbx_audit_revision_details ADD CONSTRAINT UNQ_pdbx_audit_revision_details UNIQUE ( entry_id, data_content_type, ordinal, revision_ordinal );

-- (derived from xsd:key[@name='pdbx_audit_revision_groupKey_0'])
--ALTER TABLE pdbx_audit_revision_group ADD CONSTRAINT UNQ_pdbx_audit_revision_group UNIQUE ( entry_id, data_content_type, ordinal, revision_ordinal );

-- (derived from xsd:key[@name='pdbx_audit_revision_historyKey_0'])
--ALTER TABLE pdbx_audit_revision_history ADD CONSTRAINT UNQ_pdbx_audit_revision_history UNIQUE ( entry_id, data_content_type, ordinal );

-- (derived from xsd:key[@name='pdbx_audit_revision_itemKey_0'])
--ALTER TABLE pdbx_audit_revision_item ADD CONSTRAINT UNQ_pdbx_audit_revision_item UNIQUE ( entry_id, data_content_type, ordinal, revision_ordinal );

-- (derived from xsd:key[@name='pdbx_bond_distance_limitsKey_0'])
--ALTER TABLE pdbx_bond_distance_limits ADD CONSTRAINT UNQ_pdbx_bond_distance_limits UNIQUE ( entry_id, atom_type_1, atom_type_2 );

-- (derived from xsd:key[@name='pdbx_branch_schemeKey_0'])
--ALTER TABLE pdbx_branch_scheme ADD CONSTRAINT UNQ_pdbx_branch_scheme UNIQUE ( entry_id, asym_id, entity_id, mon_id, num );

-- (derived from xsd:key[@name='pdbx_coordinate_modelKey_0'])
--ALTER TABLE pdbx_coordinate_model ADD CONSTRAINT UNQ_pdbx_coordinate_model UNIQUE ( entry_id, asym_id );

-- (derived from xsd:key[@name='pdbx_database_relatedKey_0'])
--ALTER TABLE pdbx_database_related ADD CONSTRAINT UNQ_pdbx_database_related UNIQUE ( entry_id, content_type, db_id, db_name );

-- (derived from xsd:key[@name='pdbx_database_statusKey_0'])
--ALTER TABLE pdbx_database_status ADD CONSTRAINT UNQ_pdbx_database_status UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_dcc_densityKey_0'])
--ALTER TABLE pdbx_dcc_density ADD CONSTRAINT UNQ_pdbx_dcc_density UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_dcc_density_corrKey_0'])
--ALTER TABLE pdbx_dcc_density_corr ADD CONSTRAINT UNQ_pdbx_dcc_density_corr UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_dcc_entity_geometryKey_0'])
--ALTER TABLE pdbx_dcc_entity_geometry ADD CONSTRAINT UNQ_pdbx_dcc_entity_geometry UNIQUE ( entry_id, "PDB_model_num", label_asym_id );

-- (derived from xsd:key[@name='pdbx_dcc_geometryKey_0'])
--ALTER TABLE pdbx_dcc_geometry ADD CONSTRAINT UNQ_pdbx_dcc_geometry UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_dcc_mapKey_0'])
--ALTER TABLE pdbx_dcc_map ADD CONSTRAINT UNQ_pdbx_dcc_map UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_dcc_map_overallKey_0'])
--ALTER TABLE pdbx_dcc_map_overall ADD CONSTRAINT UNQ_pdbx_dcc_map_overall UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_dcc_mapmanKey_0'])
--ALTER TABLE pdbx_dcc_mapman ADD CONSTRAINT UNQ_pdbx_dcc_mapman UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_dcc_mon_geometryKey_0'])
--ALTER TABLE pdbx_dcc_mon_geometry ADD CONSTRAINT UNQ_pdbx_dcc_mon_geometry UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_dcc_rscc_mapmanKey_0'])
--ALTER TABLE pdbx_dcc_rscc_mapman ADD CONSTRAINT UNQ_pdbx_dcc_rscc_mapman UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_dcc_rscc_mapman_overallKey_0'])
--ALTER TABLE pdbx_dcc_rscc_mapman_overall ADD CONSTRAINT UNQ_pdbx_dcc_rscc_mapman_overall UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_diffrn_reflns_shellKey_0'])
--ALTER TABLE pdbx_diffrn_reflns_shell ADD CONSTRAINT UNQ_pdbx_diffrn_reflns_shell UNIQUE ( entry_id, d_res_high, d_res_low, diffrn_id );

-- (derived from xsd:key[@name='pdbx_distant_solvent_atomsKey_0'])
--ALTER TABLE pdbx_distant_solvent_atoms ADD CONSTRAINT UNQ_pdbx_distant_solvent_atoms UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_domainKey_0'])
--ALTER TABLE pdbx_domain ADD CONSTRAINT UNQ_pdbx_domain UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_domain_rangeKey_0'])
--ALTER TABLE pdbx_domain_range ADD CONSTRAINT UNQ_pdbx_domain_range UNIQUE ( entry_id, beg_label_alt_id, beg_label_asym_id, beg_label_comp_id, beg_label_seq_id, domain_id, end_label_alt_id, end_label_asym_id, end_label_comp_id, end_label_seq_id );

-- (derived from xsd:key[@name='pdbx_em_atom_inclusionKey_0'])
--ALTER TABLE pdbx_em_atom_inclusion ADD CONSTRAINT UNQ_pdbx_em_atom_inclusion UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_atom_inclusion_markerKey_0'])
--ALTER TABLE pdbx_em_atom_inclusion_marker ADD CONSTRAINT UNQ_pdbx_em_atom_inclusion_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_density_distributionKey_0'])
--ALTER TABLE pdbx_em_density_distribution ADD CONSTRAINT UNQ_pdbx_em_density_distribution UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_density_distribution_markerKey_0'])
--ALTER TABLE pdbx_em_density_distribution_marker ADD CONSTRAINT UNQ_pdbx_em_density_distribution_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_fsc_curveKey_0'])
--ALTER TABLE pdbx_em_fsc_curve ADD CONSTRAINT UNQ_pdbx_em_fsc_curve UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_fsc_curve_markerKey_0'])
--ALTER TABLE pdbx_em_fsc_curve_marker ADD CONSTRAINT UNQ_pdbx_em_fsc_curve_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_fsc_cutoff_curveKey_0'])
--ALTER TABLE pdbx_em_fsc_cutoff_curve ADD CONSTRAINT UNQ_pdbx_em_fsc_cutoff_curve UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_fsc_cutoff_curve_markerKey_0'])
--ALTER TABLE pdbx_em_fsc_cutoff_curve_marker ADD CONSTRAINT UNQ_pdbx_em_fsc_cutoff_curve_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_fsc_resolutionKey_0'])
--ALTER TABLE pdbx_em_fsc_resolution ADD CONSTRAINT UNQ_pdbx_em_fsc_resolution UNIQUE ( entry_id, criterion, source );

-- (derived from xsd:key[@name='pdbx_em_rapsKey_0'])
--ALTER TABLE pdbx_em_raps ADD CONSTRAINT UNQ_pdbx_em_raps UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_raps_markerKey_0'])
--ALTER TABLE pdbx_em_raps_marker ADD CONSTRAINT UNQ_pdbx_em_raps_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_raw_rapsKey_0'])
--ALTER TABLE pdbx_em_raw_raps ADD CONSTRAINT UNQ_pdbx_em_raw_raps UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_raw_raps_markerKey_0'])
--ALTER TABLE pdbx_em_raw_raps_marker ADD CONSTRAINT UNQ_pdbx_em_raw_raps_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_em_validate_map_modelKey_0'])
--ALTER TABLE pdbx_em_validate_map_model ADD CONSTRAINT UNQ_pdbx_em_validate_map_model UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_validate_map_model_entityKey_0'])
--ALTER TABLE pdbx_em_validate_map_model_entity ADD CONSTRAINT UNQ_pdbx_em_validate_map_model_entity UNIQUE ( entry_id, "PDB_model_num", label_asym_id );

-- (derived from xsd:key[@name='pdbx_em_validate_map_model_overallKey_0'])
--ALTER TABLE pdbx_em_validate_map_model_overall ADD CONSTRAINT UNQ_pdbx_em_validate_map_model_overall UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_em_volume_estimateKey_0'])
--ALTER TABLE pdbx_em_volume_estimate ADD CONSTRAINT UNQ_pdbx_em_volume_estimate UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_em_volume_estimate_markerKey_0'])
--ALTER TABLE pdbx_em_volume_estimate_marker ADD CONSTRAINT UNQ_pdbx_em_volume_estimate_marker UNIQUE ( entry_id, ordinal, plot_id );

-- (derived from xsd:key[@name='pdbx_entity_assemblyKey_0'])
--ALTER TABLE pdbx_entity_assembly ADD CONSTRAINT UNQ_pdbx_entity_assembly UNIQUE ( entry_id, entity_id, id );

-- (derived from xsd:key[@name='pdbx_entity_branchKey_0'])
--ALTER TABLE pdbx_entity_branch ADD CONSTRAINT UNQ_pdbx_entity_branch UNIQUE ( entry_id, entity_id );

-- (derived from xsd:key[@name='pdbx_entity_branch_descriptorKey_0'])
--ALTER TABLE pdbx_entity_branch_descriptor ADD CONSTRAINT UNQ_pdbx_entity_branch_descriptor UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_entity_branch_linkKey_0'])
--ALTER TABLE pdbx_entity_branch_link ADD CONSTRAINT UNQ_pdbx_entity_branch_link UNIQUE ( entry_id, link_id );

-- (derived from xsd:key[@name='pdbx_entity_branch_listKey_0'])
--ALTER TABLE pdbx_entity_branch_list ADD CONSTRAINT UNQ_pdbx_entity_branch_list UNIQUE ( entry_id, comp_id, entity_id, num );

-- (derived from xsd:key[@name='pdbx_entity_descriptorKey_0'])
--ALTER TABLE pdbx_entity_descriptor ADD CONSTRAINT UNQ_pdbx_entity_descriptor UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_entity_nonpolyKey_0'])
--ALTER TABLE pdbx_entity_nonpoly ADD CONSTRAINT UNQ_pdbx_entity_nonpoly UNIQUE ( entry_id, entity_id );

-- (derived from xsd:key[@name='pdbx_entity_poly_comp_link_listKey_0'])
--ALTER TABLE pdbx_entity_poly_comp_link_list ADD CONSTRAINT UNQ_pdbx_entity_poly_comp_link_list UNIQUE ( entry_id, link_id );

-- (derived from xsd:key[@name='pdbx_entry_detailsKey_0'])
--ALTER TABLE pdbx_entry_details ADD CONSTRAINT UNQ_pdbx_entry_details UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_helical_symmetryKey_0'])
--ALTER TABLE pdbx_helical_symmetry ADD CONSTRAINT UNQ_pdbx_helical_symmetry UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_missing_nmr_star_itemKey_0'])
--ALTER TABLE pdbx_missing_nmr_star_item ADD CONSTRAINT UNQ_pdbx_missing_nmr_star_item UNIQUE ( entry_id, id, list_id );

-- (derived from xsd:key[@name='pdbx_nmr_assigned_chem_shift_listKey_0'])
--ALTER TABLE pdbx_nmr_assigned_chem_shift_list ADD CONSTRAINT UNQ_pdbx_nmr_assigned_chem_shift_list UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_nmr_chem_shift_annotationKey_0'])
--ALTER TABLE pdbx_nmr_chem_shift_annotation ADD CONSTRAINT UNQ_pdbx_nmr_chem_shift_annotation UNIQUE ( entry_id, id, list_id );

-- (derived from xsd:key[@name='pdbx_nmr_chem_shift_completenessKey_0'])
--ALTER TABLE pdbx_nmr_chem_shift_completeness ADD CONSTRAINT UNQ_pdbx_nmr_chem_shift_completeness UNIQUE ( entry_id, atom_group, atom_type, list_id );

-- (derived from xsd:key[@name='pdbx_nmr_chem_shift_re_offsetKey_0'])
--ALTER TABLE pdbx_nmr_chem_shift_re_offset ADD CONSTRAINT UNQ_pdbx_nmr_chem_shift_re_offset UNIQUE ( entry_id, atom_type, list_id );

-- (derived from xsd:key[@name='pdbx_nmr_constraintsKey_0'])
--ALTER TABLE pdbx_nmr_constraints ADD CONSTRAINT UNQ_pdbx_nmr_constraints UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_detailsKey_0'])
--ALTER TABLE pdbx_nmr_details ADD CONSTRAINT UNQ_pdbx_nmr_details UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_dihedral_angle_violationKey_0'])
--ALTER TABLE pdbx_nmr_dihedral_angle_violation ADD CONSTRAINT UNQ_pdbx_nmr_dihedral_angle_violation UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_dihedral_angle_violation_ensembleKey_0'])
--ALTER TABLE pdbx_nmr_dihedral_angle_violation_ensemble ADD CONSTRAINT UNQ_pdbx_nmr_dihedral_angle_violation_ensemble UNIQUE ( entry_id, fraction_ensemble_size );

-- (derived from xsd:key[@name='pdbx_nmr_dihedral_angle_violation_modelKey_0'])
--ALTER TABLE pdbx_nmr_dihedral_angle_violation_model ADD CONSTRAINT UNQ_pdbx_nmr_dihedral_angle_violation_model UNIQUE ( entry_id, "PDB_model_num" );

-- (derived from xsd:key[@name='pdbx_nmr_dihedral_angle_violation_pluralKey_0'])
--ALTER TABLE pdbx_nmr_dihedral_angle_violation_plural ADD CONSTRAINT UNQ_pdbx_nmr_dihedral_angle_violation_plural UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_dihedral_angle_violation_summaryKey_0'])
--ALTER TABLE pdbx_nmr_dihedral_angle_violation_summary ADD CONSTRAINT UNQ_pdbx_nmr_dihedral_angle_violation_summary UNIQUE ( entry_id, type );

-- (derived from xsd:key[@name='pdbx_nmr_distance_violationKey_0'])
--ALTER TABLE pdbx_nmr_distance_violation ADD CONSTRAINT UNQ_pdbx_nmr_distance_violation UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_distance_violation_ensembleKey_0'])
--ALTER TABLE pdbx_nmr_distance_violation_ensemble ADD CONSTRAINT UNQ_pdbx_nmr_distance_violation_ensemble UNIQUE ( entry_id, fraction_ensemble_size );

-- (derived from xsd:key[@name='pdbx_nmr_distance_violation_modelKey_0'])
--ALTER TABLE pdbx_nmr_distance_violation_model ADD CONSTRAINT UNQ_pdbx_nmr_distance_violation_model UNIQUE ( entry_id, "PDB_model_num" );

-- (derived from xsd:key[@name='pdbx_nmr_distance_violation_pluralKey_0'])
--ALTER TABLE pdbx_nmr_distance_violation_plural ADD CONSTRAINT UNQ_pdbx_nmr_distance_violation_plural UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_distance_violation_summaryKey_0'])
--ALTER TABLE pdbx_nmr_distance_violation_summary ADD CONSTRAINT UNQ_pdbx_nmr_distance_violation_summary UNIQUE ( entry_id, subtype, type );

-- (derived from xsd:key[@name='pdbx_nmr_ensembleKey_0'])
--ALTER TABLE pdbx_nmr_ensemble ADD CONSTRAINT UNQ_pdbx_nmr_ensemble UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_ensemble_rmsKey_0'])
--ALTER TABLE pdbx_nmr_ensemble_rms ADD CONSTRAINT UNQ_pdbx_nmr_ensemble_rms UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_exptlKey_0'])
--ALTER TABLE pdbx_nmr_exptl ADD CONSTRAINT UNQ_pdbx_nmr_exptl UNIQUE ( entry_id, conditions_id, experiment_id, solution_id );

-- (derived from xsd:key[@name='pdbx_nmr_exptl_sampleKey_0'])
--ALTER TABLE pdbx_nmr_exptl_sample ADD CONSTRAINT UNQ_pdbx_nmr_exptl_sample UNIQUE ( entry_id, component, solution_id );

-- (derived from xsd:key[@name='pdbx_nmr_exptl_sample_conditionsKey_0'])
--ALTER TABLE pdbx_nmr_exptl_sample_conditions ADD CONSTRAINT UNQ_pdbx_nmr_exptl_sample_conditions UNIQUE ( entry_id, conditions_id );

-- (derived from xsd:key[@name='pdbx_nmr_force_constantsKey_0'])
--ALTER TABLE pdbx_nmr_force_constants ADD CONSTRAINT UNQ_pdbx_nmr_force_constants UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_refineKey_0'])
--ALTER TABLE pdbx_nmr_refine ADD CONSTRAINT UNQ_pdbx_nmr_refine UNIQUE ( entry_id, software_ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_representativeKey_0'])
--ALTER TABLE pdbx_nmr_representative ADD CONSTRAINT UNQ_pdbx_nmr_representative UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_restraint_listKey_0'])
--ALTER TABLE pdbx_nmr_restraint_list ADD CONSTRAINT UNQ_pdbx_nmr_restraint_list UNIQUE ( entry_id, id, type );

-- (derived from xsd:key[@name='pdbx_nmr_restraint_summaryKey_0'])
--ALTER TABLE pdbx_nmr_restraint_summary ADD CONSTRAINT UNQ_pdbx_nmr_restraint_summary UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_nmr_restraint_violationKey_0'])
--ALTER TABLE pdbx_nmr_restraint_violation ADD CONSTRAINT UNQ_pdbx_nmr_restraint_violation UNIQUE ( entry_id, ordinal, type );

-- (derived from xsd:key[@name='pdbx_nmr_softwareKey_0'])
--ALTER TABLE pdbx_nmr_software ADD CONSTRAINT UNQ_pdbx_nmr_software UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_nmr_spectrometerKey_0'])
--ALTER TABLE pdbx_nmr_spectrometer ADD CONSTRAINT UNQ_pdbx_nmr_spectrometer UNIQUE ( entry_id, spectrometer_id );

-- (derived from xsd:key[@name='pdbx_nmr_unmapped_chem_shiftKey_0'])
--ALTER TABLE pdbx_nmr_unmapped_chem_shift ADD CONSTRAINT UNQ_pdbx_nmr_unmapped_chem_shift UNIQUE ( entry_id, id, list_id );

-- (derived from xsd:key[@name='pdbx_nmr_unparsed_chem_shiftKey_0'])
--ALTER TABLE pdbx_nmr_unparsed_chem_shift ADD CONSTRAINT UNQ_pdbx_nmr_unparsed_chem_shift UNIQUE ( entry_id, id, list_id );

-- (derived from xsd:key[@name='pdbx_nonpoly_schemeKey_0'])
--ALTER TABLE pdbx_nonpoly_scheme ADD CONSTRAINT UNQ_pdbx_nonpoly_scheme UNIQUE ( entry_id, asym_id, ndb_seq_num );

-- (derived from xsd:key[@name='pdbx_percentile_conditionsKey_0'])
--ALTER TABLE pdbx_percentile_conditions ADD CONSTRAINT UNQ_pdbx_percentile_conditions UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_percentile_entity_viewKey_0'])
--ALTER TABLE pdbx_percentile_entity_view ADD CONSTRAINT UNQ_pdbx_percentile_entity_view UNIQUE ( entry_id, "PDB_model_num", conditions_id, label_asym_id, type );

-- (derived from xsd:key[@name='pdbx_percentile_listKey_0'])
--ALTER TABLE pdbx_percentile_list ADD CONSTRAINT UNQ_pdbx_percentile_list UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_percentile_viewKey_0'])
--ALTER TABLE pdbx_percentile_view ADD CONSTRAINT UNQ_pdbx_percentile_view UNIQUE ( entry_id, conditions_id, type );

-- (derived from xsd:key[@name='pdbx_phasing_MAD_setKey_0'])
--ALTER TABLE "pdbx_phasing_MAD_set" ADD CONSTRAINT UNQ_pdbx_phasing_MAD_set UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_phasing_MAD_set_shellKey_0'])
--ALTER TABLE "pdbx_phasing_MAD_set_shell" ADD CONSTRAINT UNQ_pdbx_phasing_MAD_set_shell UNIQUE ( entry_id, d_res_high, d_res_low, id );

-- (derived from xsd:key[@name='pdbx_phasing_MAD_set_siteKey_0'])
--ALTER TABLE "pdbx_phasing_MAD_set_site" ADD CONSTRAINT UNQ_pdbx_phasing_MAD_set_site UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_phasing_MAD_shellKey_0'])
--ALTER TABLE "pdbx_phasing_MAD_shell" ADD CONSTRAINT UNQ_pdbx_phasing_MAD_shell UNIQUE ( entry_id, d_res_high, d_res_low );

-- (derived from xsd:key[@name='pdbx_phasing_MRKey_0'])
--ALTER TABLE "pdbx_phasing_MR" ADD CONSTRAINT UNQ_pdbx_phasing_MR UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_phasing_dmKey_0'])
--ALTER TABLE pdbx_phasing_dm ADD CONSTRAINT UNQ_pdbx_phasing_dm UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_phasing_dm_shellKey_0'])
--ALTER TABLE pdbx_phasing_dm_shell ADD CONSTRAINT UNQ_pdbx_phasing_dm_shell UNIQUE ( entry_id, d_res_high, d_res_low );

-- (derived from xsd:key[@name='pdbx_point_symmetryKey_0'])
--ALTER TABLE pdbx_point_symmetry ADD CONSTRAINT UNQ_pdbx_point_symmetry UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_poly_seq_schemeKey_0'])
--ALTER TABLE pdbx_poly_seq_scheme ADD CONSTRAINT UNQ_pdbx_poly_seq_scheme UNIQUE ( entry_id, asym_id, entity_id, mon_id, seq_id );

-- (derived from xsd:key[@name='pdbx_re_refinementKey_0'])
--ALTER TABLE pdbx_re_refinement ADD CONSTRAINT UNQ_pdbx_re_refinement UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_refineKey_0'])
--ALTER TABLE pdbx_refine ADD CONSTRAINT UNQ_pdbx_refine UNIQUE ( entry_id, pdbx_refine_id );

-- (derived from xsd:key[@name='pdbx_refine_componentKey_0'])
--ALTER TABLE pdbx_refine_component ADD CONSTRAINT UNQ_pdbx_refine_component UNIQUE ( entry_id, label_alt_id, label_asym_id, label_comp_id, label_seq_id );

-- (derived from xsd:key[@name='pdbx_refine_tlsKey_0'])
--ALTER TABLE pdbx_refine_tls ADD CONSTRAINT UNQ_pdbx_refine_tls UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_refine_tls_groupKey_0'])
--ALTER TABLE pdbx_refine_tls_group ADD CONSTRAINT UNQ_pdbx_refine_tls_group UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_refln_signal_binningKey_0'])
--ALTER TABLE pdbx_refln_signal_binning ADD CONSTRAINT UNQ_pdbx_refln_signal_binning UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_reflns_twinKey_0'])
--ALTER TABLE pdbx_reflns_twin ADD CONSTRAINT UNQ_pdbx_reflns_twin UNIQUE ( entry_id, crystal_id, diffrn_id, operator );

-- (derived from xsd:key[@name='pdbx_sequence_rangeKey_0'])
--ALTER TABLE pdbx_sequence_range ADD CONSTRAINT UNQ_pdbx_sequence_range UNIQUE ( entry_id, beg_label_alt_id, beg_label_asym_id, beg_label_comp_id, beg_label_seq_id, end_label_alt_id, end_label_asym_id, end_label_comp_id, end_label_seq_id, seq_range_id );

-- (derived from xsd:key[@name='pdbx_sifts_unp_segmentsKey_0'])
--ALTER TABLE pdbx_sifts_unp_segments ADD CONSTRAINT UNQ_pdbx_sifts_unp_segments UNIQUE ( entry_id, asym_id, entity_id, instance_id, segment_id, unp_acc );

-- (derived from xsd:key[@name='pdbx_sifts_xref_dbKey_0'])
--ALTER TABLE pdbx_sifts_xref_db ADD CONSTRAINT UNQ_pdbx_sifts_xref_db UNIQUE ( entry_id, asym_id, entity_id, seq_id, seq_id_ordinal );

-- (derived from xsd:key[@name='pdbx_sifts_xref_db_segmentsKey_0'])
--ALTER TABLE pdbx_sifts_xref_db_segments ADD CONSTRAINT UNQ_pdbx_sifts_xref_db_segments UNIQUE ( entry_id, asym_id, entity_id, instance_id, segment_id, seq_id_end, seq_id_start, xref_db, xref_db_acc );

-- (derived from xsd:key[@name='pdbx_soln_scatterKey_0'])
--ALTER TABLE pdbx_soln_scatter ADD CONSTRAINT UNQ_pdbx_soln_scatter UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_soln_scatter_modelKey_0'])
--ALTER TABLE pdbx_soln_scatter_model ADD CONSTRAINT UNQ_pdbx_soln_scatter_model UNIQUE ( entry_id, id, scatter_id );

-- (derived from xsd:key[@name='pdbx_struct_assemblyKey_0'])
--ALTER TABLE pdbx_struct_assembly ADD CONSTRAINT UNQ_pdbx_struct_assembly UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_assembly_genKey_0'])
--ALTER TABLE pdbx_struct_assembly_gen ADD CONSTRAINT UNQ_pdbx_struct_assembly_gen UNIQUE ( entry_id, assembly_id, asym_id_list, oper_expression );

-- (derived from xsd:key[@name='pdbx_struct_assembly_propKey_0'])
--ALTER TABLE pdbx_struct_assembly_prop ADD CONSTRAINT UNQ_pdbx_struct_assembly_prop UNIQUE ( entry_id, biol_id, type );

-- (derived from xsd:key[@name='pdbx_struct_asym_genKey_0'])
--ALTER TABLE pdbx_struct_asym_gen ADD CONSTRAINT UNQ_pdbx_struct_asym_gen UNIQUE ( entry_id, entity_inst_id, oper_expression );

-- (derived from xsd:key[@name='pdbx_struct_chem_comp_diagnosticsKey_0'])
--ALTER TABLE pdbx_struct_chem_comp_diagnostics ADD CONSTRAINT UNQ_pdbx_struct_chem_comp_diagnostics UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_struct_conn_angleKey_0'])
--ALTER TABLE pdbx_struct_conn_angle ADD CONSTRAINT UNQ_pdbx_struct_conn_angle UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_entity_instKey_0'])
--ALTER TABLE pdbx_struct_entity_inst ADD CONSTRAINT UNQ_pdbx_struct_entity_inst UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_group_component_rangeKey_0'])
--ALTER TABLE pdbx_struct_group_component_range ADD CONSTRAINT UNQ_pdbx_struct_group_component_range UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_struct_group_componentsKey_0'])
--ALTER TABLE pdbx_struct_group_components ADD CONSTRAINT UNQ_pdbx_struct_group_components UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='pdbx_struct_group_listKey_0'])
--ALTER TABLE pdbx_struct_group_list ADD CONSTRAINT UNQ_pdbx_struct_group_list UNIQUE ( entry_id, struct_group_id );

-- (derived from xsd:key[@name='pdbx_struct_infoKey_0'])
--ALTER TABLE pdbx_struct_info ADD CONSTRAINT UNQ_pdbx_struct_info UNIQUE ( entry_id, type, value );

-- (derived from xsd:key[@name='pdbx_struct_legacy_oper_listKey_0'])
--ALTER TABLE pdbx_struct_legacy_oper_list ADD CONSTRAINT UNQ_pdbx_struct_legacy_oper_list UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_mod_residueKey_0'])
--ALTER TABLE pdbx_struct_mod_residue ADD CONSTRAINT UNQ_pdbx_struct_mod_residue UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_msym_genKey_0'])
--ALTER TABLE pdbx_struct_msym_gen ADD CONSTRAINT UNQ_pdbx_struct_msym_gen UNIQUE ( entry_id, entity_inst_id, msym_id, oper_expression );

-- (derived from xsd:key[@name='pdbx_struct_nmr_ens_clustKey_0'])
--ALTER TABLE pdbx_struct_nmr_ens_clust ADD CONSTRAINT UNQ_pdbx_struct_nmr_ens_clust UNIQUE ( entry_id );

-- (derived from xsd:key[@name='pdbx_struct_nmr_ens_clust_genKey_0'])
--ALTER TABLE pdbx_struct_nmr_ens_clust_gen ADD CONSTRAINT UNQ_pdbx_struct_nmr_ens_clust_gen UNIQUE ( entry_id, "PDB_model_num" );

-- (derived from xsd:key[@name='pdbx_struct_nmr_ens_domKey_0'])
--ALTER TABLE pdbx_struct_nmr_ens_dom ADD CONSTRAINT UNQ_pdbx_struct_nmr_ens_dom UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_nmr_ens_dom_limKey_0'])
--ALTER TABLE pdbx_struct_nmr_ens_dom_lim ADD CONSTRAINT UNQ_pdbx_struct_nmr_ens_dom_lim UNIQUE ( entry_id, component_id, dom_id );

-- (derived from xsd:key[@name='pdbx_struct_oper_listKey_0'])
--ALTER TABLE pdbx_struct_oper_list ADD CONSTRAINT UNQ_pdbx_struct_oper_list UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_ref_seq_deletionKey_0'])
--ALTER TABLE pdbx_struct_ref_seq_deletion ADD CONSTRAINT UNQ_pdbx_struct_ref_seq_deletion UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_ref_seq_insertionKey_0'])
--ALTER TABLE pdbx_struct_ref_seq_insertion ADD CONSTRAINT UNQ_pdbx_struct_ref_seq_insertion UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_struct_sheet_hbondKey_0'])
--ALTER TABLE pdbx_struct_sheet_hbond ADD CONSTRAINT UNQ_pdbx_struct_sheet_hbond UNIQUE ( entry_id, range_id_1, range_id_2, sheet_id );

-- (derived from xsd:key[@name='pdbx_struct_special_symmetryKey_0'])
--ALTER TABLE pdbx_struct_special_symmetry ADD CONSTRAINT UNQ_pdbx_struct_special_symmetry UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_unobs_or_zero_occ_atomsKey_0'])
--ALTER TABLE pdbx_unobs_or_zero_occ_atoms ADD CONSTRAINT UNQ_pdbx_unobs_or_zero_occ_atoms UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_unobs_or_zero_occ_residuesKey_0'])
--ALTER TABLE pdbx_unobs_or_zero_occ_residues ADD CONSTRAINT UNQ_pdbx_unobs_or_zero_occ_residues UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_chiralKey_0'])
--ALTER TABLE pdbx_validate_chiral ADD CONSTRAINT UNQ_pdbx_validate_chiral UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_close_contactKey_0'])
--ALTER TABLE pdbx_validate_close_contact ADD CONSTRAINT UNQ_pdbx_validate_close_contact UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_main_chain_planeKey_0'])
--ALTER TABLE pdbx_validate_main_chain_plane ADD CONSTRAINT UNQ_pdbx_validate_main_chain_plane UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_nmr_chem_shiftKey_0'])
--ALTER TABLE pdbx_validate_nmr_chem_shift ADD CONSTRAINT UNQ_pdbx_validate_nmr_chem_shift UNIQUE ( entry_id, id, list_id );

-- (derived from xsd:key[@name='pdbx_validate_peptide_omegaKey_0'])
--ALTER TABLE pdbx_validate_peptide_omega ADD CONSTRAINT UNQ_pdbx_validate_peptide_omega UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_planesKey_0'])
--ALTER TABLE pdbx_validate_planes ADD CONSTRAINT UNQ_pdbx_validate_planes UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_planes_atomKey_0'])
--ALTER TABLE pdbx_validate_planes_atom ADD CONSTRAINT UNQ_pdbx_validate_planes_atom UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_polymer_linkageKey_0'])
--ALTER TABLE pdbx_validate_polymer_linkage ADD CONSTRAINT UNQ_pdbx_validate_polymer_linkage UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_angleKey_0'])
--ALTER TABLE pdbx_validate_rmsd_angle ADD CONSTRAINT UNQ_pdbx_validate_rmsd_angle UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_bondKey_0'])
--ALTER TABLE pdbx_validate_rmsd_bond ADD CONSTRAINT UNQ_pdbx_validate_rmsd_bond UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_ringKey_0'])
--ALTER TABLE pdbx_validate_rmsd_ring ADD CONSTRAINT UNQ_pdbx_validate_rmsd_ring UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_rings_atomKey_0'])
--ALTER TABLE pdbx_validate_rmsd_rings_atom ADD CONSTRAINT UNQ_pdbx_validate_rmsd_rings_atom UNIQUE ( entry_id, id, ring_id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_torsionKey_0'])
--ALTER TABLE pdbx_validate_rmsd_torsion ADD CONSTRAINT UNQ_pdbx_validate_rmsd_torsion UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_rmsd_torsions_atomKey_0'])
--ALTER TABLE pdbx_validate_rmsd_torsions_atom ADD CONSTRAINT UNQ_pdbx_validate_rmsd_torsions_atom UNIQUE ( entry_id, id, torsion_id );

-- (derived from xsd:key[@name='pdbx_validate_symm_contactKey_0'])
--ALTER TABLE pdbx_validate_symm_contact ADD CONSTRAINT UNQ_pdbx_validate_symm_contact UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validate_torsionKey_0'])
--ALTER TABLE pdbx_validate_torsion ADD CONSTRAINT UNQ_pdbx_validate_torsion UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='pdbx_validation_softwareKey_0'])
--ALTER TABLE pdbx_validation_software ADD CONSTRAINT UNQ_pdbx_validation_software UNIQUE ( entry_id, ordinal );

-- (derived from xsd:key[@name='phasingKey_0'])
--ALTER TABLE phasing ADD CONSTRAINT UNQ_phasing UNIQUE ( entry_id, method );

-- (derived from xsd:key[@name='phasing_MADKey_0'])
--ALTER TABLE "phasing_MAD" ADD CONSTRAINT UNQ_phasing_MAD UNIQUE ( entry_id );

-- (derived from xsd:key[@name='phasing_MAD_clustKey_0'])
--ALTER TABLE "phasing_MAD_clust" ADD CONSTRAINT UNQ_phasing_MAD_clust UNIQUE ( entry_id, expt_id, id );

-- (derived from xsd:key[@name='phasing_MAD_exptKey_0'])
--ALTER TABLE "phasing_MAD_expt" ADD CONSTRAINT UNQ_phasing_MAD_expt UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='phasing_MAD_ratioKey_0'])
--ALTER TABLE "phasing_MAD_ratio" ADD CONSTRAINT UNQ_phasing_MAD_ratio UNIQUE ( entry_id, clust_id, expt_id, wavelength_1, wavelength_2 );

-- (derived from xsd:key[@name='phasing_MAD_setKey_0'])
--ALTER TABLE "phasing_MAD_set" ADD CONSTRAINT UNQ_phasing_MAD_set UNIQUE ( entry_id, clust_id, expt_id, set_id, wavelength );

-- (derived from xsd:key[@name='phasing_MIRKey_0'])
--ALTER TABLE "phasing_MIR" ADD CONSTRAINT UNQ_phasing_MIR UNIQUE ( entry_id );

-- (derived from xsd:key[@name='phasing_MIR_derKey_0'])
--ALTER TABLE "phasing_MIR_der" ADD CONSTRAINT UNQ_phasing_MIR_der UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='phasing_MIR_der_reflnKey_0'])
--ALTER TABLE "phasing_MIR_der_refln" ADD CONSTRAINT UNQ_phasing_MIR_der_refln UNIQUE ( entry_id, der_id, index_h, index_k, index_l, set_id );

-- (derived from xsd:key[@name='phasing_MIR_der_shellKey_0'])
--ALTER TABLE "phasing_MIR_der_shell" ADD CONSTRAINT UNQ_phasing_MIR_der_shell UNIQUE ( entry_id, d_res_high, d_res_low, der_id );

-- (derived from xsd:key[@name='phasing_MIR_der_siteKey_0'])
--ALTER TABLE "phasing_MIR_der_site" ADD CONSTRAINT UNQ_phasing_MIR_der_site UNIQUE ( entry_id, der_id, id );

-- (derived from xsd:key[@name='phasing_MIR_shellKey_0'])
--ALTER TABLE "phasing_MIR_shell" ADD CONSTRAINT UNQ_phasing_MIR_shell UNIQUE ( entry_id, d_res_high, d_res_low );

-- (derived from xsd:key[@name='phasing_averagingKey_0'])
--ALTER TABLE phasing_averaging ADD CONSTRAINT UNQ_phasing_averaging UNIQUE ( entry_id );

-- (derived from xsd:key[@name='phasing_isomorphousKey_0'])
--ALTER TABLE phasing_isomorphous ADD CONSTRAINT UNQ_phasing_isomorphous UNIQUE ( entry_id );

-- (derived from xsd:key[@name='phasing_setKey_0'])
--ALTER TABLE phasing_set ADD CONSTRAINT UNQ_phasing_set UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='phasing_set_reflnKey_0'])
--ALTER TABLE phasing_set_refln ADD CONSTRAINT UNQ_phasing_set_refln UNIQUE ( entry_id, index_h, index_k, index_l, set_id );

-- (derived from xsd:key[@name='refineKey_0'])
--ALTER TABLE refine ADD CONSTRAINT UNQ_refine UNIQUE ( entry_id, pdbx_refine_id );

-- (derived from xsd:key[@name='refine_B_isoKey_0'])
--ALTER TABLE "refine_B_iso" ADD CONSTRAINT UNQ_refine_B_iso UNIQUE ( entry_id, class, pdbx_refine_id );

-- (derived from xsd:key[@name='refine_analyzeKey_0'])
--ALTER TABLE refine_analyze ADD CONSTRAINT UNQ_refine_analyze UNIQUE ( entry_id, pdbx_refine_id );

-- (derived from xsd:key[@name='refine_funct_minimizedKey_0'])
--ALTER TABLE refine_funct_minimized ADD CONSTRAINT UNQ_refine_funct_minimized UNIQUE ( entry_id, pdbx_refine_id, type );

-- (derived from xsd:key[@name='refine_histKey_0'])
--ALTER TABLE refine_hist ADD CONSTRAINT UNQ_refine_hist UNIQUE ( entry_id, cycle_id, pdbx_refine_id );

-- (derived from xsd:key[@name='refine_ls_classKey_0'])
--ALTER TABLE refine_ls_class ADD CONSTRAINT UNQ_refine_ls_class UNIQUE ( entry_id, code );

-- (derived from xsd:key[@name='refine_ls_restrKey_0'])
--ALTER TABLE refine_ls_restr ADD CONSTRAINT UNQ_refine_ls_restr UNIQUE ( entry_id, pdbx_refine_id, type );

-- (derived from xsd:key[@name='refine_ls_restr_ncsKey_0'])
--ALTER TABLE refine_ls_restr_ncs ADD CONSTRAINT UNQ_refine_ls_restr_ncs UNIQUE ( entry_id, pdbx_ordinal );

-- (derived from xsd:key[@name='refine_ls_restr_typeKey_0'])
--ALTER TABLE refine_ls_restr_type ADD CONSTRAINT UNQ_refine_ls_restr_type UNIQUE ( entry_id, type );

-- (derived from xsd:key[@name='refine_ls_shellKey_0'])
--ALTER TABLE refine_ls_shell ADD CONSTRAINT UNQ_refine_ls_shell UNIQUE ( entry_id, d_res_high, pdbx_refine_id );

-- (derived from xsd:key[@name='refine_occupancyKey_0'])
--ALTER TABLE refine_occupancy ADD CONSTRAINT UNQ_refine_occupancy UNIQUE ( entry_id, class, pdbx_refine_id );

-- (derived from xsd:key[@name='reflnKey_0'])
--ALTER TABLE refln ADD CONSTRAINT UNQ_refln UNIQUE ( entry_id, index_h, index_k, index_l );

-- (derived from xsd:key[@name='refln_sys_absKey_0'])
--ALTER TABLE refln_sys_abs ADD CONSTRAINT UNQ_refln_sys_abs UNIQUE ( entry_id, index_h, index_k, index_l );

-- (derived from xsd:key[@name='reflnsKey_0'])
--ALTER TABLE reflns ADD CONSTRAINT UNQ_reflns UNIQUE ( entry_id, pdbx_ordinal );

-- (derived from xsd:key[@name='reflns_classKey_0'])
--ALTER TABLE reflns_class ADD CONSTRAINT UNQ_reflns_class UNIQUE ( entry_id, code );

-- (derived from xsd:key[@name='reflns_scaleKey_0'])
--ALTER TABLE reflns_scale ADD CONSTRAINT UNQ_reflns_scale UNIQUE ( entry_id, group_code );

-- (derived from xsd:key[@name='reflns_shellKey_0'])
--ALTER TABLE reflns_shell ADD CONSTRAINT UNQ_reflns_shell UNIQUE ( entry_id, pdbx_ordinal );

-- (derived from xsd:key[@name='space_groupKey_0'])
--ALTER TABLE space_group ADD CONSTRAINT UNQ_space_group UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='space_group_symopKey_0'])
--ALTER TABLE space_group_symop ADD CONSTRAINT UNQ_space_group_symop UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='structKey_0'])
--ALTER TABLE struct ADD CONSTRAINT UNQ_struct UNIQUE ( entry_id );

-- (derived from xsd:key[@name='struct_asymKey_0'])
--ALTER TABLE struct_asym ADD CONSTRAINT UNQ_struct_asym UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_biolKey_0'])
--ALTER TABLE struct_biol ADD CONSTRAINT UNQ_struct_biol UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_biol_viewKey_0'])
--ALTER TABLE struct_biol_view ADD CONSTRAINT UNQ_struct_biol_view UNIQUE ( entry_id, biol_id, id );

-- (derived from xsd:key[@name='struct_confKey_0'])
--ALTER TABLE struct_conf ADD CONSTRAINT UNQ_struct_conf UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_conf_typeKey_0'])
--ALTER TABLE struct_conf_type ADD CONSTRAINT UNQ_struct_conf_type UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_connKey_0'])
--ALTER TABLE struct_conn ADD CONSTRAINT UNQ_struct_conn UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_conn_typeKey_0'])
--ALTER TABLE struct_conn_type ADD CONSTRAINT UNQ_struct_conn_type UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_mon_detailsKey_0'])
--ALTER TABLE struct_mon_details ADD CONSTRAINT UNQ_struct_mon_details UNIQUE ( entry_id );

-- (derived from xsd:key[@name='struct_mon_nuclKey_0'])
--ALTER TABLE struct_mon_nucl ADD CONSTRAINT UNQ_struct_mon_nucl UNIQUE ( entry_id, pdbx_id );

-- (derived from xsd:key[@name='struct_mon_protKey_0'])
--ALTER TABLE struct_mon_prot ADD CONSTRAINT UNQ_struct_mon_prot UNIQUE ( entry_id, pdbx_id );

-- (derived from xsd:key[@name='struct_mon_prot_cisKey_0'])
--ALTER TABLE struct_mon_prot_cis ADD CONSTRAINT UNQ_struct_mon_prot_cis UNIQUE ( entry_id, pdbx_id );

-- (derived from xsd:key[@name='struct_ncs_domKey_0'])
--ALTER TABLE struct_ncs_dom ADD CONSTRAINT UNQ_struct_ncs_dom UNIQUE ( entry_id, id, pdbx_ens_id );

-- (derived from xsd:key[@name='struct_ncs_dom_limKey_0'])
--ALTER TABLE struct_ncs_dom_lim ADD CONSTRAINT UNQ_struct_ncs_dom_lim UNIQUE ( entry_id, dom_id, pdbx_component_id, pdbx_ens_id );

-- (derived from xsd:key[@name='struct_ncs_ensKey_0'])
--ALTER TABLE struct_ncs_ens ADD CONSTRAINT UNQ_struct_ncs_ens UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_ncs_ens_genKey_0'])
--ALTER TABLE struct_ncs_ens_gen ADD CONSTRAINT UNQ_struct_ncs_ens_gen UNIQUE ( entry_id, dom_id_1, dom_id_2, ens_id, oper_id );

-- (derived from xsd:key[@name='struct_ncs_operKey_0'])
--ALTER TABLE struct_ncs_oper ADD CONSTRAINT UNQ_struct_ncs_oper UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_refKey_0'])
--ALTER TABLE struct_ref ADD CONSTRAINT UNQ_struct_ref UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_ref_seqKey_0'])
--ALTER TABLE struct_ref_seq ADD CONSTRAINT UNQ_struct_ref_seq UNIQUE ( entry_id, align_id );

-- (derived from xsd:key[@name='struct_ref_seq_difKey_0'])
--ALTER TABLE struct_ref_seq_dif ADD CONSTRAINT UNQ_struct_ref_seq_dif UNIQUE ( entry_id, pdbx_ordinal );

-- (derived from xsd:key[@name='struct_sheetKey_0'])
--ALTER TABLE struct_sheet ADD CONSTRAINT UNQ_struct_sheet UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_sheet_hbondKey_0'])
--ALTER TABLE struct_sheet_hbond ADD CONSTRAINT UNQ_struct_sheet_hbond UNIQUE ( entry_id, range_id_1, range_id_2, sheet_id );

-- (derived from xsd:key[@name='struct_sheet_orderKey_0'])
--ALTER TABLE struct_sheet_order ADD CONSTRAINT UNQ_struct_sheet_order UNIQUE ( entry_id, range_id_1, range_id_2, sheet_id );

-- (derived from xsd:key[@name='struct_sheet_rangeKey_0'])
--ALTER TABLE struct_sheet_range ADD CONSTRAINT UNQ_struct_sheet_range UNIQUE ( entry_id, id, sheet_id );

-- (derived from xsd:key[@name='struct_sheet_topologyKey_0'])
--ALTER TABLE struct_sheet_topology ADD CONSTRAINT UNQ_struct_sheet_topology UNIQUE ( entry_id, range_id_1, range_id_2, sheet_id );

-- (derived from xsd:key[@name='struct_siteKey_0'])
--ALTER TABLE struct_site ADD CONSTRAINT UNQ_struct_site UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='struct_site_genKey_0'])
--ALTER TABLE struct_site_gen ADD CONSTRAINT UNQ_struct_site_gen UNIQUE ( entry_id, id, site_id );

-- (derived from xsd:key[@name='struct_site_viewKey_0'])
--ALTER TABLE struct_site_view ADD CONSTRAINT UNQ_struct_site_view UNIQUE ( entry_id, id );

-- (derived from xsd:key[@name='symmetryKey_0'])
--ALTER TABLE symmetry ADD CONSTRAINT UNQ_symmetry UNIQUE ( entry_id );

-- (derived from xsd:key[@name='symmetry_equivKey_0'])
--ALTER TABLE symmetry_equiv ADD CONSTRAINT UNQ_symmetry_equiv UNIQUE ( entry_id, id );

-- (derived from xsd:unique[@name='struct_asymUnique_1'])
--ALTER TABLE struct_asym ADD CONSTRAINT UNQ_struct_asym UNIQUE ( entry_id, entity_id, id );

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_0_0'])
--ALTER TABLE diffrn_detector ADD CONSTRAINT KR_diffrnKeyref_0_0_0_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_1_0'])
--ALTER TABLE diffrn_measurement ADD CONSTRAINT KR_diffrnKeyref_0_0_1_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_2_0'])
--ALTER TABLE diffrn_orient_matrix ADD CONSTRAINT KR_diffrnKeyref_0_0_2_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_3_0'])
--ALTER TABLE diffrn_orient_refln ADD CONSTRAINT KR_diffrnKeyref_0_0_3_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_4_0'])
--ALTER TABLE diffrn_radiation ADD CONSTRAINT KR_diffrnKeyref_0_0_4_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_5_0'])
--ALTER TABLE diffrn_refln ADD CONSTRAINT KR_diffrnKeyref_0_0_5_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_6_0'])
--ALTER TABLE diffrn_reflns ADD CONSTRAINT KR_diffrnKeyref_0_0_6_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_7_0'])
--ALTER TABLE diffrn_source ADD CONSTRAINT KR_diffrnKeyref_0_0_7_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_8_0'])
--ALTER TABLE diffrn_standard_refln ADD CONSTRAINT KR_diffrnKeyref_0_0_8_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_9_0'])
--ALTER TABLE diffrn_standards ADD CONSTRAINT KR_diffrnKeyref_0_0_9_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='diffrnKeyref_0_0_10_0'])
--ALTER TABLE pdbx_diffrn_reflns_shell ADD CONSTRAINT KR_diffrnKeyref_0_0_10_0 FOREIGN KEY ( diffrn_id ) REFERENCES diffrn ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_0_0'])
--ALTER TABLE em_entity_assembly_molwt ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_0_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_1_0'])
--ALTER TABLE em_entity_assembly_naturalsource ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_1_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_2_0'])
--ALTER TABLE em_entity_assembly_recombinant ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_2_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_3_0'])
--ALTER TABLE em_entity_assembly_synthetic ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_3_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_4_0'])
--ALTER TABLE em_virus_entity ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_4_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_5_0'])
--ALTER TABLE em_virus_natural_host ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_5_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_6_0'])
--ALTER TABLE em_virus_shell ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_6_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='em_entity_assemblyKeyref_0_0_7_0'])
--ALTER TABLE em_virus_synthetic ADD CONSTRAINT KR_em_entity_assemblyKeyref_0_0_7_0 FOREIGN KEY ( entity_assembly_id ) REFERENCES em_entity_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_0_0'])
--ALTER TABLE entity_name_com ADD CONSTRAINT KR_entityKeyref_0_0_0_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_1_0'])
--ALTER TABLE entity_name_sys ADD CONSTRAINT KR_entityKeyref_0_0_1_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_2_0'])
--ALTER TABLE entity_poly ADD CONSTRAINT KR_entityKeyref_0_0_2_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_3_0'])
--ALTER TABLE pdbx_branch_scheme ADD CONSTRAINT KR_entityKeyref_0_0_3_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_4_0'])
--ALTER TABLE pdbx_entity_assembly ADD CONSTRAINT KR_entityKeyref_0_0_4_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_5_0'])
--ALTER TABLE pdbx_entity_branch ADD CONSTRAINT KR_entityKeyref_0_0_5_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_6_0'])
--ALTER TABLE pdbx_entity_branch_descriptor ADD CONSTRAINT KR_entityKeyref_0_0_6_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_7_0'])
--ALTER TABLE pdbx_entity_branch_list ADD CONSTRAINT KR_entityKeyref_0_0_7_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_8_0'])
--ALTER TABLE pdbx_entity_descriptor ADD CONSTRAINT KR_entityKeyref_0_0_8_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_9_0'])
--ALTER TABLE pdbx_entity_nonpoly ADD CONSTRAINT KR_entityKeyref_0_0_9_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_10_0'])
--ALTER TABLE struct_asym ADD CONSTRAINT KR_entityKeyref_0_0_10_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entityKeyref_0_0_11_0'])
--ALTER TABLE struct_ref ADD CONSTRAINT KR_entityKeyref_0_0_11_0 FOREIGN KEY ( entity_id ) REFERENCES entity ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_polyKeyref_0_0_0_0'])
--ALTER TABLE entity_poly_seq ADD CONSTRAINT KR_entity_polyKeyref_0_0_0_0 FOREIGN KEY ( entity_id ) REFERENCES entity_poly ( entity_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_0_0'])
--ALTER TABLE pdbx_entity_poly_comp_link_list ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_0_0_0 FOREIGN KEY ( entity_id ) REFERENCES entity_poly_seq ( entity_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_0_0'])
--ALTER TABLE pdbx_entity_poly_comp_link_list ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_0_0_1 FOREIGN KEY ( comp_id_1 ) REFERENCES entity_poly_seq ( mon_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_0_0'])
--ALTER TABLE pdbx_entity_poly_comp_link_list ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_0_0_2 FOREIGN KEY ( entity_comp_num_1 ) REFERENCES entity_poly_seq ( num ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_1_0'])
--ALTER TABLE pdbx_poly_seq_scheme ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_1_0_0 FOREIGN KEY ( entity_id ) REFERENCES entity_poly_seq ( entity_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_1_0'])
--ALTER TABLE pdbx_poly_seq_scheme ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_1_0_1 FOREIGN KEY ( mon_id ) REFERENCES entity_poly_seq ( mon_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entity_poly_seqKeyref_0_0_1_0'])
--ALTER TABLE pdbx_poly_seq_scheme ADD CONSTRAINT KR_entity_poly_seqKeyref_0_0_1_0_2 FOREIGN KEY ( seq_id ) REFERENCES entity_poly_seq ( num ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_0_0'])
--ALTER TABLE em_3d_fitting ADD CONSTRAINT KR_entryKeyref_0_0_0_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_1_0'])
--ALTER TABLE em_3d_reconstruction ADD CONSTRAINT KR_entryKeyref_0_0_1_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_2_0'])
--ALTER TABLE em_experiment ADD CONSTRAINT KR_entryKeyref_0_0_2_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_3_0'])
--ALTER TABLE em_image_scans ADD CONSTRAINT KR_entryKeyref_0_0_3_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_4_0'])
--ALTER TABLE em_imaging ADD CONSTRAINT KR_entryKeyref_0_0_4_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_5_0'])
--ALTER TABLE em_vitrification ADD CONSTRAINT KR_entryKeyref_0_0_5_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_6_0'])
--ALTER TABLE entry_link ADD CONSTRAINT KR_entryKeyref_0_0_6_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_7_0'])
--ALTER TABLE exptl ADD CONSTRAINT KR_entryKeyref_0_0_7_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_8_0'])
--ALTER TABLE ndb_struct_conf_na ADD CONSTRAINT KR_entryKeyref_0_0_8_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_9_0'])
--ALTER TABLE pdbx_database_status ADD CONSTRAINT KR_entryKeyref_0_0_9_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_10_0'])
--ALTER TABLE pdbx_dcc_density ADD CONSTRAINT KR_entryKeyref_0_0_10_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_11_0'])
--ALTER TABLE pdbx_dcc_geometry ADD CONSTRAINT KR_entryKeyref_0_0_11_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_12_0'])
--ALTER TABLE pdbx_dcc_map_overall ADD CONSTRAINT KR_entryKeyref_0_0_12_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_13_0'])
--ALTER TABLE pdbx_dcc_mapman ADD CONSTRAINT KR_entryKeyref_0_0_13_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_14_0'])
--ALTER TABLE pdbx_dcc_rscc_mapman_overall ADD CONSTRAINT KR_entryKeyref_0_0_14_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_15_0'])
--ALTER TABLE pdbx_em_validate_map_model_overall ADD CONSTRAINT KR_entryKeyref_0_0_15_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_16_0'])
--ALTER TABLE pdbx_entry_details ADD CONSTRAINT KR_entryKeyref_0_0_16_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_17_0'])
--ALTER TABLE pdbx_helical_symmetry ADD CONSTRAINT KR_entryKeyref_0_0_17_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_18_0'])
--ALTER TABLE pdbx_nmr_constraints ADD CONSTRAINT KR_entryKeyref_0_0_18_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_19_0'])
--ALTER TABLE pdbx_nmr_details ADD CONSTRAINT KR_entryKeyref_0_0_19_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_20_0'])
--ALTER TABLE pdbx_nmr_ensemble ADD CONSTRAINT KR_entryKeyref_0_0_20_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_21_0'])
--ALTER TABLE pdbx_nmr_ensemble_rms ADD CONSTRAINT KR_entryKeyref_0_0_21_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_22_0'])
--ALTER TABLE pdbx_nmr_force_constants ADD CONSTRAINT KR_entryKeyref_0_0_22_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_23_0'])
--ALTER TABLE pdbx_nmr_refine ADD CONSTRAINT KR_entryKeyref_0_0_23_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_24_0'])
--ALTER TABLE pdbx_nmr_representative ADD CONSTRAINT KR_entryKeyref_0_0_24_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_25_0'])
--ALTER TABLE pdbx_nmr_restraint_summary ADD CONSTRAINT KR_entryKeyref_0_0_25_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_26_0'])
--ALTER TABLE pdbx_percentile_list ADD CONSTRAINT KR_entryKeyref_0_0_26_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_27_0'])
--ALTER TABLE pdbx_percentile_view ADD CONSTRAINT KR_entryKeyref_0_0_27_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_28_0'])
--ALTER TABLE pdbx_point_symmetry ADD CONSTRAINT KR_entryKeyref_0_0_28_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_29_0'])
--ALTER TABLE pdbx_refine ADD CONSTRAINT KR_entryKeyref_0_0_29_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_30_0'])
--ALTER TABLE pdbx_soln_scatter ADD CONSTRAINT KR_entryKeyref_0_0_30_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_31_0'])
--ALTER TABLE pdbx_struct_nmr_ens_clust ADD CONSTRAINT KR_entryKeyref_0_0_31_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_32_0'])
--ALTER TABLE "phasing_MAD" ADD CONSTRAINT KR_entryKeyref_0_0_32_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_33_0'])
--ALTER TABLE "phasing_MIR" ADD CONSTRAINT KR_entryKeyref_0_0_33_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_34_0'])
--ALTER TABLE phasing_averaging ADD CONSTRAINT KR_entryKeyref_0_0_34_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_35_0'])
--ALTER TABLE phasing_isomorphous ADD CONSTRAINT KR_entryKeyref_0_0_35_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_36_0'])
--ALTER TABLE refine ADD CONSTRAINT KR_entryKeyref_0_0_36_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_37_0'])
--ALTER TABLE refine_analyze ADD CONSTRAINT KR_entryKeyref_0_0_37_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_38_0'])
--ALTER TABLE reflns ADD CONSTRAINT KR_entryKeyref_0_0_38_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_39_0'])
--ALTER TABLE struct ADD CONSTRAINT KR_entryKeyref_0_0_39_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_40_0'])
--ALTER TABLE struct_mon_details ADD CONSTRAINT KR_entryKeyref_0_0_40_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='entryKeyref_0_0_41_0'])
--ALTER TABLE symmetry ADD CONSTRAINT KR_entryKeyref_0_0_41_0 FOREIGN KEY ( entry_id ) REFERENCES entry ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_0_0'])
--ALTER TABLE pdbx_audit_revision_category ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_0_0_0 FOREIGN KEY ( data_content_type ) REFERENCES pdbx_audit_revision_history ( data_content_type ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_0_0'])
--ALTER TABLE pdbx_audit_revision_category ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_0_0_1 FOREIGN KEY ( revision_ordinal ) REFERENCES pdbx_audit_revision_history ( ordinal ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_1_0'])
--ALTER TABLE pdbx_audit_revision_details ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_1_0_0 FOREIGN KEY ( data_content_type ) REFERENCES pdbx_audit_revision_history ( data_content_type ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_1_0'])
--ALTER TABLE pdbx_audit_revision_details ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_1_0_1 FOREIGN KEY ( revision_ordinal ) REFERENCES pdbx_audit_revision_history ( ordinal ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_2_0'])
--ALTER TABLE pdbx_audit_revision_group ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_2_0_0 FOREIGN KEY ( data_content_type ) REFERENCES pdbx_audit_revision_history ( data_content_type ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_2_0'])
--ALTER TABLE pdbx_audit_revision_group ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_2_0_1 FOREIGN KEY ( revision_ordinal ) REFERENCES pdbx_audit_revision_history ( ordinal ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_3_0'])
--ALTER TABLE pdbx_audit_revision_item ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_3_0_0 FOREIGN KEY ( data_content_type ) REFERENCES pdbx_audit_revision_history ( data_content_type ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_audit_revision_historyKeyref_0_0_3_0'])
--ALTER TABLE pdbx_audit_revision_item ADD CONSTRAINT KR_pdbx_audit_revision_historyKeyref_0_0_3_0_1 FOREIGN KEY ( revision_ordinal ) REFERENCES pdbx_audit_revision_history ( ordinal ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_domainKeyref_0_0_0_0'])
--ALTER TABLE pdbx_domain_range ADD CONSTRAINT KR_pdbx_domainKeyref_0_0_0_0 FOREIGN KEY ( domain_id ) REFERENCES pdbx_domain ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_atom_inclusionKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_atom_inclusion_marker ADD CONSTRAINT KR_pdbx_em_atom_inclusionKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_atom_inclusion ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_density_distributionKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_density_distribution_marker ADD CONSTRAINT KR_pdbx_em_density_distributionKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_density_distribution ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_fsc_curveKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_fsc_curve_marker ADD CONSTRAINT KR_pdbx_em_fsc_curveKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_fsc_curve ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_fsc_curveKeyref_0_0_1_0'])
--ALTER TABLE pdbx_em_fsc_resolution ADD CONSTRAINT KR_pdbx_em_fsc_curveKeyref_0_0_1_0 FOREIGN KEY ( fsc_curve_id ) REFERENCES pdbx_em_fsc_curve ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_fsc_cutoff_curveKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_fsc_cutoff_curve_marker ADD CONSTRAINT KR_pdbx_em_fsc_cutoff_curveKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_fsc_cutoff_curve ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_fsc_cutoff_curveKeyref_0_0_1_0'])
--ALTER TABLE pdbx_em_fsc_resolution ADD CONSTRAINT KR_pdbx_em_fsc_cutoff_curveKeyref_0_0_1_0 FOREIGN KEY ( fsc_cutoff_curve_id ) REFERENCES pdbx_em_fsc_cutoff_curve ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_rapsKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_raps_marker ADD CONSTRAINT KR_pdbx_em_rapsKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_raps ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_raw_rapsKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_raw_raps_marker ADD CONSTRAINT KR_pdbx_em_raw_rapsKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_raw_raps ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_em_volume_estimateKeyref_0_0_0_0'])
--ALTER TABLE pdbx_em_volume_estimate_marker ADD CONSTRAINT KR_pdbx_em_volume_estimateKeyref_0_0_0_0 FOREIGN KEY ( plot_id ) REFERENCES pdbx_em_volume_estimate ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_0_0'])
--ALTER TABLE pdbx_missing_nmr_star_item ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_0_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_1_0'])
--ALTER TABLE pdbx_nmr_chem_shift_annotation ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_1_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_2_0'])
--ALTER TABLE pdbx_nmr_chem_shift_completeness ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_2_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_3_0'])
--ALTER TABLE pdbx_nmr_chem_shift_re_offset ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_3_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_4_0'])
--ALTER TABLE pdbx_nmr_unmapped_chem_shift ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_4_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_5_0'])
--ALTER TABLE pdbx_nmr_unparsed_chem_shift ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_5_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_nmr_assigned_chem_shift_listKeyref_0_0_6_0'])
--ALTER TABLE pdbx_validate_nmr_chem_shift ADD CONSTRAINT KR_pdbx_nmr_assigned_chem_shift_listKeyref_0_0_6_0 FOREIGN KEY ( list_id ) REFERENCES pdbx_nmr_assigned_chem_shift_list ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_percentile_conditionsKeyref_0_0_0_0'])
--ALTER TABLE pdbx_percentile_entity_view ADD CONSTRAINT KR_pdbx_percentile_conditionsKeyref_0_0_0_0 FOREIGN KEY ( conditions_id ) REFERENCES pdbx_percentile_conditions ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_percentile_conditionsKeyref_0_0_1_0'])
--ALTER TABLE pdbx_percentile_view ADD CONSTRAINT KR_pdbx_percentile_conditionsKeyref_0_0_1_0 FOREIGN KEY ( conditions_id ) REFERENCES pdbx_percentile_conditions ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_refine_tlsKeyref_0_0_0_0'])
--ALTER TABLE pdbx_refine_tls_group ADD CONSTRAINT KR_pdbx_refine_tlsKeyref_0_0_0_0 FOREIGN KEY ( refine_tls_id ) REFERENCES pdbx_refine_tls ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_assemblyKeyref_0_0_0_0'])
--ALTER TABLE pdbx_struct_assembly_gen ADD CONSTRAINT KR_pdbx_struct_assemblyKeyref_0_0_0_0 FOREIGN KEY ( assembly_id ) REFERENCES pdbx_struct_assembly ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_entity_instKeyref_0_0_0_0'])
--ALTER TABLE pdbx_struct_asym_gen ADD CONSTRAINT KR_pdbx_struct_entity_instKeyref_0_0_0_0 FOREIGN KEY ( entity_inst_id ) REFERENCES pdbx_struct_entity_inst ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_entity_instKeyref_0_0_1_0'])
--ALTER TABLE pdbx_struct_msym_gen ADD CONSTRAINT KR_pdbx_struct_entity_instKeyref_0_0_1_0 FOREIGN KEY ( entity_inst_id ) REFERENCES pdbx_struct_entity_inst ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_group_listKeyref_0_0_0_0'])
--ALTER TABLE pdbx_struct_group_component_range ADD CONSTRAINT KR_pdbx_struct_group_listKeyref_0_0_0_0 FOREIGN KEY ( struct_group_id ) REFERENCES pdbx_struct_group_list ( struct_group_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_group_listKeyref_0_0_1_0'])
--ALTER TABLE pdbx_struct_group_components ADD CONSTRAINT KR_pdbx_struct_group_listKeyref_0_0_1_0 FOREIGN KEY ( struct_group_id ) REFERENCES pdbx_struct_group_list ( struct_group_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_struct_nmr_ens_domKeyref_0_0_0_0'])
--ALTER TABLE pdbx_struct_nmr_ens_dom_lim ADD CONSTRAINT KR_pdbx_struct_nmr_ens_domKeyref_0_0_0_0 FOREIGN KEY ( dom_id ) REFERENCES pdbx_struct_nmr_ens_dom ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_validate_planesKeyref_0_0_0_0'])
--ALTER TABLE pdbx_validate_planes_atom ADD CONSTRAINT KR_pdbx_validate_planesKeyref_0_0_0_0 FOREIGN KEY ( plane_id ) REFERENCES pdbx_validate_planes ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_validate_rmsd_ringKeyref_0_0_0_0'])
--ALTER TABLE pdbx_validate_rmsd_rings_atom ADD CONSTRAINT KR_pdbx_validate_rmsd_ringKeyref_0_0_0_0 FOREIGN KEY ( ring_id ) REFERENCES pdbx_validate_rmsd_ring ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='pdbx_validate_rmsd_torsionKeyref_0_0_0_0'])
--ALTER TABLE pdbx_validate_rmsd_torsions_atom ADD CONSTRAINT KR_pdbx_validate_rmsd_torsionKeyref_0_0_0_0 FOREIGN KEY ( torsion_id ) REFERENCES pdbx_validate_rmsd_torsion ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MAD_exptKeyref_0_0_0_0'])
--ALTER TABLE "phasing_MAD_clust" ADD CONSTRAINT KR_phasing_MAD_exptKeyref_0_0_0_0 FOREIGN KEY ( expt_id ) REFERENCES "phasing_MAD_expt" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MAD_exptKeyref_0_0_1_0'])
--ALTER TABLE "phasing_MAD_ratio" ADD CONSTRAINT KR_phasing_MAD_exptKeyref_0_0_1_0 FOREIGN KEY ( expt_id ) REFERENCES "phasing_MAD_expt" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MAD_exptKeyref_0_0_2_0'])
--ALTER TABLE "phasing_MAD_set" ADD CONSTRAINT KR_phasing_MAD_exptKeyref_0_0_2_0 FOREIGN KEY ( expt_id ) REFERENCES "phasing_MAD_expt" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MIR_derKeyref_0_0_0_0'])
--ALTER TABLE "phasing_MIR_der_refln" ADD CONSTRAINT KR_phasing_MIR_derKeyref_0_0_0_0 FOREIGN KEY ( der_id ) REFERENCES "phasing_MIR_der" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MIR_derKeyref_0_0_1_0'])
--ALTER TABLE "phasing_MIR_der_shell" ADD CONSTRAINT KR_phasing_MIR_derKeyref_0_0_1_0 FOREIGN KEY ( der_id ) REFERENCES "phasing_MIR_der" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_MIR_derKeyref_0_0_2_0'])
--ALTER TABLE "phasing_MIR_der_site" ADD CONSTRAINT KR_phasing_MIR_derKeyref_0_0_2_0 FOREIGN KEY ( der_id ) REFERENCES "phasing_MIR_der" ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_setKeyref_0_0_0_0'])
--ALTER TABLE "phasing_MAD_set" ADD CONSTRAINT KR_phasing_setKeyref_0_0_0_0 FOREIGN KEY ( set_id ) REFERENCES phasing_set ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_setKeyref_0_0_1_0'])
--ALTER TABLE "phasing_MIR_der" ADD CONSTRAINT KR_phasing_setKeyref_0_0_1_0 FOREIGN KEY ( der_set_id ) REFERENCES phasing_set ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_setKeyref_0_0_2_0'])
--ALTER TABLE "phasing_MIR_der_refln" ADD CONSTRAINT KR_phasing_setKeyref_0_0_2_0 FOREIGN KEY ( set_id ) REFERENCES phasing_set ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='phasing_setKeyref_0_0_3_0'])
--ALTER TABLE phasing_set_refln ADD CONSTRAINT KR_phasing_setKeyref_0_0_3_0 FOREIGN KEY ( set_id ) REFERENCES phasing_set ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_asymKeyref_0_0_0_0'])
--ALTER TABLE pdbx_coordinate_model ADD CONSTRAINT KR_struct_asymKeyref_0_0_0_0 FOREIGN KEY ( asym_id ) REFERENCES struct_asym ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_asymKeyref_0_0_1_0'])
--ALTER TABLE pdbx_sifts_unp_segments ADD CONSTRAINT KR_struct_asymKeyref_0_0_1_0 FOREIGN KEY ( asym_id ) REFERENCES struct_asym ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_asymKeyref_0_0_2_0'])
--ALTER TABLE pdbx_sifts_xref_db ADD CONSTRAINT KR_struct_asymKeyref_0_0_2_0 FOREIGN KEY ( asym_id ) REFERENCES struct_asym ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_asymKeyref_0_0_3_0'])
--ALTER TABLE pdbx_sifts_xref_db_segments ADD CONSTRAINT KR_struct_asymKeyref_0_0_3_0 FOREIGN KEY ( asym_id ) REFERENCES struct_asym ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_biolKeyref_0_0_0_0'])
--ALTER TABLE pdbx_entity_assembly ADD CONSTRAINT KR_struct_biolKeyref_0_0_0_0 FOREIGN KEY ( biol_id ) REFERENCES struct_biol ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_biolKeyref_0_0_1_0'])
--ALTER TABLE struct_biol_view ADD CONSTRAINT KR_struct_biolKeyref_0_0_1_0 FOREIGN KEY ( biol_id ) REFERENCES struct_biol ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_conf_typeKeyref_0_0_0_0'])
--ALTER TABLE struct_conf ADD CONSTRAINT KR_struct_conf_typeKeyref_0_0_0_0 FOREIGN KEY ( conf_type_id ) REFERENCES struct_conf_type ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ncs_domKeyref_1_0_0_0'])
--ALTER TABLE struct_ncs_dom_lim ADD CONSTRAINT KR_struct_ncs_domKeyref_1_0_0_0_0 FOREIGN KEY ( dom_id ) REFERENCES struct_ncs_dom ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ncs_domKeyref_1_0_0_0'])
--ALTER TABLE struct_ncs_dom_lim ADD CONSTRAINT KR_struct_ncs_domKeyref_1_0_0_0_1 FOREIGN KEY ( pdbx_ens_id ) REFERENCES struct_ncs_dom ( pdbx_ens_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ncs_ensKeyref_0_0_0_0'])
--ALTER TABLE struct_ncs_dom ADD CONSTRAINT KR_struct_ncs_ensKeyref_0_0_0_0 FOREIGN KEY ( pdbx_ens_id ) REFERENCES struct_ncs_ens ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ncs_ensKeyref_0_0_1_0'])
--ALTER TABLE struct_ncs_ens_gen ADD CONSTRAINT KR_struct_ncs_ensKeyref_0_0_1_0 FOREIGN KEY ( ens_id ) REFERENCES struct_ncs_ens ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ncs_operKeyref_0_0_0_0'])
--ALTER TABLE struct_ncs_ens_gen ADD CONSTRAINT KR_struct_ncs_operKeyref_0_0_0_0 FOREIGN KEY ( oper_id ) REFERENCES struct_ncs_oper ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_refKeyref_0_0_0_0'])
--ALTER TABLE struct_ref_seq ADD CONSTRAINT KR_struct_refKeyref_0_0_0_0 FOREIGN KEY ( ref_id ) REFERENCES struct_ref ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_ref_seqKeyref_0_0_0_0'])
--ALTER TABLE struct_ref_seq_dif ADD CONSTRAINT KR_struct_ref_seqKeyref_0_0_0_0 FOREIGN KEY ( align_id ) REFERENCES struct_ref_seq ( align_id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_sheetKeyref_0_0_0_0'])
--ALTER TABLE pdbx_struct_sheet_hbond ADD CONSTRAINT KR_struct_sheetKeyref_0_0_0_0 FOREIGN KEY ( sheet_id ) REFERENCES struct_sheet ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_sheetKeyref_0_0_1_0'])
--ALTER TABLE struct_sheet_hbond ADD CONSTRAINT KR_struct_sheetKeyref_0_0_1_0 FOREIGN KEY ( sheet_id ) REFERENCES struct_sheet ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_sheetKeyref_0_0_2_0'])
--ALTER TABLE struct_sheet_order ADD CONSTRAINT KR_struct_sheetKeyref_0_0_2_0 FOREIGN KEY ( sheet_id ) REFERENCES struct_sheet ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_sheetKeyref_0_0_3_0'])
--ALTER TABLE struct_sheet_range ADD CONSTRAINT KR_struct_sheetKeyref_0_0_3_0 FOREIGN KEY ( sheet_id ) REFERENCES struct_sheet ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_sheetKeyref_0_0_4_0'])
--ALTER TABLE struct_sheet_topology ADD CONSTRAINT KR_struct_sheetKeyref_0_0_4_0 FOREIGN KEY ( sheet_id ) REFERENCES struct_sheet ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_siteKeyref_0_0_0_0'])
--ALTER TABLE struct_site_gen ADD CONSTRAINT KR_struct_siteKeyref_0_0_0_0 FOREIGN KEY ( site_id ) REFERENCES struct_site ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

-- (derived from xsd:keyref[@name='struct_siteKeyref_0_0_1_0'])
--ALTER TABLE struct_site_view ADD CONSTRAINT KR_struct_siteKeyref_0_0_1_0 FOREIGN KEY ( site_id ) REFERENCES struct_site ( id ) ON DELETE CASCADE NOT VALID DEFERRABLE INITIALLY DEFERRED;

