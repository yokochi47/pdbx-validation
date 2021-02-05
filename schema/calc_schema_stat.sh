#!/bin/bash

source ../scripts/env.sh

mmcif_dic=../resource/mmcif_pdbx_v50.dic
valid_dic=mmcif_pdbx_validation.dic

valid_xsd=../$WWPDB_VALIDATION_XSD

if [ -e $valid_dic ] ; then

 arg=(`grep dictionary.version $valid_dic`)
 dic_ver=${arg[1]}
 dic_major_ver=${dic_ver%%.*}

fi

valid_owl=pdbx-validation-v$dic_major_ver.owl

schema_stat=schema_stat

mkdir -p $schema_stat

#
# statistics of wwPDB validation reports dictionary
#

echo statistics of $valid_dic:

# extract categories

grep '^save_[a-z]' $mmcif_dic | sed -e 's/^save_//' | sort > $schema_stat/mmcif_categories.txt
grep '^save_[a-z]' $valid_dic | sed -e 's/^save_//' | sort > $schema_stat/valid_categories.txt

# extract category context type

grep -1 '_pdbx_category_context.type' $mmcif_dic > mmcif_category_types.txt

line_num=0
category_type=

rm -f $schema_stat/mmcif_category_types.txt

while read line ; do

 mod=$(($line_num % 4))

 if [ $mod = 1 ] ; then

  item_def=`echo $line | cut -d ' ' -f 1`

  if [ $item_def = "_pdbx_category_context.type" ] ; then

   category_type=`echo $line | cut -d ' ' -f 2`

  else

   category_type=

  fi

 elif [ $mod = 2 ] && [ ! -z $category_type ] ; then

  item_def=`echo $line | cut -d ' ' -f 1`

  if [ $item_def = "_pdbx_category_context.category_id" ] ; then

   category_id=`echo $line | cut -d ' ' -f 2`

   echo $category_id $category_type >> $schema_stat/mmcif_category_types.txt

  fi

 fi

 let line_num++

done < mmcif_category_types.txt

rm -f mmcif_category_types.txt

# extract item context type

grep -1 '_pdbx_item_context.type' $mmcif_dic > mmcif_item_types.txt

line_num=0
item_type=

rm -f $schema_stat/mmcif_item_types.txt

while read line ; do

 mod=$(($line_num % 4))

 if [ $mod = 1 ] ; then

  item_def=`echo $line | cut -d ' ' -f 1`

  if [ $item_def = "_pdbx_item_context.type" ] ; then

   item_type=`echo $line | cut -d ' ' -f 2`

  else

   item_type=

  fi

 elif [ $mod = 2 ] && [ ! -z $item_type ] ; then

  item_def=`echo $line | cut -d ' ' -f 1`

  if [ $item_def = "_pdbx_item_context.item_name" ] ; then

   item_name=`echo $line | cut -d ' ' -f 2 | sed -e "s/^'//" | sed -e "s/'$//" | sed -e 's/^_//'`

   echo $item_name $item_type >> $schema_stat/mmcif_item_types.txt

  fi

 fi

 let line_num++

done < mmcif_item_types.txt

rm -f mmcif_item_types.txt

# new or shared categories

num_categories=`wc -l $schema_stat/valid_categories.txt | cut -d ' ' -f 1`

echo " has "$num_categories categories.

num_new_categories=0

rm -f $schema_stat/new_categories.txt $schema_stat/shared_categories.txt

while read category ; do

 grep "^$category$" $schema_stat/mmcif_categories.txt > /dev/null

 if [ $? != 0 ] ; then

  echo $category >> $schema_stat/new_categories.txt
  let num_new_categories++

 else

  grep "^$category " $schema_stat/mmcif_category_types.txt > /dev/null

  if [ $? != 0 ] ; then

   echo $category >> $schema_stat/shared_categories.txt

  else

   category_type=`grep "^$category " $schema_stat/mmcif_category_types.txt | cut -d ' ' -f 2`

   echo $category $category_type >> $schema_stat/shared_categories.txt

  fi

 fi

done < $schema_stat/valid_categories.txt

grep " " $schema_stat/shared_categories.txt | cut -d ' ' -f 2 | sort | uniq -c > shared_category_types.txt

shared_category_types=

while read count type ; do

 shared_category_types+=$type:$count", "

done < shared_category_types.txt

rm -f shared_category_types.txt

# droppped category

num_dropped_categories=0

rm -f $schema_stat/dropped_categories.txt

while read category ; do

 grep "^$category$" $schema_stat/valid_categories.txt > /dev/null

 if [ $? != 0 ] ; then

  grep "^$category " $schema_stat/mmcif_category_types.txt > /dev/null

  if [ $? != 0 ] ; then

   echo $category >> $schema_stat/dropped_categories.txt

  else

   category_type=`grep "^$category " $schema_stat/mmcif_category_types.txt | cut -d ' ' -f 2`

   echo $category $category_type >> $schema_stat/dropped_categories.txt

  fi

  let num_dropped_categories++

 fi

done < $schema_stat/mmcif_categories.txt

grep " " $schema_stat/dropped_categories.txt | cut -d ' ' -f 2 | sort | uniq -c > dropped_category_types.txt

dropped_category_types=

while read count type ; do

 dropped_category_types+=$type:$count", "

done < dropped_category_types.txt

rm -f dropped_category_types.txt

