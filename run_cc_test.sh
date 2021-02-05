#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $CC2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

if [ ! -e $CC2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2CC2RDF_XSL -o:$CC2RDF_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $CC2RDF_XSL

fi

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

WORK_DIR=test

# chem_comp/RDF

mkdir -p $WORK_DIR/$COMPONENTS_RDF

for pdbml_file in $WORK_DIR/$COMPONENTS_XML/*.xml ; do

 ccid=`basename $pdbml_file .xml`

 echo
 echo Processing Chem comp ID: ${ccid^^}" ..."

 rdf_file=$WORK_DIR/$COMPONENTS_RDF/$ccid.rdf

 #java -jar $SAXON -s:$pdbml_file -xsl:$CC2RDF_XSL -o:$rdf_file || ( echo $0 aborted. ; exit 1 )
 xsltproc -o $rdf_file $CC2RDF_XSL $pdbml_file || ( echo $0 aborted. ; exit 1 )

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. ; exit 1 )
  echo " validated: "$rdf_file
 fi

 #xml_pretty $rdf_file

done

echo
echo Done.

