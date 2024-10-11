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

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ && mv -f $1~ $1 || rm -f $1~
 fi

}

MAXPROCS=`echo $PROC_INFO | cut -d 'f' -f 2`
PROC_ID=`echo $PROC_INFO | cut -d 'o' -f 1`
PROC_ID=$(($PROC_ID - 1))

# TOTAL=`wc -l < $FILE_LIST`

proc_id=0

while read info_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $info_gz_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $info_gz_file _validation.xml.gz`
  info_alt_file=$WORK_DIR/$pdb_id-validation-alt.xml
  div_dir=$WORK_DIR/${pdb_id:1:2}
  pdbml_ext_file=$PDBML_EXT/$pdb_id-noatom-ext.xml
  err_file=$WORK_DIR/extract_info_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && [ -e $pdbml_ext_file.gz ] && ( ( [ ! -e $info_alt_file ] && [ ! -e $div_dir/`basename $info_alt_file`.gz ] ) || [ -e $err_file ] ) ; then

   touch $lock_file

   info_file=${info_gz_file%.*} # remove the last '.gz'
   gunzip -c $info_gz_file > $info_file || exit 1

   gunzip -c $pdbml_ext_file.gz > $pdbml_ext_file || exit 1

   complex_vrpt=`xsltproc $COMPLEX_VRPT_XSL $info_file`

   if [ "$complex_vrpt" = "true" ] ; then
    java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_alt_file pdbml_ext_file=../$pdbml_ext_file 2> $err_file && rm -f $err_file $info_file $pdbml_ext_file || ( rm -f $info_file $info_alt_file $pdbml_ext_file ; cat $err_file ; exit 1 )
   else
    # take over entries requiring ext:node-set() from xsltproc to saxon
    xsltproc -o $info_alt_file --stringparam pdbml_ext_file ../$pdbml_ext_file $EXT_INFO_XSL $info_file 2> /dev/null && rm -f $err_file $info_file $pdbml_ext_file || ( java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_alt_file pdbml_ext_file=../$pdbml_ext_file 2> $err_file && rm -f $err_file $info_file $pdbml_ext_file || ( rm -f $info_file $info_alt_file $pdbml_ext_file ; cat $err_file ; exit 1 ) )
   fi

   xml_pretty $info_alt_file

   mk_div_dir $div_dir

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $info_alt_file > /dev/null 2> $err_file

    if [ $? = 0 ] && [ -s $info_alt_file ] ; then
     rm -f $err_file
     gzip_in_div_dir $info_alt_file $div_dir
    else
     cat $err_file
    fi

   elif [ -s $info_alt_file ] ; then
    gzip_in_div_dir $info_alt_file $div_dir
   fi

   rm -f $lock_file

  fi

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $TOTAL ...
  fi

 fi

 let proc_id++

done < $FILE_LIST

proc_id=0

while read info_gz_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $info_gz_file ] ; then

   let proc_id++
   continue

  fi

  pdb_id=`basename $info_gz_file _validation.xml.gz`
  info_alt_file=$WORK_DIR/$pdb_id-validation-alt.xml
  div_dir=$WORK_DIR/${pdb_id:1:2}
  pdbml_ext_file=$PDBML_EXT/$pdb_id-noatom-ext.xml
  err_file=$WORK_DIR/extract_info_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && [ -e $pdbml_ext_file.gz ] && [ ! -e $info_alt_file ] && [ ! -e $div_dir/`basename $info_alt_file`.gz ] ; then

   touch $lock_file

   info_file=${info_gz_file%.*} # remove the last '.gz'
   gunzip -c $info_gz_file > $info_file || exit 1

   gunzip -c $pdbml_ext_file.gz > $pdbml_ext_file || exit 1

   complex_vrpt=`xsltproc $COMPLEX_VRPT_XSL $info_file`

   if [ "$complex_vrpt" = "true" ] ; then
    java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_alt_file pdbml_ext_file=../$pdbml_ext_file 2> $err_file && rm -f $err_file $info_file $pdbml_ext_file || ( rm -f $info_file $info_alt_file $pdbml_ext_file ; cat $err_file ; exit 1 )
   else
    # take over entries requiring ext:node-set() from xsltproc to saxon
    xsltproc -o $info_alt_file --stringparam pdbml_ext_file ../$pdbml_ext_file $EXT_INFO_XSL $info_file 2> /dev/null && rm -f $err_file $info_file $pdbml_ext_file || ( java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_alt_file pdbml_ext_file=../$pdbml_ext_file 2> $err_file && rm -f $err_file $info_file $pdbml_ext_file || ( rm -f $info_file $info_alt_file $pdbml_ext_file ; cat $err_file ; exit 1 ) )
   fi

   xml_pretty $info_alt_file

   mk_div_dir $div_dir

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $info_alt_file > /dev/null 2> $err_file

    if [ $? = 0 ] && [ -s $info_alt_file ] ; then
     rm -f $err_file
     gzip_in_div_dir $info_alt_file $div_dir
    else
     cat $err_file
    fi

   elif [ -s $info_alt_file ] ; then
    gzip_in_div_dir $info_alt_file $div_dir
   fi

   rm -f $lock_file

  fi

 fi

 let proc_id++

done < $FILE_LIST~

