#!/bin/bash

VALIDATE_OPT=

ARGV=`getopt --long -o "v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -v)
  VALIDATE_OPT=$1
 ;;
 *)
  break
 ;;
 esac
 shift
done

./scripts/update_pdbml.sh
./scripts/update_validation.sh

PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
PDBML_VALID=pdbml-validation

if [ -d $PDBML_EXT ] ; then

 ./scripts/extract_pdbml.sh $VALIDATE_OPT

else

 ./scripts/extract_pdbml.sh

 if [ ! -z $VALIDATE_OPT ] ; then
  ./scripts/validate_all.sh -d $PDBML_EXT
 fi

fi

if [ -d $VALID_INFO_ALT ] ; then

 ./scripts/extract_info.sh $VALIDATE_OPT

else

 ./scripts/extract_info.sh

 if [ ! -z $VALIDATE_OPT ] ; then
  ./scripts/validate_all.sh -d $VALID_INFO_ALT
 fi

fi

if [ -d $PDBML_VALID ] ; then

 ./scripts/merge_pdbml_info.sh -v

else

 ./scripts/merge_pdbml_info.sh
 ./scripts/validate_all.sh -d $PDBML_VALID

fi

echo
echo Done.

