#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $PRD2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

if [ ! -e $PRD2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PRD2RDF_XSL -o:$PRD2RDF_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $PRD2RDF_XSL

fi

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

WORK_DIR=test

# PRD/RDF

mkdir -p $WORK_DIR/$RDF_PRD

for pdbml_file in $WORK_DIR/$PDBML_PRD/*.xml ; do

 prdid=`basename $pdbml_file .xml`

 echo
 echo Processing PRD ID: ${prdid^^}" ..."

 rdf_file=$WORK_DIR/$RDF_PRD/$prdid.rdf

 xsltproc -o $rdf_file $PRD2RDF_XSL $pdbml_file || ( echo $0 aborted. ; exit 1 )

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. ; exit 1 )
  echo " validated: "$rdf_file
 fi

done

echo
echo Done.

