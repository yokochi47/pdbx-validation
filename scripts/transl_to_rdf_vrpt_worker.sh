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

  pdb_id=`basename $pdbml_vrpt_file -validation-full.xml`
  rdf_vrpt_file=$WORK_DIR/$pdb_id-validation-full.rdf
  div_dir=$WORK_DIR/${pdb_id:1:2}
  rdf_vrpt_div_file=$div_dir/$pdb_id-validation-full.rdf
  err_file=$WORK_DIR/transl_to_rdf_vrpt_$pdb_id.err

  if ( [ ! -e $rdf_vrpt_file ] && [ ! -e $rdf_vrpt_div_file.gz ] ) || [ -e $err_file ] ; then

   #has_glycan=`java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$PDBMLV2WURCS_XSL`
   has_glycan=`xsltproc $PDBMLV2WURCS_XSL $pdbml_vrpt_file`
   #grep WURCS $pdbml_vrpt_file > /dev/null
   #has_glycan=$?

   if [ -z "$has_glycan" ] ; then
    xsltproc -o $rdf_vrpt_file --param wurcs2glytoucan $_GLYTOUCAN_XML $PDBMLV2RDF_XSL $pdbml_vrpt_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   else
    java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$PDBMLV2RDF_XSL -o:$rdf_vrpt_file wurcs2glytoucan=$GLYTOUCAN_XML 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   fi

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_vrpt_file 2> $err_file && rm -f $err_file || ( cat $err_file && exit 1 )
   fi

   if [ ! -d $div_dir ] ; then
    if [ -e $div_dir ] ; then
     rm -f $div_dir
    fi
    mkdir -p $div_dir
   fi

   mv -f $rdf_vrpt_file $div_dir && gzip $rdf_vrpt_div_file

   if [ $proc_id_mod = 0 ] ; then
    echo -e -n "\rDone "$((proc_id + 1)) of $total ...
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST

