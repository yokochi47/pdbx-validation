#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=
TOTAL=

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
  TOTAL=$2
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

# TOTAL=`wc -l < $FILE_LIST`

proc_id=0

while read cir_bird_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $cir_bird_file ] ; then

   let proc_id++
   continue

  fi

  cif_basename=`basename $cir_bird_file .cif`

  ( cd $WORK_DIR ; mmcif2XML -dictSdbFile $pdbx_sdb -funct mmcif2xml -dictName pdbx_mmcif.dic -ns PDBx -prefix pdbx-v50 -f ../../$cir_bird_file ; mv $cif_basename.cif.xml $cif_basename.xml )

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

