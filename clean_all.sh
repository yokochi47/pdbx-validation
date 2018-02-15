#!/bin/bash

echo
echo "Do you want to clean? (y [n]) "

read ans

case $ans in
 y*|Y*)
  ;;
 *)
  echo skipped.;;
esac

if [ `which DictToSdb` ] && [ `which Dict2XMLSchema` ] && [ `which Dict2XMLSchema` ]; then
 ( cd schema; ./update_schema.sh )
fi

rm -f *_list *_total url_mirror

rm -rf extlibs

EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl
PDBMLV2RDF_XSL=stylesheet/pdbmlv2rdf.xsl

rm -f $EXT_PDBML_XSL $MERGE_PDBML_INFO_XSL $PDBMLV2RDF_XSL

WORK_DIR=.

PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
XML_VALID=XML-validation
RDF_VALID=RDF-validation

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$XML_VALID $WORK_DIR/$RDF_VALID

WORK_DIR=test

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$XML_VALID $WORK_DIR/$RDF_VALID

