#!/bin/bash

show_usage() {

 echo "Usage: $0 -q QUERY_FILE -f FORMAT -e LOCATION -l LIMIT -s SILENT"
 echo " -q QUERY_FILE : SPARQL query file."
 echo " -f FORMAT     : Output format (HTML, Spreadsheet, XML, JSON, Javascript, NTriples, RDF/XML, CSV (default) or TSV)."
 echo " -e (loc|pub)  : localhost (loc) or bmrbpub.pdbj.org (pub)."
 echo " -l (on|off)   : Turn on (default) or off LIMIT clause in SPARQL."
 echo " -s (yes|no)   : Silent mode of curl command (default:no)."

}

if [ $# = 0 ] ; then

 echo "Couldn't find query file."
 show_usage

 exit 1

fi

FORMATS_FULL=("text/html" "application/vnd.ms-excel" "application/sparql-results+xml" "application/sparql-results+json" "application/javascript" "text/plain" "application/rdf+xml" "text/csv" "text/tab-separated-values")
FORMATS_ABBREV=("HTML" "Spreadsheet" "XML" "JSON" "Javascript" "NTriples" "RDF/XML" "CSV" "TSV")

URL_LOC=http://localhost:8890/sparql
URL_PUB=https://bmrbpub.pdbj.org/search/rdf

QUERY_FILE=$1
OUTPUT_FORMAT="text/csv"
LOCATION=loc
LIMIT=on
SILENT=no

ARGV=`getopt --long -o "q:f:e:l:s:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -q)
  QUERY_FILE=$2
  shift
 ;;
 -f)
  OUTPUT_FORMAT=$2
  shift
 ;;
 -e)
  LOCATION=$2
  shift
 ;;
 -l)
  LIMIT=$2
  shift
 ;;
 -s)
  SILENT=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ ! -e $QUERY_FILE ] ; then

 echo "Couldn't find $QUERY_FILE."

 exit 1

fi

if [ $LOCATION != "loc" ] && [ $LOCATION != "pub" ] ; then

 echo LOCATION should be either \"loc\" or \"pub\".
 show_usage

 exit 1

fi

SPARQL_ENDPOINT=$URL_LOC

if [ $LOCATION != "loc" ] ; then
 SPARQL_ENDPOINT=$URL_PUB
fi

if [ $LIMIT != "on" ] && [ $LIMIT != "off" ] ; then

 echo LIMIT should be either \"on\" or \"off\".
 show_usage

 exit 1

fi

if [ $SILENT != "no" ] && [ $SILENT != "yes" ] ; then

 echo SILENT should be either \"no\" or \"yes\".
 show_usage

 exit 1

fi

valid=false

i=0

for format in ${FORMATS_ABBREV[@]}
do

 if [ ${format,,} = ${OUTPUT_FORMAT,,} ] ; then
  OUTPUT_FORMAT=${FORMATS_FULL[i]}
  valid=true
  break
 fi

 let i++

done

if [ $valid = "false" ] ; then

 i=0

 for format in ${FORMATS_FULL[@]}
 do

  if [ ${format,,} = ${OUTPUT_FORMAT,,} ] ; then
   OUTPUT_FORMAT=${FORMATS_FULL[i]}
   valid=true
   break
  fi

  let i++

 done

 if [ $valid = "false" ] ; then
  OUTPUT_FORMAT="auto"
 fi

fi

if [ $LIMIT = "on" ] ; then

 if [ $SILENT = "no" ] ; then
  curl -F "query=@$QUERY_FILE" -F "format=$OUTPUT_FORMAT" $SPARQL_ENDPOINT
 else
  curl -s -F "query=@$QUERY_FILE" -F "format=$OUTPUT_FORMAT" $SPARQL_ENDPOINT
 fi

else

 if [ $SILENT = "no" ] ; then
  curl -F "query=`cat $QUERY_FILE | sed -r 's/LIMIT [0-9]+//'`" -F "format=$OUTPUT_FORMAT" $SPARQL_ENDPOINT
 else
  curl -s -F "query=`cat $QUERY_FILE | sed -r 's/LIMIT [0-9]+//'`" -F "format=$OUTPUT_FORMAT" $SPARQL_ENDPOINT
 fi

fi

