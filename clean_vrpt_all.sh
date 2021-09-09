#!/bin/bash

source ./scripts/env.sh

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

rm -f $EXT_PDBML_XSL $MERGE_PDBML_INFO_XSL $VRPTML2RDF_XSL

WORK_DIR=.

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$XML_VALID $WORK_DIR/$RDF_VALID $WORK_DIR/$MMCIF_VALID $WORK_DIR/$XML_VALID_ALT $WORK_DIR/$RDF_VALID_ALT $WORK_DIR/$MMCIF_VALID_ALT

rm -rf $WORK_DIR/chk_sum_*

WORK_DIR=test

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$XML_VALID $WORK_DIR/$RDF_VALID $WORK_DIR/$MMCIF_VALID $WORK_DIR/$XML_VALID_ALT $WORK_DIR/$RDF_VALID_ALT $WORK_DIR/$MMCIF_VALID_ALT

