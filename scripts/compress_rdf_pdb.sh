#!/bin/bash

source ./scripts/env.sh

DB_NAME="PDB/RDF"

if [ ! -d $RDF ] ; then
 ./scripts/transl_to_rdf_pdb.sh
fi

echo
echo Compressing $DB_NAME...

find $RDF -maxdepth 1 -name '*.rdf' -size 0 -exec rm {} +

find $RDF -maxdepth 1 -name '*.rdf' -exec gzip {} +

find $RDF -mindepth 1 -name "*.err" -exec rm {} +

echo $DB_NAME" ("$RDF") is up-to-date."

