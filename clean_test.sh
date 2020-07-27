#!/bin/bash

source ./scripts/env.sh

rm -f $EXT_PDBML_XSL $MERGE_PDBML_INFO_XSL $PDBMLV2RDF_XSL

WORK_DIR=test

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$XML_VALID $WORK_DIR/$RDF_VALID $WORK_DIR/$MMCIF_VALID $WORK_DIR/$XML_VALID_ALT $WORK_DIR/$RDF_VALID_ALT $WORK_DIR/$MMCIF_VALID_ALT $WORK_DIR/$VALID_INFO_REV_FROM_FULL $WORK_DIR/$VALID_INFO_REV_FROM_ALT

if [ -e $GLYTOUCAN_TSV ] ; then

 echo "Do you want to update $GLYTOUCAN_TSV? (y [n]) "

 read ans

 case $ans in
  y*|Y*) ( cd wurcs2glytoucan; ./LocalGlyTouCanID > glytoucan.tsv );;
  *) exit 0;;
 esac

fi

