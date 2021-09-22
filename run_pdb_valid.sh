#!/bin/bash

source ./scripts/env.sh

DELETE_OPT=

ARGV=`getopt --long -o "r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -r)
  DELETE_OPT=-r
 ;;
 *)
  break
 ;;
 esac
 shift
done

# PDB/RDF

if [ -d $RDF ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF $DELETE_OPT
 ./scripts/validate_all_rdf_gz.sh -d $RDF $DELETE_OPT -m 2
fi

