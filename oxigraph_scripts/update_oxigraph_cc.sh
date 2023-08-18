#!/bin/bash

source ./scripts/env.sh

if [ $? != 0 ] ; then
 exit 1
fi

source ./oxigraph_scripts/oxigraph_env.sh

DB_NAME=cc

rm -f /tmp/cc-oxigraph-last

init=false
change=`find $RDF_CC -name '*.rdf.gz' -mtime -4 | wc -l`

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

if [ -e $LOCATION_CC ] && [ $init = "false" ] ; then

 if [ $change = 0 ] ; then
  echo $DB_NAME is update.
 fi

 ls $LOCATION_CC/* &> /dev/null

 if [ $? = 0 ] ; then
  exit 0
 fi

fi

echo
echo "Do you want to update Oxigraph Server ($GRAPH_URI)? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo skipped.
    exit 1;;
esac

if [ -e $LOCATION_CC ] ; then
 rm -rf $LOCATION_CC
 mkdir $LOCATION_CC
fi

err=$DB_NAME"_err"

rm -f $err

find $RDF_CC/* -type d > cc_folder_list

while read folder ;
do

 echo $folder

 oxigraph_server --location $LOCATION_CC load --format $RDF_FORMAT --file $folder/*.rdf.gz 2>> $err

done < cc_folder_list

rm -f cc_folder_list

grep Error $err &> /dev/null || ( cat $err && exit 1 )

rm -f $err

oxigraph_server --location $LOCATION_CC optimize &

date -u +"%b %d, %Y" > /tmp/cc-oxigraph-last

echo "RDF->OXIGRAPH (prefix:"$DB_NAME") is completed."

echo

