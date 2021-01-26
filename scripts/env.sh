#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l 2> /dev/null`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

PDBML_NOATOM=XML-noatom
VALID_REPORT=validation_reports

PDBML=pdbml
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

WWPDB_VALIDATION_XSD=resource/wwpdb_validation_v6.00.xsd
WWPDB_VALIDATION_SQL=resource/wwpdb_validation_v6.00.sql

PDBX_VALIDATION_XSD=schema/pdbx-validation-v4.xsd
PDBX_VALIDATION_SQL=schema/pdbx-validation-v4.sql

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl
EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl

EXT_INFO_XSL=stylesheet/extract_info.xsl

XSD2MERGE_PDBML_INFO_XSL=stylesheet/xsd2merge_pdbml_info.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

PDBXV2PDBMLV2RDF_XSL=stylesheet/pdbxv2pdbmlv2rdf.xsl
PDBMLV2RDF_XSL=stylesheet/pdbmlv2rdf.xsl

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

PDBX_XSD=resource/pdbx-v50.xsd

PDBML_CC=chem_comp/PDBML

PDBX2PDBML2RDF_XSL=stylesheet/pdbx2pdbml2rdf.xsl
PDBML2RDF_XSL=stylesheet/pdbml2rdf.xsl

PDBX2CC2RDF_XSL=stylesheet/pdbx2cc2rdf.xsl
CC2RDF_XSL=stylesheet/cc2rdf.xsl

PDBML2WURCS_XSL=stylesheet/pdbml2wurcs.xsl
PDBMLV2WURCS_XSL=stylesheet/pdbmlv2wurcs.xsl

GLYTOUCAN_XML=../wurcs2glytoucan/glytoucan.xml
_GLYTOUCAN_XML=wurcs2glytoucan/glytoucan.xml

RDF=RDF

COMPONENTS_XML=components-xml
COMPONENTS_RDF=components-rdf

function mk_div_dir() {
 if [ ! -d $1 ] ; then
  [ -e $1 ] && rm -f $1
  mkdir -p $1
 fi
}

function gzip_in_div_dir() {
 mv -f $1 $2 && gzip $2/`basename $1`
}
