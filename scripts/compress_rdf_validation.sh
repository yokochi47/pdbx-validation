#!/bin/bash

source ./scripts/env.sh

DB_NAME="wwPDB/RDF-validation"

if [ ! -d $RDF_VALID ] ; then
 ./scripts/translate_to_rdf.sh
fi

echo
echo Compressing $DB_NAME...

rdf_file_list=rdf_file_list

find $RDF_VALID -name '*.rdf' > $rdf_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_rdf_validation_worker.sh -d $RDF_VALID -l $rdf_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo "$0 aborted."
 exit 1

fi

wait

rm -f $rdf_file_list

echo $DB_NAME" ("$RDF_VALID") is up-to-date."

