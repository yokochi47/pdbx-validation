#!/bin/bash

source ./scripts/env.sh

DB_NAME="PDBML-validation"

if [ ! -d $XML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

echo
echo Compressing $DB_NAME...

pdbml_file_list=compress_pdbml_file_list

find $XML_VALID -maxdepth 1 -name '*.xml' > $pdbml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_pdbml_validation_worker.sh -d $XML_VALID -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $pdbml_file_list

echo $DB_NAME" ("$XML_VALID") is up-to-date."

