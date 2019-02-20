#!/bin/bash

mmcif_dic=../resource/mmcif_pdbx_v50.dic
valid_dic=mmcif_pdbx_validation.dic

echo statistics of $valid_dic:

grep '^save_[a-z]' $mmcif_dic | sort > mmcif_categories
grep '^save_[a-z]' $valid_dic | sort > valid_categories

num_categories=`wc -l valid_categories | cut -d ' ' -f 1`

echo $num_categories categories.

new_categories=0

while read category ; do

 grep $category mmcif_categories > /dev/null

 if [ $? != 0 ] ; then
  let new_categories++
 fi

done < valid_categories

echo `expr $num_categories - $new_categories` shared categories with PDB Exchange Data Dictionary.
echo $new_categories new categories.

rm mmcif_categories valid_categories

grep '^save__[a-z]' $mmcif_dic | sort > mmcif_data_items
grep '^save__[a-z]' $valid_dic | sort > valid_data_items

num_data_items=`wc -l valid_data_items | cut -d ' ' -f 1`

echo $num_data_items data items.

new_data_items=0

while read data_item ; do

 grep $data_item mmcif_data_items > /dev/null

 if [ $? != 0 ] ; then
  let new_data_items++
 fi

done < valid_data_items

echo `expr $num_data_items - $new_data_items` shared data items with PDB Exchange Data Dictionary.
echo $new_data_items new data items.

linked_data_items=`grep _pdbx_item_aliases.xpath $valid_dic | wc -l`

echo $linked_data_items data items linked to wwPDB validation information XSD.

rm mmcif_data_items valid_data_items

echo

valid_owl=pdbx-validation-v1.owl

echo statistics of $valid_owl:

same_classes=`grep -n -1 '<owl:sameAs rdf:resource="PDBo:' $valid_owl | grep Class | wc -l`

echo $same_classes same classes of wwPDB/OWL.

same_properties=`grep -n -1 '<owl:sameAs rdf:resource="PDBo:' $valid_owl | grep Property | wc -l`

echo $same_properties same properties of wwPDB/OWL.

equivalent_classes=`grep '<owl:equivalentClass rdf:resource="PDBo:' $valid_owl | wc -l`

echo $equivalent_classes equivalent classes of wwPDB/OWL.

equivalent_properties=`grep '<owl:equivalentProperty rdf:resource="PDBo:' $valid_owl | wc -l`

echo $equivalent_properties equivalent properties of wwPDB/OWL.

echo

equivalent_properties=`grep '<owl:equivalentProperty rdf:resource="BMRBo:' $valid_owl | wc -l`

echo $equivalent_properties equivalent properties of BMRB/OWL.

echo
