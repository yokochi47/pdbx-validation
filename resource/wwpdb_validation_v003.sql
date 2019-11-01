--
-- PostgreSQL DDL generated from resource/wwpdb_validation_v003.xsd using xsd2pgschema
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
--  append document key: true
--  append serial key: false
--  append xpath key: false
--  retain constraint: false
--  retrieve field annotation: false
--  map integer numbers to: signed int 32 bits
--  map decimal numbers to: big decimal
--  map xsd date type to: sql date type
--
-- Statistics of schema:
--  Generated 17 tables (270 fields), 0 views (0 fields), 0 attr groups, 0 model groups in total
--   Unnecessary tables by inlining simple content as a primitive data type:
--    schema location: resource/wwpdb_validation_v003.xsd
--      atom_name, "floatORunavailable", "BfactorType", "YesString", percentile_rank, percentage
--   Namespaces:
--    http://www.w3.org/2001/XMLSchema (xsd)
--   Schema locations:
--    resource/wwpdb_validation_v003.xsd
--   Table types:
--    0 root, 17 root children, 0 admin roots, 0 admin children
--   System keys:
--    0 primary keys (0 unique constraints), 0 foreign keys, 0 nested keys (0 as attribute, 0 as attribute group)
--   User keys:
--    17 document keys, 0 serial keys, 0 xpath keys
--   Contents:
--    253 attributes (0 in-place document keys), 0 elements (0 in-place document keys), 0 simple contents (0 in-place document keys, 0 as attribute, 0 as conditional attribute)
--   Wild cards:
--    0 any elements, 0 any attributes
--   Constraints:
--    0 unique constraints from xsd:unique, 0 unique constraints from xsd:key, 0 foreign key constraints from xsd:keyref
--

--
-- COPYRIGHT ***************************************************************** Copyright 2014-2017 EMBL - European Bioinformatics Institute Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License. ***************************************************************** This is a XML schema for checking entry-specific validation XML documents from wwPDB. versions published: v1 2014/02/20 http://wwpdb.org/validation/schema/wwpdb_validation_v1.xsd v002 2016/02/25 http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd v002 2017/08/31 http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd (with annotations) v003 2019/05/27 http://wwpdb.org/validation/schema/wwpdb_validation_v003.xsd (added local_density, no-ligands-for-buster-report ligands-for-buster-report attribute) $Revision$ *****************************************************************
--

DROP TABLE IF EXISTS missing_nmrstar_tag CASCADE;
DROP TABLE IF EXISTS random_coil_index CASCADE;
DROP TABLE IF EXISTS assignment_completeness_well_defined CASCADE;
DROP TABLE IF EXISTS assignment_completeness_full_length CASCADE;
DROP TABLE IF EXISTS chemical_shift_list CASCADE;
DROP TABLE IF EXISTS "Entry" CASCADE;
DROP TABLE IF EXISTS "Model" CASCADE;
DROP TABLE IF EXISTS "bond-outlier" CASCADE;
DROP TABLE IF EXISTS "angle-outlier" CASCADE;
DROP TABLE IF EXISTS "plane-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-bond-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-angle-outlier" CASCADE;
DROP TABLE IF EXISTS "mog-ring-outlier" CASCADE;
DROP TABLE IF EXISTS "ModelledSubgroup" CASCADE;
DROP TABLE IF EXISTS cyrange_domain CASCADE;
DROP TABLE IF EXISTS "ModelledEntityInstance" CASCADE;
DROP TABLE IF EXISTS program CASCADE;

--
-- The chemical shifts must be supplied in NMR-STAR 3.1 format. In order for the shifts to be mapped to the molecular structure, certain values (data items or tags) must be provided.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE missing_nmrstar_tag (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
	nmrstar_tag_description TEXT NOT NULL ,
-- ATTRIBUTE
	nmrstar_tag TEXT NOT NULL
);

