#!/bin/bash

source ./scripts/env.sh
source ./virtuoso_scripts/virtuoso_env.sh

MAXPROCS=`echo "scale=0; $MAXPROCS / 2.5" | bc`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

DB_NAME=fam

rm -f /tmp/fam-virtuoso-last

init=false
change=`find $RDF_FAM -name '*.rdf.gz' -mtime -4 | wc -l`

which isql &> /dev/null

if [ $? != 0 ] ; then

 echo "isql: command not found..."
 echo "Please install Virtuoso (https://virtuoso.openlinksw.com/)."
 exit 1

fi

#./virtuoso_scripts/start_virtuoso.sh || exit 1

#sleep 30

GRAPH_URI=http://rdf.wwpdb.org/$DB_NAME

graph_exist=`./virtuoso_scripts/ask_graph_existance.sh $GRAPH_URI` || exit 1

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

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="status();" || exit 1

rm -rf $RDF_BIRD_LINK
mkdir -p $RDF_BIRD_LINK

cd $RDF_BIRD_LINK

rdf_file_list=rdf_file_list

find ../$RDF_FAM -type f -iname "*.rdf.gz" > $rdf_file_list

while read rdf_file
do

 ln -s $rdf_file .

done < $rdf_file_list

rm -f $rdf_file_list

err=$DB_NAME"_err"

if [ $graph_exist = 1 ] ; then

 VIRTUOSO_EXEC_COM="log_enable(3,1); SPARQL CLEAR GRAPH <$GRAPH_URI>;"
 echo $VIRTUOSO_EXEC_COM

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" 2> $err || ( cat $err && exit 1 )

 VIRTUOSO_EXEC_COM="log_enable(3,1); DELETE FROM rdf_quad WHERE g = iri_to_id ('$GRAPH_URI');"
 echo $VIRTUOSO_EXEC_COM

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" 2> $err || ( cat $err && exit 1 )

fi

VIRTUOSO_EXEC_COM="ld_dir('$PWD', '*.rdf.gz', '$GRAPH_URI');"
echo $VIRTUOSO_EXEC_COM

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="$VIRTUOSO_EXEC_COM" 2> $err || ( cat $err && exit 1 )

grep Error $err &> /dev/null || ( cat $err && exit 1 )

rm -f $err

for proc_id in `seq 1 $MAXPROCS` ; do

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="rdf_loader_run();" &

done

if [ $? != 0 ] ; then
 exit 1
fi

wait

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="checkpoint;" || exit 1

date -u +"%b %d, %Y" > /tmp/fam-virtuoso-last

echo "RDF->VIRTUOSO (prefix:"$DB_NAME") is completed."

cd .. ; rm -rf $RDF_BIRD_LINK

#echo -n $"Stopping virtuoso-t daemon: "

#isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS -K

echo

