#!/bin/bash

source ./scripts/env.sh

if [ ! -z $PDBML_EXT ] ; then
 ./scripts/validate_all_xml.sh -d $PDBML_EXT
fi

if [ ! -z $VALID_INFO_ALT ] ; then
 ./scripts/validate_all_xml.sh -d $VALID_INFO_ALT
fi

# PDBML-validation

if [ ! -z $XML_VALID ] ; then
# ./scripts/validate_all_xml.sh -d $XML_VALID
 ./scripts/validate_all_xml_gz.sh -d $XML_VALID
fi

# PDBML-validation-alt

if [ ! -z $XML_VALID_ALT ] ; then
# ./scripts/validate_all_xml.sh -d $XML_VALID_ALT
 ./scripts/validate_all_xml_gz.sh -d $XML_VALID_ALT
fi

# wwPDB/RDF-validation

if [ ! -z $RDF_VALID ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF_VALID
 ./scripts/validate_all_rdf_gz.sh -d $RDF_VALID
fi

# wwPDB/RDF-validation-alt

if [ ! -z $RDF_VALID_ALT ] ; then
# ./scripts/validate_all_rdf.sh -d $RDF_VALID_ALT
 ./scripts/validate_all_rdf_gz.sh -d $RDF_VALID_ALT
fi

# mmCIF-validation

if [ ! -z $MMCIF_VALID ] ; then
# ./scripts/validate_all_mmcif.sh -d $MMCIF_VALID
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID
fi

# mmCIF-validation-alt

if [ ! -z $MMCIF_VALID_ALT ] ; then
# ./scripts/validate_all_mmcif.sh -d $MMCIF_VALID_ALT
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID_ALT
fi

