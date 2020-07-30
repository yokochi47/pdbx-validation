#!/bin/bash

source ./scripts/env.sh

XML_DIR=
DELETE=false

ARGV=`getopt --long -o "d:r" "$@"`
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
 *)
  break
 ;;
 esac
 shift
done

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -z $XML_DIR ] ; then

 echo XML Schema validation: *.xml documents in $XML_DIR...

 find $XML_DIR -maxdepth 1 -name '*.xml' -size 0 -exec rm {} +

 if [ $DELETE = "true" ] ; then
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --sync chk_sum_valid_xml --del-invalid-xml
 else
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --sync chk_sum_valid_xml
 fi

fi

