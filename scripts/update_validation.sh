#!/bin/bash

DB_NAME="wwPDB Validation Report"
ALT_NAME="wwPDB Validation Information"

SRC_DIR=validation_reports

weekday=`date -u +"%w"`

XML_DIR=validation_info
PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
XML_VALID=XML-validation
RDF_VALID=RDF-validation

rsync_log=rsync_log

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 rsync -rlpt -v -z --delete --dry-run ftp.pdbj.org::ftp/$SRC_DIR . | grep xml.gz | cut -d '/' -f 3 > $rsync_log

 if [ -d $XML_DIR ] ; then
  while read pdb_id ; do
   rm -f $XML_DIR/$pdb_id"_validation.xml"
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

 if [ -d $XML_VALID ] ; then
  while read pdb_id ; do
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  done < $rsync_log
 fi

 if [ -d $RDF_VALID ] ; then
  while read pdb_id ; do
   rm -f $RDF_VALID/$pdb_id-validation.rdf
  done < $rsync_log
 fi

 if [ -d $XML_VALID ] ; then
  while read pdb_id ; do
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  done < $rsync_log
 fi

 if [ -d $RDF_VALID ] ; then
  while read pdb_id ; do
   rm -f $RDF_VALID/${pdb_id:1:2}/$pdb_id/$pdb_id-validation.rdf.gz
   rm -rf $RDF_VALID/${pdb_id:1:2}/$pdb_id
  done < $rsync_log
 fi

 rm -f $rsync_log

 rsync -rlpt -v -z --delete ftp.pdbj.org::ftp/$SRC_DIR .

fi

xml_file_total=validation_file_total

updated=`find $SRC_DIR -regextype posix-egrep -regex '.*/[0-9][0-9a-z]{3}_validation.xml.gz' -mtime -4 | wc -l`

if [ $updated = 0 ] || [ ! -e $xml_file_total ] ; then

 last=0

 if [ -e $xml_file_total ] ; then
  last=`cat $xml_file_total`
 fi

 total=`find $SRC_DIR -regextype posix-egrep -regex '.*/[0-9][0-9[a-z]{3}_validation.xml.gz' | wc -l`

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

date -u +"%b %d, %Y" > /tmp/pdb-validation-last

gz_file_list=gz_file_list

mkdir -p $XML_DIR

find $SRC_DIR -regextype posix-egrep -regex '.*/[0-9][0-9a-z]{3}_validation.xml.gz' > $gz_file_list

while read gz_file
do

 xml_file=`basename $gz_file .gz`

 if [ ! -e $XML_DIR/$xml_file ] ; then
  cp $gz_file $XML_DIR
 fi

done < $gz_file_list

rm -f $gz_file_list

find $XML_DIR -type f -iname "*.gz" -exec gunzip {} +

echo Unzipped $ALT_NAME" ("$XML_DIR") is up-to-date."

