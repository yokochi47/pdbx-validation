#!/bin/bash

source ./virtuoso_scripts/virtuoso_env.sh

which isql &> /dev/null

if [ $? != 0 ] ; then

 echo "isql: command not found..."
 echo "Please install Virtuoso (https://www.openlinksw.com/wiki/main/Main)."

 exit 1

fi

if [ -z $VIRTUOSO_HOME ] ; then

 echo "Need to set VIRTUOSO_HOME."
 exit 1

fi

if [ ! -d $VIRTUOSO_HOME ] ; then

 echo "$VIRTUOSO_HOME is not directory."
 exit 1

fi

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="status();" &> /dev/null

if [ $? = 0 ] ; then

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec='grant select on "DB.DBA.SPARQL_SINV_2" to "SPARQL";'
 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec='grant execute on "DB.DBA.SPARQL_SINV_IMP" to "SPARQL";'

 echo "virtuoso is already running."

 exit 0

fi

VIRTUOSO_DATA_DIR=$VIRTUOSO_HOME/var/lib/virtuoso/db

echo "start virtuoso (local)"
cd $VIRTUOSO_DATA_DIR; virtuoso-t

pid=`pidof virtuoso-t`

if [ $? = 0 ] ; then

 oom_score_adj=`cat /proc/$pid/oom_score_adj`

 echo "pid:           "$pid
 echo "oom_score_adj: "$oom_score_adj

else
 exit 1
fi

iter=1

while true ; do

 sleep 300

 isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec="status();" &> /dev/null

 if [ $? = 0 ] ; then
  break
 elif [ $iter > 6 ] ; then
  echo Failed.
  break
 fi

 let iter++

done

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec='grant select on "DB.DBA.SPARQL_SINV_2" to "SPARQL";'
isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS exec='grant execute on "DB.DBA.SPARQL_SINV_IMP" to "SPARQL";'

echo OK.

