#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=

ARGV=`getopt --long -o "d:l:n:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  WORK_DIR=$2
  shift
 ;;
 -l)
  FILE_LIST=$2
  shift
 ;;
 -n)
  PROC_INFO=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

if ! [[ $PROC_INFO =~ .*of.* ]] ; then

 echo "Invalid thread id ($PROC_INFO)."
 exit 1

fi

MAXPROCS=`echo $PROC_INFO | cut -d 'f' -f 2`
PROC_ID=`echo $PROC_INFO | cut -d 'o' -f 1`
PROC_ID=$(($PROC_ID - 1))

proc_id=0
total=`wc -l < $FILE_LIST`

while read pdbml_vrpt_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_vrpt_gz_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $pdbml_vrpt_gz_file -validation-alt.xml.gz`
  pdbml_vrpt_file=../`dirname $pdbml_vrpt_gz_file`/`basename $pdbml_vrpt_gz_file .gz`
  mmcif_vrpt_file=$pdb_id-validation-alt.cif
  mmcif_vrpt_gz_file=$WORK_DIR/${pdb_id:1:2}/$pdb_id-validation-alt.cif.gz

  if [ ! -e $WORK_DIR/$mmcif_vrpt_file ] && [ ! -e $mmcif_vrpt_gz_file ] ; then

   ( cd $WORK_DIR ; gunzip -c ../$pdbml_vrpt_gz_file > $pdbml_vrpt_file ; xml2mmcif -xml $pdbml_vrpt_file -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && ( mv -f $pdbml_vrpt_file.cif $mmcif_vrpt_file && rm $pdbml_vrpt_file && sed -i -e "s/\._\([0-9]\)\(\S*\) /\.\1\2  /" $mmcif_vrpt_file ) || exit 1 )

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

