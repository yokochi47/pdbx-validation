#!/bin/bash

source ./scripts/env.sh

if [ $has_xml2mmcif_command = "false" ] ; then

 echo "xml2mmcif: command not found..."
 echo "Please install PDBML2MMCIF (https://sw-tools.rcsb.org/apps/PDBML2CIF/index.html) to generate mmCIF version of wwPDB validation reports."

fi

MTIME=
MTIME_OPT=
VALID_OPT=

ARGV=`getopt --long -o "m:v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 -v)
  VALID_OPT=$1
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

./scripts/update_pdbml.sh $MTIME_OPT || exit $?

./scripts/update_vrpt.sh $MTIME_OPT || exit $?

huge_number=100000

total=`ls $PDBML_EXT 2> /dev/null | wc -l`

ext_pdbml_exit_code=0
ext_info_exit_code=0

if [ -d $PDBML_EXT ] && [ $total -gt $huge_number ] ; then

 ./scripts/extract_pdbml.sh $VALID_OPT
 ext_pdbml_exit_code=$?

else

 ./scripts/extract_pdbml.sh
 ext_pdbml_exit_code=$?

 if [ ! -z $VALID_OPT ] ; then
  ./scripts/validate_all_xml.sh -d $PDBML_EXT
 fi

fi

total=`ls $VALID_INFO_ALT 2> /dev/null | wc -l`

if [ -d $VALID_INFO_ALT ] && [ $total -gt $huge_number ] ; then

 ./scripts/extract_info.sh $VALID_OPT
 ext_info_exit_code=$?

else

 ./scripts/extract_info.sh
 ext_info_exit_code=$?

 if [ ! -z $VALID_OPT ] ; then
  ./scripts/validate_all_xml.sh -d $VALID_INFO_ALT
 fi

fi

xml_total=`ls $XML_VALID 2> /dev/null | wc -l`
rdf_total=`ls $RDF_VALID 2> /dev/null | wc -l`

if [[ $(find wurcs2glytoucan/glytoucan.xml -mtime +4) ]] ; then
 ( cd wurcs2glytoucan; ./update_glytoucan.sh )
fi

if [ $ext_pdbml_exit_code = 0 ] || [ $ext_info_exit_code = 0 ] || [ $xml_total -le $huge_number ] || [ $rdf_total -le $huge_number ] ; then

 ./scripts/compress_pdbml_vrpt_alt.sh

 if [ -d $XML_VALID ] && [ $xml_total -gt $huge_number ] ; then

  ./scripts/merge_pdbml_info.sh -v

 else

  ./scripts/merge_pdbml_info.sh
  ./scripts/validate_all_xml.sh -d $XML_VALID

 fi

 #./scripts/compress_pdbml_vrpt.sh

 ./scripts/transl_to_rdf_vrpt_from_pdbml_gz.sh

 if [ $has_xml2mmcif_command != "false" ] ; then
  ./scripts/transl_to_mmcif_vrpt_from_pdbml_gz.sh
 fi

# Deprecated: update_pdbml.sh has already removed.
# ./scripts/sync_delete_with_pdbml.sh

# Deprecated: update_vrpt.sh has already removed.
# ./scripts/sync_delete_with_vrpt.sh
<<REMARK
 ./scripts/compress_rdf_vrpt.sh

 if [ $has_xml2mmcif_command != "false" ] ; then
  ./scripts/compress_mmcif_vrpt.sh
 fi
REMARK
 ./scripts/transl_to_rdf_vrpt_alt.sh

 if [ $has_xml2mmcif_command != "false" ] ; then
  ./scripts/transl_to_mmcif_vrpt_alt.sh
 fi
<<REMARK
 ./scripts/compress_rdf_vrpt_alt.sh

 if [ $has_xml2mmcif_command != "false" ] ; then
  ./scripts/compress_mmcif_vrpt_alt.sh
 fi
REMARK
fi

echo
echo Everything is up-to-date.

