#!/bin/bash

XML_DIR=

ARGV=`getopt --long -o "d:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  XML_DIR=$1
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_VALIDATION_XSD=schema/pdbx-validation-v0.xsd

java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

