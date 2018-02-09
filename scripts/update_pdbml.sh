#!/bin/bash

DB_NAME=PDBML-noatom

SRC_DIR=XML-noatom

weekday=`date -u +"%w"`

XML_DIR=pdbml
PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
PDBML_VALID=pdbml-validation
RDF_VALID=rdf-validation
PDBML_VALID_GZ=XML-validation
RDF_VALID_GZ=RDF-validation

rsync_log=rsync_log

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 rsync -avz --delete --dry-run ftp.pdbj.org::ftp_data/structures/divided/$SRC_DIR/ $SRC_DIR | grep xml.gz | cut -d '/' -f 2 | cut -d '-' -f 1 > $rsync_log

 if [ -d $XML_DIR ] ; then
  while read pdb_id ; do
   rm -f $XML_DIR/$pdb_id-noatom.xml
  done < $rsync_log
 fi

 if [ -d $PDBML_EXT ] ; then
  while read pdb_id ; do
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  done < $rsync_log
 fi

 if [ -d $VALID_INFO_ALT ] ; then
  while read pdb_id ; do
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  done < $rsync_log
 fi

 if [ -d $PDBML_VALID ] ; then
  while read pdb_id ; do
   rm -f $PDBML_VALID/$pdb_id-validation-full.xml
  done < $rsync_log
 fi

 if [ -d $RDF_VALID ] ; then
  while read pdb_id ; do
   rm -f $RDF_VALID/$pdb_id-validation.rdf
  done < $rsync_log
 fi

 if [ -d $PDBML_VALID_GZ ] ; then
  while read pdb_id ; do
   rm -f $PDBML_VALID_GZ/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  done < $rsync_log
 fi

 if [ -d $RDF_VALID_GZ ] ; then
  while read pdb_id ; do
   rm -f $RDF_VALID_GZ/${pdb_id:1:2}/$pdb_id/$pdb_id-validation.rdf.gz
   rmdir --ignore-fail-on-non-empty $RDF_VALID_GZ/${pdb_id:1:2}/$pdb_id
  done < $rsync_log
 fi

 rm -f $rsync_log

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

  echo $DB_NAME" ("$SRC_DIR") is up-to-date."

  if [ -d $XML_DIR ] ; then

   unzipped=`find $XML_DIR -name '*.xml' | wc -l`

   if [ $total = $unzipped ] ; then
    exit 0
   fi

  fi

 else

   echo $total > $xml_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/pdbml-last

gz_file_list=gz_file_list

mkdir -p $XML_DIR

cd $XML_DIR

find ../$SRC_DIR/* -name '*.xml.gz' > $gz_file_list

while read gz_file
do

 xml_file=`basename $gz_file .gz`

 if [ ! -e $xml_file ] ; then
  cp $gz_file .
 fi

done < $gz_file_list

rm -f $gz_file_list

find . -type f -iname "*.gz" -exec gunzip {} +

echo Unzipped $DB_NAME" ("$XML_DIR") is up-to-date."

