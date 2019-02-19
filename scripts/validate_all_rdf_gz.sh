#!/bin/bash

source ./scripts/env.sh

if [ $has_rapper_command = "false" ] ; then

 echo "rapper: command not found..."
 echo "Please install Raptor RDF Syntax Library (http://librdf.org/raptor/)."
 exit 1

fi

RDF_DIR=
DELETE=true

ARGV=`getopt --long -o "d:r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  RDF_DIR=$2
  shift
 ;;
 -r)
  DELETE=false
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

  for proc_id in `seq 1 $MAXPROCS` ; do

   if [ $DELETE = "true" ] ; then
    ./scripts/validate_all_rdf_gz_worker.sh -l $rdf_file_list -n $proc_id"of"$MAXPROCS -r &
   else
    ./scripts/validate_all_rdf_gz_worker.sh -l $rdf_file_list -n $proc_id"of"$MAXPROCS &
   fi

  done

  if [ $? != 0 ] ; then

   echo $0 aborted.
   exit 1

  fi

  wait

  echo

  rm -f $rdf_file_list

  echo Done.

 fi

fi

