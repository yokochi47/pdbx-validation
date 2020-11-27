#!/bin/bash

XSD2PGSCHEMA=../extlibs/xsd2pgschema.jar

if [ ! -e $XSD2PGSCHEMA ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

XSD_SCHEMA=wwpdb_validation_v005.xsd
DB_SCHEMA=wwpdb_validation_v005.sql

java -classpath ../extlibs/xsd2pgschema.jar xsd2pgschema --xsd $XSD_SCHEMA --ddl $DB_SCHEMA

echo Generated: $DB_SCHEMA

