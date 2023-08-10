#!/bin/bash

source ./scripts/env.sh
source ./oxigraph_scripts/oxigraph_env.sh

DB_NAME=bird

rm -f /tmp/bird-oxigraph-last

init=false
change=`find $RDF_BIRD -name '*.rdf.gz' -mtime -4 | wc -l`

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

if [ -e $LOCATION_BIRD ] && [ $init = "false" ] ; then

 if [ $change = 0 ] ; then
  echo $DB_NAME is update.
 fi

 exit 0

fi

echo
echo "Do you want to update Oxigraph Server ($GRAPH_URI)? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo skipped.
    exit 1;;
esac

if [ -e $LOCATION_BIRD ] ; then
 rm -f $LOCATION_BIRD/*
fi

err=$DB_NAME"_err"

rm -f $err

find $RDF_BIRD/*/* -type d > bird_folder_list

while read folder ;
do

 echo $folder

 oxigraph_server --location $LOCATION_BIRD load --format $RDF_FORMAT --file $folder/*.rdf.gz 2>> $err

done < bird_folder_list

rm -f bird_folder_list

grep Error $err &> /dev/null || ( cat $err && exit 1 )

rm -f $err

oxigraph_server optimize --location $LOCATION_BIRD &

date -u +"%b %d, %Y" > /tmp/bird-oxigraph-last

echo "RDF->OXIGRAPH (prefix:"$DB_NAME") is completed."

echo

