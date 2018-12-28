#!/bin/bash

source ./scripts/env.sh

if [ $has_rapper_command = "false" ] ; then

 echo "rapper: command not found..."
 echo "Please install Raptor RDF Syntax Library (http://librdf.org/raptor/)."
 exit 1

fi

RDF_DIR=

ARGV=`getopt --long -o "d:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  RDF_DIR=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ ! -z $RDF_DIR ] ; then

 total=`find $RDF_DIR -name '*.rdf.gz' | wc -l`

 if [ $total != 0 ] ; then

  echo RDF syntax validation: *.rdf.gz documents in $RDF_DIR...

  rdf_file_list=check_${RDF_DIR,,}_rdf_gz_file_list

  find $RDF_DIR -name '*.rdf.gz' > $rdf_file_list

  while read rdf_gz_file
  do

   rdf_file=$RDF_DIR/`basename $rdf_gz_file .gz`
   err_file=$RDF_DIR/validate_$rdf_gz_file.err

   gunzip -c $rdf_gz_file > $rdf_file ; rapper -q -c $rdf_file 2> $err_file rm -f $rdf_file $err_file || ( cat $err_file && exit 1 )

  done < $rdf_file_list

  rm -f $rdf_file_list

 fi

fi

