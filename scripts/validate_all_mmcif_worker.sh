#!/bin/bash

source ./scripts/env.sh

CHK_SUM_DIR=
WORK_DIR=
FILE_LIST=
TOTAL=
DELETE=false

ARGV=`getopt --long -o "c:d:s:l:n:t:r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -c)
  CHK_SUM_DIR=$2
  shift
 ;;
 -d)
  WORK_DIR=$2
  shift
 ;;
 -s)
  dict_sdb=$2
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
 -r)
  DELETE=true
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

chk_sum_dir=`readlink -f $CHK_SUM_DIR`

proc_id=0

while read cif_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $cif_file ] ; then

   let proc_id++
   continue

  fi

  cif_label=`basename $cif_file`

  chk_sum_file=$chk_sum_dir/$cif_label.md5

  if [ $chk_sum_file -nt $cif_file ] ; then

   if [ $proc_id_mod -eq 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
   fi

   let proc_id++

   continue

  fi

  new_chk_sum=`md5sum $cif_file | cut -d ' ' -f 1`

  diag_log=$cif_label-diag.log

  if [ -e $chk_sum_file ] && [ ! -e $diag_log ] ; then

   old_chk_sum=`head -n 1 $chk_sum_file`

   if [ "$old_chk_sum" = "$new_chk_sum" ] ; then

    if [ $chk_sum_file -ot $cif_file ] ; then
     touch $chk_sum_file
    fi

    if [ $proc_id_mod -eq 0 ] ; then
     echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
    fi

    let proc_id++

    continue

   fi

  fi

  cif_dir=`dirname $cif_file`
  _cif_file=`basename $cif_file`
  entry_id=`cat $cif_label | cut -d '-' -f 1`
  lock_file=$WORK_DIR/$entry_id.lock
  parser_log=$cif_label-parser.log

  if [ ! -e $lock_file ] ; then

   touch $lock_file

   rm -f $cif_dir/$diag_log $cif_dir/$parser_log

   ( cd $cif_dir ; CifCheck -f $_cif_file -dictSdb $dict_sdb > /dev/null ; [ -e $diag_log ] && [ `LC_ALL=C grep -F -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l 2> /dev/null` = 0 ] && rm -f $diag_log )
   ( cd $cif_dir ; [ ! -e $diag_log ] && [ ! -e $parser_log ] && echo $new_chk_sum > $chk_sum_file ; [ -e $parser_log ] && ( [ $DELETE = "true" ] && rm -f $cif_file ; cat $parser_log ) ; [ -e $diag_log ] && ( [ $DELETE = "true" ] && rm -f $cif_file ; cat $diag_log ) )

   if [ $proc_id_mod -eq 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
   fi

   rm -f $lock_file

  fi

 fi

 let proc_id++

done < $FILE_LIST

proc_id=0

while read cif_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $cif_file ] ; then

   let proc_id++
   continue

  fi

  cif_label=`basename $cif_file`

  chk_sum_file=$chk_sum_dir/$cif_label.md5

  if [ $chk_sum_file -nt $cif_file ] ; then

   let proc_id++

   continue

  fi

  new_chk_sum=`md5sum $cif_file | cut -d ' ' -f 1`

  diag_log=$cif_label-diag.log

  if [ -e $chk_sum_file ] && [ ! -e $diag_log ] ; then

   old_chk_sum=`head -n 1 $chk_sum_file`

   if [ "$old_chk_sum" = "$new_chk_sum" ] ; then

    if [ $chk_sum_file -ot $cif_file ] ; then
     touch $chk_sum_file
    fi

    let proc_id++

    continue

   fi

  fi

  cif_dir=`dirname $cif_file`
  _cif_file=`basename $cif_file`
  entry_id=`cat $cif_label | cut -d '-' -f 1`
  lock_file=$WORK_DIR/$entry_id.lock
  parser_log=$cif_label-parser.log

  if [ ! -e $lock_file ] ; then

   touch $lock_file

   rm -f $cif_dir/$diag_log $cif_dir/$parser_log

   ( cd $cif_dir ; CifCheck -f $_cif_file -dictSdb $dict_sdb > /dev/null ; [ -e $diag_log ] && [ `LC_ALL=C grep -F -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l 2> /dev/null` = 0 ] && rm -f $diag_log )
   ( cd $cif_dir ; [ ! -e $diag_log ] && [ ! -e $parser_log ] && echo $new_chk_sum > $chk_sum_file ; [ -e $parser_log ] && ( [ $DELETE = "true" ] && rm -f $cif_file ; cat $parser_log ) ; [ -e $diag_log ] && ( [ $DELETE = "true" ] && rm -f $cif_file ; cat $diag_log ) )

   rm -f $lock_file

  fi

 fi

 let proc_id++

done < $FILE_LIST~

