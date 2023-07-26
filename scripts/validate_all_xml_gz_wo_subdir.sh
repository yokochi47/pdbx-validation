#!/bin/bash

source ./scripts/env.sh

# Set VRPT PDBML by default
XML_DIR=$PDBML_EXT
# Set VRPT PDBML-alt
#XML_DIR=$XML_VALID_ALT

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

 echo XML Schema validation: *.xml.gz documents in $XML_DIR...

 if [ $DELETE = "true" ] ; then
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --xml-file-ext gz --sync chk_sum_valid_xml --del-invalid-xml $WELL_FORMED
 else
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --xml-file-ext gz --sync chk_sum_valid_xml $WELL_FORMED
 fi

fi

