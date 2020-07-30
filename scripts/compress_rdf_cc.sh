#!/bin/bash

source ./scripts/env.sh

DB_NAME="chem_comp/RDF"

if [ ! -d $COMPONENTS_RDF ] ; then
 ./scripts/transl_to_rdf_cc.sh
fi

echo
echo Compressing $DB_NAME...

find $COMPONENTS_RDF -maxdepth 1 -name '*.rdf' -size 0 -exec rm {} +

find $COMPONENTS_RDF -maxdepth 1 -name '*.rdf' -exec gzip {} +

find $COMPONENTS_RDF -mindepth 1 -name "*.err" -exec rm {} +

echo $DB_NAME" ("$COMPONENTS_RDF") is up-to-date."

