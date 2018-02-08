#!/bin/bash

DB_NAME="wwPDB Validation Information"

SRC_DIR=validation_reports

weekday=`date -u +"%w"`

XML_DIR=validation_info
PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
PDBML_VALID=pdbml-validation
RDF_VALID=rdf-validation

rsync_log=rsync_log

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 rsync -rlpt -v -z --delete --dry-run ftp.pdbj.org::ftp/validation_reports . | grep xml.gz | cut -d '/' -f 3 > $rsync_log

 while read pdb_id
 do

  rm -f $XML_DIR/$pdb_id"_validation.xml"
  rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  rm -f $PDBML_VALID/$pdb_id-validation-full.xml
  rm -f $RDF_VALID/$pdb_id-validation.rdf

 done < $rsync_log

 rm -f $rsync_log

 rsync -rlpt -v -z --delete ftp.pdbj.org::ftp/validation_reports .
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

  echo $DB_NAME is update.

 else

   echo $total > $xml_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/pdb-validation-last

XML_DIR=validation_info

xml_file_list=xml_file_list

mkdir -p $XML_DIR

cd $XML_DIR

find ../$SRC_DIR -regextype posix-egrep -regex '.*/[0-9][0-9a-z]{3}_validation.xml.gz' > $xml_file_list

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

