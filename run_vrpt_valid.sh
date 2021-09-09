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

if [ -d $PDBML_EXT ] ; then
 ./scripts/validate_all_xml_gz.sh -d $PDBML_EXT $DELETE_OPT
fi
<<REMARK
if [ -d $VALID_INFO_ALT ] ; then
 ./scripts/validate_all_xml.sh -d $VALID_INFO_ALT $DELETE_OPT
fi
REMARK
# VRPT PDBML

if [ -d $XML_VALID ] ; then
# ./scripts/validate_all_xml.sh -d $XML_VALID $DELETE_OPT
 ./scripts/validate_all_xml_gz.sh -d $XML_VALID $DELETE_OPT
fi

# VRPT PDBML-alt

if [ -d $XML_VALID_ALT ] ; then
# ./scripts/validate_all_xml.sh -d $XML_VALID_ALT $DELETE_OPT
 ./scripts/validate_all_xml_gz.sh -d $XML_VALID_ALT $DELETE_OPT
fi

# VRPT/RDF

if [ -d $RDF_VALID ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF_VALID $DELETE_OPT
 ./scripts/validate_all_rdf_gz.sh -d $RDF_VALID $DELETE_OPT
fi

# VRPT/RDF-alt

if [ -d $RDF_VALID_ALT ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF_VALID_ALT $DELETE_OPT
 ./scripts/validate_all_rdf_gz.sh -d $RDF_VALID_ALT $DELETE_OPT
fi

# VRPT mmCIF

if [ -d $MMCIF_VALID ] ; then
# ./scripts/validate_all_mmcif.sh -d $MMCIF_VALID $DELETE_OPT
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID $DELETE_OPT
fi

# VRPT mmCIF-alt

if [ -d $MMCIF_VALID_ALT ] ; then
# ./scripts/validate_all_mmcif.sh -d $MMCIF_VALID_ALT $DELETE_OPT
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID_ALT $DELETE_OPT
fi

