#!/bin/bash

source ./scripts/env.sh

if [ $? != 0 ] ; then
 exit 1
fi

source ./oxigraph_scripts/oxigraph_env.sh

DB_NAME=vrpt

rm -f /tmp/vrpt-oxigraph-last

init=false
change=`find $RDF_VALID_ALT -name '*.rdf.gz' -mtime -4 | wc -l`

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

if [ -e $LOCATION_VRPT ] && [ $init = "false" ] ; then

 if [ $change = 0 ] ; then
  echo $DB_NAME is update.
 fi

 ls $LOCATION_VRPT/* &> /dev/null

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

if [ -e $LOCATION_VRPT ] ; then
 find $LOCATION_VRPT -type f | xargs rm -f
fi

err=$DB_NAME"_err"

rm -f $err

find $RDF_VALID_ALT/* -type d > vrpt_folder_list

loop_id=0

while read folder ;
do

 echo $folder

 oxigraph_server --location $LOCATION_VRPT load --format $RDF_FORMAT --file $folder/*.rdf.gz 2>> $err

 let loop_id++

 loop_id_mod=$(($loop_id % 36))

 if [ $loop_id_mod = 0 ] ; then

  prev_size=`du -sh $LOCATION_VRPT | cut -f 1`

  echo -n "Interim backup..."

  if [ -e $BACKUP_VRPT ] ; then
   rm -rf $BACKUP_VRPT
  fi

  oxigraph_server backup --location $LOCATION_VRPT --destination $BACKUP_VRPT

  rm -rf $LOCATION_VRPT && mv $BACKUP_VRPT $LOCATION_VRPT

  cur_size=`du -sh $LOCATION_VRPT | cut -f 1`

  echo " Done (" $prev_size " -> " $cur_size ")"

 fi

done < vrpt_folder_list

rm -f vrpt_folder_list

grep Error $err &> /dev/null || ( cat $err && exit 1 )

rm -f $err

rm -rf $BACKUP_VRPT

oxigraph_server backup --location $LOCATION_VRPT --destination $BACKUP_VRPT

rm -rf $LOCATION_VRPT && mv $BACKUP_VRPT $LOCATION_VRPT

date -u +"%b %d, %Y" > /tmp/vrpt-oxigraph-last

echo "RDF->OXIGRAPH (prefix:"$DB_NAME") is completed."

echo

