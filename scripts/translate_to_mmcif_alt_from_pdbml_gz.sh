#!/bin/bash

source ./scripts/env.sh

if [ $has_xml2mmcif_command = "false" ] ; then

 echo "xml2mmcif: command not found..."
 echo "Please install PDBML2MMCIF (https://sw-tools.rcsb.org/apps/PDBML2CIF/index.html) to generate mmCIF version of wwPDB validation reports."
 exit 1

fi

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

if [ ! -d $VALID_INFO_ALT ] ; then
 ./scripts/extract_info.sh
fi

if [ ! -e $VALID_INFO_ALT/$pdbx_validation_xsd ] ; then
 ( cd $VALID_INFO_ALT; ln -s ../$PDBX_VALIDATION_XSD . )
fi

mkdir -p $MMCIF_VALID_ALT

for dicfile in $pdbx_validation_dic $pdbx_validation_odb ; do

 if [ ! -e $MMCIF_VALID_ALT/$dicfile ] ; then
  ( cd $MMCIF_VALID_ALT; ln -s ../schema/$dicfile . )
 fi

done

last=`find $MMCIF_VALID_ALT -name '*.cif.gz' | wc -l`
total=`find $VALID_INFO_ALT -name '*.xml.gz' | wc -l`

if [ $total != $last ] ; then

 echo
 echo Translating compressed PDBML-validation-alt to mmCIF-validation-alt...

 pdbml_file_list=pdbml_file_list

 find $VALID_INFO_ALT -name '*.xml.gz' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/translate_to_mmcif_alt_from_pdbml_gz_worker.sh -d $MMCIF_VALID_ALT -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

if [ -e $VALID_INFO_ALT/$pdbx_validation_xsd ] ; then
 rm $VALID_INFO_ALT/$pdbx_validation_xsd
fi

for dicfile in $pdbx_validation_dic $pdbx_validation_odb ; do

 if [ -e $MMCIF_VALID_ALT/$dicfile ] ; then
  $MMCIF_VALID_ALT/$dicfile
 fi

done

echo $MMCIF_VALID_ALT is up-to-date.

