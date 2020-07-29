#!/bin/bash

source ./scripts/env.sh

DB_NAME="mmCIF-validation"

if [ ! -d $MMCIF_VALID ] ; then
 ./scripts/transl_to_mmcif_vrpt.sh
fi

echo
echo Compressing $DB_NAME...

mmcif_file_list=compress_mmcif_file_list

find $MMCIF_VALID -maxdepth 1 -name '*.cif' -size 0 -exec rm {} +

find $MMCIF_VALID -maxdepth 1 -name '*.cif' > $mmcif_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_mmcif_vrpt_worker.sh -d $MMCIF_VALID -l $mmcif_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $mmcif_file_list

find $MMCIF_VALID -mindepth 2 -name "*.cif" -exec rm {} +
find $MMCIF_VALID -mindepth 2 -name "*-diag.log" -exec rm {} +
find $MMCIF_VALID -mindepth 2 -name "*-parser.log" -exec rm {} +

echo $DB_NAME" ("$MMCIF_VALID") is up-to-date."

