#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

VALID_OPT=

ARGV=`getopt --long -o "v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -v)
  VALID_OPT=$1
 ;;
 *)
  break
 ;;
 esac
 shift
done

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_VALIDATION_XSD=schema/pdbx-validation-v0.xsd

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 (cd schema; ./update_schema.sh)
fi

VALID_INFO_ALT=validation-info-alt

mkdir -p $VALID_INFO_ALT

VALID_INFO=validation_info

if [ ! -d $VALID_INFO ] ; then
 ./scripts/update_validation.sh
fi

PDBML_EXT=pdbml-ext

if [ ! -d $PDBML_EXT ] ; then
 ./scripts/extract_pdbml.sh
fi

echo
echo Extracting wwPDB Validation Information...

info_file_list=info_file_list

find $VALID_INFO -name '*.xml' > $info_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/extract_info_worker.sh -d $VALID_INFO_ALT -e $PDBML_EXT -l $info_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

done

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

wait

echo

rm -f $info_file_list

echo $VALID_INFO_ALT is update.

