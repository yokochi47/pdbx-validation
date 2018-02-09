#!/bin/bash

SAXON=extlibs/saxon9he.jar

PDBMLV2RDF_XSL=stylesheet/pdbmlv2rdf.xsl

WORK_DIR=rdf-validation

FILE_LIST=pdbml_file_list

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
PROC_ID=`expr $PROC_ID - 1`

proc_id=0
total=`wc -l $FILE_LIST`

while read pdbml_valid_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  pdb_id=`basename $pdbml_valid_file -validation-full.xml`
  rdf_valid_file=$WORK_DIR/$pdb_id-validation.rdf
  err_file=$WORK_DIR/translate_to_rdf_$pdb_id.err

  if [ ! -e $rdf_valid_file ] || [ -e $err_file ] ; then

   java -jar $SAXON -s:$pdbml_valid_file -xsl:$PDBMLV2RDF_XSL -o:$rdf_valid_file 2> $err_file

   if [ $? = 0 ] ; then
    rm -f $err_file
   else
    cat $err_file
    exit 1
   fi

   if [ $proc_id = 0 ] ; then
    echo -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

