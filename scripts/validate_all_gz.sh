#!/bin/bash

source ./scripts/env.sh

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_VALID/[0-9a-z]{2} --xml-file-ext gz --verbose --sync chk_sum_pdbx_valid

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

