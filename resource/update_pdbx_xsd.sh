#!/bin/sh

if [ ! `which DictToSdb` ] || [ ! `which Dict2XMLSchema` ] || [ ! `which Dict2XMLSchema` ]; then

 echo "Please install MMCIF Dictionary Suite (http://sw-tools.pdb.org/)."
 exit 1

fi

which DictToSdb
which Dict2XMLSchema
which Dict2XMLSchema

DDL_FILE=mmcif_ddl.dic
DIC_FILE=mmcif_pdbx.dic

DIC_PREFIX=pdbx
NAME_SPACE=PDBx

rm -f $DIC_FILE-parser.log $DIC_FILE-diag.log

DictToSdb -ddlFile $DDL_FILE -dictFile $DIC_FILE -dictSdbFile $DIC_PREFIX.sdb -ec

if [ -e $DIC_FILE-parser.log ] ; then

 echo
 head $DIC_FILE-parser.log
 exit 1

fi

if [ -e $DIC_FILE-diag.log ] ; then

 echo
 head $DIC_FILE-diag.log
 exit 1

fi

DictObjFileCreator -dictSdbFile $DIC_PREFIX.sdb -o $DIC_PREFIX.odb
Dict2XMLSchema -dictName $DIC_FILE -df $DIC_PREFIX.odb -ns $NAME_SPACE -prefix $DIC_PREFIX

rm -f $DIC_PREFIX.sdb $DIC_PREFIX.odb

if [ -e $DIC_FILE ] ; then

 arg=(`grep dictionary.version $DIC_FILE`)
 DIC_VER=${arg[1]}
 DIC_MAJOR_VER=${DIC_VER%%.*}0

fi

mv $DIC_PREFIX-v$DIC_VER.xsd $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

sed -i -e "s/xsd:integer/xsd:int/g" $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

pattern=8,9s/$DIC_PREFIX.xsd/$DIC_PREFIX-v$DIC_MAJOR_VER.xsd/

sed -i -e $pattern $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

SAXON=../extlibs/saxon9he.jar

if [ ! -e $SAXON ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

SIMPLIFY_XSD_XSL=../stylesheet/simplify_xsd.xsl

java -jar $SAXON -s:$DIC_PREFIX-v$DIC_MAJOR_VER.xsd -xsl:$SIMPLIFY_XSD_XSL -o:$DIC_PREFIX-v$DIC_MAJOR_VER.xsd~

if [ ! `which xmllint 2> /dev/null` ] ; then
 mv $DIC_PREFIX-v$DIC_MAJOR_VER.xsd~ $DIC_PREFIX-v$DIC_MAJOR_VER.xsd
else
 xmllint --format $DIC_PREFIX-v$DIC_MAJOR_VER.xsd~ > $DIC_PREFIX-v$DIC_MAJOR_VER.xsd ; rm -f $DIC_PREFIX-v$DIC_MAJOR_VER.xsd~
fi

echo Generated: $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

if [ -e ../extlibs/xsd2pgschema.jar ] ; then

 java -classpath ../extlibs/xsd2pgschema.jar xsd2pgschema --xsd $DIC_PREFIX-v$DIC_MAJOR_VER.xsd --ddl $DIC_PREFIX-v$DIC_MAJOR_VER.sql --no-rel --doc-key --no-key

 echo Generated: $DIC_PREFIX-v$DIC_MAJOR_VER.sql

fi

