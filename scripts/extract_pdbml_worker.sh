#!/bin/bash

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

PDBX_VALIDATION_XSD=schema/pdbx-validation-v0.xsd

EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl

WORK_DIR=pdbml-ext
VALID_INFO=validation_info

FILE_LIST=pdbml_file_list

VALIDATE=false

ARGV=`getopt --long -o "d:e:l:n:v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  WORK_DIR=$2
  shift
 ;;
 -e)
  VALID_INFO=$2
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
PROC_ID=`expr $PROC_ID - 1`

proc_id=0
total=`wc -l $FILE_LIST`

while read pdbml_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  pdb_id=`basename $pdbml_file -noatom.xml`
  pdbml_ext_file=$WORK_DIR/$pdb_id-noatom-ext.xml
  info_file=$VALID_INFO/$pdb_id"_validation.xml"
  err_file=$WORK_DIR/extract_pdbml_$pdb_id.err

  if [ -e $info_file ] && ( [ ! -e $pdbml_ext_file ] || [ -e $err_file ] ); then

   java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=../$info_file 2> $err_file

   if [ $? = 0 ] ; then
    rm -f $err_file
   else
    cat $err_file
    exit 1
   fi

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null 2> $err_file

    if [ $? = 0 ] ; then
     rm -f $err_file
     if [ $proc_id_mod = 0 ] ; then
      echo -n "\rDone "$((proc_id + 1)) of $total ...
     fi
    else
     cat $err_file
    fi

   elif [ $proc_id_mod = 0 ] ; then
    echo -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