echo "  "$num_new_categories new categories "(see $schema_stat/new_categories.txt for details)."
echo "  "$(($num_categories - $num_new_categories)) shared categories from `basename $mmcif_dic` "($shared_category_types"see $schema_stat/shared_categories.txt for details")."
echo "  "$num_dropped_categories dropped categories from `basename $mmcif_dic` "($dropped_category_types"see $schema_stat/dropped_categories.txt for details")."

# extract items

grep '^save__[a-z]' $mmcif_dic | sed -e 's/^save__//' | sort > $schema_stat/mmcif_items.txt
grep '^save__[a-z]' $valid_dic | sed -e 's/^save__//' | sort > $schema_stat/valid_items.txt

# new or shared items

num_items=`wc -l $schema_stat/valid_items.txt | cut -d ' ' -f 1`

echo " has "$num_items items.

num_new_items=0
num_extended_items=0

rm -f $schema_stat/new_items.txt $schema_stat/shared_items.txt $schema_stat/extended_items.txt

while read item ; do

 category_name=`echo $item | cut -d '.' -f 1`
 item_name=`echo $item | cut -d '.' -f 2`

 grep -F $item $schema_stat/mmcif_items.txt > /dev/null

 if [ $? != 0 ] ; then

  echo $item >> $schema_stat/new_items.txt
  let num_new_items++

  grep "^$category_name$" $schema_stat/mmcif_categories.txt > /dev/null

  if [ $? = 0 ] ; then

   echo $item >> $schema_stat/extended_items.txt
   let num_extended_items++

  fi

 else

  grep -F "$item " $schema_stat/mmcif_item_types.txt > /dev/null

  if [ $? != 0 ] ; then

   echo $item >> $schema_stat/shared_items.txt

  else

   item_type=`grep -F "$item " $schema_stat/mmcif_item_types.txt | cut -d ' ' -f 2`

   echo $item $item_type >> $schema_stat/shared_items.txt

  fi

 fi

done < $schema_stat/valid_items.txt

grep " " $schema_stat/shared_items.txt | cut -d ' ' -f 2 | sort | uniq -c > shared_item_types.txt

shared_item_types=

while read count type ; do

 shared_item_types+=$type:$count", "

done < shared_item_types.txt

rm -f shared_item_types.txt

# dropped items

num_dropped_items=0

rm -f $schema_stat/dropped_items.txt

while read item ; do

 category_name=`echo $item | cut -d '.' -f 1`
 item_name=`echo $item | cut -d '.' -f 2`

 grep -F $item $schema_stat/valid_items.txt > /dev/null

 if [ $? != 0 ] ; then

  grep "^$category_name$" $schema_stat/valid_categories.txt > /dev/null

  if [ $? = 0 ] ; then

   grep -F "$item " $schema_stat/mmcif_item_types.txt > /dev/null

   if [ $? != 0 ] ; then

    echo $item >> $schema_stat/dropped_items.txt

   else

    item_type=`grep -F "$item " $schema_stat/mmcif_item_types.txt | cut -d ' ' -f 2`

    echo $item $item_type >> $schema_stat/dropped_items.txt

   fi

   let num_dropped_items++

  fi

 fi

done < $schema_stat/mmcif_items.txt

grep " " $schema_stat/dropped_items.txt | cut -d ' ' -f 2 | sort | uniq -c > dropped_item_types.txt

dropped_item_types=

while read count type ; do

 dropped_item_types+=$type:$count", "

done < dropped_item_types.txt

rm -f dropped_item_types.txt

echo "  "$num_new_items new items "(see $schema_stat/new_items.txt for details)."
echo "  "$num_extended_items extended items in shared categories "(see $schema_stat/extended_items.txt for details)."
echo "  "$(($num_items - $num_new_items)) shared items from `basename $mmcif_dic` "($shared_item_types"see $schema_stat/shared_items.txt for details")."
echo "  "$num_dropped_items dropped items from `basename $mmcif_dic` "($dropped_item_types"see $schema_stat/dropped_items.txt for details")."

linked_items=`grep _pdbx_item_aliases.xpath $valid_dic | wc -l`

echo "  "$linked_items items linked to `basename $valid_xsd`.

#
# statistics of PDB/OWL-validation
#

echo

echo statistics of $valid_owl:

num_classes=`grep 'owl:Class rdf:ID' $valid_owl | wc -l`

echo " has "$num_classes classes.

same_classes=`grep -1 '<owl:sameAs rdf:resource="PDBo:' $valid_owl | grep Class | wc -l`

echo "  "$same_classes same classes of PDB/OWL.

equivalent_classes=`grep '<owl:equivalentClass rdf:resource="PDBo:' $valid_owl | wc -l`

echo "  "$equivalent_classes equivalent classes of PDB/OWL.

num_obj_properties=`grep 'owl:ObjectProperty rdf:ID' $valid_owl | wc -l`
num_data_properties=`grep 'owl:DatatypeProperty rdf:ID' $valid_owl | wc -l`

echo " has "$(($num_obj_properties + $num_data_properties)) properties "(object: $num_obj_properties, datatype: $num_data_properties)."

same_properties=`grep -1 '<owl:sameAs rdf:resource="PDBo:' $valid_owl | grep Property | wc -l`

echo "  "$same_properties same properties of PDB/OWL.

equivalent_properties=`grep '<owl:equivalentProperty rdf:resource="PDBo:' $valid_owl | wc -l`

echo "  "$equivalent_properties equivalent properties of PDB/OWL.

equivalent_properties=`grep '<owl:equivalentProperty rdf:resource="BMRBo:' $valid_owl | wc -l`

echo "  "$equivalent_properties equivalent properties of BMRB/OWL.

echo

