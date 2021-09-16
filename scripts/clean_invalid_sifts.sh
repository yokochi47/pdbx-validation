#!/bin/bash

source scripts/env.sh

if [ ! -d $SIFTS_XML ] ; then
 echo Not found $SIFTS_XML.
 exit 1
fi

sifts_xml_file_list=sifts_xml_file_list

find $SIFTS_XML -name '*.xml' > $sifts_xml_file_list

while read sifts_xml_file
do

 pdb_id=`basename $sifts_xml_file .xml`

 sed -n 2,2p $sifts_xml_file | grep 'dbAccessionId="'$pdb_id'"' > /dev/null

 if [ $? != 0 ] ; then
  echo deleting $sifts_xml_file
  rm -f $sifts_xml_file
 fi

done < $sifts_xml_file_list

rm -f $sifts_xml_file_list

