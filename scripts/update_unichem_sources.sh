#!/bin/bash

source ./scripts/env.sh

DB_NAME=UniChem

SRC_DIR=$XML_CC
UNICHEM_DIR=$UNICHEM_SRCS

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -d $SRC_DIR ] ; then
 echo Not found $SRC_DIR.
 exit 1
fi

mkdir -p $UNICHEM_DIR

last=`find $UNICHEM_DIR -maxdepth 1 -name '*.json' | wc -l 2> /dev/null`
total=`find $SRC_DIR -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
err=`find $UNICHEM_DIR -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Querying UniChem using InChI code in chem_comp/XML...

 pdbml_file_list=pdbml_cc_file_list
 find $SRC_DIR -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/update_unichem_sources_worker.sh -d $UNICHEM_DIR -l $pdbml_file_list -n $proc_id"of"$MAXPROCS -t $total &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $UNICHEM_DIR is up-to-date.

