#!/bin/bash

EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

rm -f $EXT_PDBML_XSL $MERGE_PDBML_INFO_XSL

WORK_DIR=test

rm -rf $WORK_DIR/pdbml_ext $WORK_DIR/validation_info_ext $WORK_DIR/pdbml-validation

