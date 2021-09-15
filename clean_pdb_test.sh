#!/bin/bash

source ./scripts/env.sh

rm -f $MERGE_PDBML_INFO_XSL $PDBML2RDF_XSL

WORK_DIR=test

rm -rf $WORK_DIR/$PDBML_SIFTS $WORK_DIR/$RDF

