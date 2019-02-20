#!/bin/bash

source ./scripts/env.sh

CHK_SUM_DIR=
FILE_LIST=
DELETE=true

ARGV=`getopt --long -o "c:s:l:n:r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -c)
  CHK_SUM_DIR=$2
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
PROC_ID=`expr $PROC_ID - 1`

proc_id=0
total=`wc -l < $FILE_LIST`

while read cif_gz_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  chk_sum_file=$CHK_SUM_DIR/$cif_gz_file.md5

  if [ $chk_sum_file -nt $cif_gz_file ] ; then

   let proc_id++
   continue

  fi

  new_chk_sum=`md5sum $cif_gz_file | cut -d ' ' -f 1`

  if [ -e $chk_sum_file ] ; then

   old_chk_sum=`head -n 1 $chk_sum_file`

   if [ $old_chk_sum = $new_chk_sum ] ; then

    if [ $chk_sum_file -ot $cif_gz_file ] ; then
     touch $chk_sum_file
    fi

    let proc_id++
    continue

   fi

  fi

  cif_dir=`dirname $cif_gz_file`
  cif_file=`basename $cif_gz_file .gz`

  gunzip -c $cif_gz_file > $cif_dir/$cif_file

  diag_log=$cif_file-diag.log
  parser_log=$cif_file-parser.log

  rm -f $cif_dir/$diag_log $cif_dir/$parser_log

  ( cd $cif_dir ; CifCheck -f $cif_file -dictSdb $dict_sdb > /dev/null ; [ -e $diag_log ] && [ `grep -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l` = 0 ] && rm -f $diag_log )
  ( cd $cif_dir ; [ ! -e $diag_log ] && [ ! -e $parser_log ] && ( rm -f $cif_file ; echo $new_chk_sum > $chk_sum_file ) ; [ -e $parser_log ] && ( [ $DELETE = "true" ] && rm -f $cif_file.gz ; rm -f $cif_file ; cat $diag_log ) )

  if [ $proc_id_mod = 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

