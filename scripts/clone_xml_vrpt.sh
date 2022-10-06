#!/bin/bash

source ./scripts/env.sh

sync_update=true

if [ ! `which psql` ] ; then

 echo "psql: command not found..."
 echo "Please install PostgreSQL (https://www.postgresql.org/)."
 exit 1

fi

DB_NAME=xml_vrpt_clone
DB_USER=$USER

echo
echo "Input username of PostgreSQL? (defalut=$USER) "

read db_user

if [ ! -z $db_user ] ; then
 DB_USER=$db_user
fi

psql -U $DB_USER -l | grep $DB_NAME > /dev/null || ( echo "database \"$DB_NAME\" does not exist." ; exit 1 )

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

XML_DIR=$VALID_REPORT
FILE_EXT_DIGEST=_validation

XML_SCHEMA=$WWPDB_VALIDATION_XSD
DB_SCHEMA=$WWPDB_VALIDATION_SQL

if [ ! -e $DB_SCHEMA ] ; then
 java -classpath $XSD2PGSCHEMA xsd2pgschema --xsd $XML_SCHEMA --ddl $DB_SCHEMA
fi

echo
echo "Do you want to update $DB_NAME? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo stopped.
  exit 1;;
esac

if [ ! -d $XML_DIR ] ; then
 ./scripts/update_vrpt.sh
fi

MD5_DIR=chk_sum_psql_xml_vrpt

relations=`psql -d $DB_NAME -U $DB_USER -c "\d" | wc -l 2> /dev/null`

if [ $sync_update != "true" ] || [ ! -d $MD5_DIR ] || [ $relations -eq 0 ] ; then
 sync_update=false
 psql -d $DB_NAME -U $DB_USER -f $DB_SCHEMA --quiet
fi

WORK_DIR=pg_work
DATA_DIR=$WORK_DIR/work
ERR_DIR=$WORK_DIR/err

rm -rf $WORK_DIR

mkdir -p $WORK_DIR

if [ $sync_update != "true" ] ; then
 mkdir -p $DATA_DIR
fi

mkdir -p $ERR_DIR

err_file=$ERR_DIR/all_err

if [ $sync_update != "true" ] ; then

 java -classpath $XSD2PGSCHEMA xml2pgtsv --xsd $XML_SCHEMA --xml $XML_DIR/[0-9a-z]{2}/[0-9][0-9a-z]{3} --xml-file-ext gz --work-dir $DATA_DIR --sync $MD5_DIR --xml-file-ext-digest $FILE_EXT_DIGEST --db-name $DB_NAME --db-user $DB_USER --type-check --skip-range-outlier 2> $err_file

else

 java -classpath $XSD2PGSCHEMA xml2pgsql --xsd $XML_SCHEMA --xml $XML_DIR/[0-9a-z]{2}/[0-9][0-9a-z]{3} --xml-file-ext gz --sync $MD5_DIR --xml-file-ext-digest $FILE_EXT_DIGEST --db-name $DB_NAME --db-user $DB_USER --type-check --skip-range-outlier 2> $err_file

fi

if [ $? = 0 ] && [ ! -s $err_file ] ; then
 rm -f $err_file
 if [ $sync_update != "true" ] ; then
  rm -rf $DATA_DIR
 fi
else
 echo $0 aborted.
 exit 1
fi

red='\e[0;31m'
normal='\e[0m'

errs=`ls $ERR_DIR/*_err 2> /dev/null | wc -l 2> /dev/null`

if [ $errs = 0 ] ; then

 rm -rf $WORK_DIR

 echo "Database ($DB_NAME) is update."

else

 echo
 echo -e "${red}$errs errors were detected. Please check the log files for more details.${normal}"
 exit 1

fi

date

