#!/bin/bash

source ./scripts/env.sh

DB_NAME="wwPDB/RDF"

if [ ! -d $RDF ] ; then
 ./scripts/translate_to_pdb_rdf.sh
fi

echo
echo Compressing $DB_NAME...

rdf_file_list=compress_pdb_rdf_file_list

find $RDF -maxdepth 1 -name '*.rdf' -size 0 -exec rm {} +

find $RDF -maxdepth 1 -name '*.rdf' > $rdf_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/compress_pdb_rdf_worker.sh -d $RDF -l $rdf_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $rdf_file_list

find $RDF -mindepth 2 -name "*.rdf" -exec rm {} +
find $RDF -mindepth 2 -name "*.err" -exec rm {} +

echo $DB_NAME" ("$RDF") is up-to-date."

