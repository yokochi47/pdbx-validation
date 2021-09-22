#!/bin/bash

source ./scripts/env.sh

if [ $has_xml2mmcif_command = "false" ] ; then

 echo "xml2mmcif: command not found..."
 echo "Please install PDBML2MMCIF (https://sw-tools.rcsb.org/apps/PDBML2CIF/index.html) to generate mmCIF version of wwPDB validation reports."

fi

./scripts/update_pdbml.sh || exit $?

./scripts/update_vrpt.sh || exit $?

./scripts/extract_pdbml.sh -v

./scripts/extract_info.sh -v

./scripts/merge_pdbml_info.sh -v

if [[ $(find $_WURCS_CATALOG_XML -mtime +4) ]] ; then
 ( cd wurcs2glytoucan; ./update_glytoucan.sh )
fi

./scripts/transl_to_rdf_vrpt_from_pdbml_gz.sh
./scripts/validate_all_rdf_gz.sh -d $RDF_VALID -r

if [ $has_xml2mmcif_command != "false" ] ; then
 ./scripts/transl_to_mmcif_vrpt_from_pdbml_gz.sh
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID -r
fi

./scripts/transl_to_rdf_vrpt_alt.sh
./scripts/validate_all_rdf_gz.sh -d $RDF_VALID_ALT -r

if [ $has_xml2mmcif_command != "false" ] ; then
 ./scripts/transl_to_mmcif_vrpt_alt.sh
 ./scripts/validate_all_mmcif_gz.sh -d $MMCIF_VALID_ALT -r
fi

echo
echo Everything is up-to-date.

