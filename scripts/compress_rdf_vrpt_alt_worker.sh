#!/bin/bash

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
PROC_ID=$(($PROC_ID - 1))

proc_id=0

while read rdf_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $rdf_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $rdf_file -validation-alt.rdf`
  div_dir=$WORK_DIR/${pdb_id:1:2}

  if [ ! -d $div_dir ] ; then
   if [ -e $div_dir ] ; then
    rm -f $div_dir
   fi
   mkdir -p $div_dir
  fi

  mv -f $rdf_file $div_dir && gzip $div_dir/$pdb_id-validation-alt.rdf

 fi

 let proc_id++

done < $FILE_LIST

