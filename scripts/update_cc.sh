#!/bin/bash

source ./scripts/env.sh

if [ ! `which aria2c` ] ; then

 echo "aria2c: command not found..."
 echo "Please install aria2 (https://aria2.github.io/ZZ)."
 exit 1

fi

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

DB_NAME=chem_comp

SRC_DIR=$CC_CIF_URL

weekday=`date -u +"%w"`

PDB_MIRROR=ftp.pdbj.org

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

mkdir -p $SRC_DIR

if [ $weekday -ge 1 ] && [ $weekday -le 4 ] ; then

 components_cif=components.cif
 components_cif_all=components_cif_all
 components_cif_old=components_cif_old
 components_cif_del=components_cif_del
 components_cif_new=components_cif_new
 components_cif_list=components_cif_list
 components_cif_url=${SRC_DIR//\//\\\/}

 rm -f $components_cif* $components_cif_url

 wget ftp://$PDB_MIRROR/pub/pdb/data/monomers/$components_cif.gz && gunzip $components_cif.gz
 grep '^data_' $components_cif | cut -d '_' -f 2 | sort > $components_cif_all
 find $SRC_DIR -name '*.cif' -size 0 -delete
 find $SRC_DIR -name '*.cif' | cut -d '/' -f 6 | cut -d '.' -f 1 | sort > $components_cif_old
 comm -23 $components_cif_all $components_cif_old > $components_cif_new

 comm -13 $components_cif_all $components_cif_old > $components_cif_del

 if [ -d $XML_CC ] ; then
  while read cc_id ; do
   [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
   rm -f $XML_CC/$cc_id.xml
  done < $components_cif_del
 fi

 if [ -d $RDF_CC ] ; then
  while read cc_id ; do
   [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
   rm -f $RDF_CC/$cc_id.rdf
   rm -f $RDF_CC/${cc_id: -1}/$cc_id.rdf.gz
  done < $components_cif_del
 fi

 rm -f $components_cif_list
 while read cc_id
 do
  echo ftp://$SRC_DIR/${cc_id: -1}/${cc_id}/${cc_id}.cif >> $components_cif_list
 done < $components_cif_new
 aria2c -i $components_cif_list -j $MAXPROCS -d $SRC_DIR --allow-overwrite=true --auto-file-renaming=false

 rm -f $components_cif $components_cif_list $components_cif_all $components_cif_old $components_cif_new $components_cif_del

fi

cif_file_total=cif_cc_file_total

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

date -u +"%b %d, %Y" > /tmp/cif-cc-last

mkdir -p $XML_CC

MD5_DIR=chk_sum_pdbml_chem_comp

chk_sum_log=pdbml_chem_comp_log

java -classpath $XSD2PGSCHEMA chksumstat --xml $XML_CC --sync $MD5_DIR --update --verbose > $chk_sum_log

if [ -d $XML_CC ] ; then
 while read cc_id ; do
  [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
  rm -f $XML_CC/$cc_id.xml
 done < $chk_sum_log
fi

if [ -d $RDF_CC ] ; then
 while read cc_id ; do
  [ -z "$cc_id" ] || [[ "$cc_id" =~ ^#.* ]] && continue
  rm -f $RDF_CC/$cc_id.rdf
  rm -f $RDF_CC/${cc_id: -1}/$cc_id.rdf.gz
 done < $chk_sum_log
fi

rm -f $chk_sum_log

echo
echo Translating $DB_NAME mmCIF to PDBML...

for dicfile in $pdbx_dic $pdbx_odb $pdbx_sdb ; do

 if [ ! -e $XML_CC/$dicfile ] ; then
  ( cd $XML_CC; ln -s ../resource/$dicfile . )
 fi

done

cif_cc_file_list=cif_cc_file_list

find $SRC_DIR -name "*.cif" > $cif_cc_file_list
<<REMARK
while read cif_cc_file
do

 cif_basename=`basename $cif_cc_file .cif`

 if [ ! -e $XML_CC/$cif_basename.xml ] ; then

  ( cd $XML_CC ; mmcif2XML -dictSdbFile $pdbx_sdb -funct mmcif2xml -dictName pdbx_mmcif.dic -ns PDBx -prefix pdbx-v50 -f ../$cif_cc_file ; mv $cif_basename.cif.xml $cif_basename.xml )

 fi

done < $cif_cc_file_list
REMARK
for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/transl_to_pdbml_cc_worker.sh -d $XML_CC -l $cif_cc_file_list -n $proc_id"of"$MAXPROCS &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

echo

rm -f $cif_cc_file_list

for dicfile in $pdbx_dic $pdbx_odb $pdbx_sdb ; do

 if [ -e $XML_CC/$dicfile ] ; then
  rm $XML_CC/$dicfile
 fi

done

echo $XML_CC is up-to-date.

