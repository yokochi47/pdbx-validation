--
-- PostgreSQL DDL generated from resource/wwpdb_validation_v004.xsd using xsd2pgschema
--  xsd2pgschema - Database replication tool based on XML Schema
--  https://sourceforge.net/projects/xsd2pgschema/
--
-- Schema modeling options:
--  explicit named schema: false
--  relational extension: true
--  inline simple content: false
--  realize simple bridge: false
--  wild card extension: true
--  case sensitive name: true
--  no name collision: true
--  append document key: true
--  append serial key: false
--  append xpath key: false
--  retain constraint: true
--  retrieve field annotation: false
--  map integer numbers to: signed int 32 bits
--  map decimal numbers to: big decimal
--  map xsd date type to: sql date type
--  assumed hash algorithm: SHA-1
--  hash key type: unsigned long 64 bits
--
-- Statistics of schema:
--  Generated 44 tables (554 fields), 48 views (144 fields), 0 attr groups, 0 model groups in total
--   Orphan tables that can not be reached from the document root:
--    schema location: resource/wwpdb_validation_v004.xsd
--      "NotAvailable"
--   Namespaces:
--    http://www.w3.org/2001/XMLSchema (xsd)
--   Schema locations:
--    resource/wwpdb_validation_v004.xsd
--   Table types:
--    1 root, 82 root children, 8 admin roots, 1 admin children
--   System keys:
--    92 primary keys (25 unique constraints), 83 foreign keys, 141 nested keys (95 as attribute, 1 as attribute group)
--   User keys:
--    92 document keys, 0 serial keys, 0 xpath keys
--   Contents:
--    284 attributes (0 in-place document keys), 0 elements (0 in-place document keys), 6 simple contents (0 in-place document keys, 6 as attribute, 0 as conditional attribute)
--   Wild cards:
--    0 any elements, 0 any attributes
--   Constraints:
--    0 unique constraints from xsd:unique, 0 unique constraints from xsd:key, 0 foreign key constraints from xsd:keyref
--

--
-- COPYRIGHT ***************************************************************** Copyright 2014-2017 EMBL - European Bioinformatics Institute Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. ***************************************************************** This is a XML schema for checking entry-specific validation XML documents from wwPDB. versions published: v1 2014/02/20 http://wwpdb.org/validation/schema/wwpdb_validation_v1.xsd v002 2016/02/25 http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd v002 2017/08/31 http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd (with annotations) v003 2019/05/27 http://wwpdb.org/validation/schema/wwpdb_validation_v003.xsd (added local_density, no-ligands-for-buster-report ligands-for-buster-report attribute) v004 2019/10/16 http://wwpdb.org/validation/schema/wwpdb_validation_v004.xsd (added em validation) $Revision$ *****************************************************************
--

DROP TABLE IF EXISTS atom_name CASCADE;
DROP TABLE IF EXISTS unmapped_chemical_shift CASCADE;
DROP TABLE IF EXISTS unparsed_chemical_shift CASCADE;
DROP TABLE IF EXISTS missing_nmrstar_tag CASCADE;
DROP TABLE IF EXISTS random_coil_index CASCADE;
DROP TABLE IF EXISTS chemical_shift_outlier CASCADE;
DROP TABLE IF EXISTS referencing_offset CASCADE;
DROP TABLE IF EXISTS assignment_completeness_well_defined CASCADE;
DROP TABLE IF EXISTS assignment_completeness_full_length CASCADE;
DROP TABLE IF EXISTS "floatORunavailable" CASCADE;
DROP TABLE IF EXISTS "YesString" CASCADE;
DROP TABLE IF EXISTS percentage CASCADE;
DROP TABLE IF EXISTS "BfactorType" CASCADE;
DROP TABLE IF EXISTS percentile_rank CASCADE;
DROP TABLE IF EXISTS "Model" CASCADE;
DROP TABLE IF EXISTS "bond-outlier" CASCADE;
DROP TABLE IF EXISTS "angle-outlier" CASCADE;
DROP TABLE IF EXISTS "chiral-outlier" CASCADE;
DROP TABLE IF EXISTS "plane-outlier" CASCADE;
DROP TABLE IF EXISTS clash CASCADE;
DROP TABLE IF EXISTS "symm-clash" CASCADE;
DROP TABLE IF EXISTS "mog-bond-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-angle-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-torsion-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-ring-outlier" CASCADE;
DROP TABLE IF EXISTS cyrange_domain CASCADE;
DROP TABLE IF EXISTS "ModelledEntityInstance" CASCADE;
DROP TABLE IF EXISTS "RecommendedContourLevel" CASCADE;
DROP TABLE IF EXISTS atom_inclusion CASCADE;
DROP TABLE IF EXISTS fsc_intersection CASCADE;
DROP TABLE IF EXISTS resolution_intersections CASCADE;
DROP TABLE IF EXISTS fsc_curves CASCADE;
DROP TABLE IF EXISTS fsc_indicator_curves CASCADE;
DROP TABLE IF EXISTS program CASCADE;
DROP TABLE IF EXISTS coordinate CASCADE;
DROP TABLE IF EXISTS graph CASCADE;
DROP TABLE IF EXISTS intersection CASCADE;
DROP TABLE IF EXISTS programs CASCADE;
DROP TABLE IF EXISTS fsc CASCADE;
DROP TABLE IF EXISTS "EM_validation" CASCADE;
DROP TABLE IF EXISTS chemical_shift_list CASCADE;
DROP TABLE IF EXISTS "Entry" CASCADE;
DROP TABLE IF EXISTS "ModelledSubgroup" CASCADE;
DROP TABLE IF EXISTS "wwPDB-validation-information" CASCADE;

--
-- No annotation is available
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root, content: false, list: true, bridge: false, virtual: false
--
CREATE TABLE "wwPDB-validation-information" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY : "Entry" ( "Entry_id" )
	"Entry_id" BIGINT CHECK ( "Entry_id" >= 0 ) ,
-- NESTED KEY : "Model" ( "Model_id" )
	"Model_id" BIGINT CHECK ( "Model_id" >= 0 ) ,
-- NESTED KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY : cyrange_domain ( cyrange_domain_id )
	cyrange_domain_id BIGINT CHECK ( cyrange_domain_id >= 0 ) ,
-- NESTED KEY : "ModelledEntityInstance" ( "ModelledEntityInstance_id" )
	"ModelledEntityInstance_id" BIGINT CHECK ( "ModelledEntityInstance_id" >= 0 ) ,
-- NESTED KEY : "EM_validation" ( "EM_validation_id" )
	"EM_validation_id" BIGINT CHECK ( "EM_validation_id" >= 0 ) ,
-- NESTED KEY : programs ( programs_id )
	programs_id BIGINT CHECK ( programs_id >= 0 )
);

--
-- A "ModelledSubgroup" is an individual occurence of a residue. If there are alternate atoms in the residue each alternate and any alternate atoms is a separate ModelledSubgroup. If there are multiple models then each of these is a separate subgroup.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: true, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_ModelledSubgroup_rama CASCADE;
CREATE TYPE ENUM_ModelledSubgroup_rama AS ENUM ( 'Favored', 'Allowed', 'OUTLIER' );
DROP TYPE IF EXISTS ENUM_ModelledSubgroup_flippable_sidechain CASCADE;
CREATE TYPE ENUM_ModelledSubgroup_flippable_sidechain AS ENUM ( '1' );
DROP TYPE IF EXISTS ENUM_ModelledSubgroup_RNAsuite CASCADE;
CREATE TYPE ENUM_ModelledSubgroup_RNAsuite AS ENUM ( 'NonRotameric', 'NotAvailable', 'Rotameric', 'Triaged/NotBinned' );
CREATE TABLE "ModelledSubgroup" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY : "bond-outlier" ( "bond-outlier_id" )
	"bond-outlier_id" BIGINT CHECK ( "bond-outlier_id" >= 0 ) ,
-- NESTED KEY : "angle-outlier" ( "angle-outlier_id" )
	"angle-outlier_id" BIGINT CHECK ( "angle-outlier_id" >= 0 ) ,
-- NESTED KEY : "chiral-outlier" ( "chiral-outlier_id" )
	"chiral-outlier_id" BIGINT CHECK ( "chiral-outlier_id" >= 0 ) ,
-- NESTED KEY : "plane-outlier" ( "plane-outlier_id" )
	"plane-outlier_id" BIGINT CHECK ( "plane-outlier_id" >= 0 ) ,
-- NESTED KEY : clash ( clash_id )
	clash_id BIGINT CHECK ( clash_id >= 0 ) ,
-- NESTED KEY : "symm-clash" ( "symm-clash_id" )
	"symm-clash_id" BIGINT CHECK ( "symm-clash_id" >= 0 ) ,
-- NESTED KEY : "mog-bond-outlier" ( "mog-bond-outlier_id" )
	"mog-bond-outlier_id" BIGINT CHECK ( "mog-bond-outlier_id" >= 0 ) ,
-- NESTED KEY : "mog-angle-outlier" ( "mog-angle-outlier_id" )
	"mog-angle-outlier_id" BIGINT CHECK ( "mog-angle-outlier_id" >= 0 ) ,
-- NESTED KEY : "mog-torsion-outlier" ( "mog-torsion-outlier_id" )
	"mog-torsion-outlier_id" BIGINT CHECK ( "mog-torsion-outlier_id" >= 0 ) ,
-- NESTED KEY : "mog-ring-outlier" ( "mog-ring-outlier_id" )
	"mog-ring-outlier_id" BIGINT CHECK ( "mog-ring-outlier_id" >= 0 ) ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	resnum INTEGER ,
-- ATTRIBUTE
	resname TEXT ,
-- ATTRIBUTE
	model TEXT ,
-- ATTRIBUTE
	altcode TEXT ,
-- ATTRIBUTE
	icode TEXT ,
-- ATTRIBUTE
	ent TEXT ,
-- ATTRIBUTE
	said TEXT ,
-- ATTRIBUTE
	seq TEXT ,
-- ATTRIBUTE
	ligand_num_clashes INTEGER ,
-- ATTRIBUTE
	ligand_num_symm_clashes INTEGER ,
