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

while read pdbml_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_file ] ; then

   let proc_id++
   continue

  fi

  cc_id=`basename $pdbml_file .xml`
  rdf_file=$WORK_DIR/$cc_id.rdf
  div_dir=$WORK_DIR/${cc_id: -1}
  err_file=$WORK_DIR/transl_to_rdf_cc_$cc_id.err

  if ( [ ! -e $rdf_file ] && [ ! -e $div_dir/`basename $rdf_file`.gz ] ) || [ -e $err_file ] ; then

   #pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'

   #gunzip -c $pdbml_gz_file | xsltproc -o $rdf_file $CC2RDF_XSL - 2> $err_file && rm -f $err_file || ( rm -f $rdf_file ; cat $err_file ; exit 1 )
   xsltproc -o $rdf_file $CC2RDF_XSL $pdbml_file 2> $err_file && rm -f $err_file || ( rm -f $rdf_file ; cat $err_file ; exit 1 )

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_file 2> $err_file && rm -f $err_file || ( cat $err_file ; exit 1 )
   fi

   mk_div_dir $div_dir

   if [ -s $rdf_file ] ; then
    gzip_in_div_dir $rdf_file $div_dir
   fi

  fi

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

