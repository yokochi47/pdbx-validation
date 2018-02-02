# pdbx-validation

The pdb-validation is a generation tool for alternative [wwPDB validation information](https://www.wwpdb.org/validation/validation-reports), which includes [PDBx/mmCIF](http://mmcif.wwpdb.org/) compatible validation information (**PDBML-validationi**), RDF version of validation information (**PDB/RDF-validation**) and its ontologies, wwPDB Validation Information Dictionary, derived XML Schema for the PDBML-validation and Ontology for the PDB/RDF-validation.

## Usage

- To generate alternative wwPDB validation information documents for several PDB IDs,<br />
 `./run_test.sh`

- To generate and update whole PDB entries,<br />
 `./run_all.sh`

- Here is map of the program.<br />

File path | Document
--------- | --------
[schema/mmcif_pdbx_validation_v0.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_pdbx_validation_v0.289.dic) | current wwPDB Validation Information Dictionary
[schema/pdbx-validation-v0.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v0.289.xsd) | derived XML Schema for PDBML-validation
[schema/pdbx-validation-v0.html](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v0.html) | HTML expression of the XML Schema for PDBML-validation
[schema/mmcif_ddl.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_ddl_v2.2.0.dic) | extended mmCIF DDL Core Dictionary (dubbed as v2.2.0)
[resource/mmcif_pdbx_v50.dic](http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic) | current PDBx/mmCIF Dictionary
[resource/wwpdb_validation_v002.xsd](http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd) | current XML Schema for wwPDB validation information
[scripts](https://github.com/yokochi47/pdbx-validation/blob/master/scripts) | a directory contains scripts invoked by the 'run_all.sh' script
[stylesheet](https://github.com/yokochi47/pdbx-validation/blob/master/stylesheet) | a directory contains XSL style sheets for generation of alternative wwPDB validation information
[test](https://github.com/yokochi47/pdbx-validation/blob/master/test) | a directory contains resource files for test of several PDB entries

## Examples of PDBML-validation

- PDB ID: [5B1L](https://pdbj.org/mine/summary/5b1l), Exptl. method: X-RAY DIFFRACTION, PDBML-validation: [5b1l-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/pdbml-validation/5b1l-validation-full.xml)

- PDB ID: [5U9B](https://pdbj.org/mine/summary/5u9b), Exptl. method: SOLUTION NMR, PDBML-validation: [5u9b-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/pdbml-validation/5u9b-validation-full.xml)

- PDB ID: [5H0S](https://pdbj.org/mine/summary/5h0s), Exptl. method: ELECTRON MISCROSCOPY, PDBML-validation: [5h0s-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/pdbml-validation/5h0s-validation-full.xml)

## Software requirements

- [**Java 8**](https://java.com/en/) or later.
- [**Apache Maven (mvn)**](https://maven.apache.org), used to install external libraries.
- [**Git (git)**](https://git-scm.com), used to install external libraries.
- [**mmCIF Dictionary Suite**](http://mmcif.wwpdb.org/docs/software-resources.html), optionally used to generate XML Schema from the wwPDB Validation Information Dictionary.
- [**PostgreSQL**](https://www.postgresql.org), optionally used to import XML contents to relational database.

## Release notes

- **Feb 02, 2018**: Released v0.0.2
	- Changed directory names and file extension of PDBML-validation.
	- Implemented consistency checker about entry ID in XSL stylesheet.
	- Avoid XSLT error for entries used other experimental method such as NUTRON DIFFRACTION.
	- Added 'clean_all.sh' script.
- **Feb 01, 2018**: Released v0.0.1
	- Generate PDBML-validation from PDBML-noatom and wwPDB Validation Information.

