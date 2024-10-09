#!/bin/bash

source ./scripts/env.sh

set -e

if [ ! `which aria2c` ] ; then

 echo "aria2c: command not found..."
 echo "Please install aria2 (https://aria2.github.io/ZZ)."
 exit 1

fi

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

SRC_DIR=$SIFTS_XML_URL
XML_DIR=$SIFTS_XML

weekday=`date -u +"%w"`

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 #wget -c -r -nv -np ftp://$SRC_DIR -nH 2> /dev/null

 pdb_chain_uniprot_tsv=pdb_chain_uniprot.tsv
 sifts_xml_all=sifts_xml_all
 sifts_xml_unz=sifts_xml_unz
 sifts_xml_new=sifts_xml_new
 sifts_xml_del=sifts_xml_del
 sifts_xml_list=sifts_xml_list
 sifts_xml_url=${SRC_DIR//\//\\\/}

 rm -f $pdb_chain_uniprot_tsv*

 wget ftp://ftp.ebi.ac.uk/pub/databases/msd/sifts/flatfiles/tsv/$pdb_chain_uniprot_tsv.gz && gunzip $pdb_chain_uniprot_tsv.gz || exit 1
 sed -e "1,2d" $pdb_chain_uniprot_tsv | cut -f 1 | uniq | sort > $sifts_xml_all
 find $XML_DIR -name '*.xml' -size 0 -delete
 find $XML_DIR -name "*.xml" | cut -d '/' -f 2 | cut -d '.' -f 1 | sort > $sifts_xml_unz
 comm -23 $sifts_xml_all $sifts_xml_unz > $sifts_xml_new

 comm -13 $sifts_xml_all $sifts_xml_unz > $sifts_xml_del

 if [ -d $PDBML_SIFTS ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $PDBML_SIFTS/${pdb_id:1:2}/$pdb_id-noatom-sifts.xml.gz
  done < $sifts_xml_del
 fi

 if [ -d $PDBML_EXT ] ; then
  while read pdb_id ; do
   [ -z "$pdb_id" ] || [[ "$pdb_id" =~ ^#.* ]] && continue
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml.gz
  done < $sifts_xml_del
 fi

 max_connection=$((MAXPROCS > 16 ? 16 : MAXPROCS))

 sed -e "s/^/ftp:\/\/$sifts_xml_url\//" $sifts_xml_new | sed -e "s/$/\.xml.gz/" > $sifts_xml_list
 aria2c -i $sifts_xml_list -j $max_connection -d $SRC_DIR --allow-overwrite=true --auto-file-renaming=false || aria2c -i $sifts_xml_list -j $max_connection -d $SRC_DIR --allow-overwrite=true --auto-file-renaming=false || aria2c -i $sifts_xml_list -j $max_connection -d $SRC_DIR --allow-overwrite=true --auto-file-renaming=false || true

 rm -f $pdb_chain_uniprot_tsv $sifts_xml_list $sifts_xml_all $sifts_xml_unz $sifts_xml_new $sifts_xml_del

 MD5_DIR=chk_sum_xml_sifts

 chk_sum_log=sifts_xml_log

 java -classpath $XSD2PGSCHEMA chksumstat --xml $SRC_DIR --xml-file-ext gz --sync $MD5_DIR --update --verbose > $chk_sum_log

 if [ $FULL = "true" ] ; then

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

