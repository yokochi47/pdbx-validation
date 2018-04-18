# pdbx-validation

The pdbx-validation is a generation tool for alternative [wwPDB validation information](https://www.wwpdb.org/validation/validation-reports), which includes [PDBx/mmCIF](http://mmcif.wwpdb.org/) compatible version of validation information (**PDBML-validation**), RDF version of validation information (**wwPDB/RDF-validation**) and a series of ontologies, **wwPDB Validation Information Dictionary**, **PDBML-validation Schema** and **wwPDB/OWL-validation**.

## Usage

- To generate the alternative wwPDB validation information of some PDB entries,<br />
 `./run_test.sh 5b1l 5u9b 5h0s ... `

- To update the alternative wwPDB validation information of the entire PDB entry,<br />
 `./run_all.sh`

- Here is a map of the program.<br />

File path | Document
--------- | --------
[schema/mmcif_pdbx_validation_v1.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_pdbx_validation_v1.293.dic) | wwPDB Validation Information Dictionary (v1.293)
[schema/pdbx-validation-v1.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v1.293.xsd) | PDBML-validation Schema (v1.293)
[schema/pdbx-validation-v1.owl](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v1.293.owl) | wwPDB/OWL-validation (v1.293)
[schema/mmcif_ddl.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_ddl_v2.2.0.dic) | extended mmCIF DDL Core Dictionary (dubbed as v2.2.0)
[resource/mmcif_pdbx_v50.dic](http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic) | current PDBx/mmCIF Dictionary (v5.293)
[resource/pdbx-v50.xsd](http://mmcif.wwpdb.org/schema/pdbx-v50.xsd) | current PDBML Schema (v5.293)
[resource/pdbx-v50.owl](https://rdf.wwpdb.org/schema/pdbx-v50.owl) | current PDBx ontology, ontology for wwPDB/RDF (v5.293)
[resource/wwpdb_validation_v002.xsd](http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd) | current XML Schema for wwPDB validation information (v002, rev30291)
[scripts](https://github.com/yokochi47/pdbx-validation/blob/master/scripts) | a directory contains scripts invoked by the 'run_all.sh' script
[virtuoso_scripts](https://github.com/yokochi47/pdbx-validation/blob/master/virtuoso_scripts) | a directory contains scripts for uploading wwPDB/RDF-validation to local SPARQL endpoint
[stylesheet](https://github.com/yokochi47/pdbx-validation/blob/master/stylesheet) | a directory contains XSL style sheets for generation of alternative wwPDB validation information
[test](https://github.com/yokochi47/pdbx-validation/blob/master/test) | a directory contains resource files for test on several PDB entries

## Examples of alternative wwPDB validation information

- PDB ID: [5B1L](https://pdbj.org/mine/summary/5b1l), Exptl. method: X-RAY DIFFRACTION
	- PDBML-validation: [5b1l-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5b1l-validation-full.xml)
	- wwPDB/RDF-validation: [5b1l-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5b1l-validation.rdf)

- PDB ID: [5U9B](https://pdbj.org/mine/summary/5u9b), Exptl. method: SOLUTION NMR
	- PDBML-validation: [5u9b-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5u9b-validation-full.xml)
	- wwPDB/RDF-validation: [5u9b-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5u9b-validation.rdf)

- PDB ID: [5H0S](https://pdbj.org/mine/summary/5h0s), Exptl. method: ELECTRON MICROSCOPY
	- PDBML-validation: [5h0s-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5h0s-validation-full.xml)
	- wwPDB/RDF-validation: [5h0s-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5h0s-validation.rdf)

## Bulk download service of alternative wwPDB validation information

- Bulk download via HTTP protocol

	- [PDBML-validation](http://bmrbpub.protein.osaka-u.ac.jp/archive/pdbml-valid/)

	- [wwPDB/RDF-validation](http://bmrbpub.protein.osaka-u.ac.jp/archive/wwpdb-rdf-valid/)

- Bulk download via rsync protocol

	- PDBML-validation:<br />
	 `% rsync -av --delete rsync://bmrbpub.protein.osaka-u.ac.jp/pdbml-valid .`

	- wwPDB/RDF-validation:<br />
	 `% rsync -av --delete rsync://bmrbpub.protein.osaka-u.ac.jp/wwpdb-rdf-valid .`

## Software requirements

- [**Java 8**](https://java.com/en/) or later.
- [**Apache Maven (mvn)**](https://maven.apache.org), used to install external libraries.
- [**Git (git)**](https://git-scm.com), used to install external libraries.
- [**mmCIF Dictionary Suite**](http://mmcif.wwpdb.org/docs/software-resources.html), optionally used to generate XML Schema from the wwPDB Validation Information Dictionary.
- [**PostgreSQL**](https://www.postgresql.org), optionally used to import XML contents to relational database.
- [**Virtuoso**](https://www.openlinksw.com/wiki/main/Main), oprionally used as SPARQL endpoint of wwPDB/RDF-validation.

## Release notes

- **Apr 18, 2018**: Release v1.2.3
	- Update wwPDB Validation Information Dictionary from v1.292 to 1.293.

- **Apr 9, 2018**: Release v1.2.2
	- Add description of bulk download service of the alternative wwPDB validation information.

- **Apr 5, 2018**: Release v1.2.1
	- Fix stylesheet to handle null RSR value, null medoid model number.
	- Enable differential XML Schema validation of compressed PDBML-validation.

- **Mar 23, 2018**: Release v1.2.0
	- Update PostgreSQL data migration scripts, in which differential update is enabled.
	- Update wwPDB Validation Information Dictionary from v1.291 to 1.292.

- **Mar 14, 2018**: Release v1.1.0
	- Added RDF uploader scripts, virtuoso_scripts.
	- Update wwPDB Validation Information Dictionary from v0.290 to 1.291.
	- Fix translation of _pdbx_dcc_map.LLDFZ from @ligRSRZ.
	- Fix translation of _pdbx_dcc_map.LLDF from @ligRSRnbrMean.

- **Feb 20, 2018**: Release v1.0.0
	- Changed dictionary version from v0 to v1.

- **Feb 16, 2018**: Release v0.1.0
	- Revise PDBML-validation Schema using xsd:minInclusive and xsd:maxExclusive without xsd:union.
	- Fix wwPDB/OWL-validation lacking XSD data type definition.
	- Add validate_all_gz.sh script to perform XML Schema validation of compressed PDBML-validation.

- **Feb 15, 2018**: Release v0.0.9
	- Add ontology relationship between wwPDB/OWL-validation and PDBx ontology.
	- Add ontology relationship between wwPDB/OWL-validation and BMRB/OWL.
	- Update ontology mapping between PDBx/mmCIF and NMR-STAR data items.
	- PDB mirror server is selectable from rsync.rcsb.org, ftp.pdbj.org, rsync.ebi.ac.uk based on network response.

- **Feb 13, 2018**: Release v0.0.8
	- Change directory: from pdbml-validtion to XML-validation, which contains compressed PDBML-validation.
	- Change directory: from rdf-validation to RDF-validation, which contains compressed wwPDB/RDF-validation.
	- Add source URL in PDBML-validation Schema pointing PDBx/mmCIF dictionary browser.

- **Feb 9, 2018**: Release v0.0.7
	- Add gzip compression scripts: compress_pdbml_validation.sh and compress_rdf_validation.sh
	- Update wwPDB Validation Information Dictionary from v0.289 to 0.290.

- **Feb 8, 2018**: Release v0.0.6
	- Fix scripts: merge_pdbml_info_worker.sh and validate_all.sh
	- Fix update_pdbml.sh and update_validation.sh scripts to support deleted or revised PDB entries.
	- Add scripts: sync_delete_with_pdbml.sh and sync_delete_with_info.sh

- **Feb 7, 2018**: Release v0.0.5
	- Add null value check for pdbx_dcc_geometry.all_atom_clashscore data item.

- **Feb 6, 2018**: Release v0.0.4
	- Update wwPDB Validation Information Dictionary.
	- Add null value check for pdbx_dcc_geometry.*_nmr_well_formed data items.
	- Support @no-percentile-property="true" case for pdbx_percentile_entity_view.
	- Reject multiple omega values for struct_mon_prot.omega since multi conformer occurs.
	- Fix parser for @residue_string where negative auth_seq_id prevents delimitation such as "A:-1-A:-1".
	- Fix parser for @atoms that involves null atom name such as "C5,,C6,", "C6,,N1,,C2,".

- **Feb 5, 2018**: Release v0.0.3
	- Update wwPDB Validation Information Dictionary.
	- Update 'extract_info.xsl' style sheet which caused validation errors.
	- Update 'run_test.sh' script which allows to add PDB IDs.

- **Feb 2, 2018**: Release v0.0.2
	- Change directory names and file extension of PDBML-validation.
	- Implement consistency checker about entry ID in XSL style sheet.
	- Avoid XSLT error for entries used other experimental method such as NEUTRON DIFFRACTION.
	- Add 'clean_all.sh' script.
	- Append current PDBx Ontology (pdbx-v50.owl) in resource directory.
	- Append PostgreSQL DDL for wwPDB validation (resource/wwpdb_validation_v002.sql) information and PDBML-validation (schema/pdbx-validation-v0.sql).
	- Add wwPDB/OWL-validation, ontology for wwPDB/RDF-validation.
	- Add script 'scripts/translate_to_rdf.sh' for generation of wwPDB/RDF-validation.
- **Feb 1, 2018**: Release v0.0.1
	- Generate PDBML-validation from PDBML-noatom and wwPDB Validation Information.

