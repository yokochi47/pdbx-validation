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

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

MAXPROCS=`echo $PROC_INFO | cut -d 'f' -f 2`
PROC_ID=`echo $PROC_INFO | cut -d 'o' -f 1`
PROC_ID=`expr $PROC_ID - 1`

proc_id=0
total=`wc -l < $FILE_LIST`

while read pdbml_ext_file
do

 proc_id_mod=`expr $proc_id % $MAXPROCS`

 if [ $proc_id_mod = $PROC_ID ] ; then

  pdb_id=`basename $pdbml_ext_file -noatom-ext.xml`
  info_alt_file=$VALID_INFO_ALT/$pdb_id-validation-alt.xml
  pdbml_valid_file=$WORK_DIR/$pdb_id-validation-full.xml
  pdbml_gz_valid_file=$WORK_DIR/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  err_file=$WORK_DIR/merge_pdbml_info_$pdb_id.err

  if [ -e $info_alt_file ] && ( ( [ ! -e $pdbml_valid_file ] && [ ! -e $pdbml_gz_valid_file ] ) || [ -e $err_file ] ); then

   java -jar $SAXON -s:$pdbml_ext_file -xsl:$MERGE_PDBML_INFO_XSL -o:$pdbml_valid_file info_alt_file=../$info_alt_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )

   xml_pretty $pdbml_valid_file

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_valid_file > /dev/null 2> $err_file

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