--
-- The Random Coil Index (RCI) is calculated for each residue from the protein sequence and assigned chemical shifts. Via an empirical formula the RCI correlates with disorder propensity of the residue.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE random_coil_index (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- For the well-defined regions of the structure, what is the completeness of chemical shift assignments for the typically assigned nuclei.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE assignment_completeness_well_defined (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE assignment_completeness_full_length (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- NMR entries are normally linked to one or more assigned chemical shift lists. A typical reason for containing multiple chemical shift lists would be differing experimental conditions or samples.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE chemical_shift_list (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- Entry contains most information that has a single value for the structure analyzed and in the run.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_YesString_content CASCADE;
CREATE TYPE ENUM_YesString_content AS ENUM ( 'yes' );
DROP TYPE IF EXISTS ENUM_BfactorType_content CASCADE;
CREATE TYPE ENUM_BfactorType_content AS ENUM ( 'PARTIAL', 'FULL' );
CREATE TABLE "Entry" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
	pdbid TEXT ,
-- ATTRIBUTE
	"PDB-deposition-date" TEXT ,
-- ATTRIBUTE
	"PDB-revision-number" DECIMAL ,
-- ATTRIBUTE
	"PDB-revision-date" TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"PDB-resolution" TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"PDB-resolution-low" TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"PDB-R" TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"PDB-Rfree" TEXT ,
-- ATTRIBUTE
	"protein-DNA-RNA-entities" TEXT ,
-- ATTRIBUTE
	"CA_ONLY" ENUM_YesString_content ,
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
-- ATTRIBUTE
	"no-ligands-for-mogul" ENUM_YesString_content ,
-- ATTRIBUTE
	"no-ligands-for-buster-report" ENUM_YesString_content ,
-- ATTRIBUTE
	"ligands-for-buster-report" ENUM_YesString_content ,
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
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-rama-outliers" REAL CHECK ( "percent-rama-outliers" >= 0.0 AND "percent-rama-outliers" <= 100.0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-rama-outliers-full-length" REAL CHECK ( "percent-rama-outliers-full-length" >= 0.0 AND "percent-rama-outliers-full-length" <= 100.0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-rota-outliers" REAL CHECK ( "percent-rota-outliers" >= 0.0 AND "percent-rota-outliers" <= 100.0 ) ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-rota-outliers-full-length" REAL CHECK ( "percent-rota-outliers-full-length" >= 0.0 AND "percent-rota-outliers-full-length" <= 100.0 ) ,
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
-- ATTRIBUTE
	"B_factor_type" ENUM_BfactorType_content ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"DataCompleteness" REAL CHECK ( "DataCompleteness" >= 0.0 AND "DataCompleteness" <= 100.0 ) ,
-- ATTRIBUTE
	"DCC_R" DECIMAL ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"DCC_Rfree" TEXT ,
-- ATTRIBUTE
	"DCC_refinement_program" TEXT ,
-- ATTRIBUTE
	"num-free-reflections" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-free-reflections" REAL CHECK ( "percent-free-reflections" >= 0.0 AND "percent-free-reflections" <= 100.0 ) ,
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
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"percent-RSRZ-outliers" REAL CHECK ( "percent-RSRZ-outliers" >= 0.0 AND "percent-RSRZ-outliers" <= 100.0 ) ,
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
	percentilebins TEXT ,
-- ATTRIBUTE
	"no-percentile-property" BOOLEAN ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-RNAsuiteness" REAL CHECK ( "absolute-percentile-RNAsuiteness" >= 0.0 AND "absolute-percentile-RNAsuiteness" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-RNAsuiteness" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-RNAsuiteness" REAL CHECK ( "relative-percentile-RNAsuiteness" >= 0.0 AND "relative-percentile-RNAsuiteness" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-RNAsuiteness" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-RNAsuiteness" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-RNAsuiteness" DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-clashscore" REAL CHECK ( "absolute-percentile-clashscore" >= 0.0 AND "absolute-percentile-clashscore" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-clashscore" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-clashscore" REAL CHECK ( "relative-percentile-clashscore" >= 0.0 AND "relative-percentile-clashscore" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-clashscore" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-clashscore" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-clashscore" DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-percent-rama-outliers" REAL CHECK ( "absolute-percentile-percent-rama-outliers" >= 0.0 AND "absolute-percentile-percent-rama-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-rama-outliers" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-percent-rama-outliers" REAL CHECK ( "relative-percentile-percent-rama-outliers" >= 0.0 AND "relative-percentile-percent-rama-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-rama-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-rama-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-rama-outliers" DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-percent-rota-outliers" REAL CHECK ( "absolute-percentile-percent-rota-outliers" >= 0.0 AND "absolute-percentile-percent-rota-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-rota-outliers" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-percent-rota-outliers" REAL CHECK ( "relative-percentile-percent-rota-outliers" >= 0.0 AND "relative-percentile-percent-rota-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-rota-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-rota-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-rota-outliers" DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-DCC_Rfree" REAL CHECK ( "absolute-percentile-DCC_Rfree" >= 0.0 AND "absolute-percentile-DCC_Rfree" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-DCC_Rfree" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-DCC_Rfree" REAL CHECK ( "relative-percentile-DCC_Rfree" >= 0.0 AND "relative-percentile-DCC_Rfree" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-DCC_Rfree" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-DCC_Rfree" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-DCC_Rfree" DECIMAL ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"absolute-percentile-percent-RSRZ-outliers" REAL CHECK ( "absolute-percentile-percent-RSRZ-outliers" >= 0.0 AND "absolute-percentile-percent-RSRZ-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-absolute-percentile-percent-RSRZ-outliers" INTEGER ,
-- ATTRIBUTE
-- xsd:restriction/xsd:maxInclusive="100."
-- xsd:restriction/xsd:minInclusive="0."
	"relative-percentile-percent-RSRZ-outliers" REAL CHECK ( "relative-percentile-percent-RSRZ-outliers" >= 0.0 AND "relative-percentile-percent-RSRZ-outliers" <= 100.0 ) ,
-- ATTRIBUTE
	"numPDBids-relative-percentile-percent-RSRZ-outliers" INTEGER ,
-- ATTRIBUTE
	"low-resol-relative-percentile-percent-RSRZ-outliers" DECIMAL ,
-- ATTRIBUTE
	"high-resol-relative-percentile-percent-RSRZ-outliers" DECIMAL
);

--
-- A "Model" is one of the structures that are described by a PDB entry. Most NMR entries as well as some entries determined by other experimental techniques, contain an ensemble of models (structures). For most NMR entries, the models should be chemically identical - i.e., contain the exact same atoms, and will only differ in the cartesian coordinates of constituent atoms. For older NMR entries, and for non-NMR entries, this is not enforced.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "Model" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
	model INTEGER ,
-- ATTRIBUTE
	nmrclust_cluster_id TEXT ,
-- ATTRIBUTE
	nmrclust_representative TEXT
);

--
-- Bond outlier for standard amino acid or nucleic acid in comparison to the Engh and Huber EH99 parameters, Parkinson et al. parameter set. It involves two atoms. The obs, mean, stdev will all be in Angstroms units. Example: <bond-outlier atom0="C" atom1="OXT" mean="1.229" obs="1.327" stdev="0.019" z="5.16"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "bond-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minLength="1"
	atom0 TEXT ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minLength="1"
	atom1 TEXT ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	obs DECIMAL ,
-- ATTRIBUTE
	z DECIMAL ,
-- ATTRIBUTE
	link ENUM_YesString_content
);

--
-- Bond angle outlier for standard amino acid or nucleic acid in comparison to the Engh and Huber EH99 parameters, Parkinson et al. parameter set. It involves three atoms. The obsval, mean, mindiff, stdev will all be in degrees. Example: < atom0="C" atom1="N" atom2="CA" link="yes" mean="121.700" obs="139.881" stdev="2.500" z="7.27"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "angle-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minLength="1"
	atom0 TEXT ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minLength="1"
	atom1 TEXT ,
-- ATTRIBUTE
-- xsd:restriction/xsd:minLength="1"
	atom2 TEXT ,
-- ATTRIBUTE
	mean DECIMAL ,
-- ATTRIBUTE
	stdev DECIMAL ,
-- ATTRIBUTE
	obs DECIMAL ,
-- ATTRIBUTE
	z DECIMAL ,
-- ATTRIBUTE
	link ENUM_YesString_content
);

--
-- Indicates that there is a problem with planarity of group defined in the standard_geometry.cif for amino acids/proteins or nucleic acid. Calculated by the Validation-pack program. Examples: <plane-outlier improper="-13.96" type="mainchain"/> <plane-outlier omega="-145.49" type="peptide"/> <plane-outlier planeRMSD="0.17" type="sidechain"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
DROP TYPE IF EXISTS ENUM_plane_outlier_type CASCADE;
CREATE TYPE ENUM_plane_outlier_type AS ENUM ( 'mainchain', 'peptide', 'sidechain' );
CREATE TABLE "plane-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- Bond outlier for ligand or modified amino acid/nucleic acid identified by the Mogul program. It will involve two atoms. The obsval, mean, mindiff, stdev will all be in Angstroms units. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD) Example: <mog-bond-outlier Zscore="2.25" atoms="C1,C6" mean="1.53" mindiff="0.00" numobs="128" obsval="1.56" stdev="0.01"/>
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-bond-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-angle-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- Unusual ring conformation identified by Mogul. Mogul finds similar ring and works out the rmsd deviation of the ring torsion angles compared to the CSD similar rings. Each ring involves five or six atoms. The Mogul program (Bruno et al., 2004) works by comparing the ligand geometry with preferred molecular geometries derived from high-quality, small-molecule structures in the Cambridge Structural Database (CSD).
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "mog-ring-outlier" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- A "ModelledSubgroup" is an individual occurence of a residue. If there are alternate atoms in the residue each alternate and any alternate atoms is a separate ModelledSubgroup. If there are multiple models then each of these is a separate subgroup.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
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
-- ATTRIBUTE
	ligand_clashes_outlier ENUM_YesString_content ,
-- ATTRIBUTE
	ligand_chirality_outlier ENUM_YesString_content ,
-- ATTRIBUTE
	cis_peptide ENUM_YesString_content ,
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
-- ATTRIBUTE
	"mogul-ignore" ENUM_YesString_content ,
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
-- ATTRIBUTE
	ligand_geometry_outlier ENUM_YesString_content ,
-- ATTRIBUTE
	ligand_density_outlier ENUM_YesString_content
);

--
-- Cyrange software is used to identify well-defined regions of protein structures in NMR ensembles. The well-defined region may contain more than one well-defined core or domain, which are not well defined with respect to each other. Each of these individual cores/domains is described as a "cyrange_domain".
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE cyrange_domain (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
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
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE "ModelledEntityInstance" (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"absolute_RSRZ_percentile" TEXT ,
-- ATTRIBUTE
-- xsd:union/@memberTypes="xsd:decimal NotAvailable"
	"relative_RSRZ_percentile" TEXT ,
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
	chain TEXT ,
-- ATTRIBUTE
	model TEXT ,
-- ATTRIBUTE
	said TEXT ,
-- ATTRIBUTE
	ent TEXT
);

--
-- An individual program used by the validation pipeline. Normally this corresponds to a "step" but not always.
-- xmlns: no namespace, schema location: resource/wwpdb_validation_v003.xsd
-- type: root child, content: true, list: false, bridge: false, virtual: false
--
CREATE TABLE program (
-- DOCUMENT KEY is pointer to data source (aka. Entry ID)
	document_id TEXT ,
-- ATTRIBUTE
	name TEXT NOT NULL ,
-- ATTRIBUTE
	properties TEXT NOT NULL ,
-- ATTRIBUTE
	version TEXT NOT NULL
);

