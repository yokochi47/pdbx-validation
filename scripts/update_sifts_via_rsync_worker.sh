#!/bin/bash

source ./scripts/env.sh

SRC_DIR=
DST_DIR=
DIR_LIST=

ARGV=`getopt --long -o "s:d:l:n:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -s)
  SRC_DIR=$2
  shift
 ;;
 -d)
  DST_DIR=$2
  shift
 ;;
 -l)
  DIR_LIST=$2
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

while read div_dir
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  rsync -av --delete $SRC_DIR/$div_dir/ $DST_DIR/$div_dir

 fi

 let proc_id++

done < $DIR_LIST

