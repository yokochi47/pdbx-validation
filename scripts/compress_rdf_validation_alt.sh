#!/bin/bash

source ./scripts/env.sh

DB_NAME="wwPDB/RDF-validation-alt"

if [ ! -d $RDF_VALID_ALT ] ; then
 ./scripts/translate_to_rdf_alt.sh
fi

echo
echo Compressing $DB_NAME...

rdf_file_list=compress_rdf_alt_file_list

find $RDF_VALID_ALT -maxdepth 1 -name '*.rdf' > $rdf_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_rdf_validation_alt_worker.sh -d $RDF_VALID_ALT -l $rdf_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $rdf_file_list

echo $DB_NAME" ("$RDF_VALID_ALT") is up-to-date."

