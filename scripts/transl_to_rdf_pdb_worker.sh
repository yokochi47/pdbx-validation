#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=

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
  total=$2
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

# total=`wc -l < $FILE_LIST`

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
  rdf_file=$WORK_DIR/$pdb_id.rdf
  div_dir=$WORK_DIR/${pdb_id:1:2}
  err_file=$WORK_DIR/transl_to_rdf_pdb_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if ( [ ! -e $rdf_file ] && [ ! -e $div_dir/`basename $rdf_file`.gz  ] ) || [ -e $err_file ] ; then

   touch $lock_file

   pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file || exit 1

   #has_glycan=`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`
   #has_glycan=`xsltproc $PDBML2WURCS_XSL $pdbml_file`
   #grep WURCS $pdbml_file > /dev/null
   #has_glycan=$?

   #if [ -z "$has_glycan" ] ; then
    xsltproc -o $rdf_file --stringparam wurcs2glytoucan $WURCS_CATALOG_XML $PDBML2RDF_XSL $pdbml_file 2> $err_file && rm -f $err_file $pdbml_file || ( rm -f $pdbml_file $rdf_file ; cat $err_file ; exit 1 )
   #else
   # java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$WURCS_CATALOG_XML 2> $err_file && rm -f $err_file $pdbml_file || ( rm -f $pdbml_file $rdf_file ; cat $err_file ; exit 1 )
   #fi

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_file 2> $err_file && rm -f $err_file || ( cat $err_file ; exit 1 )
   fi

   mk_div_dir $div_dir

   if [ -s $rdf_file ] ; then
    gzip_in_div_dir $rdf_file $div_dir
   fi

   rm -f $lock_file

  fi

  if [ $proc_id_mod -eq 0 ] ; then
   echo -e -n "\rDone "$((proc_id + 1)) of $total ...
  fi

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
  rdf_file=$WORK_DIR/$pdb_id.rdf
  div_dir=$WORK_DIR/${pdb_id:1:2}
  err_file=$WORK_DIR/transl_to_rdf_pdb_$pdb_id.err
  lock_file=$WORK_DIR/$pdb_id.lock

  if [ ! -e $lock_file ] && ( ( [ ! -e $rdf_file ] && [ ! -e $div_dir/`basename $rdf_file`.gz  ] ) || [ -e $err_file ] ) ; then

   pdbml_file=${pdbml_gz_file%.*} # remove the last '.gz'
   gunzip -c $pdbml_gz_file > $pdbml_file || exit 1

   #has_glycan=`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`
   #has_glycan=`xsltproc $PDBML2WURCS_XSL $pdbml_file`
   #grep WURCS $pdbml_file > /dev/null
   #has_glycan=$?

   #if [ -z "$has_glycan" ] ; then
    xsltproc -o $rdf_file --stringparam wurcs2glytoucan $WURCS_CATALOG_XML $PDBML2RDF_XSL $pdbml_file 2> $err_file && rm -f $err_file $pdbml_file || ( rm -f $pdbml_file $rdf_file ; cat $err_file ; exit 1 )
   #else
   # java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$WURCS_CATALOG_XML 2> $err_file && rm -f $err_file $pdbml_file || ( rm -f $pdbml_file $rdf_file ; cat $err_file ; exit 1 )
   #fi

   if [ $has_rapper_command != "false" ] ; then
    rapper -q -c $rdf_file 2> $err_file && rm -f $err_file || ( cat $err_file ; exit 1 )
   fi

   mk_div_dir $div_dir

   if [ -s $rdf_file ] ; then
    gzip_in_div_dir $rdf_file $div_dir
   fi

  fi

 fi

 let proc_id++

done < $FILE_LIST~

