#!/bin/bash

source ./scripts/env.sh

DB_NAME=PDBML-chem_comp

SRC_DIR=$PDBML_CC
XML_DIR=$COMPONENTS_XML

weekday=`date -u +"%w"`

PDB_MIRROR=ftp.pdbj.org

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 wget -c -r -nv -np http://$PDB_MIRROR/$SRC_DIR/* -nH -R index.html*

 MD5_DIR=chk_sum_pdbml_cc

 chk_sum_log=pdbml_cc_log

 java -classpath $XSD2PGSCHEMA chksumstat --xml $SRC_DIR --xml-file-ext gz --sync $MD5_DIR --update --verbose > $chk_sum_log

 if [ -d $XML_DIR ] ; then
  while read cc_id ; do
   [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
   rm -f $XML_DIR/$cc_id.xml
  done < $chk_sum_log
 fi

 if [ -d $COMPONENTS_RDF ] ; then
  while read cc_id ; do
   [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
   rm -f $COMPONENTS_RDF/$cc_id.rdf
  done < $chk_sum_log
 fi

 rm -f $chk_sum_log

fi

xml_file_total=pdbml_cc_file_total

updated=`find $SRC_DIR/* -name "*.xml.gz" -mtime -4 | wc -l`

if [ $updated = 0 ] || [ ! -e $xml_file_total ] ; then

 last=0

 if [ -e $xml_file_total ] ; then
  last=`cat $xml_file_total`
 fi

 total=`find $SRC_DIR/* -name '*.xml.gz' | wc -l`

 if [ $total = $last ] ; then

  echo $DB_NAME" ("$SRC_DIR") is up-to-date."

  if [ -d $XML_DIR ] ; then

   unzipped=`find $XML_DIR -maxdepth 1 -name '*.xml' | wc -l`

   if [ $total = $unzipped ] ; then
    exit 0
   fi

  fi

 else

   echo $total > $xml_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/pdbml-cc-last

gz_file_list=${SRC_DIR,,}_gz_file_list

mkdir -p $XML_DIR

find $SRC_DIR/* -name '*.xml.gz' > $gz_file_list

while read gz_file
do

 xml_file=`basename $gz_file .gz`

 if [ ! -e $XML_DIR/$xml_file ] ; then
  cp $gz_file $XML_DIR
 fi

done < $gz_file_list

rm -f $gz_file_list

find $XML_DIR -type f -name "*.gz" -exec gunzip {} +

echo Unzipped $DB_NAME" ("$XML_DIR") is up-to-date."

