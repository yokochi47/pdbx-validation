#!/bin/bash

source ./scripts/env.sh

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
total=`wc -l < $FILE_LIST`

while read pdbml_vrpt_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_vrpt_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $pdbml_vrpt_file -validation-alt.xml`
  rdf_vrpt_file=$WORK_DIR/$pdb_id-validation-alt.rdf
  rdf_vrpt_gz_file=$WORK_DIR/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
  err_file=$WORK_DIR/transl_to_rdf_vrpt_alt_$pdb_id.err

  if ( [ ! -e $rdf_vrpt_file ] && [ ! -e $rdf_vrpt_gz_file ] ) || [ -e $err_file ] ; then

   java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$PDBMLV2RDF_XSL -o:$rdf_vrpt_file wurcs2glytoucan=$GLYTOUCAN_XML 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_vrpt_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   fi

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