-- NESTED KEY AS ATTRIBUTE : ligand_clashes_outlier ( ligand_clashes_outlier_id, DELEGATED TO "YesString_id" )
	ligand_clashes_outlier_id BIGINT CHECK ( ligand_clashes_outlier_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : ligand_chirality_outlier ( ligand_chirality_outlier_id, DELEGATED TO "YesString_id" )
	ligand_chirality_outlier_id BIGINT CHECK ( ligand_chirality_outlier_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : cis_peptide ( cis_peptide_id, DELEGATED TO "YesString_id" )
	cis_peptide_id BIGINT CHECK ( cis_peptide_id >= 0 ) ,
-- ATTRIBUTE
	"NatomsEDS" INTEGER ,
-- ATTRIBUTE
	cyrange_domain_id INTEGER ,
-- ATTRIBUTE
	validate TEXT ,
-- ATTRIBUTE
	rsr DECIMAL ,
-- ATTRIBUTE
	rscc DECIMAL ,
-- ATTRIBUTE
	rsrz DECIMAL ,
-- ATTRIBUTE
	owab DECIMAL ,
-- ATTRIBUTE
	avgoccu DECIMAL ,
-- ATTRIBUTE
	lig_rsrz_nbr_id TEXT ,
-- ATTRIBUTE
	"ligRSRnbrMean" DECIMAL ,
-- ATTRIBUTE
	"ligRSRnbrStdev" DECIMAL ,
-- ATTRIBUTE
	"ligRSRnumnbrs" INTEGER ,
-- ATTRIBUTE
	"ligRSRZ" DECIMAL ,
-- ATTRIBUTE
	"num-H-reduce" DECIMAL ,
-- ATTRIBUTE
	rama ENUM_ModelledSubgroup_rama ,
-- ATTRIBUTE
	rota TEXT ,
-- ATTRIBUTE
	phi DECIMAL ,
-- ATTRIBUTE
	psi DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "mogul-ignore" ( "mogul-ignore_id", DELEGATED TO "YesString_id" )
	"mogul-ignore_id" BIGINT CHECK ( "mogul-ignore_id" >= 0 ) ,
-- ATTRIBUTE
	"flippable-sidechain" ENUM_ModelledSubgroup_flippable_sidechain ,
-- ATTRIBUTE
	"RNAscore" DECIMAL ,
-- ATTRIBUTE
	"RNAsuite" ENUM_ModelledSubgroup_RNAsuite ,
-- ATTRIBUTE
	"RNApucker" TEXT ,
-- ATTRIBUTE
	mogul_angles_rmsz DECIMAL ,
-- ATTRIBUTE
	mogul_bonds_rmsz DECIMAL ,
-- ATTRIBUTE
	mogul_rmsz_numangles INTEGER ,
-- ATTRIBUTE
	mogul_rmsz_numbonds INTEGER ,
-- NESTED KEY AS ATTRIBUTE : ligand_geometry_outlier ( ligand_geometry_outlier_id, DELEGATED TO "YesString_id" )
	ligand_geometry_outlier_id BIGINT CHECK ( ligand_geometry_outlier_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : ligand_density_outlier ( ligand_density_outlier_id, DELEGATED TO "YesString_id" )
	ligand_density_outlier_id BIGINT CHECK ( ligand_density_outlier_id >= 0 ) ,
-- ATTRIBUTE
	residue_inclusion DECIMAL
);

--
-- Entry contains most information that has a single value for the structure analyzed and in the run.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: true, bridge: false, virtual: false
--
CREATE TABLE "Entry" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"Entry_id" BIGINT CHECK ( "Entry_id" >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	pdbid TEXT ,
-- ATTRIBUTE
	emdb_id TEXT ,
-- ATTRIBUTE
	"PDB-deposition-date" TEXT ,
-- ATTRIBUTE
	"PDB-revision-number" DECIMAL ,
-- ATTRIBUTE
	"PDB-revision-date" TEXT ,
-- NESTED KEY AS ATTRIBUTE : "PDB-resolution" ( "PDB-resolution_id", DELEGATED TO "floatORunavailable_id" )
	"PDB-resolution_id" BIGINT CHECK ( "PDB-resolution_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "PDB-resolution-low" ( "PDB-resolution-low_id", DELEGATED TO "floatORunavailable_id" )
	"PDB-resolution-low_id" BIGINT CHECK ( "PDB-resolution-low_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "PDB-R" ( "PDB-R_id", DELEGATED TO "floatORunavailable_id" )
	"PDB-R_id" BIGINT CHECK ( "PDB-R_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "PDB-Rfree" ( "PDB-Rfree_id", DELEGATED TO "floatORunavailable_id" )
	"PDB-Rfree_id" BIGINT CHECK ( "PDB-Rfree_id" >= 0 ) ,
-- ATTRIBUTE
	"protein-DNA-RNA-entities" TEXT ,
-- NESTED KEY AS ATTRIBUTE : "CA_ONLY" ( "CA_ONLY_id", DELEGATED TO "YesString_id" )
	"CA_ONLY_id" BIGINT CHECK ( "CA_ONLY_id" >= 0 ) ,
-- ATTRIBUTE
	"XMLcreationDate" TEXT ,
-- ATTRIBUTE
	"coordinatesInputFilename" TEXT ,
-- ATTRIBUTE
	"reflectionsInputFilename" TEXT ,
-- ATTRIBUTE
	"chemicalshiftsInputFilename" TEXT ,
-- ATTRIBUTE
	"attemptedValidationSteps" TEXT ,
-- NESTED KEY AS ATTRIBUTE : "no-ligands-for-mogul" ( "no-ligands-for-mogul_id", DELEGATED TO "YesString_id" )
	"no-ligands-for-mogul_id" BIGINT CHECK ( "no-ligands-for-mogul_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "no-ligands-for-buster-report" ( "no-ligands-for-buster-report_id", DELEGATED TO "YesString_id" )
	"no-ligands-for-buster-report_id" BIGINT CHECK ( "no-ligands-for-buster-report_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "ligands-for-buster-report" ( "ligands-for-buster-report_id", DELEGATED TO "YesString_id" )
	"ligands-for-buster-report_id" BIGINT CHECK ( "ligands-for-buster-report_id" >= 0 ) ,
-- ATTRIBUTE
	"RestypesNotcheckedForBondAngleGeometry" TEXT ,
-- ATTRIBUTE
	angles_rmsz DECIMAL ,
-- ATTRIBUTE
	bonds_rmsz DECIMAL ,
-- ATTRIBUTE
	num_bonds_rmsz INTEGER ,
-- ATTRIBUTE
	num_angles_rmsz INTEGER ,
-- ATTRIBUTE
	"num-H-reduce" DECIMAL ,
-- ATTRIBUTE
	clashscore DECIMAL ,
-- ATTRIBUTE
	"clashscore-full-length" DECIMAL ,
-- ATTRIBUTE
	"RNAsuiteness" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "percent-rama-outliers" ( "percent-rama-outliers_id", DELEGATED TO percentage_id )
	"percent-rama-outliers_id" BIGINT CHECK ( "percent-rama-outliers_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "percent-rama-outliers-full-length" ( "percent-rama-outliers-full-length_id", DELEGATED TO percentage_id )
	"percent-rama-outliers-full-length_id" BIGINT CHECK ( "percent-rama-outliers-full-length_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "percent-rota-outliers" ( "percent-rota-outliers_id", DELEGATED TO percentage_id )
	"percent-rota-outliers_id" BIGINT CHECK ( "percent-rota-outliers_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "percent-rota-outliers-full-length" ( "percent-rota-outliers-full-length_id", DELEGATED TO percentage_id )
	"percent-rota-outliers-full-length_id" BIGINT CHECK ( "percent-rota-outliers-full-length_id" >= 0 ) ,
-- ATTRIBUTE
	"CCP4version" TEXT ,
-- ATTRIBUTE
	"resol-high-from-reflectionsfile" DECIMAL ,
-- ATTRIBUTE
	"resol-low-from-reflectionsfile" DECIMAL ,
-- ATTRIBUTE
	xtriage_input_columns TEXT ,
-- ATTRIBUTE
	acentric_outliers INTEGER ,
-- ATTRIBUTE
	centric_outliers DECIMAL ,
-- ATTRIBUTE
	"IoverSigma" TEXT ,
-- ATTRIBUTE
	"numMillerIndices" INTEGER ,
-- ATTRIBUTE
	"WilsonBestimate" DECIMAL ,
-- ATTRIBUTE
	"WilsonBaniso" TEXT ,
-- ATTRIBUTE
	"DataAnisotropy" DECIMAL ,
-- ATTRIBUTE
	"TransNCS" TEXT ,
-- ATTRIBUTE
	"TwinL" DECIMAL ,
-- ATTRIBUTE
	"TwinL2" DECIMAL ,
-- ATTRIBUTE
	"TwinFraction" TEXT ,
-- NESTED KEY AS ATTRIBUTE : "B_factor_type" ( "B_factor_type_id", DELEGATED TO "BfactorType_id" )
	"B_factor_type_id" BIGINT CHECK ( "B_factor_type_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "DataCompleteness" ( "DataCompleteness_id", DELEGATED TO percentage_id )
	"DataCompleteness_id" BIGINT CHECK ( "DataCompleteness_id" >= 0 ) ,
-- ATTRIBUTE
	"DCC_R" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "DCC_Rfree" ( "DCC_Rfree_id", DELEGATED TO "floatORunavailable_id" )
	"DCC_Rfree_id" BIGINT CHECK ( "DCC_Rfree_id" >= 0 ) ,
-- ATTRIBUTE
	"DCC_refinement_program" TEXT ,
-- ATTRIBUTE
	"num-free-reflections" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "percent-free-reflections" ( "percent-free-reflections_id", DELEGATED TO percentage_id )
	"percent-free-reflections_id" BIGINT CHECK ( "percent-free-reflections_id" >= 0 ) ,
-- ATTRIBUTE
	"RefmacVersion" TEXT ,
-- ATTRIBUTE
	"EDS_R" DECIMAL ,
-- ATTRIBUTE
	"EDS_resolution" DECIMAL ,
-- ATTRIBUTE
	"EDS_resolution_low" DECIMAL ,
-- ATTRIBUTE
	"Fo_Fc_correlation" DECIMAL ,
-- ATTRIBUTE
	babinet_b DECIMAL ,
-- ATTRIBUTE
	babinet_k DECIMAL ,
-- ATTRIBUTE
	bulk_solvent_b DECIMAL ,
-- ATTRIBUTE
	bulk_solvent_k DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "percent-RSRZ-outliers" ( "percent-RSRZ-outliers_id", DELEGATED TO percentage_id )
	"percent-RSRZ-outliers_id" BIGINT CHECK ( "percent-RSRZ-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	nmr_models_consistency_flag TEXT ,
-- ATTRIBUTE
	cyrange_error TEXT ,
-- ATTRIBUTE
	cyrange_version TEXT ,
-- ATTRIBUTE
	nmrclust_error TEXT ,
-- ATTRIBUTE
	nmrclust_version TEXT ,
-- ATTRIBUTE
	nmrclust_representative_model INTEGER ,
-- ATTRIBUTE
	medoid_model INTEGER ,
-- ATTRIBUTE
	nmrclust_number_of_outliers INTEGER ,
-- ATTRIBUTE
	nmrclust_number_of_models INTEGER ,
-- ATTRIBUTE
	nmrclust_number_of_clusters INTEGER ,
-- ATTRIBUTE
	cyrange_number_of_domains INTEGER ,
-- ATTRIBUTE
	chemical_shift_completeness DECIMAL ,
-- ATTRIBUTE
	chemical_shift_completeness_full_length DECIMAL ,
-- ATTRIBUTE
	panav_version TEXT ,
-- ATTRIBUTE
	rci_version TEXT ,
-- ATTRIBUTE
	shiftchecker_version TEXT ,
-- ATTRIBUTE
	contour_level_primary_map TEXT ,
-- ATTRIBUTE
	atom_inclusion_all_atoms DECIMAL ,
-- ATTRIBUTE
	atom_inclusion_backbone DECIMAL ,
-- ATTRIBUTE
	"author_provided_fsc_resolution_by_cutoff_0.143" DECIMAL ,
-- ATTRIBUTE
	"author_provided_fsc_resolution_by_cutoff_0.333" DECIMAL ,
-- ATTRIBUTE
	"author_provided_fsc_resolution_by_cutoff_0.5" DECIMAL ,
-- ATTRIBUTE
	author_provided_fsc_resolution_by_cutoff_halfbit DECIMAL ,
-- ATTRIBUTE
	author_provided_fsc_resolution_by_cutoff_onebit DECIMAL ,
-- ATTRIBUTE
	author_provided_fsc_resolution_by_cutoff_threesigma DECIMAL ,
-- ATTRIBUTE
	"calculated_fsc_resolution_by_cutoff_0.143" DECIMAL ,
-- ATTRIBUTE
	"calculated_fsc_resolution_by_cutoff_0.333" DECIMAL ,
-- ATTRIBUTE
	"calculated_fsc_resolution_by_cutoff_0.5" DECIMAL ,
-- ATTRIBUTE
	calculated_fsc_resolution_by_cutoff_halfbit DECIMAL ,
-- ATTRIBUTE
	calculated_fsc_resolution_by_cutoff_onebit DECIMAL ,
-- ATTRIBUTE
	calculated_fsc_resolution_by_cutoff_threesigma DECIMAL ,
-- ATTRIBUTE
	percentilebins TEXT ,
-- ATTRIBUTE
	"no-percentile-property" BOOLEAN ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-RNAsuiteness" ( "absolute-percentile-RNAsuiteness_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-RNAsuiteness_id" BIGINT CHECK ( "absolute-percentile-RNAsuiteness_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-RNAsuiteness" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-RNAsuiteness" ( "relative-percentile-RNAsuiteness_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-RNAsuiteness_id" BIGINT CHECK ( "relative-percentile-RNAsuiteness_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-RNAsuiteness" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-RNAsuiteness" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-RNAsuiteness" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-clashscore" ( "absolute-percentile-clashscore_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-clashscore_id" BIGINT CHECK ( "absolute-percentile-clashscore_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-clashscore" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-clashscore" ( "relative-percentile-clashscore_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-clashscore_id" BIGINT CHECK ( "relative-percentile-clashscore_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-clashscore" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-clashscore" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-clashscore" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-percent-rama-outliers" ( "absolute-percentile-percent-rama-outliers_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-percent-rama-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-rama-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-rama-outliers" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-percent-rama-outliers" ( "relative-percentile-percent-rama-outliers_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-percent-rama-outliers_id" BIGINT CHECK ( "relative-percentile-percent-rama-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-rama-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-rama-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-rama-outliers" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-percent-rota-outliers" ( "absolute-percentile-percent-rota-outliers_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-percent-rota-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-rota-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-rota-outliers" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-percent-rota-outliers" ( "relative-percentile-percent-rota-outliers_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-percent-rota-outliers_id" BIGINT CHECK ( "relative-percentile-percent-rota-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-rota-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-rota-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-rota-outliers" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-DCC_Rfree" ( "absolute-percentile-DCC_Rfree_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-DCC_Rfree_id" BIGINT CHECK ( "absolute-percentile-DCC_Rfree_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-DCC_Rfree" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-DCC_Rfree" ( "relative-percentile-DCC_Rfree_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-DCC_Rfree_id" BIGINT CHECK ( "relative-percentile-DCC_Rfree_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-DCC_Rfree" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-DCC_Rfree" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-DCC_Rfree" DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : "absolute-percentile-percent-RSRZ-outliers" ( "absolute-percentile-percent-RSRZ-outliers_id", DELEGATED TO percentile_rank_id )
	"absolute-percentile-percent-RSRZ-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-RSRZ-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-RSRZ-outliers" INTEGER ,
-- NESTED KEY AS ATTRIBUTE : "relative-percentile-percent-RSRZ-outliers" ( "relative-percentile-percent-RSRZ-outliers_id", DELEGATED TO percentile_rank_id )
	"relative-percentile-percent-RSRZ-outliers_id" BIGINT CHECK ( "relative-percentile-percent-RSRZ-outliers_id" >= 0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-RSRZ-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-RSRZ-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-RSRZ-outliers" DECIMAL
);

--
-- NMR entries are normally linked to one or more assigned chemical shift lists. A typical reason for containing multiple chemical shift lists would be differing experimental conditions or samples.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: true, bridge: false, virtual: false
--
CREATE TABLE chemical_shift_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- FOREIGN KEY : "Entry" ( "Entry_id" )
	"Entry_id" BIGINT CHECK ( "Entry_id" >= 0 ) ,
-- NESTED KEY : unmapped_chemical_shift ( unmapped_chemical_shift_id )
	unmapped_chemical_shift_id BIGINT CHECK ( unmapped_chemical_shift_id >= 0 ) ,
-- NESTED KEY : unparsed_chemical_shift ( unparsed_chemical_shift_id )
	unparsed_chemical_shift_id BIGINT CHECK ( unparsed_chemical_shift_id >= 0 ) ,
-- NESTED KEY : missing_nmrstar_tag ( missing_nmrstar_tag_id )
	missing_nmrstar_tag_id BIGINT CHECK ( missing_nmrstar_tag_id >= 0 ) ,
-- NESTED KEY : random_coil_index ( random_coil_index_id )
	random_coil_index_id BIGINT CHECK ( random_coil_index_id >= 0 ) ,
-- NESTED KEY : chemical_shift_outlier ( chemical_shift_outlier_id )
	chemical_shift_outlier_id BIGINT CHECK ( chemical_shift_outlier_id >= 0 ) ,
-- NESTED KEY : referencing_offset ( referencing_offset_id )
	referencing_offset_id BIGINT CHECK ( referencing_offset_id >= 0 ) ,
-- NESTED KEY : assignment_completeness_well_defined ( assignment_completeness_well_defined_id )
	assignment_completeness_well_defined_id BIGINT CHECK ( assignment_completeness_well_defined_id >= 0 ) ,
-- NESTED KEY : assignment_completeness_full_length ( assignment_completeness_full_length_id )
	assignment_completeness_full_length_id BIGINT CHECK ( assignment_completeness_full_length_id >= 0 ) ,
-- ATTRIBUTE
	file_id INTEGER ,
-- ATTRIBUTE
	file_name TEXT ,
-- ATTRIBUTE
	block_name TEXT ,
-- ATTRIBUTE
	list_id TEXT ,
-- ATTRIBUTE
	type TEXT ,
-- ATTRIBUTE
	number_of_errors_while_mapping INTEGER ,
-- ATTRIBUTE
	number_of_warnings_while_mapping INTEGER ,
-- ATTRIBUTE
	number_of_mapped_shifts INTEGER ,
-- ATTRIBUTE
	number_of_parsed_shifts INTEGER ,
-- ATTRIBUTE
	total_number_of_shifts INTEGER ,
-- ATTRIBUTE
	number_of_unparsed_shifts INTEGER
);

--
-- EM validation information which is not tied to a specific chain or residue.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: false, bridge: false, virtual: false
--
CREATE TABLE "EM_validation" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"EM_validation_id" BIGINT CHECK ( "EM_validation_id" >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY : "RecommendedContourLevel" ( "RecommendedContourLevel_id" )
	"RecommendedContourLevel_id" BIGINT CHECK ( "RecommendedContourLevel_id" >= 0 ) ,
-- NESTED KEY : map_value_distribution ( map_value_distribution_id, DELEGATED TO graph_id )
	map_value_distribution_id BIGINT CHECK ( map_value_distribution_id >= 0 ) ,
-- NESTED KEY : rotationally_averaged_power_spectrum ( rotationally_averaged_power_spectrum_id, DELEGATED TO graph_id )
	rotationally_averaged_power_spectrum_id BIGINT CHECK ( rotationally_averaged_power_spectrum_id >= 0 ) ,
-- NESTED KEY : volume_estimate ( volume_estimate_id, DELEGATED TO graph_id )
	volume_estimate_id BIGINT CHECK ( volume_estimate_id >= 0 ) ,
-- NESTED KEY : atom_inclusion ( atom_inclusion_id )
	atom_inclusion_id BIGINT CHECK ( atom_inclusion_id >= 0 ) ,
-- NESTED KEY : fsc ( fsc_id )
	fsc_id BIGINT CHECK ( fsc_id >= 0 )
);

--
-- Contains all fsc information. Including fsc curves, fsc indicator curves and fsc intersections
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: false, bridge: false, virtual: false
--
CREATE TABLE fsc (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	fsc_id BIGINT CHECK ( fsc_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "EM_validation" ( "EM_validation_id" )
	"EM_validation_id" BIGINT CHECK ( "EM_validation_id" >= 0 ) ,
-- NESTED KEY : resolution_intersections ( resolution_intersections_id )
	resolution_intersections_id BIGINT CHECK ( resolution_intersections_id >= 0 ) ,
-- NESTED KEY : fsc_curves ( fsc_curves_id )
	fsc_curves_id BIGINT CHECK ( fsc_curves_id >= 0 ) ,
-- NESTED KEY : fsc_indicator_curves ( fsc_indicator_curves_id )
	fsc_indicator_curves_id BIGINT CHECK ( fsc_indicator_curves_id >= 0 )
);

--
-- Contains the data required to plot the map-value distribution graph for the primary map
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: true, bridge: true, virtual: true
--
CREATE TABLE graph (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	graph_id BIGINT CHECK ( graph_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : map_value_distribution ( map_value_distribution_id )
	map_value_distribution_id BIGINT CHECK ( map_value_distribution_id >= 0 ) ,
-- FOREIGN KEY : rotationally_averaged_power_spectrum ( rotationally_averaged_power_spectrum_id )
	rotationally_averaged_power_spectrum_id BIGINT CHECK ( rotationally_averaged_power_spectrum_id >= 0 ) ,
-- FOREIGN KEY : volume_estimate ( volume_estimate_id )
	volume_estimate_id BIGINT CHECK ( volume_estimate_id >= 0 ) ,
-- FOREIGN KEY : all_atoms ( all_atoms_id )
	all_atoms_id BIGINT CHECK ( all_atoms_id >= 0 ) ,
-- FOREIGN KEY : backbone ( backbone_id )
	backbone_id BIGINT CHECK ( backbone_id >= 0 ) ,
-- NESTED KEY : coordinate ( coordinate_id )
	coordinate_id BIGINT CHECK ( coordinate_id >= 0 ) ,
-- ATTRIBUTE
	"xTitle" TEXT NOT NULL ,
-- ATTRIBUTE
	"xScale" TEXT ,
-- ATTRIBUTE
	"xUnit" TEXT ,
-- ATTRIBUTE
	"yTitle" TEXT NOT NULL ,
-- ATTRIBUTE
	"yScale" TEXT ,
-- ATTRIBUTE
	"yUnit" TEXT ,
-- ATTRIBUTE
	"Title" TEXT
);

--
-- No annotation is available
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: true, bridge: true, virtual: false
--
CREATE TABLE intersection (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	intersection_id BIGINT CHECK ( intersection_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE GROUP : fsc_intersection ( fsc_intersection_id )
	fsc_intersection_id BIGINT CHECK ( fsc_intersection_id >= 0 )
);

--
-- A list of programs used by the validation pipeline.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: true, bridge: true, virtual: false
--
CREATE TABLE programs (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	programs_id BIGINT CHECK ( programs_id >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY : program ( program_id )
	program_id BIGINT CHECK ( program_id >= 0 )
);

--
-- An atom name from cif item _atom_site.label_atom_id and _chem_comp_atom.atom_id. Currently limited to 4 characters. Example: atom="NE2"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
CREATE TABLE atom_name (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	atom_name_id BIGINT CHECK ( atom_name_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : atom ( atom_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- FOREIGN KEY : atom0 ( atom0_id )
	atom0_id BIGINT CHECK ( atom0_id >= 0 ) ,
-- FOREIGN KEY : atom1 ( atom1_id )
	atom1_id BIGINT CHECK ( atom1_id >= 0 ) ,
-- FOREIGN KEY : atom2 ( atom2_id )
	atom2_id BIGINT CHECK ( atom2_id >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: atom atom0 atom1 atom2
-- xsd:restriction/xsd:minLength="1"
	content TEXT
);

--
-- Each assigned chemical shift should map to one or more nuclei of the studied biological macromolecule or complex. In preliminary reports and for some older entries, this mapping is not always accurate and some chemical shifts can therefore be "unmapped". It implies, that the chemical shift was parsed, but not mapped to any nucleus expected from the molecular description. It may result for instance from typos or from an incomplete molecular description. Details are given in the free text "diagnostic" attribute.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE unmapped_chemical_shift (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	unmapped_chemical_shift_id BIGINT CHECK ( unmapped_chemical_shift_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	rescode TEXT ,
-- ATTRIBUTE
	resnum INTEGER ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	value DECIMAL ,
-- ATTRIBUTE
	error TEXT ,
-- ATTRIBUTE
	ambiguity TEXT ,
-- ATTRIBUTE
	diagnostic TEXT
);

--
-- An unparsed chemical shift implies that some expected values were missing or did not conform to expected format: e.g., non-numeric value of a shift measurement or missing chain/entity identifier.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE unparsed_chemical_shift (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	unparsed_chemical_shift_id BIGINT CHECK ( unparsed_chemical_shift_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	id TEXT ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	rescode TEXT ,
-- ATTRIBUTE
	resnum INTEGER ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	value DECIMAL ,
-- ATTRIBUTE
	error TEXT ,
-- ATTRIBUTE
	ambiguity TEXT ,
-- ATTRIBUTE
	diagnostic TEXT
);

--
-- The chemical shifts must be supplied in NMR-STAR 3.1 format. In order for the shifts to be mapped to the molecular structure, certain values (data items or tags) must be provided.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE missing_nmrstar_tag (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	missing_nmrstar_tag_id BIGINT CHECK ( missing_nmrstar_tag_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	nmrstar_tag_description TEXT NOT NULL ,
-- ATTRIBUTE
	nmrstar_tag TEXT NOT NULL
);

--
-- The Random Coil Index (RCI) is calculated for each residue from the protein sequence and assigned chemical shifts. Via an empirical formula the RCI correlates with disorder propensity of the residue.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE random_coil_index (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	random_coil_index_id BIGINT CHECK ( random_coil_index_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	rescode TEXT ,
-- ATTRIBUTE
	resnum INTEGER ,
-- ATTRIBUTE
	value DECIMAL
);

--
-- BMRB compiled statistics of assigned chemical shifts, against which a given value is checked. A value is deemed an outlier if it is 5 standard deviation away from the expected mean.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE chemical_shift_outlier (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	chemical_shift_outlier_id BIGINT CHECK ( chemical_shift_outlier_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	rescode TEXT ,
-- ATTRIBUTE
	resnum INTEGER ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	value DECIMAL ,
-- ATTRIBUTE
	zscore DECIMAL ,
-- ATTRIBUTE
	prediction DECIMAL NOT NULL ,
-- ATTRIBUTE
	method TEXT NOT NULL
);

--
-- PANAV software is used to calculate suggested referencing correction for each chemical shift list.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE referencing_offset (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	referencing_offset_id BIGINT CHECK ( referencing_offset_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	uncertainty DECIMAL NOT NULL ,
-- ATTRIBUTE
	precision DECIMAL ,
-- ATTRIBUTE
	value DECIMAL ,
-- ATTRIBUTE
	number_of_measurements INTEGER NOT NULL
);

--
-- For the well-defined regions of the structure, what is the completeness of chemical shift assignments for the typically assigned nuclei.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE assignment_completeness_well_defined (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	assignment_completeness_well_defined_id BIGINT CHECK ( assignment_completeness_well_defined_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	number_of_assigned_shifts INTEGER ,
-- ATTRIBUTE
	number_of_unassigned_shifts INTEGER ,
-- ATTRIBUTE
	number_of_shifts INTEGER ,
-- ATTRIBUTE
	type TEXT NOT NULL ,
-- ATTRIBUTE
	element TEXT
);

--
-- For the complete structure, what is the completeness of chemical shift assignments for the typically assigned nuclei.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE assignment_completeness_full_length (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	assignment_completeness_full_length_id BIGINT CHECK ( assignment_completeness_full_length_id >= 0 ) ,
-- FOREIGN KEY : chemical_shift_list ( chemical_shift_list_id )
	chemical_shift_list_id BIGINT CHECK ( chemical_shift_list_id >= 0 ) ,
-- ATTRIBUTE
	number_of_assigned_shifts INTEGER ,
-- ATTRIBUTE
	number_of_unassigned_shifts INTEGER ,
-- ATTRIBUTE
	number_of_shifts INTEGER ,
-- ATTRIBUTE
	type TEXT NOT NULL ,
-- ATTRIBUTE
	element TEXT
);

--
-- For X-ray entries: data high resolution diffraction limit in Angstroms as reported in the input mmCIF file, normally taken from mmcif item _refine.ls_d_res_high or if this is not found _reflns.d_resolution_high. For EM entries: The final resolution, in Angstroms, of the 3d reconstruction as reported in the input mmCIF file, taken from _em_3d_reconstruction.resolution. If not available then item will be absent or set to "NotAvailable".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
CREATE TABLE "floatORunavailable" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	"floatORunavailable_id" BIGINT CHECK ( "floatORunavailable_id" >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "PDB-resolution" ( "PDB-resolution_id" )
	"PDB-resolution_id" BIGINT CHECK ( "PDB-resolution_id" >= 0 ) ,
-- FOREIGN KEY : "PDB-resolution-low" ( "PDB-resolution-low_id" )
	"PDB-resolution-low_id" BIGINT CHECK ( "PDB-resolution-low_id" >= 0 ) ,
-- FOREIGN KEY : "PDB-R" ( "PDB-R_id" )
	"PDB-R_id" BIGINT CHECK ( "PDB-R_id" >= 0 ) ,
-- FOREIGN KEY : "PDB-Rfree" ( "PDB-Rfree_id" )
	"PDB-Rfree_id" BIGINT CHECK ( "PDB-Rfree_id" >= 0 ) ,
-- FOREIGN KEY : "DCC_Rfree" ( "DCC_Rfree_id" )
	"DCC_Rfree_id" BIGINT CHECK ( "DCC_Rfree_id" >= 0 ) ,
-- FOREIGN KEY : "absolute_RSRZ_percentile" ( "absolute_RSRZ_percentile_id" )
	"absolute_RSRZ_percentile_id" BIGINT CHECK ( "absolute_RSRZ_percentile_id" >= 0 ) ,
-- FOREIGN KEY : "relative_RSRZ_percentile" ( "relative_RSRZ_percentile_id" )
	"relative_RSRZ_percentile_id" BIGINT CHECK ( "relative_RSRZ_percentile_id" >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: PDB-resolution PDB-resolution-low PDB-R PDB-Rfree DCC_Rfree absolute_RSRZ_percentile relative_RSRZ_percentile
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	content TEXT
);

--
-- The structure is a Calpha only model. Currently implementation uses test that the structure has more than 30 atoms with the name CA and that number of atoms with name CA is greater than 1/3 of the total number of atoms. Currently test only applied in the EDS step so will be only set for X-ray structures.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
DROP TYPE IF EXISTS ENUM_YesString_content CASCADE;
CREATE TYPE ENUM_YesString_content AS ENUM ( 'yes' );
CREATE TABLE "YesString" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	"YesString_id" BIGINT CHECK ( "YesString_id" >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "CA_ONLY" ( "CA_ONLY_id" )
	"CA_ONLY_id" BIGINT CHECK ( "CA_ONLY_id" >= 0 ) ,
-- FOREIGN KEY : "no-ligands-for-mogul" ( "no-ligands-for-mogul_id" )
	"no-ligands-for-mogul_id" BIGINT CHECK ( "no-ligands-for-mogul_id" >= 0 ) ,
-- FOREIGN KEY : "no-ligands-for-buster-report" ( "no-ligands-for-buster-report_id" )
	"no-ligands-for-buster-report_id" BIGINT CHECK ( "no-ligands-for-buster-report_id" >= 0 ) ,
-- FOREIGN KEY : "ligands-for-buster-report" ( "ligands-for-buster-report_id" )
	"ligands-for-buster-report_id" BIGINT CHECK ( "ligands-for-buster-report_id" >= 0 ) ,
-- FOREIGN KEY : link ( link_id )
	link_id BIGINT CHECK ( link_id >= 0 ) ,
-- FOREIGN KEY : ligand_clashes_outlier ( ligand_clashes_outlier_id )
	ligand_clashes_outlier_id BIGINT CHECK ( ligand_clashes_outlier_id >= 0 ) ,
-- FOREIGN KEY : ligand_chirality_outlier ( ligand_chirality_outlier_id )
	ligand_chirality_outlier_id BIGINT CHECK ( ligand_chirality_outlier_id >= 0 ) ,
-- FOREIGN KEY : cis_peptide ( cis_peptide_id )
	cis_peptide_id BIGINT CHECK ( cis_peptide_id >= 0 ) ,
-- FOREIGN KEY : "mogul-ignore" ( "mogul-ignore_id" )
	"mogul-ignore_id" BIGINT CHECK ( "mogul-ignore_id" >= 0 ) ,
-- FOREIGN KEY : ligand_geometry_outlier ( ligand_geometry_outlier_id )
	ligand_geometry_outlier_id BIGINT CHECK ( ligand_geometry_outlier_id >= 0 ) ,
-- FOREIGN KEY : ligand_density_outlier ( ligand_density_outlier_id )
	ligand_density_outlier_id BIGINT CHECK ( ligand_density_outlier_id >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: CA_ONLY no-ligands-for-mogul no-ligands-for-buster-report ligands-for-buster-report link ligand_clashes_outlier ligand_chirality_outlier cis_peptide mogul-ignore ligand_geometry_outlier ligand_density_outlier
	content ENUM_YesString_content
);

--
-- The MolProbity Ramachandran outlier score (a percentage). A residue is considered to be a Ramachandran plot outlier if the combination of its phi and psi torsion angles is unusual, as assessed by MolProbity. The Ramachandran outlier score for an entry is calculated as the percentage of Ramachandran outliers with respect to the total number of residues in the entry for which the outlier assessment is available. Example: percent-rama-outliers="0.00" Specific to structures that contain protein chains. For NMR structures only the well-defined (core) residues from ensemble analysis will be considered.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
CREATE TABLE percentage (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	percentage_id BIGINT CHECK ( percentage_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "percent-rama-outliers" ( "percent-rama-outliers_id" )
	"percent-rama-outliers_id" BIGINT CHECK ( "percent-rama-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "percent-rama-outliers-full-length" ( "percent-rama-outliers-full-length_id" )
	"percent-rama-outliers-full-length_id" BIGINT CHECK ( "percent-rama-outliers-full-length_id" >= 0 ) ,
-- FOREIGN KEY : "percent-rota-outliers" ( "percent-rota-outliers_id" )
	"percent-rota-outliers_id" BIGINT CHECK ( "percent-rota-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "percent-rota-outliers-full-length" ( "percent-rota-outliers-full-length_id" )
	"percent-rota-outliers-full-length_id" BIGINT CHECK ( "percent-rota-outliers-full-length_id" >= 0 ) ,
-- FOREIGN KEY : "DataCompleteness" ( "DataCompleteness_id" )
	"DataCompleteness_id" BIGINT CHECK ( "DataCompleteness_id" >= 0 ) ,
-- FOREIGN KEY : "percent-free-reflections" ( "percent-free-reflections_id" )
	"percent-free-reflections_id" BIGINT CHECK ( "percent-free-reflections_id" >= 0 ) ,
-- FOREIGN KEY : "percent-RSRZ-outliers" ( "percent-RSRZ-outliers_id" )
	"percent-RSRZ-outliers_id" BIGINT CHECK ( "percent-RSRZ-outliers_id" >= 0 ) ,
-- FOREIGN KEY : local_density ( local_density_id )
	local_density_id BIGINT CHECK ( local_density_id >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: percent-rama-outliers percent-rama-outliers-full-length percent-rota-outliers percent-rota-outliers-full-length DataCompleteness percent-free-reflections percent-RSRZ-outliers local_density
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	content REAL CHECK ( content >= 0.0 AND content <= 100.0 )
);

--
-- Whether the B factor is FULL or PARTIAL. Normally B factors are FULL. Example: B_factor_type="FULL". X-ray entry specific, obtained from the DCC program.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
DROP TYPE IF EXISTS ENUM_BfactorType_content CASCADE;
CREATE TYPE ENUM_BfactorType_content AS ENUM ( 'PARTIAL', 'FULL' );
CREATE TABLE "BfactorType" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	"BfactorType_id" BIGINT CHECK ( "BfactorType_id" >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "B_factor_type" ( "B_factor_type_id" )
	"B_factor_type_id" BIGINT CHECK ( "B_factor_type_id" >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: B_factor_type
	content ENUM_BfactorType_content
);

--
-- The "all" percentile rank for the property RNAsuiteness (the MolProbity conformer-match quality parameter for RNA structures). The comparison will be to: * For X-ray structures: the set of all structures determined by X-ray crystallography ... * For NMR and EM structures: the set of all PDB structures ... deposited, up to the date included in the program name="percentiles" version, where the RNAsuiteness was successfully calculated. Example: absolute-percentile-RNAsuiteness="99.7" Specific to entries that contain RNA polymers (and have a RNAsuiteness attribute). Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
CREATE TABLE percentile_rank (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	percentile_rank_id BIGINT CHECK ( percentile_rank_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "absolute-percentile-RNAsuiteness" ( "absolute-percentile-RNAsuiteness_id" )
	"absolute-percentile-RNAsuiteness_id" BIGINT CHECK ( "absolute-percentile-RNAsuiteness_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-RNAsuiteness" ( "relative-percentile-RNAsuiteness_id" )
	"relative-percentile-RNAsuiteness_id" BIGINT CHECK ( "relative-percentile-RNAsuiteness_id" >= 0 ) ,
-- FOREIGN KEY : "absolute-percentile-clashscore" ( "absolute-percentile-clashscore_id" )
	"absolute-percentile-clashscore_id" BIGINT CHECK ( "absolute-percentile-clashscore_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-clashscore" ( "relative-percentile-clashscore_id" )
	"relative-percentile-clashscore_id" BIGINT CHECK ( "relative-percentile-clashscore_id" >= 0 ) ,
-- FOREIGN KEY : "absolute-percentile-percent-rama-outliers" ( "absolute-percentile-percent-rama-outliers_id" )
	"absolute-percentile-percent-rama-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-rama-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-percent-rama-outliers" ( "relative-percentile-percent-rama-outliers_id" )
	"relative-percentile-percent-rama-outliers_id" BIGINT CHECK ( "relative-percentile-percent-rama-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "absolute-percentile-percent-rota-outliers" ( "absolute-percentile-percent-rota-outliers_id" )
	"absolute-percentile-percent-rota-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-rota-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-percent-rota-outliers" ( "relative-percentile-percent-rota-outliers_id" )
	"relative-percentile-percent-rota-outliers_id" BIGINT CHECK ( "relative-percentile-percent-rota-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "absolute-percentile-DCC_Rfree" ( "absolute-percentile-DCC_Rfree_id" )
	"absolute-percentile-DCC_Rfree_id" BIGINT CHECK ( "absolute-percentile-DCC_Rfree_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-DCC_Rfree" ( "relative-percentile-DCC_Rfree_id" )
	"relative-percentile-DCC_Rfree_id" BIGINT CHECK ( "relative-percentile-DCC_Rfree_id" >= 0 ) ,
-- FOREIGN KEY : "absolute-percentile-percent-RSRZ-outliers" ( "absolute-percentile-percent-RSRZ-outliers_id" )
	"absolute-percentile-percent-RSRZ-outliers_id" BIGINT CHECK ( "absolute-percentile-percent-RSRZ-outliers_id" >= 0 ) ,
-- FOREIGN KEY : "relative-percentile-percent-RSRZ-outliers" ( "relative-percentile-percent-RSRZ-outliers_id" )
	"relative-percentile-percent-RSRZ-outliers_id" BIGINT CHECK ( "relative-percentile-percent-RSRZ-outliers_id" >= 0 ) ,
-- SIMPLE CONTENT AS ATTRIBUTE, ATTRIBUTE NODE: absolute-percentile-RNAsuiteness relative-percentile-RNAsuiteness absolute-percentile-clashscore relative-percentile-clashscore absolute-percentile-percent-rama-outliers relative-percentile-percent-rama-outliers absolute-percentile-percent-rota-outliers relative-percentile-percent-rota-outliers absolute-percentile-DCC_Rfree relative-percentile-DCC_Rfree absolute-percentile-percent-RSRZ-outliers relative-percentile-percent-RSRZ-outliers
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	content REAL CHECK ( content >= 0.0 AND content <= 100.0 )
);

--
-- A "Model" is one of the structures that are described by a PDB entry. Most NMR entries as well as some entries determined by other experimental techniques, contain an ensemble of models (structures). For most NMR entries, the models should be chemically identical - i.e., contain the exact same atoms, and will only differ in the cartesian coordinates of constituent atoms. For older NMR entries, and for non-NMR entries, this is not enforced.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "Model" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"Model_id" BIGINT CHECK ( "Model_id" >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- ATTRIBUTE
	model INTEGER ,
-- ATTRIBUTE
	nmrclust_cluster_id TEXT ,
-- ATTRIBUTE
	nmrclust_representative TEXT
);

--
-- Bond outlier for standard amino acid or nucleic acid in comparison to the Engh and Huber EH99 parameters, Parkinson et al. parameter set. It involves two atoms. The obs, mean, stdev will all be in Angstroms units. Example: <bond-outlier atom0="C" atom1="OXT" mean="1.229" obs="1.327" stdev="0.019" z="5.16"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "bond-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"bond-outlier_id" BIGINT CHECK ( "bond-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom0 ( atom0_id, DELEGATED TO atom_name_id )
	atom0_id BIGINT CHECK ( atom0_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom1 ( atom1_id, DELEGATED TO atom_name_id )
	atom1_id BIGINT CHECK ( atom1_id >= 0 ) ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	obs DECIMAL ,
-- ATTRIBUTE
	z DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : link ( link_id, DELEGATED TO "YesString_id" )
	link_id BIGINT CHECK ( link_id >= 0 )
);

--
-- Bond angle outlier for standard amino acid or nucleic acid in comparison to the Engh and Huber EH99 parameters, Parkinson et al. parameter set. It involves three atoms. The obsval, mean, mindiff, stdev will all be in degrees. Example: < atom0="C" atom1="N" atom2="CA" link="yes" mean="121.700" obs="139.881" stdev="2.500" z="7.27"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "angle-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"angle-outlier_id" BIGINT CHECK ( "angle-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom0 ( atom0_id, DELEGATED TO atom_name_id )
	atom0_id BIGINT CHECK ( atom0_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom1 ( atom1_id, DELEGATED TO atom_name_id )
	atom1_id BIGINT CHECK ( atom1_id >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom2 ( atom2_id, DELEGATED TO atom_name_id )
	atom2_id BIGINT CHECK ( atom2_id >= 0 ) ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	obs DECIMAL ,
-- ATTRIBUTE
	z DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : link ( link_id, DELEGATED TO "YesString_id" )
	link_id BIGINT CHECK ( link_id >= 0 )
);

--
-- Indicates there is a problem in the chirality compared to that expected with an atom in the residue. Chiral centres for all compounds occurring in the PDB are described in the chemical component dictionary. Chirality can be assessed in a number of ways, including calculation of the chiral volume, e.g. for the Calpha of amino acids this is 2.6 or -2.6 Angstrom cubed for L or D configurations, respectively. If the sign of the computed volume is incorrect, the handedness is wrong. If the absolute volume is less than 0.7Å3 , the chiral centre has been modelled as a planar moiety which is very likely to be erroneous. Chirality deviations are summarised per chain.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
DROP TYPE IF EXISTS ENUM_chiral_outlier_problem CASCADE;
CREATE TYPE ENUM_chiral_outlier_problem AS ENUM ( 'WRONG HAND', 'PLANAR' );
CREATE TABLE "chiral-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"chiral-outlier_id" BIGINT CHECK ( "chiral-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	problem ENUM_chiral_outlier_problem NOT NULL
);

--
-- Indicates that there is a problem with planarity of group defined in the standard_geometry.cif for amino acids/proteins or nucleic acid. Calculated by the Validation-pack program. Examples: <plane-outlier improper="-13.96" type="mainchain"/> <plane-outlier omega="-145.49" type="peptide"/> <plane-outlier planeRMSD="0.17" type="sidechain"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_plane_outlier_type CASCADE;
CREATE TYPE ENUM_plane_outlier_type AS ENUM ( 'mainchain', 'peptide', 'sidechain' );
CREATE TABLE "plane-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"plane-outlier_id" BIGINT CHECK ( "plane-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- ATTRIBUTE
	type ENUM_plane_outlier_type NOT NULL ,
-- ATTRIBUTE
	improper DECIMAL ,
-- ATTRIBUTE
	omega DECIMAL ,
-- ATTRIBUTE
	"planeRMSD" DECIMAL
);

--
-- A MolProbity all-atom clash outlier within the residue. Note that hydrogen atoms are added to the model and optimized by the reduce program. Outliers often involve these added hydrogen atoms. Example: <clash atom="HB3" cid="7" clashmag="0.44" dist="2.57"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE clash (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	clash_id BIGINT CHECK ( clash_id >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	cid INTEGER NOT NULL ,
-- ATTRIBUTE
	clashmag DECIMAL NOT NULL ,
-- ATTRIBUTE
	dist DECIMAL
);

--
-- A symmetry-related clash identified by Validation-pack. Symmetry related clashes are too-close contacts between two atoms across a crystallographic symmetry contact. Only relevant to crystallographic structures. Example: <symm-clash atom="O" clashmag="0.79" dist="1.41" scid="0" symop="2_657"/> From mmcif item "_pdbx_validate_symm_contact".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE "symm-clash" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"symm-clash_id" BIGINT CHECK ( "symm-clash_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : atom ( atom_id, DELEGATED TO atom_name_id )
	atom_id BIGINT CHECK ( atom_id >= 0 ) ,
-- ATTRIBUTE
	symop TEXT NOT NULL ,
-- ATTRIBUTE
	scid INTEGER NOT NULL ,
-- ATTRIBUTE
	clashmag DECIMAL NOT NULL ,
-- ATTRIBUTE
	dist DECIMAL
);

--
-- Bond outlier for ligand or modified amino acid/nucleic acid identified by the Mogul program. It will involve two atoms. The obsval, mean, mindiff, stdev will all be in Angstroms units. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD) Example: <mog-bond-outlier Zscore="2.25" atoms="C1,C6" mean="1.53" mindiff="0.00" numobs="128" obsval="1.56" stdev="0.01"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-bond-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"mog-bond-outlier_id" BIGINT CHECK ( "mog-bond-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- ATTRIBUTE
	atoms TEXT ,
-- ATTRIBUTE
	obsval DECIMAL ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	numobs INTEGER ,
-- ATTRIBUTE
	"Zscore" DECIMAL ,
-- ATTRIBUTE
	mindiff DECIMAL
);

--
-- Bond angle outlier for ligand or modified amino acid/nucleic acid identified by the Mogul program. It involves three atoms. The obsval, mean, mindiff, stdev will all be in degrees. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD).
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-angle-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"mog-angle-outlier_id" BIGINT CHECK ( "mog-angle-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- ATTRIBUTE
	atoms TEXT ,
-- ATTRIBUTE
	obsval DECIMAL ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	numobs INTEGER ,
-- ATTRIBUTE
	"Zscore" DECIMAL ,
-- ATTRIBUTE
	mindiff DECIMAL
);

--
-- Torsion angle outlier for ligand or modified amino acid/nucleic acid identified by the Mogul program. It will involve four atoms. The obsval, mean, mindiff, stdev will all be in degrees. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD).
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: true, virtual: false
--
CREATE TABLE "mog-torsion-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"mog-torsion-outlier_id" BIGINT CHECK ( "mog-torsion-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- ATTRIBUTE
	atoms TEXT ,
-- ATTRIBUTE
	obsval DECIMAL ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	mindiff DECIMAL ,
-- ATTRIBUTE
	numobs INTEGER ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- NESTED KEY AS ATTRIBUTE : local_density ( local_density_id, DELEGATED TO percentage_id )
	local_density_id BIGINT CHECK ( local_density_id >= 0 )
);

--
-- Unusual ring conformation identified by Mogul. Mogul finds similar ring and works out the rmsd deviation of the ring torsion angles compared to the CSD similar rings. Each ring involves five or six atoms. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD).
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-ring-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"mog-ring-outlier_id" BIGINT CHECK ( "mog-ring-outlier_id" >= 0 ) ,
-- FOREIGN KEY : "ModelledSubgroup" ( "ModelledSubgroup_id" )
	"ModelledSubgroup_id" BIGINT CHECK ( "ModelledSubgroup_id" >= 0 ) ,
-- ATTRIBUTE
	atoms TEXT ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	mindiff DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	numobs INTEGER
);

--
-- Cyrange software is used to identify well-defined regions of protein structures in NMR ensembles. The well-defined region may contain more than one well-defined core or domain, which are not well defined with respect to each other. Each of these individual cores/domains is described as a "cyrange_domain".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE cyrange_domain (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	cyrange_domain_id BIGINT CHECK ( cyrange_domain_id >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- ATTRIBUTE
	domain INTEGER ,
-- ATTRIBUTE
	number_of_gaps INTEGER ,
-- ATTRIBUTE
	number_of_residues INTEGER ,
-- ATTRIBUTE
	percentage_of_core DECIMAL ,
-- ATTRIBUTE
	rmsd DECIMAL ,
-- ATTRIBUTE
	medoid_model INTEGER ,
-- ATTRIBUTE
	medoid_rmsd DECIMAL ,
-- ATTRIBUTE
	residue_string TEXT
);

--
-- Each separate chain in the structure is a "ModelledEntityInstance". In the case of multiple models each individual model is a "ModelledEntityInstance" on its own.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "ModelledEntityInstance" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	"ModelledEntityInstance_id" BIGINT CHECK ( "ModelledEntityInstance_id" >= 0 ) ,
-- FOREIGN KEY : "wwPDB-validation-information" ( "wwPDB-validation-information_id" )
	"wwPDB-validation-information_id" BIGINT CHECK ( "wwPDB-validation-information_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "absolute_RSRZ_percentile" ( "absolute_RSRZ_percentile_id", DELEGATED TO "floatORunavailable_id" )
	"absolute_RSRZ_percentile_id" BIGINT CHECK ( "absolute_RSRZ_percentile_id" >= 0 ) ,
-- NESTED KEY AS ATTRIBUTE : "relative_RSRZ_percentile" ( "relative_RSRZ_percentile_id", DELEGATED TO "floatORunavailable_id" )
	"relative_RSRZ_percentile_id" BIGINT CHECK ( "relative_RSRZ_percentile_id" >= 0 ) ,
-- ATTRIBUTE
	absolute_rama_percentile DECIMAL ,
-- ATTRIBUTE
	relative_rama_percentile DECIMAL ,
-- ATTRIBUTE
	absolute_sidechain_percentile DECIMAL ,
-- ATTRIBUTE
	relative_sidechain_percentile DECIMAL ,
-- ATTRIBUTE
	angles_rmsz DECIMAL ,
-- ATTRIBUTE
	bonds_rmsz DECIMAL ,
-- ATTRIBUTE
	num_bonds_rmsz INTEGER ,
-- ATTRIBUTE
	num_angles_rmsz INTEGER ,
-- ATTRIBUTE
	average_residue_inclusion DECIMAL ,
-- ATTRIBUTE
	chain TEXT ,
-- ATTRIBUTE
	model TEXT ,
-- ATTRIBUTE
	said TEXT ,
-- ATTRIBUTE
	ent TEXT
);

--
-- The recommended contour level for the primary map of this entry
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "RecommendedContourLevel" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	"RecommendedContourLevel_id" BIGINT CHECK ( "RecommendedContourLevel_id" >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "EM_validation" ( "EM_validation_id" )
	"EM_validation_id" BIGINT CHECK ( "EM_validation_id" >= 0 ) ,
-- ATTRIBUTE
	value DECIMAL NOT NULL
);

--
-- Contains an element for each atom inclusion graph line
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: false, bridge: false, virtual: false
--
CREATE TABLE atom_inclusion (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	atom_inclusion_id BIGINT CHECK ( atom_inclusion_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : "EM_validation" ( "EM_validation_id" )
	"EM_validation_id" BIGINT CHECK ( "EM_validation_id" >= 0 ) ,
-- NESTED KEY : all_atoms ( all_atoms_id, DELEGATED TO graph_id )
	all_atoms_id BIGINT CHECK ( all_atoms_id >= 0 ) ,
-- NESTED KEY : backbone ( backbone_id, DELEGATED TO graph_id )
	backbone_id BIGINT CHECK ( backbone_id >= 0 )
);

--
-- Contains information regarding a fsc intersection
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin root, content: true, list: false, bridge: false, virtual: true
--
CREATE TABLE fsc_intersection (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	fsc_intersection_id BIGINT CHECK ( fsc_intersection_id >= 0 ) ,
-- FOREIGN KEY : intersection ( intersection_id )
	intersection_id BIGINT CHECK ( intersection_id >= 0 ) ,
-- ATTRIBUTE
	correlation DECIMAL NOT NULL ,
-- ATTRIBUTE
	curve TEXT NOT NULL ,
-- ATTRIBUTE
	resolution DECIMAL NOT NULL ,
-- ATTRIBUTE
	spatial_frequency DECIMAL NOT NULL ,
-- ATTRIBUTE
	type TEXT NOT NULL
);

--
-- Contains intersections between fsc_curves and their corresponding fsc_indicator_curves
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: true, bridge: true, virtual: false
--
CREATE TABLE resolution_intersections (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	resolution_intersections_id BIGINT CHECK ( resolution_intersections_id >= 0 ) ,
-- FOREIGN KEY : fsc ( fsc_id )
	fsc_id BIGINT CHECK ( fsc_id >= 0 ) CONSTRAINT FK_resolution_intersections_fsc REFERENCES fsc ( fsc_id ) ON DELETE CASCADE ,
-- NESTED KEY : intersection ( intersection_id, DELEGATED TO fsc_intersection_id )
	intersection_id BIGINT CHECK ( intersection_id >= 0 ) ,
-- ATTRIBUTE
-- @default="A"
	resolution_unit TEXT ,
-- ATTRIBUTE
-- @default="1/A"
	spatial_frequency_unit TEXT
);

--
-- No annotation is available
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: false, bridge: false, virtual: false
--
CREATE TABLE fsc_curves (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	fsc_curves_id BIGINT CHECK ( fsc_curves_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : fsc ( fsc_id )
	fsc_id BIGINT CHECK ( fsc_id >= 0 ) CONSTRAINT FK_fsc_curves_fsc REFERENCES fsc ( fsc_id ) ON DELETE CASCADE
);

--
-- No annotation is available
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: false, list: false, bridge: false, virtual: false
--
CREATE TABLE fsc_indicator_curves (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- PRIMARY KEY
	fsc_indicator_curves_id BIGINT CHECK ( fsc_indicator_curves_id >= 0 ) PRIMARY KEY ,
-- FOREIGN KEY : fsc ( fsc_id )
	fsc_id BIGINT CHECK ( fsc_id >= 0 ) CONSTRAINT FK_fsc_indicator_curves_fsc REFERENCES fsc ( fsc_id ) ON DELETE CASCADE
);

--
-- An individual program used by the validation pipeline. Normally this corresponds to a "step" but not always.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE program (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	program_id BIGINT CHECK ( program_id >= 0 ) ,
-- FOREIGN KEY : programs ( programs_id )
	programs_id BIGINT CHECK ( programs_id >= 0 ) ,
-- ATTRIBUTE
	name TEXT NOT NULL ,
-- ATTRIBUTE
	properties TEXT NOT NULL ,
-- ATTRIBUTE
	version TEXT NOT NULL
);

--
-- A shared element for storing graphs, contains X and Y coordinates for a single point. Axis labels and scales should be stored in the parent element
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: admin child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE coordinate (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
	coordinate_id BIGINT CHECK ( coordinate_id >= 0 ) ,
-- FOREIGN KEY : graph ( graph_id )
	graph_id BIGINT CHECK ( graph_id >= 0 ) CONSTRAINT FK_coordinate_graph REFERENCES graph ( graph_id ) ON DELETE CASCADE ,
-- ATTRIBUTE
	x REAL NOT NULL ,
-- ATTRIBUTE
	y REAL NOT NULL
);

--
-- An atom name from cif item _atom_site.label_atom_id and _chem_comp_atom.atom_id. Currently limited to 4 characters. Example: atom="NE2"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW atom AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM unmapped_chemical_shift WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM unparsed_chemical_shift WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM chemical_shift_outlier WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM referencing_offset WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM "chiral-outlier" WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM clash WHERE atom_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom_id AS atom_name_id
FROM "symm-clash" WHERE atom_id IS NOT NULL;

--
-- An atom name for the first atom in a bond or angle outlier. Atom names are from cif item _atom_site.label_atom_id and _chem_comp_atom.atom_id. Currently limited to 4 characters. Example: atom="NE2"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW atom0 AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom0_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom0_id AS atom_name_id
FROM "bond-outlier" WHERE atom0_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom0_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom0_id AS atom_name_id
FROM "angle-outlier" WHERE atom0_id IS NOT NULL;

--
-- An atom name for the second atom in a bond or angle outlier. Atom names are from cif item _atom_site.label_atom_id and _chem_comp_atom.atom_id. Currently limited to 4 characters. Example: atom="CE2"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW atom1 AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom1_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom1_id AS atom_name_id
FROM "bond-outlier" WHERE atom1_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom1_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom1_id AS atom_name_id
FROM "angle-outlier" WHERE atom1_id IS NOT NULL;

--
-- The bond or bond angle involves one or atom that is in another residue. Example: link="yes"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW link AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	link_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	link_id AS "YesString_id"
FROM "bond-outlier" WHERE link_id IS NOT NULL
UNION ALL
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	link_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	link_id AS "YesString_id"
FROM "angle-outlier" WHERE link_id IS NOT NULL;

--
-- An atom name for third atom in an angle outlier. Atom names are from cif item _atom_site.label_atom_id and _chem_comp_atom.atom_id. Currently limited to 4 characters. Example: atom="NE2"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW atom2 AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	atom2_id ,
-- NESTED KEY AS ATTRIBUTE : atom_name ( atom_name_id )
	atom2_id AS atom_name_id
FROM "angle-outlier" WHERE atom2_id IS NOT NULL;

--
-- The local density is the percentage of observed Mogul torsion angles within certain units of the query torsion angle. Units depend on the parameter being analyzed. Example: local_density="17.5"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW local_density AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	local_density_id ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	local_density_id AS percentage_id
FROM "mog-torsion-outlier" WHERE local_density_id IS NOT NULL;

--
-- The "all" percentile rank for the property percent-RSRZ-outliers for the chain/model (The proportion of residues that are RSRZ outliers reported as a percentage). The comparison will be to the set of all structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the percent-RSRZ-outliers was successfully calculated. Example: absolute_RSRZ_percentile="39.90" N.B. this is the chain/model equivalent of the overall (all chain) category "absolute-percentile-percent-RSRZ-outliers" X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute_RSRZ_percentile" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	"absolute_RSRZ_percentile_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"absolute_RSRZ_percentile_id" AS "floatORunavailable_id"
FROM "ModelledEntityInstance" WHERE "absolute_RSRZ_percentile_id" IS NOT NULL;

--
-- The "similar" percentile rank for the property percent-RSRZ-outliers for the chain/model (The proportion of residues that are RSRZ outliers reported as a percentage). The comparison will be to the subset of structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the percent-RSRZ-outliers was successfully calculated that have a similar resolution ("PDB-resolution"). Example: relative_RSRZ_percentile="34.81" N.B. this is the chain/model equivalent of the overall (all chain) category "absolute-percentile-percent-RSRZ-outliers" X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative_RSRZ_percentile" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	"relative_RSRZ_percentile_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"relative_RSRZ_percentile_id" AS "floatORunavailable_id"
FROM "ModelledEntityInstance" WHERE "relative_RSRZ_percentile_id" IS NOT NULL;

--
-- Contains the data required to plot atom inclusion for for all atoms.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW all_atoms AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	all_atoms_id ,
-- NESTED KEY : graph ( graph_id )
	all_atoms_id AS graph_id
FROM atom_inclusion WHERE all_atoms_id IS NOT NULL;

--
-- Contains the data required to plot the atom inclusion for the backbone.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW backbone AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	backbone_id ,
-- NESTED KEY : graph ( graph_id )
	backbone_id AS graph_id
FROM atom_inclusion WHERE backbone_id IS NOT NULL;

--
-- Contains the data required to plot the map-value distribution graph for the primary map
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW map_value_distribution AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	map_value_distribution_id ,
-- NESTED KEY : graph ( graph_id )
	map_value_distribution_id AS graph_id
FROM "EM_validation" WHERE map_value_distribution_id IS NOT NULL;

--
-- Contains the data required to plot the rotationally averaged power spectrum graph for the primary map
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW rotationally_averaged_power_spectrum AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	rotationally_averaged_power_spectrum_id ,
-- NESTED KEY : graph ( graph_id )
	rotationally_averaged_power_spectrum_id AS graph_id
FROM "EM_validation" WHERE rotationally_averaged_power_spectrum_id IS NOT NULL;

--
-- Contains the data required to plot the volume estimate for the primary map
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW volume_estimate AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
-- PRIMARY KEY
	volume_estimate_id ,
-- NESTED KEY : graph ( graph_id )
	volume_estimate_id AS graph_id
FROM "EM_validation" WHERE volume_estimate_id IS NOT NULL;

--
-- For X-ray entries: data high resolution diffraction limit in Angstroms as reported in the input mmCIF file, normally taken from mmcif item _refine.ls_d_res_high or if this is not found _reflns.d_resolution_high. For EM entries: The final resolution, in Angstroms, of the 3d reconstruction as reported in the input mmCIF file, taken from _em_3d_reconstruction.resolution. If not available then item will be absent or set to "NotAvailable".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "PDB-resolution" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"PDB-resolution_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"PDB-resolution_id" AS "floatORunavailable_id"
FROM "Entry" WHERE "PDB-resolution_id" IS NOT NULL;

--
-- For X-ray entries: lower data resolution diffraction limit, in Angstroms, as reported in the input mmCIF file, normally taken from mmcif item _refine.ls_d_res_low or if this is not found _reflns.d_resolution_low.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "PDB-resolution-low" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"PDB-resolution-low_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"PDB-resolution-low_id" AS "floatORunavailable_id"
FROM "Entry" WHERE "PDB-resolution-low_id" IS NOT NULL;

--
-- The residual R-factor reported in the input mmCIF file. The value will be taken from mmcif item _refine.ls_R_factor_all or if this not found _refine.ls_R_factor_obs or if this is not found _refine.ls_R_factor_R_work. The R-factor is measure of the agreement between the crystallographic model and the experimental X-ray diffraction data. If not available then item will be absent or set to "NotAvailable".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "PDB-R" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"PDB-R_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"PDB-R_id" AS "floatORunavailable_id"
FROM "Entry" WHERE "PDB-R_id" IS NOT NULL;

--
-- The residual R-factor for free reflections in the refinement reported in the input mmCIF file. The value will be taken from mmcif item _refine.ls_R_factor_R_free. If not available then item will be absent or set to "NotAvailable".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "PDB-Rfree" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"PDB-Rfree_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"PDB-Rfree_id" AS "floatORunavailable_id"
FROM "Entry" WHERE "PDB-Rfree_id" IS NOT NULL;

--
-- The structure is a Calpha only model. Currently implementation uses test that the structure has more than 30 atoms with the name CA and that number of atoms with name CA is greater than 1/3 of the total number of atoms. Currently test only applied in the EDS step so will be only set for X-ray structures.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "CA_ONLY" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"CA_ONLY_id" ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	"CA_ONLY_id" AS "YesString_id"
FROM "Entry" WHERE "CA_ONLY_id" IS NOT NULL;

--
-- This will be set to "yes" when there were no ligands or modified residues found in the structure and consequently Mogul has not been run.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "no-ligands-for-mogul" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"no-ligands-for-mogul_id" ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	"no-ligands-for-mogul_id" AS "YesString_id"
FROM "Entry" WHERE "no-ligands-for-mogul_id" IS NOT NULL;

--
-- This will be set to "yes" when buster-report program was not run.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "no-ligands-for-buster-report" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"no-ligands-for-buster-report_id" ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	"no-ligands-for-buster-report_id" AS "YesString_id"
FROM "Entry" WHERE "no-ligands-for-buster-report_id" IS NOT NULL;

--
-- This will be set to "yes" when buster-report program was run.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "ligands-for-buster-report" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"ligands-for-buster-report_id" ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	"ligands-for-buster-report_id" AS "YesString_id"
FROM "Entry" WHERE "ligands-for-buster-report_id" IS NOT NULL;

--
-- The MolProbity Ramachandran outlier score (a percentage). A residue is considered to be a Ramachandran plot outlier if the combination of its phi and psi torsion angles is unusual, as assessed by MolProbity. The Ramachandran outlier score for an entry is calculated as the percentage of Ramachandran outliers with respect to the total number of residues in the entry for which the outlier assessment is available. Example: percent-rama-outliers="0.00" Specific to structures that contain protein chains. For NMR structures only the well-defined (core) residues from ensemble analysis will be considered.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-rama-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-rama-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-rama-outliers_id" AS percentage_id
FROM "Entry" WHERE "percent-rama-outliers_id" IS NOT NULL;

--
-- Only given for structures determined by NMR. The MolProbity Ramachandran outlier score for all atoms in the structure rather than just the well-defined (core) residues.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-rama-outliers-full-length" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-rama-outliers-full-length_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-rama-outliers-full-length_id" AS percentage_id
FROM "Entry" WHERE "percent-rama-outliers-full-length_id" IS NOT NULL;

--
-- The MolProbity sidechain outlier score (a percentage). Protein sidechains mostly adopt certain (combinations of) preferred torsion angle values (called rotamers or rotameric conformers), much like their backbone torsion angles (as assessed in the Ramachandran analysis). MolProbity considers the sidechain conformation of a residue to be an outlier if its set of torsion angles is not similar to any preferred combination. The sidechain outlier score is calculated as the percentage of residues with an unusual sidechain conformation with respect to the total number of residues for which the assessment is available. Example: percent-rota-outliers="2.44". Specific to structure that contain protein chains and have sidechains modelled. For NMR structures only the well-defined (core) residues from ensemble analysis will be considered.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-rota-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-rota-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-rota-outliers_id" AS percentage_id
FROM "Entry" WHERE "percent-rota-outliers_id" IS NOT NULL;

--
-- Only given for structures determined by NMR. The MolProbity sidechain outlier score for all atoms in the structure rather than just the well-defined (core) residues.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-rota-outliers-full-length" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-rota-outliers-full-length_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-rota-outliers-full-length_id" AS percentage_id
FROM "Entry" WHERE "percent-rota-outliers-full-length_id" IS NOT NULL;

--
-- Whether the B factor is FULL or PARTIAL. Normally B factors are FULL. Example: B_factor_type="FULL". X-ray entry specific, obtained from the DCC program.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "B_factor_type" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"B_factor_type_id" ,
-- NESTED KEY AS ATTRIBUTE : "BfactorType" ( "BfactorType_id" )
	"B_factor_type_id" AS "BfactorType_id"
FROM "Entry" WHERE "B_factor_type_id" IS NOT NULL;

--
-- The number of expected diffraction spots is a function of data resolution and the space group. This metric describes the number of recorded reflections as a percentage of the number expected. Example: "DataCompleteness="95.71"" X-ray entry specific, obtained from the REFMAC program, during the EDS calculation.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "DataCompleteness" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"DataCompleteness_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"DataCompleteness_id" AS percentage_id
FROM "Entry" WHERE "DataCompleteness_id" IS NOT NULL;

--
-- The free R-factor from a DCC recalculation of the electron density maps for the deposited coordinates and structure factors. Example: DCC_Rfree="0.19". Currently value is rounded to 2 decimal places. X-ray entry specific, obtained from the DCC program.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "DCC_Rfree" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"DCC_Rfree_id" ,
-- NESTED KEY AS ATTRIBUTE : "floatORunavailable" ( "floatORunavailable_id" )
	"DCC_Rfree_id" AS "floatORunavailable_id"
FROM "Entry" WHERE "DCC_Rfree_id" IS NOT NULL;

--
-- The percentage reflections in the free set as defined in the input structure factor file supplied to the validation pipeline. Example: percent-free-reflections="10.17". X-ray entry specific, obtained from the DCC program.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-free-reflections" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-free-reflections_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-free-reflections_id" AS percentage_id
FROM "Entry" WHERE "percent-free-reflections_id" IS NOT NULL;

--
-- The proportion of residues that are RSRZ outliers reported as a percentage. An RSRZ outlier is a residue that has an RSRZ greater than 2. For a description of the how RSRZ provides a measure of the fit between the model and electron density, see: https://wwpdb.org/validation/2016/XrayValidationReportHelp#fit_model_data. Example: percent-RSRZ-outliers="3.88" X-ray entry specific, obtained in the eds step from REFMAC calculated electron density map.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "percent-RSRZ-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"percent-RSRZ-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentage ( percentage_id )
	"percent-RSRZ-outliers_id" AS percentage_id
FROM "Entry" WHERE "percent-RSRZ-outliers_id" IS NOT NULL;

--
-- The "all" percentile rank for the property RNAsuiteness (the MolProbity conformer-match quality parameter for RNA structures). The comparison will be to: * For X-ray structures: the set of all structures determined by X-ray crystallography ... * For NMR and EM structures: the set of all PDB structures ... deposited, up to the date included in the program name="percentiles" version, where the RNAsuiteness was successfully calculated. Example: absolute-percentile-RNAsuiteness="99.7" Specific to entries that contain RNA polymers (and have a RNAsuiteness attribute). Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-RNAsuiteness" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-RNAsuiteness_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-RNAsuiteness_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-RNAsuiteness_id" IS NOT NULL;

--
-- The "relative" percentile rank for the property RNAsuiteness (the MolProbity conformer-match quality parameter for RNA structures). The comparison will be to: * For X-ray structures: the subset of structures structures determined by X-ray crystallography, that have a similar resolution ("PDB-resolution") to this entry, ... * For structures determined by NMR: the subset of structures determined by NMR ... * For structures determined by EM: the subset of structures determined by EM ... ... deposited up to the date included in the program name="percentiles" version and where the RNAsuiteness was successfully calculated. Example: absolute-percentile-RNAsuiteness="99.7" Specific to entries that contain RNA polymers (and have a RNAsuiteness attribute). Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-RNAsuiteness" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-RNAsuiteness_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-RNAsuiteness_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-RNAsuiteness_id" IS NOT NULL;

--
-- The "all" percentile rank for the property clashscore (the MolProbity all-atom too-close contacts parameter). The comparison will be to: * For X-ray structures: the set of all structures determined by X-ray crystallography ... * For NMR and EM structures: the set of all PDB structures ... deposited, up to the date included in the program name="percentiles" version, where the clashscore was successfully calculated. Example: absolute-percentile-clashscore="71.6" Only calculated if clashscore is available. Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-clashscore" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-clashscore_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-clashscore_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-clashscore_id" IS NOT NULL;

--
-- The "relative" percentile rank for the property clashscore (the MolProbity all-atom too-close contacts parameter). The comparison will be to: * For X-ray structures: the subset of structures structures determined by X-ray crystallography, that have a similar resolution ("PDB-resolution") to this entry, ... * For structures determined by NMR: the subset of structures determined by NMR ... * For structures determined by EM: the subset of structures determined by EM ... ... deposited up to the date included in the program name="percentiles" version and where the clashscore was successfully calculated. Example: relative-percentile-clashscore="64.4" Only calculated if clashscore is available. Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-clashscore" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-clashscore_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-clashscore_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-clashscore_id" IS NOT NULL;

--
-- The "all" percentile rank for the property percent-rama-outliers (the MolProbity Ramachandran outlier score). The comparison will be to: * For X-ray structures: the set of all structures determined by X-ray crystallography ... * For NMR and EM structures: the set of all PDB structures ... deposited, up to the date included in the program name="percentiles" version, where the percent-rama-outliers was successfully calculated. Example: absolute-percentile-percent-rama-outliers="100.0" Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-percent-rama-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-percent-rama-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-percent-rama-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-percent-rama-outliers_id" IS NOT NULL;

--
-- The "relative" percentile rank for the property percent-rama-outliers (the MolProbity Ramachandran outlier score). The comparison will be to: * For X-ray structures: the subset of structures structures determined by X-ray crystallography, that have a similar resolution ("PDB-resolution") to this entry, ... * For structures determined by NMR: the subset of structures determined by NMR ... * For structures determined by EM: the subset of structures determined by EM ... ... deposited up to the date included in the program name="percentiles" version and where the percent-rama-outliers was successfully calculated. Example: relative-percentile-percent-rama-outliers="100.0". Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-percent-rama-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-percent-rama-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-percent-rama-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-percent-rama-outliers_id" IS NOT NULL;

--
-- The "all" percentile rank for the property percent-rota-outliers (the MolProbity sidechain outlier score). The comparison will be to: * For X-ray structures: the set of all structures determined by X-ray crystallography ... * For NMR and EM structures: the set of all PDB structures ... deposited, up to the date included in the program name="percentiles" version, where the percent-rota-outliers was successfully calculated. Example: absolute-percentile-percent-rota-outliers="54.2" Only calculated if percent-rota-outliers is available. Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-percent-rota-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-percent-rota-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-percent-rota-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-percent-rota-outliers_id" IS NOT NULL;

--
-- The "relative" percentile rank for the property percent-rota-outliers (the MolProbity sidechain outlier score). The comparison will be to: * For X-ray structures: the subset of structures structures determined by X-ray crystallography, that have a similar resolution ("PDB-resolution") to this entry, ... * For structures determined by NMR: the subset of structures determined by NMR ... * For structures determined by EM: the subset of structures determined by EM ... ... deposited up to the date included in the program name="percentiles" version and where the percent-rota-outliers was successfully calculated. Example: relative-percentile-percent-rota-outliers="64.4" Only calculated if percent-rota-outliers is available. Produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-percent-rota-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-percent-rota-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-percent-rota-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-percent-rota-outliers_id" IS NOT NULL;

--
-- The "all" percentile rank for the property DCC_Rfree (the free R-factor from a DCC recalculation of the electron density maps for the deposited coordinates and structure factors). The comparison will be to the set of all structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the DCC_Rfree was successfully calculated. Example: absolute-percentile-DCC_Rfree="90.6". X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-DCC_Rfree" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-DCC_Rfree_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-DCC_Rfree_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-DCC_Rfree_id" IS NOT NULL;

--
-- The "similar" percentile rank for the property DCC_Rfree (the free R-factor from a DCC recalculation of the electron density maps for the deposited coordinates and structure factors). The comparison will be to the subset of structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the DCC_Rfree was successfully calculated that have a similar resolution ("PDB-resolution"). Example: relative-percentile-DCC_Rfree="92.9". X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-DCC_Rfree" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-DCC_Rfree_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-DCC_Rfree_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-DCC_Rfree_id" IS NOT NULL;

--
-- The "all" percentile rank for the property percent-RSRZ-outliers (The proportion of residues that are RSRZ outliers reported as a percentage). The comparison will be to the set of all structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the percent-RSRZ-outliers was successfully calculated. Example: absolute_RSRZ_percentile="83.82" N.B. this is the chain/model equivalent of the overall (all chain) category "absolute-percentile-percent-RSRZ-outliers" X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "absolute-percentile-percent-RSRZ-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"absolute-percentile-percent-RSRZ-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"absolute-percentile-percent-RSRZ-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "absolute-percentile-percent-RSRZ-outliers_id" IS NOT NULL;

--
-- The "similar" percentile rank for the property percent-RSRZ-outliers (The proportion of residues that are RSRZ outliers reported as a percentage). The comparison will be to the subset of structures determined by X-ray crystallography deposited, up to the date included in the program name="percentiles" version, where the percent-RSRZ-outliers was successfully calculated that have a similar resolution ("PDB-resolution"). Example: relative-percentile-percent-RSRZ-outliers="100.0". X-ray entry specific, produced by the percentiles step of the validation pipeline software.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "relative-percentile-percent-RSRZ-outliers" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"relative-percentile-percent-RSRZ-outliers_id" ,
-- NESTED KEY AS ATTRIBUTE : percentile_rank ( percentile_rank_id )
	"relative-percentile-percent-RSRZ-outliers_id" AS percentile_rank_id
FROM "Entry" WHERE "relative-percentile-percent-RSRZ-outliers_id" IS NOT NULL;

--
-- If the residue is a ligand and involved in clashes this will be set to yes: Example: ligand_clashes_outlier="yes".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW ligand_clashes_outlier AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	ligand_clashes_outlier_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	ligand_clashes_outlier_id AS "YesString_id"
FROM "ModelledSubgroup" WHERE ligand_clashes_outlier_id IS NOT NULL;

--
-- Will be set to "yes" if the residue is a ligand and has a chiral atom problem compared to the PDB chemical component definition. Example: ligand_chirality_outlier="yes".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW ligand_chirality_outlier AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	ligand_chirality_outlier_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	ligand_chirality_outlier_id AS "YesString_id"
FROM "ModelledSubgroup" WHERE ligand_chirality_outlier_id IS NOT NULL;

--
-- This residue is linked to the next residue by a peptide bond that has a cis rather than trans conformation. Example: cis_peptide="yes"
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW cis_peptide AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	cis_peptide_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	cis_peptide_id AS "YesString_id"
FROM "ModelledSubgroup" WHERE cis_peptide_id IS NOT NULL;

--
-- This will be set to "yes" if the residue is ignored for Mogul validation of bond geometry. For instance monoatomic ions such as sodium resname="NA" will have mogul-ignore="yes". Produced by the mogul step.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW "mogul-ignore" AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	"mogul-ignore_id" ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	"mogul-ignore_id" AS "YesString_id"
FROM "ModelledSubgroup" WHERE "mogul-ignore_id" IS NOT NULL;

--
-- This will be set to "yes" if that more than 40% of bonds, angles, torsions, and rings are found in the Mogul analysis to be outliers. Produced by the mogul step.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW ligand_geometry_outlier AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	ligand_geometry_outlier_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	ligand_geometry_outlier_id AS "YesString_id"
FROM "ModelledSubgroup" WHERE ligand_geometry_outlier_id IS NOT NULL;

--
-- This will be set to "yes" if EDS finds that the ligand has an issue with electron density fit. is used where the residue has Real-Space R-value (RSR) exceeding 0.5 or a Local Ligand Density Fit value (LLDF) is greater than 2. Note that the LLDF calculation is still under development and the methods and criterion for identifying outlier will be refined following analysis of a large test set of ligands. X-ray specific produce by the EDS step.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v004.xsd
-- type: root child (view), content: false, list: false, bridge: true, virtual: false
--
CREATE OR REPLACE VIEW ligand_density_outlier AS
SELECT
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id ,
	ligand_density_outlier_id ,
-- NESTED KEY AS ATTRIBUTE : "YesString" ( "YesString_id" )
	ligand_density_outlier_id AS "YesString_id"
FROM "ModelledSubgroup" WHERE ligand_density_outlier_id IS NOT NULL;

