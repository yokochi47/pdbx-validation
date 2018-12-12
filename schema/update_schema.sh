#!/bin/sh

if [ ! `which DictToSdb` ] || [ ! `which Dict2XMLSchema` ] || [ ! `which Dict2XMLSchema` ]; then

 echo "Please install MMCIF Dictionary Suite (http://sw-tools.pdb.org/)."
 exit 1

fi

which DictToSdb
which Dict2XMLSchema
which Dict2XMLSchema

DDL_FILE=mmcif_ddl.dic
DIC_FILE=mmcif_pdbx_validation.dic

DIC_PREFIX=pdbx-validation
NAME_SPACE=PDBxv

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

# .sdb and .odb are used for conversion between mmCIF and PDBML
#rm -f $DIC_PREFIX.sdb $DIC_PREFIX.odb

if [ -e $DIC_FILE ] ; then

 arg=(`grep dictionary.version $DIC_FILE`)
 DIC_VER=${arg[1]}
 DIC_MAJOR_VER=${DIC_VER%%.*}

fi

sed -i -e "s/xsd:integer/xsd:int/g" $DIC_PREFIX-v$DIC_VER.xsd

pattern=3,4s/$DIC_PREFIX.xsd/$DIC_PREFIX-v$DIC_MAJOR_VER.xsd/

sed '2,6d' $DIC_PREFIX-v$DIC_VER.xsd | sed $pattern > $DIC_PREFIX.xsd~

SAXON=../extlibs/saxon9he.jar

if [ ! -e $SAXON ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

APPEND_XSD_XSL=../stylesheet/append_xsd.xsl

pdbx_xsd_file=../resource/pdbx-v50.xsd

java -jar $SAXON -s:$DIC_PREFIX.xsd~ -xsl:$APPEND_XSD_XSL -o:$DIC_PREFIX-v$DIC_VER.xsd pdbx_xsd_file=$pdbx_xsd_file

rm -f $DIC_PREFIX.xsd~ $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

ln -s $DIC_PREFIX-v$DIC_VER.xsd $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

echo Generated: $DIC_PREFIX-v$DIC_MAJOR_VER.xsd

# Convert tagmap.csv to tagmap.xml

TAGMAP2XML_XSL=../stylesheet/tagmap2xml.xsl
tagmap_csv_file=../schema/tagmap.csv
tagmap_xml_file=tagmap.xml

java -jar $SAXON -it:main -xsl:$TAGMAP2XML_XSL -o:$tagmap_xml_file tagmap_csv_file=$tagmap_csv_file

# Generate wwPDB/OWL-validation

PDBXV2OWL_XSL=../stylesheet/pdbxv2owl.xsl

pdbx_owl_file=../resource/pdbx-v50.owl

tagmap_xml_file=../schema/$tagmap_xml_file

java -jar $SAXON -s:$DIC_PREFIX-v$DIC_MAJOR_VER.xsd -xsl:$PDBXV2OWL_XSL -o:$DIC_PREFIX-v$DIC_VER.owl pdbx_owl_file=$pdbx_owl_file tagmap_xml_file=$tagmap_xml_file

rm -f $DIC_PREFIX-v$DIC_MAJOR_VER.owl

ln -s $DIC_PREFIX-v$DIC_VER.owl $DIC_PREFIX-v$DIC_MAJOR_VER.owl

echo Generated: $DIC_PREFIX-v$DIC_MAJOR_VER.owl

# Generate HTML representation of PDBML-validation Schema

XS3P_XSLT_CODE=../stylesheet/xs3p.xsl

java -jar $SAXON -s:$DIC_PREFIX-v$DIC_MAJOR_VER.xsd -xsl:$XS3P_XSLT_CODE -o:$DIC_PREFIX-v$DIC_MAJOR_VER.html

echo Generated: $DIC_PREFIX-v$DIC_MAJOR_VER.html

