#!/bin/bash

source ./scripts/env.sh

CHK_SUM_DIR=
FILE_LIST=
DELETE=true

ARGV=`getopt --long -o "c:l:n:r" "$@"`
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
 -r)
  DELETE=false
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

while read rdf_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $rdf_file ] ; then

   let proc_id++
   continue

  fi

  rdf_label=`basename $rdf_file`

  chk_sum_file=$CHK_SUM_DIR/$rdf_label.md5

  if [ $chk_sum_file -nt $rdf_file ] ; then

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

   let proc_id++

   continue

  fi

  new_chk_sum=`md5sum $rdf_file | cut -d ' ' -f 1`

  if [ -e $chk_sum_file ] ; then

   old_chk_sum=`head -n 1 $chk_sum_file`

   if [ "$old_chk_sum" = "$new_chk_sum" ] ; then

    if [ $chk_sum_file -ot $rdf_file ] ; then
     touch $chk_sum_file
    fi

    if [ $proc_id_mod = 0 ] ; then
     echo -e -n "\rDone "$((proc_id + 1)) of $total ...
    fi

    let proc_id++

    continue

   fi

  fi

  rdf_dir=`dirname $rdf_file`
  err_file=$rdf_dir/validate_$rdf_label.err

  rapper -q -c $rdf_file 2> $err_file && ( rm -f $err_file ; echo $new_chk_sum > $chk_sum_file ) || ( [ $DELETE = "true" ] && rm -f $rdf_file ; cat $err_file )

  if [ $proc_id_mod = 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

