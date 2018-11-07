#!/bin/bash

source ./scripts/env.sh

# Set PDBML-validation by default
XML_DIR=$XML_VALID
# Set PDBML-validation-alt
#XML_DIR=$XML_VALID_ALT

ARGV=`getopt --long -o "d:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  XML_DIR=$2
  shift
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

 echo XML Schema validation: *.xml.gz documents in $XML_DIR/"[0-9a-z]{2}"...

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR/[0-9a-z]{2} --xml-file-ext gz --sync chk_sum_pdbml_valid || ( echo $0 aborted. && exit 1 )

fi

