#!/bin/bash

source ./scripts/env.sh

DB_NAME="wwPDB/RDF-validation"

if [ ! -d $RDF_VALID ] ; then
 ./scripts/transl_to_rdf_vrpt.sh
fi

echo
echo Compressing $DB_NAME...

rdf_file_list=compress_rdf_file_list

find $RDF_VALID -maxdepth 1 -name '*.rdf' -size 0 -exec rm {} +

find $RDF_VALID -maxdepth 1 -name '*.rdf' > $rdf_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_rdf_vrpt_worker.sh -d $RDF_VALID -l $rdf_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $rdf_file_list

find $RDF_VALID -mindepth 2 -name "*.rdf" -exec rm {} +
find $RDF_VALID -mindepth 2 -name "*.err" -exec rm {} +

echo $DB_NAME" ("$RDF_VALID") is up-to-date."

