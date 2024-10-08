#!/bin/bash

source ./scripts/env.sh

MTIME=

ARGV=`getopt --long -o "m:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

DB_NAME=PDBML-noatom

SRC_DIR=$PDBML_NOATOM
#XML_DIR=$PDBML

weekday=`date -u +"%w"`

PDB_MIRRORS=("rsync.rcsb.org" "ftp.pdbj.org" "rsync.ebi.ac.uk")
RSYNC_PORTS=("--port=33444" "" "")
RSYNC_BASE_DIRS=("ftp_data/structures/divided" "ftp_data/structures/divided" "pub/databases/pdb/data/structures/divided")

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

    if [ $? = 0 ] ; then

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
  rm -f url_mirror
  exit 1;;
esac

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if ( [ $weekday -ge 1 ] && [ $weekday -le 4 ] ) || [ ! -d $SRC_DIR ] ; then

 rsync -av --delete $RSYNC_PORT $PDB_MIRROR::$RSYNC_BASE_DIR/$SRC_DIR/ $SRC_DIR

 MD5_DIR=chk_sum_pdbml_noatom
 FILE_EXT_DIGEST=-noatom

 chk_sum_log=pdbml_noatom_log

 java -classpath $XSD2PGSCHEMA chksumstat --xml $SRC_DIR/[0-9a-z]{2} --xml-file-ext gz --sync $MD5_DIR --xml-file-ext-digest $FILE_EXT_DIGEST --update --verbose > $chk_sum_log

 if [ ! -z $MTIME ] ; then
  find $SRC_DIR -name "*.xml.gz" -mtime $MTIME | cut -d '/' -f 3 | cut -d '-' -f 1 > $chk_sum_log
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

 rm -f $chk_sum_log

fi

xml_file_total=pdbml_file_total

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

date -u +"%b %d, %Y" > /tmp/pdbml-last

