#!/bin/bash

source ./scripts/env.sh

CHK_SUM_DIR=
FILE_LIST=

ARGV=`getopt --long -o "c:l:n:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -c)
  CHK_SUM_DIR=$2
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

chk_sum_dir=`readlink -f $CHK_SUM_DIR`

while read sifts_xml_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $sifts_xml_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $sifts_xml_file .xml`

  chk_sum_file=$chk_sum_dir/$pdb_id.xml.md5

  if [ $chk_sum_file -nt $sifts_xml_file ] ; then

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

   let proc_id++

   continue

  fi

  new_chk_sum=`md5sum $sifts_xml_file | cut -d ' ' -f 1`

  if [ -e $chk_sum_file ] ; then

   old_chk_sum=`head -n 1 $chk_sum_file`

   if [ "$old_chk_sum" = "$new_chk_sum" ] ; then

    if [ $chk_sum_file -ot $sifts_xml_file ] ; then
     touch $chk_sum_file
    fi

    if [ $proc_id_mod = 0 ] ; then
     echo -e -n "\rDone "$((proc_id + 1)) of $total ...
    fi

    let proc_id++

    continue

   fi

  fi

  sed -n 2,2p $sifts_xml_file | grep 'dbAccessionId="'$pdb_id'"' > /dev/null

  if [ $? != 0 ] ; then
   echo deleting $sifts_xml_file
   rm -f $sifts_xml_file
  else
   echo $new_chk_sum > $chk_sum_file
  fi

  if [ $proc_id_mod = 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

