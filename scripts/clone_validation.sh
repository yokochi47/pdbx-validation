#!/bin/bash

if [ ! `which psql` ] ; then

 echo "psql: command not found..."
 echo "Please install PostgreSQL (https://www.postgresql.org/)."

 exit 1

fi

DB_NAME=validation_clone
DB_USER=$USER

echo
echo "Input username of PostgreSQL? (defalut=$USER) "

read db_user

if [ ! -z $db_user ] ; then
 DB_USER=$db_user
fi

psql -U $DB_USER -l | grep $DB_NAME > /dev/null

if [ $? != 0 ] ; then

 echo "database \"$DB_NAME\" does not exist."
 exit 1

fi

XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

XML_DIR=validation_info
FILE_EXT_DIGEST=_validation

XSD_SCHEMA=resource/wwpdb_validation_v002.xsd
DB_SCHEMA=resource/wwpdb_validation_v002.sql

java -classpath $XSD2PGSCHEMA xsd2pgschema --xsd $XSD_SCHEMA --ddl $DB_SCHEMA --no-rel --doc-key --no-key

echo
echo "Do you want to update $DB_NAME? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo stopped.
  exit 1;;
esac

if [ ! -d $XML_DIR ] ; then
 ./scripts/update_validation.sh
fi

psql -d $DB_NAME -U $DB_USER -f $DB_SCHEMA --quiet

WORK_DIR=pg_work
CSV_DIR=$WORK_DIR/csv
ERR_DIR=$WORK_DIR/err

rm -rf $WORK_DIR

mkdir -p $WORK_DIR
mkdir -p $CSV_DIR
mkdir -p $ERR_DIR

err_file=$ERR_DIR/all_err

java -classpath $XSD2PGSCHEMA xml2pgcsv --xsd $XSD_SCHEMA --xml $XML_DIR --csv-dir $CSV_DIR --no-rel --doc-key --no-valid --xml-file-ext-digest $FILE_EXT_DIGEST --db-name $DB_NAME --db-user $DB_USER 2> $err_file

if [ $? = 0 ] && [ ! -s $err_file ] ; then
 rm -f $err_file
 rm -rf $CSV_DIR
else
 echo "$0 aborted."
 exit 1
fi

red='\e[0;31m'
normal='\e[0m'

errs=`ls $ERR_DIR/*_err 2> /dev/null | wc -l`

if [ $errs = 0 ] ; then

 rm -rf $WORK_DIR

 echo "Database ($DB_NAME) is update."

else

 echo
 echo -e "${red}$errs errors were detected. Please check the log files for more details.${normal}"

 exit 1

fi

date

