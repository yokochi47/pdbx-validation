#!/bin/bash

source ./scripts/env.sh

if [ ! -z $VALID_OPT ] ; then
 ./scripts/validate_all_xml.sh -d $PDBML_EXT
fi

if [ ! -z $VALID_OPT ] ; then
 ./scripts/validate_all_xml.sh -d $VALID_INFO_ALT
fi

if [ ! -z $XML_VALID ] ; then
 ./scripts/validate_all_xml.sh -d $XML_VALID
 ./scripts/validate_all_gz.sh
fi

if [ ! -z $XML_VALID_ALT ] ; then
 ./scripts/validate_all_xml.sh -d $XML_VALID_ALT
 ./scripts/validate_all_gz.sh -d $XML_VALID_ALT
fi

