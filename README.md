# pdbx-validation

The pdbx-validation is a generation tool for alternative [wwPDB validation reports](https://www.wwpdb.org/validation/validation-reports), which includes [PDBx/mmCIF](http://mmcif.wwpdb.org/) compatible version of validation information (**PDBML-validation**), RDF version of validation information (**wwPDB/RDF-validation**) and a series of ontologies, **wwPDB Validation Information Dictionary**, **PDBML-validation Schema** and **wwPDB/OWL-validation**.

## Usage

- To generate the wwPDB validation information of some PDB entries,<br />
 `./run_test.sh 5b1l 5u9b 5h0s ... `

- To update the wwPDB validation information of the entire PDB entry,<br />
 `./run_all.sh`

- Here is a map of the program.<br />

File path | Document
--------- | --------
[schema/mmcif_pdbx_validation_v1.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_pdbx_validation_v1.299.dic) | wwPDB Validation Information Dictionary (v1.299)
[schema/pdbx-validation-v1.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v1.299.xsd) | PDBML-validation Schema (v1.299)
[schema/pdbx-validation-v1.owl](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v1.299.owl) | wwPDB/OWL-validation (v1.299)
[schema/mmcif_ddl.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_ddl_v2.2.0.dic) | extended mmCIF DDL Core Dictionary (dubbed as v2.2.0)
[resource/mmcif_pdbx_v50.dic](http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic) | PDBx/mmCIF Dictionary (v5.299)
[resource/pdbx-v50.xsd](http://mmcif.wwpdb.org/schema/pdbx-v50.xsd) | PDBML Schema (v5.299)
[resource/pdbx-v50.owl](https://rdf.wwpdb.org/schema/pdbx-v50.owl) | PDBx ontology, ontology for wwPDB/RDF (v5.299)
[resource/wwpdb_validation_v002.xsd](https://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd) | XML Schema for wwPDB validation reports (v002, rev30291)
[scripts](https://github.com/yokochi47/pdbx-validation/blob/master/scripts) | a directory contains scripts invoked by the 'run_all.sh' script
[virtuoso_scripts](https://github.com/yokochi47/pdbx-validation/blob/master/virtuoso_scripts) | a directory contains scripts for uploading wwPDB/RDF-validation to local SPARQL endpoint
[stylesheet](https://github.com/yokochi47/pdbx-validation/blob/master/stylesheet) | a directory contains XSL style sheets for generation of alternative wwPDB validation reports
[test](https://github.com/yokochi47/pdbx-validation/blob/master/test) | a directory contains resource files for test on several PDB entries

## Examples of alternative wwPDB validation reports

- PDB ID: [5B1L](https://pdbj.org/mine/summary/5b1l), Exptl. method: X-RAY DIFFRACTION
	- PDBML-validation: [5b1l-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5b1l-validation-full.xml)
	- PDBML-validation-alt: [5b1l-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5b1l-validation-alt.xml)
	- wwPDB/RDF-validation: [5b1l-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5b1l-validation.rdf)
	- wwPDB/RDF-validation-alt: [5b1l-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5b1l-validation-alt.rdf)

- PDB ID: [5U9B](https://pdbj.org/mine/summary/5u9b), Exptl. method: SOLUTION NMR
	- PDBML-validation: [5u9b-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5u9b-validation-full.xml)
	- PDBML-validation-alt: [5u9b-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5u9b-validation-alt.xml)
	- wwPDB/RDF-validation: [5u9b-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5u9b-validation.rdf)
	- wwPDB/RDF-validation-alt: [5u9b-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5u9b-validation-alt.rdf)

- PDB ID: [5H0S](https://pdbj.org/mine/summary/5h0s), Exptl. method: ELECTRON MICROSCOPY
	- PDBML-validation: [5h0s-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5h0s-validation-full.xml)
	- PDBML-validation: [5h0s-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5h0s-validation-alt.xml)
	- wwPDB/RDF-validation: [5h0s-validation.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5h0s-validation.rdf)
	- wwPDB/RDF-validation-alt: [5h0s-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5h0s-validation-alt.rdf)

## Bulk download service of alternative wwPDB validation reports

- Bulk download via HTTP protocol

	- [PDBML-validation](https://bmrbpub.pdbj.org/archive/pdbml-valid/)
	- [PDBML-validation-alt (light version)](https://bmrbpub.pdbj.org/archive/pdbml-valid-alt/)

	- [wwPDB/RDF-validation](https://bmrbpub.pdbj.org/archive/wwpdb-rdf-valid/)
	- [wwPDB/RDF-validation-alt (light version)](https://bmrbpub.pdbj.org/archive/wwpdb-rdf-valid-alt/)

- Bulk download via rsync protocol

	- PDBML-validation:<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/pdbml-valid .`

	- PDBML-validation-alt (light version):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/pdbml-valid-alt .`

	- wwPDB/RDF-validation:<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/wwpdb-rdf-valid .`

	- wwPDB/RDF-validation-alt (light version):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/wwpdb-rdf-valid-alt .`

- [PDBML-validation-alt PostgreSQL 10 dump file](https://bmrbpub.pdbj.org/resources.html)

- [SPARQL endpoint for wwPDB/RDF-validation-alt](https://bmrbpub.pdbj.org/examples.html)

## Software requirements

- [**Java 8**](https://java.com/en/) or later.
- [**Apache Maven (mvn)**](https://maven.apache.org), used to install external libraries.
- [**Git (git)**](https://git-scm.com), used to install external libraries.
- [**mmCIF Dictionary Suite**](http://mmcif.wwpdb.org/), optionally used to generate XML Schema from the wwPDB Validation Information Dictionary.
- [**PostgreSQL**](https://www.postgresql.org), optionally used to import XML contents to relational database.
- [**Virtuoso**](https://www.openlinksw.com/wiki/main/Main), oprionally used as SPARQL endpoint of wwPDB/RDF-validation.

## Release notes

- **Sep 5, 2018**: Release v1.3.7
	- Update wwPDB Validation Information Dictionary from v1.298 to 1.299.
	- Add _diffrn.pdbx_serial_crystal_experiment.
	- Remove categories of xfel_group defined by PDB Exchange Data Dictionary V5.299.

- **Aug 3, 2018**: Release v1.3.6
	- Update wwPDB Validation Information Dictionary from v1.297 to 1.298.

- **Jul 24, 2018**: Release v1.3.5
	- Update wwPDB Validation Information Dictionary from v1.296 to 1.297.

- **Jul 18, 2018**: Release v1.3.4
	- Change check sum directory name from chk_sum_pdbx_valid to chk_sum_pdbml_valid.
	- Add PDBML-validation-alt, which is a light version of PDBML-validation by omitting PDBML-noatom content.
	- Add wwPDB/validation-alt, which is a light version of wwPDB/RDF-validation by omitting PDBML-noatom content.
	- Add PostgreSQL data migration script for PDBML-validation-alt.
	- Add Virtuoso data upload script for wwPDB/RDF-validation-alt.
	- Add PostgreSQL data migration script for PDBML-noatom.

- **Jul 10, 2018**: Release v1.3.3
	- Update wwPDB Validation Information Dictionary from v1.295 to 1.296.
	- Change domain name of bulk download service (from bmrbpub.protein.osaka-u.ac.jp to bmrbpub.pdbj.org).
	- Revise PostgreSQL data migration scripts.

- **Jun 13, 2018**: Release v1.3.2
	- Update wwPDB Validation Information Dictionary from v1.294 to 1.295.

- **May 23, 2018**: Release v1.3.1
	- Update wwPDB Validation Information Dictionary from v1.293 to 1.294.

- **May 11, 2018**: Release v1.3.0
	- More efficient udpate scripts using check sum.
	- Fix PostgreSQL data migration scripts.

- **Apr 18, 2018**: Release v1.2.3
	- Update wwPDB Validation Information Dictionary from v1.292 to 1.293.

- **Apr 9, 2018**: Release v1.2.2
	- Add description of bulk download service of the alternative wwPDB validation reports.

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

