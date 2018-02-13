#!/bin/sh

if [ ! `which DictToSdb` ] || [ ! `which Dict2XMLSchema` ] || [ ! `which Dict2XMLSchema` ]; then

 echo "Please install MMCIF Dictionary Suite (http://sw-tools.pdb.org/)."

 exit 1

fi

DDL_FILE=mmcif_ddl.dic
DICT_FILE=mmcif_pdbx_validation.dic

DICT_PREFIX=pdbx-validation
NAME_SPACE=PDBxv

rm -f $DICT_FILE-parser.log $DICT_FILE-diag.log

DictToSdb -ddlFile $DDL_FILE -dictFile $DICT_FILE -dictSdbFile $DICT_PREFIX.sdb -ec

if [ -e $DICT_FILE-parser.log ] ; then

 echo

 head $DICT_FILE-parser.log

 exit 1

fi

if [ -e $DICT_FILE-diag.log ] ; then

 echo

 head $DICT_FILE-diag.log

 exit 1

fi

DictObjFileCreator -dictSdbFile $DICT_PREFIX.sdb -o $DICT_PREFIX.odb
Dict2XMLSchema -dictName $DICT_FILE -df $DICT_PREFIX.odb -ns $NAME_SPACE -prefix $DICT_PREFIX

rm -f $DICT_PREFIX.sdb $DICT_PREFIX.odb

if [ -e $DICT_FILE ] ; then

 arg=(`grep dictionary.version $DICT_FILE`)
 DICT_VER=${arg[1]}
 DICT_MAJOR_VER=${DICT_VER%%.*}

fi

pattern=3,4s/$DICT_PREFIX.xsd/$DICT_PREFIX-v$DICT_MAJOR_VER.xsd/

sed '2,6d' $DICT_PREFIX-v$DICT_VER.xsd | sed $pattern > $DICT_PREFIX.xsd~

SAXON=../extlibs/saxon9he.jar

if [ ! -e $SAXON ] ; then
 (cd ..; ./scripts/update_extlibs.sh)
fi

APPEND_SOURCE_XSL=../stylesheet/append_source.xsl

pdbx_xsd_file=../resource/pdbx-v50.xsd

java -jar $SAXON -s:$DICT_PREFIX.xsd~ -xsl:$APPEND_SOURCE_XSL -o:$DICT_PREFIX-v$DICT_VER.xsd pdbx_xsd_file=$pdbx_xsd_file

rm -f $DICT_PREFIX.xsd~ $DICT_PREFIX-v$DICT_MAJOR_VER.xsd

ln -s $DICT_PREFIX-v$DICT_VER.xsd $DICT_PREFIX-v$DICT_MAJOR_VER.xsd

echo Generated: $DICT_PREFIX-v$DICT_MAJOR_VER.xsd

# Generate wwPDB/OWL-validation

PDBXV2OWL_XSL=../stylesheet/pdbxv2owl.xsl

java -jar $SAXON -s:$DICT_PREFIX-v$DICT_MAJOR_VER.xsd -xsl:$PDBXV2OWL_XSL -o:$DICT_PREFIX-v$DICT_VER.owl

rm -f $DICT_PREFIX-v$DICT_MAJOR_VER.owl

ln -s $DICT_PREFIX-v$DICT_VER.owl $DICT_PREFIX-v$DICT_MAJOR_VER.owl

echo Generated: $DICT_PREFIX-v$DICT_MAJOR_VER.owl

# Generate HTML representation of PDBML-validation Schema

XS3P_XSLT_CODE=../stylesheet/xs3p.xsl

java -jar $SAXON -s:$DICT_PREFIX-v$DICT_MAJOR_VER.xsd -xsl:$XS3P_XSLT_CODE -o:$DICT_PREFIX-v$DICT_MAJOR_VER.html

echo Generated: $DICT_PREFIX-v$DICT_MAJOR_VER.html


