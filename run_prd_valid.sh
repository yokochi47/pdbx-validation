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

# PRD/RDF

if [ -d $RDF_PRD ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF_PRD $DELETE_OPT
 ./scripts/validate_all_rdf_gz.sh -d $RDF_PRD $DELETE_OPT -m 2
fi

