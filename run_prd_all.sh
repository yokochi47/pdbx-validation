#!/bin/bash

source ./scripts/env.sh

MTIME=
MTIME_OPT=

ARGV=`getopt --long -o "m:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ ! -z $MTIME ] ; then
 MTIME_OPT="-m "$MTIME
fi

./scripts/update_bird.sh $MTIME_OPT || exit $?

./scripts/transl_to_rdf_prd.sh

echo
echo Everything is up-to-date.

