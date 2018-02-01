#!/bin/bash

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_VALIDATION_XSD=schema/pdbx-validation-v0.xsd

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl
EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl
EXT_INFO_XSL=stylesheet/extract_info.xsl
XSD2MERGE_PDBML_INFO_XSL=stylesheet/xsd2merge_pdbml_info.xsl
MERGE_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

if [ ! -e $EXT_PDBML_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2EXT_PDBML_XSL -o:$EXT_PDBML_XSL

 if [ $? = 0 ] ; then
  echo Generated: $EXT_PDBML_XSL
 else
  echo aborted.
  exit 1
 fi

fi

if [ ! -e $MERGE_PDBML_INFO_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2MERGE_PDBML_INFO_XSL -o:$MERGE_PDBML_INFO_XSL

 if [ $? = 0 ] ; then
  echo Generated: $MERGE_PDBML_INFO_XSL
 else
  echo aborted.
  exit 1
 fi

fi

WORK_DIR=test

PDBIDS=("5b1l" "5u9b" "5h0s")

mkdir -p $WORK_DIR/pdbml_ext
mkdir -p $WORK_DIR/validation_info_ext
mkdir -p $WORK_DIR/pdbml-validation

for pdbid in ${PDBIDS[@]} ; do

 pdbml_file=$WORK_DIR/pdbml/$pdbid"-noatom.xml"

 exptl_method=`java -jar $SAXON -s:$pdbml_file -xsl:stylesheet/exptl_method.xsl`

 echo
 echo Processing PDB ID: ${pdbid^^}, "Exerimental method: "$exptl_method" ..."

 pdbml_ext_file=$WORK_DIR/pdbml_ext/$pdbid-validation.xml
 info_file=../$WORK_DIR/validation_info/$pdbid"_validation.xml"

 java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=$info_file

 if [ $? = 0 ] ; then
  echo " extracted: "$pdbml_ext_file
 else
  echo aborted.
  exit 1
 fi

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null

 if [ $? != 0 ] ; then
  echo aborted.
  exit 1
 else
  echo " validated: "$pdbml_ext_file
 fi

 info_file=$WORK_DIR/validation_info/$pdbid"_validation.xml"
 info_ext_file=$WORK_DIR/validation_info_ext/$pdbid-validation.xml
 pdbml_ext_file=../$pdbml_ext_file # add relative path (../) from directory contains target styleseet

 java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_ext_file pdbml_ext_file=$pdbml_ext_file

 if [ $? = 0 ] ; then
  echo " extracted: "$info_ext_file
 else
  echo aborted.
  exit 1
 fi

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $info_ext_file > /dev/null

 if [ $? != 0 ] ; then
  echo aborted.
  exit 1
 else
  echo " validated: "$info_ext_file
 fi

 pdbml_ext_file=$WORK_DIR/pdbml_ext/$pdbid-validation.xml
 info_ext_file=../$info_ext_file # add relative path (../) from directory contains target stylesheet
 pdbml_validation_file=$WORK_DIR/pdbml-validation/$pdbid-validation.xml

 java -jar $SAXON -s:$pdbml_ext_file -xsl:$MERGE_PDBML_INFO_XSL -o:$pdbml_validation_file info_ext_file=$info_ext_file

 if [ $? = 0 ] ; then
  echo " merged   : "$pdbml_validation_file
 else
  echo aborted.
  exit 1
 fi

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_validation_file > /dev/null

 if [ $? != 0 ] ; then
  echo aborted.
  exit 1
 else
  echo " validated: "$pdbml_validation_file
 fi

done

echo
echo Done.

