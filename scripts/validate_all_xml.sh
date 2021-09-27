#!/bin/bash

source ./scripts/env.sh

XML_DIR=
DELETE=false
WELL_FORMED=--well-formed

ARGV=`getopt --long -o "d:rf" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  XML_DIR=$2
  shift
 ;;
 -r)
  DELETE=true
 ;;
 -f)
  WELL_FORMED=
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ -d $XML_DIR ] ; then

 echo XML Schema validation: *.xml documents in $XML_DIR...

 find $XML_DIR -maxdepth 1 -name '*.xml' -size 0 -exec rm {} +

 if [ $DELETE = "true" ] ; then
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --sync chk_sum_valid_xml --del-invalid-xml $WELL_FORMED
 else
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --sync chk_sum_valid_xml $WELL_FORMED
 fi

fi

