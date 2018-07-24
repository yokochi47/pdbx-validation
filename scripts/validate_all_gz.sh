#!/bin/bash

source ./scripts/env.sh

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_VALID/[0-9a-z]{2} --xml-file-ext gz --sync chk_sum_pdbml_valid || ( echo "$0 aborted."; exit 1 )

