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

if [ ! -d $XML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

if [ ! -e $XML_VALID/$pdbx_validation_xsd ] ; then
 ( cd $XML_VALID; ln -s ../$PDBX_VALIDATION_XSD . )
fi

mkdir -p $MMCIF_VALID

for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

 if [ ! -e $MMCIF_VALID/$dicfile ] ; then
  ( cd $MMCIF_VALID; ln -s ../schema/$dicfile . )
 fi

done

last=`find $MMCIF_VALID -maxdepth 1 -name '*.cif' | wc -l`
total=`find $XML_VALID -maxdepth 1 -name '*.xml' | wc -l`

if [ $total != $last ] ; then

 echo
 echo Translating PDBML-validation to mmCIF-validation...

 pdbml_file_list=pdbml_to_mmcif_file_list

 find $XML_VALID -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/translate_to_mmcif_worker.sh -d $MMCIF_VALID -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

if [ -e $XML_VALID/$pdbx_validation_xsd ] ; then
 rm $XML_VALID/$pdbx_validation_xsd
fi

for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb PdbMlParser.log ; do

 if [ -e $MMCIF_VALID/$dicfile ] ; then
  rm $MMCIF_VALID/$dicfile
 fi

done

echo $MMCIF_VALID is up-to-date.

