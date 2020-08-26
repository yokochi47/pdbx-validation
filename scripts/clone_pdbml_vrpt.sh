#!/bin/bash

source ./scripts/env.sh

sync_update=true

if [ ! `which psql` ] ; then

 echo "psql: command not found..."
 echo "Please install PostgreSQL (https://www.postgresql.org/)."
 exit 1

fi

DB_NAME=pdbml_vrpt_clone
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

XML_DIR=$XML_VALID
FILE_EXT_DIGEST=-validation-full

XSD_SCHEMA=$PDBX_VALIDATION_XSD
DB_SCHEMA=$PDBX_VALIDATION_SQL

if [ ! -e $DB_SCHEMA ] ; then
 java -classpath $XSD2PGSCHEMA xsd2pgschema --xsd $XSD_SCHEMA --ddl $DB_SCHEMA --no-rel --no-key --inplace-doc-key-name entry_id --inplace-doc-key-name entry.id --doc-key-if-no-inplace --doc-key-name entry_id
fi

echo
echo "Do you want to update $DB_NAME? (y [n]) "

read ans

case $ans in
 y*|Y*) ;;
 *) echo stopped.
  exit 1;;
esac

if [ ! -d $XML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

MD5_DIR=chk_sum_psql_pdbml_vrpt

relations=`psql -d $DB_NAME -U $DB_USER -c "\d" | wc -l 2> /dev/null`

if [ $sync_update != "true" ] || [ ! -d $MD5_DIR ] || [ $relations -eq 0 ] ; then
 psql -d $DB_NAME -U $DB_USER -f $DB_SCHEMA --quiet
fi

WORK_DIR=pg_work

if [ $sync_update != "true" ] ; then
 sync_update=false
 DATA_DIR=$WORK_DIR/data
fi

ERR_DIR=$WORK_DIR/err

rm -rf $WORK_DIR

mkdir -p $WORK_DIR

if [ $sync_update != "true" ] ; then
 mkdir -p $DATA_DIR
fi

mkdir -p $ERR_DIR

err_file=$ERR_DIR/all_err

if [ $sync_update != "true" ] ; then

 java -classpath $XSD2PGSCHEMA xml2pgtsv --xsd $XSD_SCHEMA --xml $XML_DIR/[0-9a-z]{2} --xml-file-ext gz --work-dir $DATA_DIR --sync $MD5_DIR --no-rel --inplace-doc-key-name entry_id --inplace-doc-key-name entry.id --doc-key-if-no-inplace --doc-key-name entry_id --upper-case-doc-key --no-valid --xml-file-ext-digest $FILE_EXT_DIGEST --db-name $DB_NAME --db-user $DB_USER 2> $err_file

else

 java -classpath $XSD2PGSCHEMA xml2pgsql --xsd $XSD_SCHEMA --xml $XML_DIR/[0-9a-z]{2} --xml-file-ext gz --sync $MD5_DIR --no-rel --inplace-doc-key-name entry_id --inplace-doc-key-name entry.id --doc-key-if-no-inplace --doc-key-name entry_id --upper-case-doc-key --no-valid --xml-file-ext-digest $FILE_EXT_DIGEST --db-name $DB_NAME --db-user $DB_USER 2> $err_file

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

