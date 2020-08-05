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

while read pdbml_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $pdbml_file -noatom.xml`
  rdf_file=$WORK_DIR/$pdb_id.rdf
  rdf_gz_file=$WORK_DIR/$pdb_id.rdf.gz
  err_file=$WORK_DIR/transl_to_rdf_pdb_$pdb_id.err
  #has_glycan=`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`
  grep WURCS $pdbml_file > /dev/null
  has_glycan=$?

  if ( [ ! -e $rdf_file ] && [ ! -e $rdf_gz_file ] ) || [ -e $err_file ] ; then

   if [ $has_glycan == 0 ] ; then
    xsltproc -o $rdf_file --param wurcs2glytoucan $_GLYTOUCAN_XML $PDBML2RDF_XSL $pdbml_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   else
    java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$GLYTOUCAN_XML 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   fi

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   fi

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

