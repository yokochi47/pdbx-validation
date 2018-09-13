#!/bin/bash

source ./scripts/env.sh

XML_DIR=

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

java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $XML_DIR --sync chk_sum_pdbml_valid || echo $0 aborted. && exit 1

