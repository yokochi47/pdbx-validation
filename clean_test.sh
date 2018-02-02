#!/bin/bash

EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

rm -f $EXT_PDBML_XSL $MERGE_PDBML_INFO_XSL

WORK_DIR=test

PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
PDBML_VALID=pdbml-validation

rm -rf $WORK_DIR/$PDBML_EXT $WORK_DIR/$VALID_INFO_ALT $WORK_DIR/$PDBML_VALID

