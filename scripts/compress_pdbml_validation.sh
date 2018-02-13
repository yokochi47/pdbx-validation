#!/bin/bash

DB_NAME="PDBML-validation"

PDBML_VALID=XML-validation

if [ ! -d $PDBML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

echo
echo Compressing PDBML-validation...

pdbml_file_list=pdbml_file_list

find $PDBML_VALID -name '*.xml' > $pdbml_file_list

while read xml_file
do

 pdb_id=`basename $xml_file -validation-full.xml`
 div_dir=$PDBML_VALID/${pdb_id:1:2}

 if [ ! -d $div_dir ] ; then
  mkdir -p $div_dir
 fi

 mv -f $xml_file $div_dir
 gzip $div_dir/$pdb_id-validation-full.xml

done < $pdbml_file_list

rm -f $pdbml_file_list

echo $DB_NAME" ("$PDBML_VALID") is up-to-date."

