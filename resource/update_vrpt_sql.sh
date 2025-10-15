#!/bin/bash

XSD2PGSCHEMA=../extlibs/xsd2pgschema.jar

if [ ! -e $XSD2PGSCHEMA ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

XML_SCHEMA=wwpdb_validation_v6.06.xsd
DB_SCHEMA=wwpdb_validation_v6.06.sql

java -classpath ../extlibs/xsd2pgschema.jar xsd2pgschema --xsd $XML_SCHEMA --ddl $DB_SCHEMA

echo Generated: $DB_SCHEMA

