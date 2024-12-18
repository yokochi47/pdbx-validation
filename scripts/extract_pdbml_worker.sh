#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=
TOTAL=
VALIDATE=false

ARGV=`getopt --long -o "d:l:n:t:v" "$@"`
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

# TOTAL=`wc -l < $FILE_LIST`

proc_id=0

while read pdbml_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_gz_file ] ; then

   let proc_id++
   continue

  fi

  #pdb_id=`basename $pdbml_gz_file -noatom.xml.gz`
  pdb_id=`basename $pdbml_gz_file -noatom-sifts.xml.gz`
  pdbml_ext_file=$WORK_DIR/$pdb_id-noatom-ext.xml
  info_gz_file=$VALID_REPORT/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz"
  err_file=$WORK_DIR/extract_pdbml_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && [ -e $info_gz_file ] && ( [ ! -e $pdbml_ext_file.gz ] || [ -e $err_file ] ); then

   touch $lock_file

   pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file || exit 1

   info_file=${info_gz_file%.*} # remove the last '.gz'
   gunzip -c $info_gz_file > $info_file || exit 1

   xsltproc -o $pdbml_ext_file --stringparam info_file ../$info_file $EXT_PDBML_XSL $pdbml_file 2> $err_file && rm -f $err_file $pdbml_file $info_file || ( rm -f $pdbml_file $pdbml_ext_file $info_file ; cat $err_file ; exit 1 )
   #java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=../$info_file 2> $err_file && rm -f $err_file $pdbml_file $info_file || ( rm -f $pdbml_file $pdbml_ext_file $info_file ; cat $err_file ; exit 1 )

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null 2> $err_file

    if [ $? = 0 ] && [ -s $pdbml_ext_file ] ; then
     rm -f $err_file
     gzip $pdbml_ext_file
    else
     cat $err_file
    fi

   elif [ -s $pdbml_ext_file ] ; then
    gzip $pdbml_ext_file
   fi

  fi

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
  fi

  rm -f $lock_file

 fi

 let proc_id++

done < $FILE_LIST

proc_id=0

while read pdbml_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_gz_file ] ; then

   let proc_id++
   continue

  fi

  #pdb_id=`basename $pdbml_gz_file -noatom.xml.gz`
  pdb_id=`basename $pdbml_gz_file -noatom-sifts.xml.gz`
  pdbml_ext_file=$WORK_DIR/$pdb_id-noatom-ext.xml
  info_gz_file=$VALID_REPORT/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz"
  err_file=$WORK_DIR/extract_pdbml_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && [ -e $info_gz_file ] && [ ! -e $pdbml_ext_file.gz ] ; then

   touch $lock_file

   pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file || exit 1

   info_file=${info_gz_file%.*} # remove the last '.gz'
   gunzip -c $info_gz_file > $info_file || exit 1

   xsltproc -o $pdbml_ext_file --stringparam info_file ../$info_file $EXT_PDBML_XSL $pdbml_file 2> $err_file && rm -f $err_file $pdbml_file $info_file || ( rm -f $pdbml_file $pdbml_ext_file $info_file ; cat $err_file ; exit 1 )
   #java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=../$info_file 2> $err_file && rm -f $err_file $pdbml_file $info_file || ( rm -f $pdbml_file $pdbml_ext_file $info_file ; cat $err_file ; exit 1 )

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null 2> $err_file

    if [ $? = 0 ] && [ -s $pdbml_ext_file ] ; then
     rm -f $err_file
     gzip $pdbml_ext_file
    else
     cat $err_file
    fi

   elif [ -s $pdbml_ext_file ] ; then
    gzip $pdbml_ext_file
   fi

   rm -f $lock_file

  fi

 fi

 let proc_id++

done < $FILE_LIST~

