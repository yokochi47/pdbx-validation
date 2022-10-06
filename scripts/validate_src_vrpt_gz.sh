#!/bin/bash

source ./scripts/env.sh

XML_DIR=$VALID_REPORT

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

if [ -d $XML_DIR ] ; then

 echo XML Schema validation: *.xml.gz documents in $XML_DIR/"[0-9a-z]{2}/[0-9a-z]{4}"...

 if [ $DELETE = "true" ] ; then
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $WWPDB_VALIDATION_XSD --xml $XML_DIR/[0-9a-z]{2}/[0-9a-z]{4} --xml-file-ext gz --sync chk_sum_valid_src_vrpt --del-invalid-xml
 else
  java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $WWPDB_VALIDATION_XSD --xml $XML_DIR/[0-9a-z]{2}/[0-9a-z]{4} --xml-file-ext gz --sync chk_sum_valid_src_vrpt
 fi

fi

