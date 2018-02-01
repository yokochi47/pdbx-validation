#!/bin/bash

DB_NAME=PDBML-noatom

SRC_DIR=XML-noatom

weekday=`date -u +"%w"`

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then
 rsync -avz --delete ftp.pdbj.org::ftp_data/structures/divided/$SRC_DIR/ $SRC_DIR
fi

xml_file_total=pdbml_file_total

updated=`find $SRC_DIR/* -iname "*.xml.gz" -mtime -4 | wc -l`

if [ $updated = 0 ] || [ ! -e $xml_file_total ] ; then

 last=0

 if [ -e $xml_file_total ] ; then
  last=`cat $xml_file_total`
 fi

 total=`find $SRC_DIR/* -name '*.xml.gz' | wc -l`

 if [ $total = $last ] ; then
  
  echo $DB_NAME is update.
  exit 0

 else

   echo $total > $xml_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/pdbml-last

XML_DIR=pdbml

xml_file_list=xml_file_list

mkdir -p $XML_DIR

cd $XML_DIR

find ../$SRC_DIR/* -name '*.xml.gz' > $xml_file_list

while read xml_file
do

 BASENAME=`basename $xml_file .gz`

 if [ ! -e $BASENAME ] ; then
  cp $xml_file .
 fi

done < $xml_file_list

rm -f $xml_file_list

find . -type f -iname "*.gz" -exec gunzip {} +

echo $DB_NAME is unzipped.

