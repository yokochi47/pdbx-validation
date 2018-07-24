#!/bin/bash

source ./scripts/env.sh

DB_NAME="PDBML-validation-alt"

if [ ! -d $VALID_INFO_ALT ] ; then
 ./scripts/extract_info.sh
fi

if [ ! -d $XML_VALID_ALT ] ; then
 mkdir -p $XML_VALID_ALT
fi

echo
echo Compressing $DB_NAME...

pdbml_file_list=pdbml_file_list

find $VALID_INFO_ALT -name '*.xml' > $pdbml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_pdbml_validation_alt_worker.sh -d $XML_VALID_ALT -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo "$0 aborted."
 exit 1

fi

wait

rm -f $pdbml_file_list

echo $DB_NAME" ("$XML_VALID_ALT") is up-to-date."

