#!/bin/bash

RDF_VALID=rdf-validation
RDF_VALID_GZ=RDF-validation

if [ ! -d $RDF_VALID ] ; then
 ./scripts/translate_to_rdf.sh
fi

echo
echo Compressing wwPDB/RDF-validation...

mkdir -p $RDF_VALID_GZ

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

echo Done.

