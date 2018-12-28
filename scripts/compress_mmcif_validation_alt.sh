#!/bin/bash

source ./scripts/env.sh

DB_NAME="mmCIF-validation-alt"

if [ ! -d $MMCIF_VALID_ALT ] ; then
 ./scripts/translate_to_mmcif_alt.sh
fi

echo
echo Compressing $DB_NAME...

mmcif_file_list=compress_mmcif_alt_file_list

find $MMCIF_VALID_ALT -name '*.cif' > $mmcif_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_mmcif_validation_alt_worker.sh -d $MMCIF_VALID_ALT -l $mmcif_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $mmcif_file_list

echo $DB_NAME" ("$MMCIF_VALID_ALT") is up-to-date."

