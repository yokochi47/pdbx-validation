﻿# pdbx-validation

The pdbx-validation is a generation tool of alternative [wwPDB validation reports](https://www.wwpdb.org/validation/validation-reports) where validation metrics are reorganized using the familiar mmCIF naming scheme and categories. It includes [PDBx/mmCIF](https://mmcif.wwpdb.org) compatible versions of validation reports (**VRPT mmCIF** and **VRPT PDBML**), RDF version of validation reports (**VRPT/RDF**), and a series of ontologies; **wwPDB Validation Information Dictionary**, **VRPT PDBML Schema**, and **VRPT/OWL**.

## Usage

- To generate the alternative wwPDB validation report of some PDB entries,<br />
 `./run_vrpt_test.sh 5b1l 5u9b 5h0s ... `

- To update the alternative wwPDB validation report of the entire PDB entry,<br />
 `./run_vrpt_all.sh`

- Here is a map of the program.<br />

File path | Document
--------- | --------
[schema/pdbx-with-vrptx-v50.owl](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-with-vrptx-v50.owl) | PDB/OWL combined with VRPT/OWL, combined ontology for PDB core archive and wwPDB validation reports. (v397)
[schema/mmcif_pdbx_validation_v4.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_pdbx_validation_v4.399.dic) | wwPDB Validation Information Dictionary (v4.399)
[schema/pdbx-validation-v4.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v4.399.xsd) | VRPT PDBML Schema (v4.399)
[schema/pdbx-validation-v4.owl](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-validation-v4.399.owl) | VRPT/OWL (v4.399)
[schema/mmcif_ddl.dic](https://github.com/yokochi47/pdbx-validation/blob/master/schema/mmcif_ddl_v2.4.1.dic) | extended mmCIF DDL Core Dictionary (dubbed as v2.4.2)
[resource/mmcif_pdbx_v50.dic](https://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic) | PDB Exchange Data Dictionary (v5.399)
[resource/pdbx-v50.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/resource/pdbx-v50.xsd) | PDBML Schema (v5.399)
[resource/pdbx-v50.owl](https://github.com/yokochi47/pdbx-validation/blob/master/resource/pdbx-v50.owl) | PDB/OWL, ontology for PDB/RDF (v5.399)
[resource/wwpdb_validation_v6.03.xsd](https://github.com/yokochi47/pdbx-validation/blob/master/resource/wwpdb_validation_v6.03.xsd) | XML Schema for wwPDB validation reports (v6.03, rev 2024-08-29)
[scripts](https://github.com/yokochi47/pdbx-validation/blob/master/scripts) | a directory contains scripts invoked by the 'run_vrpt_all.sh' script
[virtuoso_scripts](https://github.com/yokochi47/pdbx-validation/blob/master/virtuoso_scripts) | a directory contains scripts for uploading VRPT/RDF to local SPARQL endpoint
[stylesheet](https://github.com/yokochi47/pdbx-validation/blob/master/stylesheet) | a directory contains XSL style sheets for generation of alternative wwPDB validation reports
[test](https://github.com/yokochi47/pdbx-validation/blob/master/test) | a directory contains resource files for test on several PDB entries

## References

- Gert-Jan Bekker, Masashi Yokochi, Hirofumi Suzuki, Yasuyo Ikegawa, Takeshi Iwata, Takahiro Kudou, Kei Yura, Toshimichi Fujiwara, Takeshi Kawabata, Genji Kurisu.<br />
 "Protein Data Bank Japan: Celebrating our 20th anniversary during a global pandemic as the Asian hub of three dimensional macromolecular structural data", Protein Science, 31(1), 173-186 (2022)

## Examples of alternative wwPDB validation reports

- PDB ID: [5B1L](https://pdbj.org/mine/summary/5b1l), Exptl. method: X-RAY DIFFRACTION
	- PDBx/mmCIF format
		- VRPT mmCIF: [5b1l-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/5b1l-validation-full.cif)
		- VRPT mmCIF-alt: [5b1l-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/5b1l-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [5b1l-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5b1l-validation-full.xml)
		- VRPT PDBML-alt: [5b1l-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5b1l-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [5b1l-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5b1l-validation-full.rdf)
		- VRPT/RDF-alt: [5b1l-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5b1l-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [5b1l_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/5b1l_validation.xml)
		- Reverted from VRPT PDBML: [5b1l_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/5b1l_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [5b1l_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/5b1l_validation.xml)

- PDB ID: [5U9B](https://pdbj.org/mine/summary/5u9b), Exptl. method: SOLUTION NMR
	- PDBx/mmCIF format
		- VRPT mmCIF: [5u9b-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/5u9b-validation-full.cif)
		- VRPT mmCIF-alt: [5u9b-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/5u9b-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [5u9b-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5u9b-validation-full.xml)
		- VRPT PDBML-alt: [5u9b-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5u9b-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [5u9b-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5u9b-validation-full.rdf)
		- VRPT/RDF-alt: [5u9b-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5u9b-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [5u9b_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/5u9b_validation.xml)
		- Reverted from VRPT PDBML: [5u9b_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/5u9b_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [5u9b_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/5u9b_validation.xml)

- PDB ID: [2LOY](https://pdbj.org/mine/summary/2loy), Exptl. method: SOLUTION NMR with NMR restraint validation (v6.00, 2021-01-22)
	- PDBx/mmCIF format
		- VRPT mmCIF: [2loy-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/2loy-validation-full.cif)
		- VRPT mmCIF-alt: [2loy-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/2loy-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [2loy-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/2loy-validation-full.xml)
		- VRPT PDBML-alt: [2loy-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/2loy-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [2loy-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/2loy-validation-full.rdf)
		- VRPT/RDF-alt: [2loy-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/2loy-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [2loy_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/2loy_validation.xml)
		- Reverted from VRPT PDBML: [2loy_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/2loy_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [2loy_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/2loy_validation.xml)

- PDB ID: [5H0S](https://pdbj.org/mine/summary/5h0s), Exptl. method: ELECTRON MICROSCOPY
	- PDBx/mmCIF format
		- VRPT mmCIF: [5h0s-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/5h0s-validation-full.cif)
		- VRPT mmCIF-alt: [5h0s-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/5h0s-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [5h0s-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/5h0s-validation-full.xml)
		- VRPT PDBML-alt: [5h0s-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/5h0s-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [5h0s-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/5h0s-validation-full.rdf)
		- VRPT/RDF-alt: [5h0s-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/5h0s-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [5h0s_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/5h0s_validation.xml)
		- Reverted from VRPT PDBML: [5h0s_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/5h0s_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [5h0s_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/5h0s_validation.xml)

- PDB ID: [6RJH](https://pdbj.org/mine/summary/6rjh), Exptl. method: ELECTRON MICROSCOPY with EM map/model validation (v004, 2019-11-18)
	- PDBx/mmCIF format
		- VRPT mmCIF: [6rjh-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/6rjh-validation-full.cif)
		- VRPT mmCIF-alt: [6rjh-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/6rjh-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [6rjh-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/6rjh-validation-full.xml)
		- VRPT PDBML-alt: [6rjh-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/6rjh-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [6rjh-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/6rjh-validation-full.rdf)
		- VRPT/RDF-alt: [6rjh-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/6rjh-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [6rjh_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/6rjh_validation.xml)
		- Reverted from VRPT PDBML: [6rjh_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/6rjh_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [6rjh_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/6rjh_validation.xml)

- PDB ID: [6XEY](https://pdbj.org/mine/summary/6xey), Exptl. method: ELECTRON MICROSCOPY with EM map/model validation (v004, 2020-02-18)
	- PDBx/mmCIF format
		- VRPT mmCIF: [6xey-validation-full.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation/6xey-validation-full.cif)
		- VRPT mmCIF-alt: [6xey-validation-alt.cif](https://github.com/yokochi47/pdbx-validation/blob/master/test/mmcif-validation-alt/6xey-validation-alt.cif)
	- PDBML format
		- VRPT PDBML: [6xey-validation-full.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/XML-validation/6xey-validation-full.xml)
		- VRPT PDBML-alt: [6xey-validation-alt.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-alt/6xey-validation-alt.xml)
	- PDB/RDF format
		- VRPT/RDF: [6xey-validation-full.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation/6xey-validation-full.rdf)
		- VRPT/RDF-alt: [6xey-validation-alt.rdf](https://github.com/yokochi47/pdbx-validation/blob/master/test/RDF-validation-alt/6xey-validation-alt.rdf)
	- wwPDB validation report (XML format)
		- Original source: [6xey_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info/6xey_validation.xml)
		- Reverted from VRPT PDBML: [6xey_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-full/6xey_validation.xml)
		- Reverted from VRPT PDBML-alt and PDBML-noatom: [6xey_validation.xml](https://github.com/yokochi47/pdbx-validation/blob/master/test/validation-info-rev-from-alt/6xey_validation.xml)

## Bulk download service of full specification or lightweight alternative version of wwPDB validation reports

- Bulk download via HTTP protocol

	- [VRPT mmCIF (full specification @ BMRBj data server)](https://bmrbpub.pdbj.org/archive/mmcif-vrpt/)
	- [VRPT mmCIF (full specification @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/mmcif-full/)
	- [VRPT mmCIF-alt (lightweight alternative version @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/mmcif/)

	- [VRPT PDBML (full specification @ BMRBj data server)](https://bmrbpub.pdbj.org/archive/pdbml-vrpt/)
	- [VRPT PDBML (full specification @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/xml-full/)
	- [VRPT PDBML-alt (lightweight alternative version @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/xml/)

	- [VRPT/RDF (full specification @ BMRBj data server)](https://bmrbpub.pdbj.org/archive/rdf-vrpt/)
	- [VRPT/RDF (full specification @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/rdf-full/)
	- [VRPT/RDF-alt (lightweight alternative version @ PDBj data server)](https://data.pdbj.org/pdbjplus/data/vrpt/rdf/)

- Bulk download via rsync protocol

	- VRPT mmCIF (full specification):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/mmcif-vrpt .`

	- VRPT PDBML (full specification):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/pdbml-vrpt .`

	- VRPT/RDF (full specification):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/rdf-vrpt .`

	- VRPT mmCIF (lightweight alternative version):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/mmcif-vrpt-alt .`

	- VRPT PDBML (lightweight alternative version):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/pdbml-vrpt-alt .`

	- VRPT/RDF (lightweight alternative version):<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/rdf-vrpt-alt .`

- [VRPT PDBML-alt PostgreSQL dump file](https://bmrbpub.pdbj.org/resources.html)

### Other wwPDB Core Archives in RDF format that have been generated by this tool

- Bulk download via HTTP protocol

	- [PDB/RDF @ BMRBj data server](https://bmrbpub.pdbj.org/archive/rdf-pdb/)
	- [PDB/RDF @ PDBj data server](https://data.pdbj.org/pdbjplus/data/pdb/rdf/)

	- [chem_comp/RDF ala CCD @ BMRBj data server](https://bmrbpub.pdbj.org/archive/rdf-cc/)
	- [chem_comp/RDF aka CCD @ PDBj data server](https://data.pdbj.org/pdbjplus/data/cc/rdf/)

	- [BIRD/RDF @ BMRBj data server (includes PRD/RDF and FAM/RDF)](https://bmrbpub.pdbj.org/archive/rdf-bird/)
	- [PRD/RDF aka BIRD @ PDBj data server](https://data.pdbj.org/pdbjplus/data/prd/rdf/)
	- [FAM/RDF aka BIRD @ PDBj data server](https://data.pdbj.org/pdbjplus/data/family/rdf/)

- Bulk download via rsync protocol

	- PDB/RDF:<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/rdf-pdb .`

	- chem_comp/RDF:<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/rdf-cc .`

	- BIRD/RDF:<br />
	 `% rsync -av --delete rsync://bmrbpub.pdbj.org/rdf-bird .`

- [SPARQL endpoint for BMRB/RDF, PDB/RDF, chem_comp/RDF, PRD/RDF, and FAM/RDF](https://bmrbpub.pdbj.org/examples.html)

- [NBDC RDF Portal](https://integbio.jp/rdf/)

## Software requirements

- [**Java 14**](https://java.com/en/) or later.
- [**Apache Maven (mvn)**](https://maven.apache.org), used to install external libraries.
- [**Git (git)**](https://git-scm.com), used to install external libraries.
- [**xsltproc**](http://xmlsoft.org/XSLT/), used for XSL translation v1.0.
- [**mmCIF Dictionary Suite**](https://sw-tools.rcsb.org/apps/MMCIF-DICT-SUITE/index.html), optionally used to generate VRPT PDBML Schema from the wwPDB Validation Information Dictionary.
- [**PDBML2CIF**](https://sw-tools.rcsb.org/apps/PDBML2CIF/index.html), optionally, used to generate mmCIF version of wwPDB validation reports.
- [**Raptor RDF Syntax Library**](https://librdf.org/raptor/), optionally, used to validate RDF syntax.
- [**libxml2**](http://xmlsoft.org/), optionally, used to post XML beutification (xmllint).
- [**ROBOT is an OBO Tool (robot)**](http://robot.obolibrary.org/), used to combine PDB/OWL and VRPT/OWL.
- [**PostgreSQL**](https://www.postgresql.org), optionally used to import XML contents to relational database.
- [**Virtuoso**](https://www.openlinksw.com/wiki/main/Main), oprionally used as SPARQL endpoint of VRPT/RDF.

## Release notes

- **Nov 07, 2024**: Release v4.4.49
	- Update wwPDB Validation Information Dictionary to 4.399.

- **Oct 25, 2024**: Release v4.4.48
	- Update wwPDB Validation Information Dictionary to 4.398.

- **Oct 3, 2024**: Release v4.4.47
	- Update wwPDB Validation Information Dictionary to 4.397.
	- Create [a combined ontology for PDB core archive and wwPDB validation reports](https://github.com/yokochi47/pdbx-validation/blob/master/schema/pdbx-with-vrptx-v50.owl)
	- New namespace URI of the combined ontology for PDB/RDF, chem_comp/RDF, PRD/RDF, FAM/RDF, and VRPT/RDF.
		- xmlns:PDBo="http://rdf.wwpdb.org/schema/pdbx-with-vrptx-v50.owl#"
	- Replaced namespace URIs:
		- xmlns:PDBo="http://rdf.wwpdb.org/schema/pdbx-v50.owl#", which acts as the master ontology for PDB core archive
		- xmlns:VRPTo="http://rdf.wwpdb.org/schema/pdbx-validation-v4.owl#", which acts as the master ontology for wwPDB validation reports

- **Sep 30, 2024**: Release v4.4.46
	- Update wwPDB Validation Information Dictionary to 4.396.
	- Add supports for '_pdbx_related_exp_data_set' categories including RDF links for DOI of experimental data.
	- Avoid to use QNames in attribute values in RDF archives.
	- Support for wwpdb_validation_v6.03.xsd (density-fitness's EDIAm and OPIA scores).

- **Sep 27, 2024**: Release v4.4.45
	- Update wwPDB Validation Information Dictionary to 4.395.

- **Sep 27, 2024**: Release v4.4.44
	- Update wwPDB Validation Information Dictionary to 4.394.

- **Sep 27, 2024**: Release v4.4.43
	- Update wwPDB Validation Information Dictionary to 4.393.

- **Sep 27, 2024**: Release v4.4.42
	- Update wwPDB Validation Information Dictionary to 4.392.

- **Sep 27, 2024**: Release v4.4.41
	- Update wwPDB Validation Information Dictionary to 4.391.

- **Sep 27, 2024**: Release v4.4.40
	- Update wwPDB Validation Information Dictionary to 4.390.

- **Mar 27, 2024**: Release v4.4.39
	- Update wwPDB Validation Information Dictionary to 4.389.

- **Mar 27, 2024**: Release v4.4.38
	- Update wwPDB Validation Information Dictionary to 4.388.

- **Feb 21, 2024**: Release v4.4.37
	- Update wwPDB Validation Information Dictionary to 4.387.

- **Feb 21, 2024**: Release v4.4.36
	- Update wwPDB Validation Information Dictionary to 4.386.

- **Feb 21, 2024**: Release v4.4.35
	- Update wwPDB Validation Information Dictionary to 4.385.

- **Feb 21, 2024**: Release v4.4.34
	- Update wwPDB Validation Information Dictionary to 4.384.

- **Feb 21, 2024**: Release v4.4.33
	- Update wwPDB Validation Information Dictionary to 4.383.

- **Feb 21, 2024**: Release v4.4.32
	- Update wwPDB Validation Information Dictionary to 4.382.

- **Oct 24, 2023**: Release v4.4.31
	- Update wwPDB Validation Information Dictionary to 4.381.

- **Oct 19, 2023**: Release v4.4.30
	- Update wwPDB Validation Information Dictionary to 4.380.

- **Sep 06, 2023**: Release v4.4.29
	- Update wwPDB Validation Information Dictionary to 4.379.

- **Aug 25, 2023**: Release v4.4.28
	- Update wwPDB Validation Information Dictionary to 4.378.
	- Minor fix to support UNNAMED dihedral angle.

- **Aug 18, 2023**: Release v4.4.27
	- Update wwPDB Validation Information Dictionary to 4.377.

- **Aug 18, 2023**: Release v4.4.26
	- Update wwPDB Validation Information Dictionary to 4.376.
	- Fix invalid IRI codes.
	- Added RDF uploader scripts for Oxigraph Server, oxigraph_scripts. Oxigraph Server is still under evaluations.

- **Jul 27, 2023**: Release v4.4.25
	- Update wwPDB Validation Information Dictionary to 4.375.
	- Performance improvement of extract_info.xsl (XSLT 2.0 -> 1.0, though SAXON is required)

- **Jul 24, 2023**: Release v4.4.24
	- Update wwPDB Validation Information Dictionary to 4.374.

- **Jul 14, 2023**: Release v4.4.23
	- Update wwPDB Validation Information Dictionary to 4.373.
	- Support NMR restraint remediation.
	- Set _diffrn.pdbx_serial_crystal_experiment is not mandatory.
	- Fix clean-up scripts.
	- Fix invalid code of RDF resource URI.
	- Strip carriage return codes from PDBo:entity_poly.pdbx_seq_one_letter_code and PDBo:entity_poly.pdbx_seq_one_letter_code_can.
	- Enable to switch SIFTS resource from original SIFTS or PDB NextGen Archive.
	- Use rsync service to retrieve SIFTS resource. 'aria2c' is not necessary.
	- Mitigate validation report data issue, aka. DAOTHER-8001: Atom names containing '_' character are unexpectedly converted to name with comma character in Mogul outliers of XML validation report.
	- Include 0.0 in the range for the following data items:
		- _pdbx_nmr_distance_violation_model.maximum_violation
		- _pdbx_nmr_distance_violation_model.average_violation
		- _pdbx_nmr_distance_violation_model.median_violation
		- _pdbx_nmr_dihedral_angle_violation_model.maximum_violation
		- _pdbx_nmr_dihedral_angle_violation_model.average_violation
		- _pdbx_nmr_dihedral_angle_violation_model.median_violation
	- Improve performane of translation/validation scripts.
	- Add XSD datatype of RDF literals, except for xsd:string.

- **Jun 21, 2023**: Release v4.4.22
	- Update wwPDB Validation Information Dictionary to 4.372.

- **Jun 21, 2023**: Release v4.4.21
	- Update wwPDB Validation Information Dictionary to 4.371.

- **Jun 21, 2023**: Release v4.4.20
	- Update wwPDB Validation Information Dictionary to 4.370.

- **Jun 21, 2023**: Release v4.4.22
	- Update wwPDB Validation Information Dictionary to 4.372.

- **Jun 21, 2023**: Release v4.4.21
	- Update wwPDB Validation Information Dictionary to 4.371.

- **Jun 21, 2023**: Release v4.4.20
	- Update wwPDB Validation Information Dictionary to 4.370.

- **Apr 13, 2023**: Release v4.4.19
	- Update wwPDB Validation Information Dictionary to 4.369.

- **Mar 20, 2023**: Release v4.4.18
	- Update wwPDB Validation Information Dictionary to 4.368.
	- Update URL template for source PDBML.

- **Mar 7, 2023**: Release v4.4.17
	- Update wwPDB Validation Information Dictionary to 4.367.

- **Mar 6, 2023**: Release v4.4.16
	- Update wwPDB Validation Information Dictionary to 4.366.
	- Support for wwpdb_validation_v6.02.xsd (/wwPDB-validation-information/Entry/@bmrb_id).
	- Improve performace of SIFTS XML file validation script.

- **Mar 6, 2023**: Release v4.4.15
	- Update wwPDB Validation Information Dictionary to 4.365.

- **Dec 20, 2022**: Release v4.4.14
	- Update wwPDB Validation Information Dictionary to 4.364.

- **Dec 20, 2022**: Release v4.4.13
	- Update wwPDB Validation Information Dictionary to 4.363.

- **Dec 20, 2022**: Release v4.4.12
	- Update wwPDB Validation Information Dictionary to 4.362.

- **Oct 5, 2022**: Release v4.4.11
	- Update wwPDB Validation Information Dictionary to 4.361.
	- Support for Q-score metric of EM map-model validation (wwpdb_validation_v6.01.xsd).

- **Aug 2, 2022**: Release v4.4.10
	- Update wwPDB Validation Information Dictionary to 4.360.

- **Jun 7, 2022**: Release v4.4.9
	- Update wwPDB Validation Information Dictionary to 4.359.

- **Jun 7, 2022**: Release v4.4.8
	- Update wwPDB Validation Information Dictionary to 4.358.

- **Mar 31, 2022**: Release v4.4.7
	- Update wwPDB Validation Information Dictionary to 4.357.

- **Mar 31, 2022**: Release v4.4.6
	- Update wwPDB Validation Information Dictionary to 4.355.

- **Jan 18, 2022**: Release v4.4.5
	- Update wwPDB Validation Information Dictionary to 4.354.

- **Dec 17, 2021**: Release v4.4.4
	- Update wwPDB Validation Information Dictionary to 4.353.

- **Nov 26, 2021**: Release v4.4.3
	- Update RDF URIs to GO and ChEBI resources.

- **Nov 4, 2021**: Release v4.4.2
	- Update wwPDB Validation Information Dictionary to 4.352.
	- Revert RDF URI patterns to identifiers.org.

- **Oct 21, 2021**: Release v4.4.1
	- Update wwPDB Validation Information Dictionary to 4.351.

- **Sep 30, 2021**: Release v4.4.0
	- Add resources for FAM/RDF.
		- Update PDB/OWL, VRPT/OWL, XSLT codes to support external databases: CCDC, PubChem-Substance, ChemSpider, CAS, ChEBI, MeSH, ChEMBL, BindingDB, DrugBank, ChemDB.

- **Sep 24, 2021**: Release v4.3.0
	- Change namespace URIs:
		- xmlns:PDBo="http://rdf.wwpdb.org/schema/pdbx-v50.owl#"
		- xmlns:VRPTo="http://rdf.wwpdb.org/schema/pdbx-validation-v4.owl#"
	- Revise RDF links.
	- Revise RDF directory trees.
	- Add resources for PRD/RDF.
	- Fix stylesheets to remove category element that has no children. (PDB ID: 7lqs)
	- Fix XSD data type of '_pdbx_em_volume_estimate_marker.enclosed_volume' and '_pdbx_em_density_distribution_marker.map_value' (xsd:double).
	- Update Virtuoso data upload scripts for PDB/RDF, chem_comp/RDF, PRD/RDF, and VRPT/RDF(-alt).

- **Sep 17, 2021**: Release v4.2.0
	- Integration of [SIFTS](https://www.ebi.ac.uk/pdbe/docs/sifts/) into PDB/RDF that includes HTML links to GO, InterPro, Pfam, CATH domain, SCOP/SCOP2/SCOP2B, and Ensembl from '_pdbx_sifts_xref_db_segments' category.
	- Add HTML links to EMDB and SASBDB entries from '_pdbx_database_related' category.

- **Sep 13, 2021**: Release v4.1.1
	- Update wwPDB Validation Information Dictionary to 4.350.

- **Sep 9, 2021**: Release v4.1.0
	- Change prefixes as follows.
		- xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
		- xmlns:VRPTo="https://rdf.wwpdb.org/schema/pdbx-validation-v4.owl#"
	- Add supports for '_pdbx_sifts_xref_db', '_pdbx_sifts_xref_db_segments', and '_pdbx_sifts_unp_segments' categories of PDBx/mmCIF Dictionary (v5.349).
		- Update PDB/OWL, VRPT/OWL, XSLT codes to support external databases: GO, InterPro, Pfam, CATH domain, SCOP/SCOP2/SCOP2B, and Ensembl.
	- Change software requirement of mmCIF Dictionary Suite.
	- Add RDF link to Peptide Reference Dictionary (PRD) in BIRD (Biologically Interesting molecule Reference Dictionary).
	- Add supports for '_struct_ref.pdbx_db_code'.
		- Update PDB/OWL, VRPT/OWL, XSLT codes to support external databases: GenBank, EMBL, PIR, RefSeq, and Norine.

- **Sep 2, 2021**: Release v4.0.8
	- Update wwPDB Validation Information Dictionary to 4.349.
	- Update PDBj's data server URLs (data.pdbj.org).

- **Aug 4, 2021**: Release v4.0.7
	- Update wwPDB Validation Information Dictionary to 4.348.

- **Aug 3, 2021**: Release v4.0.6
	- Update wwPDB Validation Information Dictionary to 4.347.
	- Update extended mmCIF DDL Core Dictionary to v2.4.1.

- **Apr 29, 2021**: Release v4.0.5
	- Update wwPDB Validation Information Dictionary to 4.342.
	- Update extended mmCIF DDL Core Dictionary to v2.3.1.

- **Apr 6, 2021**: Release v4.0.4
	- Modify XSLT to handle multiple enzyme commission numbers.

- **Mar 16, 2021**: Release v4.0.3
	- Update wwPDB Validation Information Dictionary to 4.341.

- **Mar 15, 2021**: Release v4.0.2
	- Update wwPDB Validation Information Dictionary to 4.340.

- **Feb 19, 2021**: Release v4.0.1
	- Update wwPDB Validation Information Dictionary to 4.339.

- **Jan 26, 2021**: Release v4.0.0
	- Support XML Schema for wwPDB validation report (wwpdb_validation_v6.00.xsd).

- **Jan 21, 2021**: Release v3.0.2
	- Update wwPDB Validation Information Dictionary to 3.338.

- **Jan 8, 2021**: Release v3.0.1
	- Update wwPDB Validation Information Dictionary to 3.337.

- **Dec 16, 2020**: Release v3.0.0
	- Support XML Schema for wwPDB validation report (wwpdb_validation_v5.01.xsd).
		- Add '_pdbx_nmr_restraint_list' category that records list of NMR restraints.
		- Add '_pdbx_nmr_restraint_summary' category that records sumarry of conformationally restricting restraints.
		- Add '_pdbx_nmr_restraint_violation' category that records residual violations of conformationally restricting restraints in different bins.
		- Add '_pdbx_nmr_distance_violation_summary' category that records violations of distance restraints.
		- Add '_pdbx_nmr_distance_violation_model' category that records violations of distance restraints for each model.
		- Add '_pdbx_nmr_distance_violation_ensemble' category that records violations of distance restraints for each virtual ensemble alternating the size of an ensemble.
		- Add '_pdbx_nmr_distance_violation_plural' category that records potentially severe violations of distance restraints, which occurred in multiple coordinate models of the ensemble.
		- Add '_pdbx_nmr_distance_violation' category that records all distance restraint violations of the ensemble.
		- Add '_pdbx_nmr_dihedral_angle_violation_summary' category that records violations of dihedral angle restraints.
		- Add '_pdbx_nmr_dihedral_angle_violation_model' category that records violations of dihedral angle restraints for each model.
		- Add '_pdbx_nmr_dihedral_angle_violation_ensemble' category that records violations of dihedral angle restraints for each virtual ensemble alternating the size of an ensemble.
		- Add '_pdbx_nmr_dihedral_angle_violation_plural' category that records potentially severe violations of dihedral angle restraints, which occurred in multiple coordinate models of the ensemble.
		- Add '_pdbx_nmr_dihedral_angle_violation' category that records all dihedral angle restraint violations of the ensemble.

- **Nov 27, 2020**: Release v2.0.16
	- Update wwPDB Validation Information Dictionary to 2.336.
	- Add support for wwPDB validation report (wwpdb_validation_v004.xsd, 2020-10-16)

- **Oct 28, 2020**: Release v2.0.15
	- Update wwPDB Validation Information Dictionary to 2.335.

- **Sep 24, 2020**: Release v2.0.13
	- Update wwPDB Validation Information Dictionary to 2.333.

- **Aug 24, 2020**: Release v2.0.12
	- Update wwPDB Validation Information Dictionary to 2.332.
	- Add '_pdbx_percentile_view.conditions_label' and '_pdbx_percentile_entity_view.conditions_label' that provides short descriptive label about conditions applied for percentile calculation.

- **Aug 19, 2020**: Release v2.0.11
	- Update wwPDB Validation Information Dictionary to 2.331-3.
	- Add resources for PDB/RDF and chem_comp/RDF (stylesheet/pdbml2rdf.xsl, stylesheet/cc2rdf.xsl).
	- Add RDF link to rdf.glycoinfo.org and GlyTouCan.
	- Add support for wwPDB validation report (wwpdb_validation_v004.xsd, 2020-02-18)
	- Fix XSL version number of stylesheets and use xsltproc for XSL translation v1.0, instead of SAXON.
	- Restore 'em_admin' category.
		- Link '_em_admin.entry_id' and /wwPDB-validation-information/Entry/@emdb_id.
		- Link '_em_admin.deposition_date' and /wwPDB-validation-information/Entry/@EMDB-deposition-date.

- **Jul 13, 2020**: Release v2.0.10
	- Update wwPDB Validation Information Dictionary to 2.330.

- **Jun 24, 2020**: Release v2.0.9
	- Update wwPDB Validation Information Dictionary to 2.329.

- **Jun 23, 2020**: Release v2.0.8
	- Update wwPDB Validation Information Dictionary to 2.328.

- **Jun 23, 2020**: Release v2.0.7
	- Update wwPDB Validation Information Dictionary to 2.327.

- **May 29, 2020**: Release v2.0.6
	- Update wwPDB Validation Information Dictionary to 2.326 (incorpoate branch chain dictionary extension).

- **May 26, 2020**: Release v2.0.5
	- Update wwPDB Validation Information Dictionary to 2.325.

- **Mar 31, 2020**: Release v2.0.4
	- Update wwPDB Validation Information Dictionary to 2.324.

- **Feb 10, 2020**: Release v2.0.3
	- Update wwPDB Validation Information Dictionary to 2.323.

- **Feb 4, 2020**: Release v2.0.2
	- Update wwPDB Validation Information Dictionary to 2.322.

- **Dec 25, 2019**: Release v2.0.1
	- Update wwPDB Validation Information Dictionary to 2.321.
	- Add URLs for PDBj's FTP and PDBj Mine2 SQL search services.

- **Dec 10, 2019**: Release v2.0.0
	- Support XML Schema for wwPDB validation report (wwpdb_validation_v004.xsd).
		- Add '_pdbx_em_density_distribution' category that records map-value distribution of the primary EM volume.
		- Add '_pdbx_em_density_distribution_marker' category that records map-value distribution plot of the primary EM volume.
		- Add '_pdbx_em_volume_estimate' category that records volume estimation of the primary EM volume.
		- Add '_pdbx_em_volume_estimate_marker' category that records volume estimation plot of the primary EM volume.
		- Add '_pdbx_em_raps' category that records Rotationally Averaged Power Spectrum (RAPS).
		- Add '_pdbx_em_raps_marker' category that records Rotationally Averaged Power Spectrum (RAPS) plot.
		- Add '_pdbx_em_fsc_resolution' category that records estimated global resolutions from Fourier-Shell Correlation (FSC) curve using various criteria
		- Add '_pdbx_em_fsc_curve' category that records Fourier-Shell Correlation (FSC) curve.
		- Add '_pdbx_em_fsc_curve_marker' category that records row data to plot Fourier-Shell Correlation (FSC) curve.
		- Add '_pdbx_em_fsc_cutoff_curve' category that records Fourier-Shell Correlation (FSC) cut-off curve that represents a given criterion.
		- Add '_pdbx_em_fsc_cutoff_curve_marker' category that records row data to plot Fourier-Shell Correlation (FSC) cut-off curve that represents a given criterion.
		- Add '_pdbx_em_atom_inclusion' category that records fraction of atoms that are inside the surface.
		- Add '_pdbx_em_atom_inclusion_marker' category that records atom inclusion plot.
		- Add '_pdbx_em_validate_map_model_overall' category that records overall EM map-model validation of each entry.
		- Add '_pdbx_em_validate_map_model' category that records EM map-model validation of each residue.
		- Add '_pdbx_em_validate_map_model_entity' category that records EM map-model validation of each entity.

- **Nov 19, 2019**: Release v1.6.5
	- Fix typo of '_pdbx_validate_rmsd_torsion.percent_dihedral_angles_fitted_to_kb'.
	- Partial support XML Schema for wwPDB validation report (wwpdb_validation_v004.xsd).
		- Fix typo in style sheet.
		- Add '_pdbx_database_related' category.
		- Update PostgreSQL DDLs (wwpdb_validation_v004.sql) enabling relational model extension.

- **Nov 14, 2019**: Release v1.6.4
	- Update wwPDB Validation Information Dictionary from v1.318 to 1.319.

- **Nov 5, 2019**: Release v1.6.3
	- Update wwPDB Validation Information Dictionary from v1.315 to 1.318.
	- Update PostgreSQL DDLs.

- **Sep 18, 2019**: Release v1.6.2
	- Update wwPDB Validation Information Dictionary from v1.314 to 1.315.
		- Add '_refine.pdbx_R_complete' and '_refine_ls_shell.pdbx_R_complete'.

- **Aug 23, 2019**: Release v1.6.1
	- Update wwPDB Validation Information Dictionary from v1.313 to 1.314.

- **Aug 21, 2019**: Release v1.6.0
	- Update wwPDB Validation Information Dictionary from v1.311 to 1.313.
	- Support XML Schema for wwPDB validation report (wwpdb_validation_v003.xsd).
		- Add '_pdbx_validate_rmsd_torsion.percent_dihedral_angles_fitted_to_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-torsion-outlier/@local_density.
	- Add null check for /wwPDB-validation-information/ModelledSubgroup/@mogul_angles_rmsz | @mogul_bonds_rmsz.

- **Jun 3, 2019**: Release v1.5.5
	- Update wwPDB Validation Information Dictionary from v1.309 to 1.311.

- **May 8, 2019**: Release v1.5.4
	- Update wwPDB Validation Information Dictionary from v1.307 to 1.309.
	- Update extended mmCIF DDL Core Dictionary from v2.2.1 to v2.2.2.

- **Apl 10, 2019**: Release v1.5.3
	- Update wwPDB Validation Information Dictionary from v1.306 to 1.307.

- **Mar 19, 2019**: Release v1.5.2
	- Update wwPDB Validation Information Dictionary from v1.305 to 1.306.

- **Feb 23, 2019**: Release v1.5.1
	- Rename 'revert_info.xsl' to 'revert_info_from_full.xsl'.
	- Enable mutual transformation between VRPT PDBML-alt and wwPDB Validation Reports (XML).
		- Add 'revert_info_from_alt_noatom.xsl', 'validation_created_date.xsl', and 'nmr_atom_consistency.xsl' style sheets for the translation.
	- Enable parallel mmCIF and RDF syntax validation with check sum calculation.
	- Add script 'calc_schema_stat.sh', which reports statistics of wwPDB Validation Information Dictionary and difference with PDB Exchange Data Dictionary.
	- Fix typographical errors in item description. (pdbx_nmr_chem_shift_list.id -> pdbx_nmr_assigned_chem_shift_list.id)
	- Change '_pdbx_missing_nmr_star_item.name' type to line
	- Add '_pdbx_audit_revision_history.major_version' with link to /wwPDB-validation-information/Entry/@PDB-revision-number, which was formerly linked to '_pdbx_audit_revision_history.ordinal'
	- Change '_pdbx_validate_rmsd_ring.dihedral_angle_standard_deviation' unit to degrees
	- Change '_pdbx_validate_rmsd_torsion.dihedral_angle_standard_deviation' unit to degrees
	- Change '_pdbx_dcc_map.LLDFZ_outlier_flag' type to uchar1
	- Change '_pdbx_dcc_mon_geometry.LLDFZ_outlier_flag' type to uchar1

- **Feb 6, 2019**: Release v1.5.0
	- Add/Revise the following data items in relation with wwPDB validation information XSD.
		- Add '_pdbx_dcc_density.ls_d_res_low' with link to /wwPDB-validation-information/Entry/@PDB-resolution-low
		- Add '_pdbx_dcc_density.reflns_number_obs' with link to /wwPDB-validation-information/Entry/@numMillerIndices, which was formerly linked to '_reflns.number_all'
		- Add '_pdbx_dcc_density.ls_number_reflns_R_free' with link to /wwPDB-validation-information/Entry/@num-free-reflections, which was formerly linked to '_refine.ls_number_reflns_R_free'
		- Add '_pdbx_dcc_density.ls_percent_reflns_obs' with link to /wwPDB-validation-information/Entry/@DataCompleteness, which was formerly linked to '_refine.ls_percent_reflns_obs'
		- Add '_pdbx_dcc_density.ls_percent_reflns_R_free' and '_pdbx_dcc_density_corr.ls_percent_reflns_R_free' with link to /wwPDB-validation-information/Entry/@percent-free-reflections, which was formerly linked to '_refine.ls_percent_reflns_R_free'
	- Add the following relationships to wwPDB validation information XSD.
		- Link '_pdbx_dcc_density_corr.ls_d_res_high' and /wwPDB-validation-information/Entry/@EDS_resolution
		- Link '_pdbx_dcc_density_corr.ls_d_res_high' and /wwPDB-validation-information/Entry/@EDS_resolution_low
		- Link '_pdbx_dcc_density_corr.ls_R_factor_R_work' and /wwPDB-validation-information/Entry/@EDS_R
		- Link '_pdbx_dcc_density_corr.ls_number_reflns_obs' and /wwPDB-validation-information/Entry/@numMillerIndices
		- Link '_pdbx_dcc_density_corr.ls_percent_reflns_obs' and /wwPDB-validation-information/Entry/@DataCompleteness
		- Link '_pdbx_dcc_density_corr.correlation_coeff_Fo_to_Fc' and /wwPDB-validation-information/Entry/@Fo_Fc_correlation
	- Add '_struct_mon_prot.PDB_model_num' with link to /wwPDB-validation-information/ModelledSubgroup/@model
	- Add '_struct_mon_nucl.PDB_model_num' with link to /wwPDB-validation-information/ModelledSubgroup/@model
	- Add the following data items in relation with wwPDB validation information XSD.
		- Add '_pdbx_validate_rmsd_bond.bond_minimum_diff_to_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-bond-outlier/@mindiff
		- Add '_pdbx_validate_rmsd_bond.number_bonds_in_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-bond-outlier/@numobs
		- Add '_pdbx_validate_rmsd_angle.angle_minimum_diff_to_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-angle-outlier/@mindiff
		- Add '_pdbx_validate_rmsd_angle.number_angles_in_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-angle-outlier/@numobs
		- Add '_pdbx_validate_rmsd_torsion.dihedral_angle_minimum_diff_to_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-torsion-outlier/@mindiff
		- Add '_pdbx_validate_rmsd_torsion.number_dihedral_angles_in_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-torsion-outlier/@numobs
		- Add '_pdbx_validate_rmsd_ring.dihedral_angle_minimum_diff_to_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-ring-outlier/@mindiff
		- Add '_pdbx_validate_rmsd_ring.number_dihedral_angles_in_kb' with link to /wwPDB-validation-information/ModelledSubgroup/mog-ring-outlier/@numobs
	- Revise dictionary link of '_pdbx_validate_rmsd_bond.bond_deviation'.
	- Revise dictionary link of '_pdbx_validate_rmsd_angle.angle_deviation'.
	- Add the following data items in relation with wwPDB validation information XSD.
		- Add '_pdbx_validate_rmsd_bond.Zscore' with link to /wwPDB-validation-information/ModelledSubgroup/bond-outlier/@z
		- Add '_pdbx_validate_rmsd_angle.Zscore' with link to /wwPDB-validation-information/ModelledSubgroup/angle-outlier/@z
		- Add '_pdbx_dcc_mon_geometry.number_angles' with link to /wwPDB-validation-information/ModelledSubgroup/@mogul_rmsz_numangles
		- Add '_pdbx_dcc_mon_geometry.number_bonds' with link to /wwPDB-validation-information/ModelledSubgroup/@mogul_rmsz_numbonds
		- Add '_pdbx_struct_nmr_ens_dom.percent_of_core' with link to /wwPDB-validation-information/cyrange_domain/@percentage_of_core
		- Add '_pdbx_dcc_entity_geometry.number_angles' with link to /wwPDB-validation-information/ModelledEntityInstance/@num_bonds_rmsz
		- Add '_pdbx_dcc_entity_geometry.number_bonds' with link to /wwPDB-validation-information/ModelledEntityInstance/@num_angles_rmsz
		- Add '_pdbx_dcc_geometry.number_angles' with link to /wwPDB-validation-information/Entry/@num_bonds_rmsz
		- Add '_pdbx_dcc_geometry.number_bonds' with link to /wwPDB-validation-information/Entry/@num_angles_rmsz
	- Enable mutual transformation between VRPT PDBML and wwPDB Validation Reports (XML).
		- Add 'revert_info.xsl' style sheet for the translation.
		- Modify 'run_test.sh' script which include translation from VRPT PDBML to wwPDB Validation Reports (XML).
	- Update wwPDB Validation Information Dictionary from v1.303 to 1.305.
	- Apply XML beautifier using xmllint command, if possible.

- **Jan 8, 2019**: Release v1.4.1
	- Ensure identity of chemical_shift_list/@list_id.
	- Set category key for '_pdbx_missing_nmr_star_item' category.
	- Fix style sheet to escape validtion error occurs for empty data in 'pdbx_nmr_unmapped_chem_shift.val_err' and 'pdbx_nmr_unmapped_chem_shift.ambiguity_code'.
	- Revise style sheet to support unpaired steric clash (a solo clash/@cid).
	- Change directory name containing uncompressed validation reports from validation_info to validation-info.
	- Add mmCIF syntax validation when mmCIF Dictionary Suite is available (CifCheck).
	- Validate ambiguity code while translation of VRPT PDBML.

- **Dec 19, 2018**: Release v1.4.0
	- Add '_pdbx_nmr_chem_shift_annotation.id' and set category key along with '_pdbx_nmr_chem_shift_annotation.list_id'.
	- Set '_pdbx_nmr_unmapped_chem_shift.id' as category key along with '_pdbx_nmr_unmapped_chem_shift.list_id'.
	- Set '_pdbx_nmr_unparsed_chem_shift.id' as category key along with '_pdbx_nmr_unparsed_chem_shift.list_id'.
	- Update 'extract_info.xsl' style sheet which caused translation errors of NMR structure entries.
	- Add support for mmCIF version of wwPDB validation reports using PDBML2CIF command.
	- Change file extension of VRPT/RDF form validation.rdf to validation-full.rdf.
	- Add RDF syntax validation when Raptor RDF Syntax Library is available (rapper).

- **Dec 4, 2018**: Release v1.3.11
	- Update wwPDB Validation Information Dictionary from v1.302 to 1.303.

- **Nov 26, 2018**: Release v1.3.10
	- Update wwPDB Validation Information Dictionary from v1.301 to 1.302.

- **Nov 12, 2018**: Release v1.3.9
	- Update wwPDB Validation Information Dictionary from v1.300 to 1.301.
	- Update units for _em_imaging.c2_aperture_diameter from millimeters to micrometres.

- **Nov 8, 2018**: Release v1.3.8
	- Update wwPDB Validation Information Dictionary from v1.299 to 1.300.
	- Replace all xsd:integer of PDBML Schema and VRPT PDBML Schema by xsd:int.
	- Retrieve '_pdbx_audit_revision_category', 'pdbx_audit_revision_item' categories.
	- Retrieve '_diffrn_detector.pdbx_frequency'.
	- Add XML Schema validation script 'run_valid.sh'.
	- Update extended mmCIF DDL Core Dictionary from v2.2.0 to v2.2.1.
	- Add PDBML Schema generation script, 'resource/update_pdbx_xsd.sh'.

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
	- Add VRPT PDBML-alt, which is a lightweight version of VRPT PDBML by omitting PDBML-noatom content.
	- Add PDB/validation-alt, which is a lightweight version of VRPT/RDF by omitting PDBML-noatom content.
	- Add PostgreSQL data migration script for VRPT PDBML-alt.
	- Add Virtuoso data upload script for VRPT/RDF-alt.
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
	- More efficient update scripts using check sum.
	- Fix PostgreSQL data migration scripts.

- **Apr 18, 2018**: Release v1.2.3
	- Update wwPDB Validation Information Dictionary from v1.292 to 1.293.

- **Apr 9, 2018**: Release v1.2.2
	- Add description of bulk download service of the alternative wwPDB validation reports.

- **Apr 5, 2018**: Release v1.2.1
	- Fix style sheet to handle null RSR value, null medoid model number.
	- Enable differential XML Schema validation of compressed VRPT PDBML.

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
	- Revise VRPT PDBML Schema using xsd:minInclusive and xsd:maxExclusive without xsd:union.
	- Fix VRPT/OWL lacking XSD data type definition.
	- Add validate_all_gz.sh script to perform XML Schema validation of compressed VRPT PDBML.

- **Feb 15, 2018**: Release v0.0.9
	- Add ontology relationship between VRPT/OWL and PDB/OWL.
	- Add ontology relationship between VRPT/OWL and BMRB/OWL.
	- Update ontology mapping between PDBx/mmCIF and NMR-STAR data items.
	- PDB mirror server is selectable from rsync.rcsb.org, ftp.pdbj.org, rsync.ebi.ac.uk based on network response.

- **Feb 13, 2018**: Release v0.0.8
	- Change directory: from pdbml-validtion to XML-validation, which contains compressed VRPT PDBML.
	- Change directory: from rdf-validation to RDF-validation, which contains compressed VRPT/RDF.
	- Add source URL in VRPT PDBML Schema pointing PDBx/mmCIF dictionary browser.

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
	- Change directory names and file extension of VRPT PDBML.
	- Implement consistency checker about entry ID in XSL style sheet.
	- Avoid XSLT error for entries used other experimental method such as NEUTRON DIFFRACTION.
	- Add 'clean_all.sh' script.
	- Append current PDBx Ontology (pdbx-v50.owl) in resource directory.
	- Append PostgreSQL DDL for wwPDB validation (resource/wwpdb_validation_v002.sql) information and VRPT PDBML (schema/pdbx-validation-v0.sql).
	- Add VRPT/OWL, ontology for VRPT/RDF.
	- Add script 'scripts/translate_to_rdf.sh' for generation of VRPT/RDF.
- **Feb 1, 2018**: Release v0.0.1
	- Generate VRPT PDBML from PDBML-noatom and wwPDB Validation Information.

