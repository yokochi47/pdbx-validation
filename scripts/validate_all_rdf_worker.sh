#!/bin/bash

source ./scripts/env.sh

FILE_LIST=
DELETE=true

ARGV=`getopt --long -o "l:n:r" "$@"`
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

while read rdf_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  rdf_dir=`dirname $rdf_file`
  err_file=$rdf_dir/validate_$rdf_file.err

  rapper -q -c $rdf_file 2> $err_file && rm -f $err_file || ( [ $DELETE = "true" ] && rm -f $rdf_file ; cat $err_file )

  if [ $proc_id_mod = 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

