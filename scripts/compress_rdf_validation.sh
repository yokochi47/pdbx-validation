#!/bin/bash

DB_NAME="wwPDB/RDF-validation"

RDF_VALID=rdf-validation
RDF_VALID_GZ=RDF-validation

if [ ! -d $RDF_VALID ] ; then
 ./scripts/translate_to_rdf.sh
fi

echo
echo Compressing wwPDB/RDF-validation...

mkdir -p $RDF_VALID_GZ

last=`find $RDF_VALID_GZ/* -regextype posix-egrep -regex '.*/[0-9][0-9a-z]{3}-validation.rdf.gz' | wc -l`
total=`find $RDF_VALID -name '*.rdf' | wc -l`

if [ $total != $last ] ; then

 rdf_file_list=rdf_file_list

 find $RDF_VALID -name '*.rdf' > $rdf_file_list

 while read rdf_file
 do

  pdb_id=`basename $rdf_file -validation.rdf`
  div_dir=$RDF_VALID_GZ/${pdb_id:1:2}/$pdb_id

  mkdir -p $div_dir

  cp -f $rdf_file $div_dir
  gzip $div_dir/$pdb_id-validation.rdf

 done < $rdf_file_list

 rm -f $rdf_file_list

fi

echo $DB_NAME" ("$RDF_VALID_GZ") is up-to-date."

