#!/bin/bash

source ./scripts/env.sh

if [ ! `which mmcif2XML` ]; then

 echo "Please install MMCIF Dictionary Suite (http://sw-tools.pdb.org/)."
 exit 1

fi

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

DB_NAME=BIRD

SRC_DIR=$MMCIF_BIRD

weekday=`date -u +"%w"`

PDB_MIRROR=ftp.pdbj.org

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

mkdir -p $SRC_DIR

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 wget -c -r -nv -np https://$PDB_MIRROR/$SRC_DIR/ -nH -R index.html* 2> /dev/null

fi

cif_file_total=cif_bird_file_total

if [ -z $MTIME ] ; then
 MTIME=-4
fi

updated=`find $SRC_DIR -name "*.cif" -mtime $MTIME | wc -l 2> /dev/null`

if [ $updated = 0 ] || [ ! -e $cif_file_total ] ; then

 last=0

 if [ -e $cif_file_total ] ; then
  last=`cat $cif_file_total`
 fi

 total=`find $SRC_DIR -name '*.cif' | wc -l 2> /dev/null`

 if [ $total = $last ] ; then

  echo $DB_NAME" ("$SRC_DIR") is up-to-date."

 else

  echo $total > $cif_file_total

 fi

fi

date -u +"%b %d, %Y" > /tmp/cif-bird-last

mkdir -p $XML_BIRD

SUBDIR=("family" "prd" "prdcc")

for subdir in ${SUBDIR[@]}
do

 echo
 echo Translating $subdir mmCIF to PDBML...

 DST_DIR=$XML_BIRD/$subdir

 rm -rf $DST_DIR

 mkdir -p $DST_DIR

 for dicfile in $pdbx_dic $pdbx_odb $pdbx_sdb ; do

  if [ ! -e $DST_DIR/$dicfile ] ; then
   ( cd $DST_DIR; ln -s ../../resource/$dicfile . )
  fi

 done

 cif_bird_file_list=cif_bird_file_list

 find $SRC_DIR/$subdir -name "*.cif" > $cif_bird_file_list

 while read cif_bird_file
 do

  cif_basename=`basename $cif_bird_file .cif`

  ( cd $DST_DIR ; mmcif2XML -dictSdbFile $pdbx_sdb -funct mmcif2xml -dictName pdbx_mmcif.dic -ns PDBx -prefix pdbx-v50 -f ../../$cif_bird_file ; mv $cif_basename.cif.xml $cif_basename.xml )

 done < $cif_bird_file_list

 rm -f $cif_bird_file_list

 for dicfile in $pdbx_dic $pdbx_odb $pdbx_sdb ; do

  if [ -e $DST_DIR/$dicfile ] ; then
   rm $DST_DIR/$dicfile
  fi

 done

 MD5_DIR=chk_sum_pdbml_$subdir

 chk_sum_log=pdbml_$subdir"_log"

 java -classpath $XSD2PGSCHEMA chksumstat --xml $DST_DIR --sync $MD5_DIR --update --verbose > $chk_sum_log

 if [ ! -z $MTIME ] ; then
  find $DST_DIR -name "*.xml" -mtime $MTIME | cut -d '/' -f 3 | cut -d '.' -f 1 > $chk_sum_log
 fi

 XML_DIR=$XML_BIRD/$subdir

 if [ -d $XML_DIR ] ; then
  while read bird_id ; do
   [ -z "$bird_id" ] || [[ "$bird_id" =~ ^#.* ]] && continue
   rm -f $XML_DIR/$bird_id.xml
  done < $chk_sum_log
 fi

 RDF_DIR=$RDF_BIRD/$subdir

 if [ -d $RDF_DIR ] ; then
  while read bird_id ; do
   [ -z "$bird_id" ] || [[ "$bird_id" =~ ^#.* ]] && continue
   rm -f $RDF_DIR/$bird_id.rdf
   rm -f $RDF_DIR/${bird_id: -1}/$bird_id.rdf.gz
  done < $chk_sum_log
 fi

 rm -f $chk_sum_log

done

