#!/bin/bash

source ./scripts/env.sh
source ./virtuoso_scripts/virtuoso_env.sh

DB_NAME=pdb-validation

rm -f /tmp/pdb-validation-virtuoso-last

init=false
change=`find $RDF_VALID -name '*.rdf.gz' -mtime -4 | wc -l`

which isql &> /dev/null

if [ $? != 0 ] ; then

 echo "isql: command not found..."
 echo "Please install Virtuoso (http://www.openlinksw.com/dataspace/doc/dav/wiki/Main/)."

 exit 1

fi

./virtuoso_scripts/start_virtuoso.sh

if [ $? != 0 ] ; then
 exit 1
fi

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

graph_exist=`./virtuoso_scripts/ask_graph_existance.sh $GRAPH_URI`

if [ $? != 0 ] ; then
 exit 1
fi

if [ $graph_exist = 1 ] && [ $init = "false" ] ; then

 if [ $change = 0 ] ; then
  echo $DB_NAME is update.
 fi

 exit 0

fi

echo
echo "Do you want to update Virtuoso DB ($GRAPH_URI)? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo skipped.
    exit 1;;
esac

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="status();"

if [ $? != 0 ] ; then
 exit 1
fi

rm -rf $RDF_VALID_LINK
mkdir -p $RDF_VALID_LINK

cd $RDF_VALID_LINK

rdf_file_list=rdf_file_list

find ../$RDF_VALID -type f -iname "*.rdf.gz" > $rdf_file_list

while read rdf_file
do

 ln -s $rdf_file .

done < $rdf_file_list

rm -f $rdf_file_list

err=$DB_NAME"_err"

if [ $graph_exist = 0 ] ; then

 VIRTUOSO_EXEC_COM="ld_dir('$PWD', '*.rdf.gz', '$GRAPH_URI');"
 echo $VIRTUOSO_EXEC_COM

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" 2> $err

 if [ $? != 0 ] ; then
  cat $err
  exit 1
 fi

 grep Error $err &> /dev/null

 if [ $? = 0 ] ; then
  cat $err
  exit 1
 fi

 rm -f $err

 for proc_id in `seq 1 $MAXPROCS` ; do

  isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="rdf_loader_run();" &

 done

 if [ $? != 0 ] ; then
  exit 1
 fi

 wait

else

 if [ $graph_exist = 1 ] ; then

  VIRTUOSO_EXEC_COM="log_enable(3,1); SPARQL CLEAR GRAPH <$GRAPH_URI>;"
  echo $VIRTUOSO_EXEC_COM

  isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" 2> $err

  if [ $? != 0 ] ; then
   cat $err
   exit 1
  fi

 fi

 for file in `ls *.rdf.gz 2> /dev/null`
 do

  VIRTUOSO_EXEC_COM="ld_file('$PWD/$file', '$GRAPH_URI');"

  isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" > /dev/null 2> $err

  if [ $? != 0 ] ; then
   cat $err
   exit 1
  fi

  echo -n .

  rm -f $err

 done

 echo

fi

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="checkpoint;"

if [ $? != 0 ] ; then
 exit 1
fi

date -u +"%b %d, %Y" > /tmp/pdb-validation-virtuoso-last

echo "RDF->VIRTUOSO (prefix:"$DB_NAME") is completed."

echo -n $"Stopping virtuoso-t daemon: "

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS -K

echo

sleep 60

