#!/bin/bash

source ./scripts/env.sh

FILE_LIST=

ARGV=`getopt --long -o "l:n:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
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

while read sifts_xml_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $sifts_xml_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $sifts_xml_file .xml`

  sed -n 2,2p $sifts_xml_file | grep 'dbAccessionId="'$pdb_id'"' > /dev/null

  if [ $? != 0 ] ; then
   echo deleting $sifts_xml_file
   rm -f $sifts_xml_file
  fi

 fi

 let proc_id++

done < $FILE_LIST

