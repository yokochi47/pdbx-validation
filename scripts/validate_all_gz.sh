#!/bin/bash

XML_DIR=XML-validation

XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_VALIDATION_XSD=schema/pdbx-validation-v1.xsd

java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR/[0-9a-z]{2} --xml-file-ext gz

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

