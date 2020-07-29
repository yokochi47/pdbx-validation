#!/bin/bash

source ./scripts/env.sh

DB_NAME=PDBML-chem_comp

SRC_DIR=$PDBML_CC
XML_DIR=$COMPONENTS_XML

weekday=`date -u +"%w"`

PDB_MIRRORS=("rsync.rcsb.org" "ftp.pdbj.org" "rsync.ebi.ac.uk")
RSYNC_PORTS=("--port=33444" "" "")
RSYNC_BASE_DIRS=("ftp_data/chem_comp/PDBML" "ftp_data/chem_comp/PDBML" "pub/databases/pdb/data/chem_comp/PDBML")

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

   cmp=`echo "$time > $delay" | bc 2> /dev/null`

   if [ "$cmp" = 0 ] ; then

    server_alive=`curl -I $url -m 5 2> /dev/null`

    if [ $? == 0 ] ; then

     PDB_MIRROR=$url
     delay=$time

    fi

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

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 rsync -avz --delete $RSYNC_PORT $PDB_MIRROR::$RSYNC_BASE_DIR/$SRC_DIR/ $SRC_DIR

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

