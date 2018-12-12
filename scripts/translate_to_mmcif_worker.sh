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
PROC_ID=`expr $PROC_ID - 1`

proc_id=0
total=`wc -l < $FILE_LIST`

while read pdbml_valid_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  pdb_id=`basename $pdbml_valid_file -validation-full.xml`
  mmcif_valid_file=$pdb_id-validation-full.cif
  mmcif_gz_valid_file=$WORK_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id-validation-full.cif.gz

  if [ ! -e $WORK_DIR/$mmcif_valid_file ] && [ ! -e $mmcif_gz_valid_file ] ; then

   ( cd $WORK_DIR ; xml2mmcif -xml ../$pdbml_valid_file -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && mv ../$pdbml_valid_file.cif $mmcif_valid_file )

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

