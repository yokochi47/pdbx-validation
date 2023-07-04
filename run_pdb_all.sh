#!/bin/bash

source ./scripts/env.sh

MTIME=
MTIME_OPT=
FULL_OPT=

ARGV=`getopt --long -o "m:f" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 -f)
  FULL_OPT=$1
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

#./scripts/update_sifts.sh $MTIME_OPT $FULL_OPT || exit $?
./scripts/update_pdbml_nextgen.sh $MTIME_OPT || exit $?

./scripts/update_pdbml.sh $MTIME_OPT || exit $?

#./scripts/merge_pdbml_sifts.sh $MTIME_OPT || exit $?
./scripts/merge_pdbml_nextgen.sh $MTIME_OPT || exit $?

if [[ $(find $_WURCS_CATALOG_XML -mtime +4) ]] ; then
 ( cd wurcs2glytoucan; ./update_glytoucan.sh )
fi

./scripts/transl_to_rdf_pdb.sh

echo
echo Everything is up-to-date.

