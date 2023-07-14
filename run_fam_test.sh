#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

#if [ ! -e $PDBX_PRIMITIVE_TYPE_MAPPING_XML ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2PRIMITIVE_TYPE_MAPPING_XSL -o:$PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )

 echo Generated: $PDBX_PRIMITIVE_TYPE_MAPPING_XML

#fi

#if [ ! -e $FAM2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2FAM2RDF_XSL -o:$FAM2RDF_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $FAM2RDF_XSL

#fi

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

WORK_DIR=test

# FAM/RDF

mkdir -p $WORK_DIR/$RDF_FAM

for pdbml_file in $WORK_DIR/$PDBML_FAM/*.xml ; do

 fam_id=`basename $pdbml_file .xml`

 echo
 echo Processing FAM ID: ${fam_id^^}" ..."

 rdf_file=$WORK_DIR/$RDF_FAM/$fam_id.rdf

 xsltproc -o $rdf_file --stringparam primitive_type_mapping $_PDBX_PRIMITIVE_TYPE_MAPPING_XML $FAM2RDF_XSL $pdbml_file || ( echo $0 aborted. ; exit 1 )

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. ; exit 1 )
  echo " validated: "$rdf_file
 fi

done

echo
echo Done.

