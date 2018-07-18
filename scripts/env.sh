#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

PDBML_NOATOM=XML-noatom
VALID_REPORT=validation_reports

PDBML=pdbml
PDBML_EXT=pdbml-ext
VALID_INFO=validation_info
VALID_INFO_ALT=validation-info-alt
XML_VALID=XML-validation
RDF_VALID=RDF-validation
XML_VALID_ALT=XML-validation-alt
RDF_VALID_ALT=RDF-validation-alt

PDBML_XSD=resource/pdbx-v50.xsd
PDBML_SQL=resource/pdbx-v50.sql

WWPDB_VALIDATION_XSD=resource/wwpdb_validation_v002.xsd
WWPDB_VALIDATION_SQL=resource/wwpdb_validation_v002.sql

PDBX_VALIDATION_XSD=schema/pdbx-validation-v1.xsd
PDBX_VALIDATION_SQL=schema/pdbx-validation-v1.sql

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl
EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl

EXT_INFO_XSL=stylesheet/extract_info.xsl

XSD2MERGE_PDBML_INFO_XSL=stylesheet/xsd2merge_pdbml_info.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

PDBXV2PDBMLV2RDF_XSL=stylesheet/pdbxv2pdbmlv2rdf.xsl
PDBMLV2RDF_XSL=stylesheet/pdbmlv2rdf.xsl

