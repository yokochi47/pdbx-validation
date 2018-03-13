#!/bin/bash

source ./scripts/env.sh

DB_NAME="wwPDB Validation Report"
ALT_NAME="wwPDB Validation Information"

SRC_DIR=$VALID_REPORT
XML_DIR=$VALID_INFO

weekday=`date -u +"%w"`

PDB_MIRRORS=("rsync.rcsb.org" "ftp.pdbj.org" "rsync.ebi.ac.uk")
RSYNC_PORTS=("--port=33444" "" "")
RSYNC_BASE_DIRS=("ftp" "ftp" "pub/databases/pdb")

if [ ! -e url_mirror ] ; then

 printf "    PDB mirror sites\t\t delay [ms]\n"
 echo "-------------------------------------------"

 PDB_MIRROR=${PDB_MIRRORS[0]}

 delay=10000
 i=1

 for url in ${PDB_MIRRORS[@]}
 do

  time=`ping -c 1 -w 10 $url | grep 'avg' | cut -d '=' -f 2 | cut -d '/' -f 2`

  if [ $? = 0 ] ; then

   printf "[%d] %s\t\t%6.1f\n" $i $url $time

   cmp=`echo "$time > $delay" | bc`

   if [ $cmp = 0 ] ; then
    PDB_MIRROR=$url
    delay=$time
   fi

  else
   echo $url: timed out.
  fi

  let i++

 done

 echo
 echo "$PDB_MIRROR is selected by default. OK (1/2/3/n [y]) ? "

 read ans

 case $ans in
  n*|N*)
   echo stopped.
   exit 1;;
  1) PDB_MIRROR=${PDB_MIRRORS[0]};;
  2) PDB_MIRROR=${PDB_MIRRORS[1]};;
  3) PDB_MIRROR=${PDB_MIRRORS[2]};;
  *) ;;
 esac

 echo $PDB_MIRROR > url_mirror

else

 PDB_MIRROR=`cat url_mirror`

fi

case $PDB_MIRROR in
 rsync.rcsb.org)
  RSYNC_PORT=${RSYNC_PORTS[0]}
  RSYNC_BASE_DIR=${RSYNC_BASE_DIRS[0]};;
 ftp.pdbj.org)
  RSYNC_PORT=${RSYNC_PORTS[1]}
  RSYNC_BASE_DIR=${RSYNC_BASE_DIRS[1]};;
 rsync.ebi.ac.uk)
  RSYNC_PORT=${RSYNC_PORTS[2]}
  RSYNC_BASE_DIR=${RSYNC_BASE_DIRS[2]};;
 *)
  echo $PDB_MIRROR: undefined PDB mirror site.
  rm -f url_miror
  exit 1;;
esac

rsync_log=rsync_log

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 rsync -rlpt -v -z --delete --dry-run $RSYNC_PORT $PDB_MIRROR::$RSYNC_BASE_DIR/$SRC_DIR . | grep xml.gz | cut -d '/' -f 3 > $rsync_log

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
   rm -rf $RDF_VALID/${pdb_id:1:2}/$pdb_id
  done < $rsync_log
 fi

 rm -f $rsync_log

 rsync -rlpt -v -z --delete $RSYNC_PORT $PDB_MIRROR::$RSYNC_BASE_DIR/$SRC_DIR .

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

