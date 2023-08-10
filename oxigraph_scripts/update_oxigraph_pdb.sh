#!/bin/bash

source ./scripts/env.sh
source ./oxigraph_scripts/oxigraph_env.sh

DB_NAME=pdb

rm -f /tmp/pdb-oxigraph-last

init=false
change=`find $RDF -name '*.rdf.gz' -mtime -4 | wc -l`

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

if [ -e $LOCATION_PDB ] && [ $init = "false" ] ; then

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

if [ -e $LOCATION_PDB ] ; then
 rm -f $LOCATION_PDB/*
fi

err=$DB_NAME"_err"

rm -f $err

find $RDF/* -type d > pdb_folder_list

while read folder ;
do

 echo $folder

 oxigraph_server --location $LOCATION_PDB load --format $RDF_FORMAT --file $folder/*.rdf.gz 2>> $err

done < pdb_folder_list

rm -f pdb_folder_list

grep Error $err &> /dev/null || ( cat $err && exit 1 )

rm -f $err

oxigraph_server optimize --location $LOCATION_PDB &

date -u +"%b %d, %Y" > /tmp/pdb-oxigraph-last

echo "RDF->OXIGRAPH (prefix:"$DB_NAME") is completed."

echo

