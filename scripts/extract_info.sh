#!/bin/bash

source ./scripts/env.sh

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

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

mkdir -p $XML_VALID_ALT

if [ ! -d $VALID_REPORT ] ; then
 ./scripts/update_vrpt.sh
fi

if [ ! -d $PDBML_EXT ] ; then
 ./scripts/extract_pdbml.sh
fi

#last=`find $VALID_INFO_ALT -maxdepth 1 -name '*.xml' | wc -l`
#err=`find $VALID_INFO_ALT -maxdepth 1 -name '*.err' | wc -l`
#total=`find $VALID_INFO -maxdepth 1 -name '*.xml' | wc -l`
last=`find $XML_VALID_ALT -maxdepth 2 -name '*.xml.gz' | wc -l`
err=`find $XML_VALID_ALT -maxdepth 1 -name '*.err' | wc -l`
total=`find $VALID_REPORT -maxdepth 3 -name '*_validation.xml.gz' | wc -l`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Extracting wwPDB Validation Information...

 info_file_list=extract_info_file_list

# find $VALID_INFO -maxdepth 1 -name '*.xml' > $info_file_list
 find $VALID_REPORT -maxdepth 3 -name '*_validation.xml.gz' > $info_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/extract_info_worker.sh -d $XML_VALID_ALT -l $info_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $info_file_list

else

 echo $XML_VALID_ALT is up-to-date.
 exit 2

fi

echo $XML_VALID_ALT is up-to-date.

