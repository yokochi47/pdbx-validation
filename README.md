# pdbx-validation

The pdb-validation is a generation tool for alternative wwPDB validation information, which includes mmCIF-compatible validation information (PDBML-validation), RDF version of validation information (wwPDB/RDF-validation) and its ontologies, wwPDB Validation Information Dictionary, derived XML Schema for the PDBML-validation and Ontology for the wwPDB/RDF-validation.

## Usage

- To generate alternative wwPDB validation information documents for several PDB IDs,<br />
 `./run_test.sh`

- To generate and update whole PDB entries,<br />
 `./run_all.sh`

- Here is map of the program.<br />
File path | Document
--------- | --------
[schema/mmcif_pdbx_validation_v0.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_pdbx_validation_v0.dic) | wwPDB Validation Information Dictionary
[schema/pdbx-validation-v0.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v0.xsd) | derived XML Schema for PDBML-validation
[schema/pdbx-validation-v0.html](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v0.html) | HTML expression of the XML Schema for PDBML-validation
[schema/mmcif_ddl.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_ddl.dic) | extended mmCIF DDL Core Dictionary (dubbed v2.2.0)
[resource/mmcif_pdbx_v50.dic](http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic) | current mmCIF/PDBx Dictionary
[resource/wwpdb_validation_v002.xsd](http://wwpdb.org/validation/schema/wwpdb_validation_v002.xsd) | current XML Schema for wwPDB validation information
stylesheet | a directory contains XSL style sheets for generation of alternative wwPDB validation information
test | a directory contains resource files for test of several PDB entries |
scripts | a directory contains scripts invoked by the 'run_all.sh' script |

## Software requirements

- **Java 8** or later.
- **Apache Maven (mvn)**, used to install external libraries.
- **Git (git)**, used to install external libraries.
- **mmCIF Dictionary Suite**, optionally used to generate XML Schema from the wwPDB Validation Information Dictionary.
- **PostgreSQL**, optionally used to import XML contents to relational database.

## Release notes

**Feb 01, 2018**: Released v0.0.1, Generate PDBML-validation from PDBML-noatom and wwPDB Validation Information.

