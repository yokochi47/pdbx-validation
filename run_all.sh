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

if [ $? != 0 ] ; then
 exit $?
fi

./scripts/update_validation.sh

if [ $? != 0 ] ; then
 exit $?
fi

PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
XML_VALID=XML-validation
RDF_VALID=RDF-validation

total=`ls $PDBML_EXT | wc -l`

ext_pdbml_exit_code=0
ext_info_exit_code=0

if [ -d $PDBML_EXT ] && [ $total -gt 100000 ] ; then

 ./scripts/extract_pdbml.sh $VALIDATE_OPT
 ext_pdbml_exit_code=$?

else

 ./scripts/extract_pdbml.sh
 ext_pdbml_exit_code=$?

 if [ ! -z $VALIDATE_OPT ] ; then
  ./scripts/validate_all.sh -d $PDBML_EXT
 fi

fi

total=`ls $VALID_INFO_ALT | wc -l`

if [ -d $VALID_INFO_ALT ] && [ $total -gt 100000 ] ; then

 ./scripts/extract_info.sh $VALIDATE_OPT
 ext_info_exit_code=$?

else

 ./scripts/extract_info.sh
 ext_info_exit_code=$?

 if [ ! -z $VALIDATE_OPT ] ; then
  ./scripts/validate_all.sh -d $VALID_INFO_ALT
 fi

fi

if [ $ext_pdbml_exit_code = 0 ] || [ $ext_info_exit_code = 0 ] || [ ! -d $XML_VALID ] || [ ! -d $RDF_VALID ] ; then

 total=`ls $XML_VALID | wc -l`

 if [ -d $XML_VALID ] && [ $total -gt 100000 ] ; then

  ./scripts/merge_pdbml_info.sh -v

 else

  ./scripts/merge_pdbml_info.sh
  ./scripts/validate_all.sh -d $XML_VALID

 fi

 ./scripts/translate_to_rdf.sh

 ./scripts/sync_delete_with_pdbml.sh
 ./scripts/sync_delete_with_info.sh

 ./scripts/compress_pdbml_validation.sh
 ./scripts/compress_rdf_validation.sh

fi

echo
echo Everything is up-to-date.

