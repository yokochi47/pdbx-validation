#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=

ARGV=`getopt --long -o "d:l:n:t:" "$@"`
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
 -t)
  total=$2
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

# total=`wc -l < $FILE_LIST`

proc_id=0

while read pdbml_vrpt_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_vrpt_gz_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $pdbml_vrpt_gz_file -validation-full.xml.gz`
  pdbml_vrpt_file=../${pdbml_vrpt_gz_file%.*} # remove the last '.gz'
  pdbml_vrpt_base=`basename $pdbml_vrpt_file`
  mmcif_vrpt_file=$pdb_id-validation-full.cif
  div_dir=$WORK_DIR/${pdb_id:1:2}
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $WORK_DIR/$mmcif_vrpt_file ] && [ ! -e $div_dir/`basename $mmcif_vrpt_file`.gz ] ; then

   touch $lock_file

   ( cd $WORK_DIR ; gunzip -c ../$pdbml_vrpt_gz_file > $pdbml_vrpt_base ; xml2mmcif -xml $pdbml_vrpt_base -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && ( rm -f $pdbml_vrpt_base && mv -f $pdbml_vrpt_base.cif $mmcif_vrpt_file && sed -i -e "s/\._\([0-9]\)\(\S*\) /\.\1\2  /" $mmcif_vrpt_file ) || ( rm -f $pdbml_vrpt_base ; exit 1 ) )

   mk_div_dir $div_dir

   if [ -s $WORK_DIR/$mmcif_vrpt_file ] ; then
    gzip_in_div_dir $WORK_DIR/$mmcif_vrpt_file $div_dir
   fi

   rm -f $lock_file

  fi

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

proc_id=0

while read pdbml_vrpt_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_vrpt_gz_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $pdbml_vrpt_gz_file -validation-full.xml.gz`
  pdbml_vrpt_file=../${pdbml_vrpt_gz_file%.*} # remove the last '.gz'
  pdbml_vrpt_base=`basename $pdbml_vrpt_file`
  mmcif_vrpt_file=$pdb_id-validation-full.cif
  div_dir=$WORK_DIR/${pdb_id:1:2}
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && [ ! -e $WORK_DIR/$mmcif_vrpt_file ] && [ ! -e $div_dir/`basename $mmcif_vrpt_file`.gz ] ; then

   ( cd $WORK_DIR ; gunzip -c ../$pdbml_vrpt_gz_file > $pdbml_vrpt_base ; xml2mmcif -xml $pdbml_vrpt_base -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && ( rm -f $pdbml_vrpt_base && mv -f $pdbml_vrpt_base.cif $mmcif_vrpt_file && sed -i -e "s/\._\([0-9]\)\(\S*\) /\.\1\2  /" $mmcif_vrpt_file ) || ( rm -f $pdbml_vrpt_base ; exit 1 ) )

   mk_div_dir $div_dir

   if [ -s $WORK_DIR/$mmcif_vrpt_file ] ; then
    gzip_in_div_dir $WORK_DIR/$mmcif_vrpt_file $div_dir
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST~

