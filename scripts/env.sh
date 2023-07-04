#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l 2> /dev/null`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

SAXON=extlibs/saxon-he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

PDBML_NOATOM=XML-noatom
VALID_REPORT=validation_reports

PDBML=pdbml # used in test directory

PDBML_EXT=pdbml-ext
VALID_INFO=validation-info
VALID_INFO_ALT=validation-info-alt
VALID_INFO_REV_FROM_FULL=validation-info-rev-from-full
VALID_INFO_REV_FROM_ALT=validation-info-rev-from-alt
XML_VALID=XML-validation
RDF_VALID=RDF-validation
MMCIF_VALID=mmcif-validation
XML_VALID_ALT=XML-validation-alt
RDF_VALID_ALT=RDF-validation-alt
MMCIF_VALID_ALT=mmcif-validation-alt

PDBML_XSD=resource/pdbx-v50.xsd
PDBML_SQL=resource/pdbx-v50.sql

WWPDB_VALIDATION_XSD=resource/wwpdb_validation_v6.02.xsd
WWPDB_VALIDATION_SQL=resource/wwpdb_validation_v6.02.sql

PDBX_VALIDATION_XSD=schema/pdbx-validation-v4.xsd
PDBX_VALIDATION_SQL=schema/pdbx-validation-v4.sql

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl
EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl

EXT_INFO_XSL=stylesheet/extract_info.xsl

XSD2MERGE_PDBML_INFO_XSL=stylesheet/xsd2merge_pdbml_info.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

VRPTX2VRPTML2RDF_XSL=stylesheet/vrptx2vrptml2rdf.xsl
VRPTML2RDF_XSL=stylesheet/vrptml2rdf.xsl

REVERT_INFO_FROM_FULL_XSL=stylesheet/revert_info_from_full.xsl
REVERT_INFO_FROM_ALT_NOATOM_XSL=stylesheet/revert_info_from_alt_noatom.xsl

pdbx_validation_dic=mmcif_pdbx_validation.dic
pdbx_validation_odb=pdbx-validation.odb
pdbx_validation_sdb=pdbx-validation.sdb
pdbx_validation_xsd=`basename $PDBX_VALIDATION_XSD`

has_xml2mmcif_command=true

if [ ! `which xml2mmcif 2> /dev/null` ] ; then
 has_xml2mmcif_command=false
fi

has_rapper_command=true

if [ ! `which rapper 2> /dev/null` ] ; then
 has_rapper_command=false
fi

has_cifcheck_command=true

if [ ! `which CifCheck 2> /dev/null` ] ; then
 has_cifcheck_command=false
fi

has_xmllint_command=true

if [ ! `which xmllint 2> /dev/null` ] ; then
 has_xmllint_command=false
fi

#PDBML_CC=chem_comp/PDBML

PDBX2PDBML2RDF_XSL=stylesheet/pdbx2pdbml2rdf.xsl
PDBML2RDF_XSL=stylesheet/pdbml2rdf.xsl

PDBX2CC2RDF_XSL=stylesheet/pdbx2cc2rdf.xsl
CC2RDF_XSL=stylesheet/cc2rdf.xsl

PDBX2PRD2RDF_XSL=stylesheet/pdbx2prd2rdf.xsl
PRD2RDF_XSL=stylesheet/prd2rdf.xsl

PDBX2FAM2RDF_XSL=stylesheet/pdbx2fam2rdf.xsl
FAM2RDF_XSL=stylesheet/fam2rdf.xsl

PDBML2WURCS_XSL=stylesheet/pdbml2wurcs.xsl
VRPTML2WURCS_XSL=stylesheet/vrptml2wurcs.xsl

WURCS_CATALOG_XML=../wurcs2glytoucan/wurcs_catalog.xml
_WURCS_CATALOG_XML=wurcs2glytoucan/wurcs_catalog.xml

RDF=RDF

SIFTS_XML_URL=ftp.ebi.ac.uk/pub/databases/msd/sifts/xml
SIFTS_XML=sifts_xml

PDBML_SIFTS=pdbml-sifts # used in test directory

PDBML_NOATOM_SIFTS=XML-noatom-sifts

NEXTGEN=nextgen
NEXTGEN_FILE_PREFIX=pdb_0000
NEXTGEN_FILE_SUFFIX=_xyz-no-atom-enrich

XSD2MERGE_PDBML_SIFTS_XSL=stylesheet/xsd2merge_pdbml_sifts.xsl
MERGE_PDBML_SIFTS_XSL=stylesheet/merge_pdbml_sifts.xsl

XSD2MERGE_PDBML_NEXTGEN_XSL=stylesheet/xsd2merge_pdbml_nextgen.xsl
MERGE_PDBML_NEXTGEN_XSL=stylesheet/merge_pdbml_nextgen.xsl

CC_CIF_URL=ftp.pdbj.org/pub/pdb/refdata/chem_comp
MMCIF_CC=pub/pdb/refdata/chem_comp
MMCIF_BIRD=pub/pdb/refdata/bird
XML_CC=XML-chem_comp
XML_BIRD=XML-bird
RDF_CC=RDF-chem_comp
RDF_BIRD=RDF-bird

pdbx_dic=mmcif_pdbx.dic
pdbx_odb=pdbx.odb
pdbx_sdb=pdbx.sdb

PDBML_PRD=$XML_BIRD/prd
RDF_PRD=$RDF_BIRD/prd

PDBML_FAM=$XML_BIRD/family
RDF_FAM=$RDF_BIRD/family

function mk_div_dir() {
 if [ ! -d $1 ] ; then
  [ -e $1 ] && rm -f $1
  mkdir -p $1
 fi
}

function gzip_in_div_dir() {
 mv -f $1 $2 && gzip $2/`basename $1`
}
