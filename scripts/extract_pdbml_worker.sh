#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=

VALIDATE=false

ARGV=`getopt --long -o "d:l:n:v" "$@"`
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
 -v)
  VALIDATE=true
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

while read pdbml_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_gz_file ] ; then

   let proc_id++
   continue

  fi

#  pdb_id=`basename $pdbml_file -noatom.xml`
  pdb_id=`basename $pdbml_gz_file -noatom.xml.gz`
  pdbml_ext_file=$WORK_DIR/$pdb_id-noatom-ext.xml
#  info_file=$VALID_INFO/$pdb_id"_validation.xml"
  info_gz_file=$VALID_REPORT/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz"
  err_file=$WORK_DIR/extract_pdbml_$pdb_id.err

  if [ -e $info_gz_file ] && ( [ ! -e $pdbml_ext_file ] || [ -e $err_file ] ); then

   pdbml_file=${pdbml_gz_file::-3} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file

   info_file=${info_gz_file::-3} # remove the last '.gz'
   gunzip -c $info_gz_file > $info_file

   java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=../$info_file 2> $err_file && rm -f $err_file $pdbml_file $info_file || ( rm -f $pdbml_file $info_file && cat $err_file && exit 1 )

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null 2> $err_file

    if [ $? = 0 ] ; then
     rm -f $err_file
     if [ $proc_id_mod = 0 ] ; then
      echo -e -n "\rDone "$((proc_id + 1)) of $total ...
     fi
    else
     cat $err_file
    fi

   elif [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

