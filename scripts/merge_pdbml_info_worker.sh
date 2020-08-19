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
PROC_ID=$(($PROC_ID - 1))

proc_id=0
total=`wc -l < $FILE_LIST`

while read pdbml_ext_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_ext_gz_file ] ; then

   let proc_id++
   continue

  fi

  #pdb_id=`basename $pdbml_ext_file -noatom-ext.xml`
  pdb_id=`basename $pdbml_ext_gz_file -noatom-ext.xml.gz`
  info_alt_file=$XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml
  pdbml_vrpt_file=$WORK_DIR/$pdb_id-validation-full.xml
  div_dir=$WORK_DIR/${pdb_id:1:2}
  pdbml_vrpt_div_file=$div_dir/$pdb_id-validation-full.xml
  err_file=$WORK_DIR/merge_pdbml_info_$pdb_id.err

  if [ -e $info_alt_file.gz ] && ( ( [ ! -e $pdbml_vrpt_file ] && [ ! -e $pdbml_vrpt_div_file.gz ] ) || [ -e $err_file ] ); then

   pdbml_ext_file=${pdbml_ext_gz_file::-3} # remove the last '.gz'
   gunzip -c $pdbml_ext_gz_file > $pdbml_ext_file || exit 1

   gunzip -c $info_alt_file.gz > $info_alt_file || exit 1

   java -jar $SAXON -s:$pdbml_ext_file -xsl:$MERGE_PDBML_INFO_XSL -o:$pdbml_vrpt_file info_alt_file=../$info_alt_file 2> $err_file && rm -f $err_file $pdbml_ext_file $info_alt_file || ( rm -f $pdbml_ext_file $info_alt_file && cat $err_file && exit 1 )

   xml_pretty $pdbml_vrpt_file

   if [ ! -d $div_dir ] ; then
    if [ -e $div_dir ] ; then
     rm -f $div_dir
    fi
    mkdir -p $div_dir
   fi

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_vrpt_file > /dev/null 2> $err_file

    if [ $? = 0 ] ; then
     rm -f $err_file
     mv -f $pdbml_vrpt_file $div_dir && gzip $pdbml_vrpt_div_file
     if [ $proc_id_mod = 0 ] ; then
      echo -e -n "\rDone "$((proc_id + 1)) of $total ...
     fi
    else
     cat $err_file
    fi

   else
    mv -f $pdbml_vrpt_file $div_dir && gzip $pdbml_vrpt_div_file
    if [ $proc_id_mod = 0 ] ; then
     echo -e -n "\rDone "$((proc_id + 1)) of $total ...
    fi
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

