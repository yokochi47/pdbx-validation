#!/bin/bash

source ./scripts/env.sh

rm -f $PDBML2RDF_XSL $CC2RDF_XSL

WORK_DIR=test

rm -rf $WORK_DIR/$RDF $WORK_DIR/$COMPONENTS_RDF

