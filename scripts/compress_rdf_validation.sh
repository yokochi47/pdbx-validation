#!/bin/bash

DB_NAME="wwPDB/RDF-validation"

RDF_VALID=RDF-validation

if [ ! -d $RDF_VALID ] ; then
 ./scripts/translate_to_rdf.sh
fi

echo
echo Compressing wwPDB/RDF-validation...

rdf_file_list=rdf_file_list

find $RDF_VALID -name '*.rdf' > $rdf_file_list

while read rdf_file
do

 pdb_id=`basename $rdf_file -validation.rdf`
 div_dir=$RDF_VALID/${pdb_id:1:2}/$pdb_id

 if [ ! -d $div_dir ] ; then
  mkdir -p $div_dir
 fi

 mv -f $rdf_file $div_dir
 gzip $div_dir/$pdb_id-validation.rdf

done < $rdf_file_list

rm -f $rdf_file_list

echo $DB_NAME" ("$RDF_VALID") is up-to-date."

