#!/bin/bash

source ./scripts/env.sh

set -e

MTIME=
FULL=false

ARGV=`getopt --long -o "m:f" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 -f)
  FULL=true
 ;;
 *)
  break
 ;;
 esac
 shift
done

DB_NAME=SIFTS

SRC_DIR=$SIFTS_SPLIT_XML
XML_DIR=$SIFTS_XML

weekday=`date -u +"%w"`

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if ( [ $weekday -ge 1 ] && [ $weekday -le 4 ] ) || [ ! -d $SRC_DIR ] ; then

 if [ -d $PDBML_NOATOM ] || [ -e scripts/default_div_dirs ] ; then

  div_dirs=div_dirs
  max_connection=$((MAXPROCS > 24 ? 24 : MAXPROCS))

  find $PDBML_NOATOM -mindepth 1 -type d | cut -d '/' -f 2 > $div_dirs

  if [ ! -s $div_dirs ] ; then
   cp scripts/default_div_dirs $div_dirs
  fi

  for proc_id in `seq 1 $max_connection` ; do

   ./scripts/update_sifts_via_rsync_worker.sh -s $SIFTS_SPLIT_XML_URL -d $SRC_DIR -l $div_dirs -n $proc_id"of"$max_connection &

  done

  wait

  rm -f $div_dirs

 fi

 ( rsync -a --delete $SIFTS_SPLIT_XML_URL/ $SRC_DIR || rsync -a --delete $SIFTS_SPLIT_XML_URL/ $SRC_DIR || rsync -a --delete $SIFTS_SPLIT_XML_URL/ $SRC_DIR || true )

 MD5_DIR=chk_sum_xml_sifts

 chk_sum_log=sifts_xml_log

 java -classpath $XSD2PGSCHEMA chksumstat --xml $SRC_DIR/[0-9a-z]{2} --xml-file-ext gz --sync $MD5_DIR --update --verbose > $chk_sum_log

 if [ $FULL = "true" ] ; then

 if [ -d $XML_DIR ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $XML_DIR/$pdb_id.xml
  done < $chk_sum_log
 fi

 if [ -d $PDBML_SIFTS ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $PDBML_SIFTS/${pdb_id:1:2}/$pdb_id-noatom-sifts.xml.gz
  done < $chk_sum_log
 fi

 if [ -d $PDBML_EXT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml.gz
  done < $chk_sum_log
 fi

 if [ -d $VALID_INFO_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  done < $chk_sum_log
 fi

 if [ -d $XML_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $XML_VALID_ALT/$pdb_id-validation-alt.xml
  done < $chk_sum_log
 fi

 if [ -d $XML_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  done < $chk_sum_log
 fi

 if [ -d $RDF_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
  done < $chk_sum_log
 fi

 if [ -d $RDF_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF_VALID/$pdb_id-validation-full.rdf
  done < $chk_sum_log
 fi

 if [ -d $RDF ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF/$pdb_id.rdf
  done < $chk_sum_log
 fi

 if [ -d $MMCIF_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $MMCIF_VALID_ALT/$pdb_id-validation-alt.cif
  done < $chk_sum_log
 fi

 if [ -d $MMCIF_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $MMCIF_VALID/$pdb_id-validation-full.cif
  done < $chk_sum_log
 fi

 if [ -d $XML_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
  done < $chk_sum_log
 fi

 if [ -d $XML_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  done < $chk_sum_log
 fi

 if [ -d $RDF_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
  done < $chk_sum_log
 fi

 if [ -d $RDF_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.rdf.gz
  done < $chk_sum_log
 fi

 if [ -d $RDF ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $RDF/$pdb_id.rdf.gz
  done < $chk_sum_log
 fi

 if [ -d $MMCIF_VALID_ALT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $MMCIF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.cif.gz
  done < $chk_sum_log
 fi

 if [ -d $MMCIF_VALID ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $MMCIF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.cif.gz
  done < $chk_sum_log
 fi

 fi

 rm -f $chk_sum_log

fi

xml_file_total=sifts_xml_file_total

if [ -z $MTIME ] ; then
 MTIME=-4
fi

updated=`find $SRC_DIR -name "*.xml.gz" -mtime $MTIME | wc -l 2> /dev/null`

if [ $updated = 0 ] || [ ! -e $xml_file_total ] ; then

 last=0

 if [ -e $xml_file_total ] ; then
  last=`cat $xml_file_total`
 fi

 total=`find $SRC_DIR -name '*.xml.gz' | wc -l 2> /dev/null`

 if [ $total = $last ] ; then

  echo $DB_NAME" ("$SRC_DIR") is up-to-date."

 else

  echo $total > $xml_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/sifts_xml-last

gz_file_list=`echo ${SRC_DIR,,}_gz_file_list | tr '-' _`

mkdir -p $XML_DIR

find $SRC_DIR -name '*.xml.gz' > $gz_file_list

while read gz_file
do

 xml_file=`basename $gz_file .gz`

 if [ ! -e $XML_DIR/$xml_file ] ; then
  cp $gz_file $XML_DIR
 fi

done < $gz_file_list

rm -f $gz_file_list

find $XML_DIR -type f -name "*.gz" -exec gunzip {} +

./scripts/delete_invalid_sifts.sh

echo Unzipped $DB_NAME" ("$XML_DIR") is up-to-date."

