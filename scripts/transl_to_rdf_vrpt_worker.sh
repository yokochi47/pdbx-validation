#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=
TOTAL=

ARGV=`getopt --long -o "d:l:n:t:" "$@"`
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
  err_file=$WORK_DIR/transl_to_rdf_vrpt_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  # DAOTHER-8442
  if [ $pdb_id = "3zpm" ] || [ $pdb_id = "7acs" ] ; then
   continue
  fi

  if [ ! -e $lock_file ] && ( ( [ ! -e $rdf_vrpt_file ] && [ ! -e $div_dir/`basename $rdf_vrpt_file`.gz ] ) || [ -e $err_file ] ) ; then

   touch $lock_file

   #has_glycan=`java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$VRPTML2WURCS_XSL`
   #has_glycan=`xsltproc $VRPTML2WURCS_XSL $pdbml_vrpt_file`
   #grep WURCS $pdbml_vrpt_file > /dev/null
   #has_glycan=$?

   #if [ -z "$has_glycan" ] ; then
    xsltproc -o $rdf_vrpt_file --stringparam wurcs2glytoucan $WURCS_CATALOG_XML $VRPTML2RDF_XSL --stringparam primitive_type_mapping $_VRPTX_PRIMITIVE_TYPE_MAPPING_XML $pdbml_vrpt_file 2> $err_file && rm -f $err_file || ( rm -f $rdf_vrpt_file ; cat $err_file ; exit 1 )
   #else
   # java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$VRPTML2RDF_XSL -o:$rdf_vrpt_file wurcs2glytoucan=$WURCS_CATALOG_XML primitive_type_mapping=$_VRPTX_PRIMITIVE_TYPE_MAPPING_XML 2> $err_file && rm -f $err_file || ( rm -f $rdf_vrpt_file ; cat $err_file ; exit 1 )
   #fi

   if [ $has_rapper_command != "false" ] && [ -s $rdf_vrpt_file ] ; then
    rapper -q -c $rdf_vrpt_file 2> $err_file && rm -f $err_file || ( cat $err_file ; exit 1 )
   fi

   mk_div_dir $div_dir

   if [ -s $rdf_vrpt_file ] ; then
    gzip_in_div_dir $rdf_vrpt_file $div_dir
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
  err_file=$WORK_DIR/transl_to_rdf_vrpt_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  # DAOTHER-8442
  if [ $pdb_id = "3zpm" ] || [ $pdb_id = "7acs" ] ; then
   continue
  fi

  if [ ! -e $lock_file ] && [ ! -e $rdf_vrpt_file ] && [ ! -e $div_dir/`basename $rdf_vrpt_file`.gz ] ; then

   #has_glycan=`java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$VRPTML2WURCS_XSL`
   #has_glycan=`xsltproc $VRPTML2WURCS_XSL $pdbml_vrpt_file`
   #grep WURCS $pdbml_vrpt_file > /dev/null
   #has_glycan=$?

   #if [ -z "$has_glycan" ] ; then
    xsltproc -o $rdf_vrpt_file --stringparam wurcs2glytoucan $WURCS_CATALOG_XML --stringparam primitive_type_mapping $_VRPTX_PRIMITIVE_TYPE_MAPPING_XML $VRPTML2RDF_XSL $pdbml_vrpt_file 2> $err_file && rm -f $err_file || ( rm -f $rdf_vrpt_file ; cat $err_file ; exit 1 )
   #else
   # java -jar $SAXON -s:$pdbml_vrpt_file -xsl:$VRPTML2RDF_XSL -o:$rdf_vrpt_file wurcs2glytoucan=$WURCS_CATALOG_XML primitive_type_mapping=$_VRPTX_PRIMITIVE_TYPE_MAPPING_XML 2> $err_file && rm -f $err_file || ( rm -f $rdf_vrpt_file ; cat $err_file ; exit 1 )
   #fi

   if [ $has_rapper_command != "false" ] && [ -s $rdf_vrpt_file ] ; then
    rapper -q -c $rdf_vrpt_file 2> $err_file && rm -f $err_file || ( cat $err_file ; exit 1 )
   fi

   mk_div_dir $div_dir

   if [ -s $rdf_vrpt_file ] ; then
    gzip_in_div_dir $rdf_vrpt_file $div_dir
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST~

