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
  xmllint --format $1 > $1~ && mv -f $1~ $1 || rm -f $1~
 fi

}

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

  pdb_id=`basename $pdbml_gz_file -noatom.xml.gz`
  sifts_xml_file=$SIFTS_XML/$pdb_id.xml
  pdbml_sifts_file=$WORK_DIR/$pdb_id-noatom-sifts.xml
  div_dir=$WORK_DIR/${pdb_id:1:2}
  err_file=$WORK_DIR/merge_pdbml_sifts_$pdb_id.err

  if [ ! -e $sifts_xml_file ] ; then

   if [ ! -e $div_dir/$pdb_id-noatom-sifts.xml.gz ] ; then

    mk_div_dir $div_dir
    cp $pdbml_gz_file $div_dir/$pdb_id-noatom-sifts.xml.gz

   fi
   
  elif ( ( [ ! -e $pdbml_sifts_file ] && [ ! -e $div_dir/`basename $pdbml_sifts_file`.gz ] ) || [ -e $err_file ] ); then

   pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file || exit 1

   java -jar $SAXON -s:$pdbml_file -xsl:$MERGE_PDBML_SIFTS_XSL -o:$pdbml_sifts_file sifts_file=../$sifts_xml_file 2> $err_file && rm -f $err_file $pdbml_file || ( rm -f $pdbml_file $pdbml_sifts_file ; cat $err_file ; exit 1 )

   xml_pretty $pdbml_sifts_file

   mk_div_dir $div_dir

   if [ $VALIDATE = 'true' ] ; then

    java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBML_XSD --xml $pdbml_sifts_file > /dev/null 2> $err_file

    if [ $? = 0 ] && [ -s $pdbml_sifts_file ] ; then
     rm -f $err_file
     gzip_in_div_dir $pdbml_sifts_file $div_dir
     if [ $proc_id_mod = 0 ] ; then
      echo -e -n "\rDone "$((proc_id + 1)) of $total ...
     fi
    else
     cat $err_file
    fi

   elif [ -s $pdbml_sifts_file ] ; then
    gzip_in_div_dir $pdbml_sifts_file $div_dir
    if [ $proc_id_mod = 0 ] ; then
     echo -e -n "\rDone "$((proc_id + 1)) of $total ...
    fi
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

