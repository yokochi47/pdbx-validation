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

echo -n $"Stopping virtuoso-t daemon: "

isql $VIRTUOSO_DB_PORT $VIRTUOSO_DB_USER $VIRTUOSO_DB_PASS -K

echo

