#!/bin/bash

SAXON=../extlibs/saxon9he.jar

if [ ! -e $SAXON ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

PDBX_XSD=pdbx-v50.xsd

PDBX2OWL_XSL=../stylesheet/pdbx2owl.xsl
PDBX_OWL=pdbx-v50.owl

PDBX2PDBML2RDF_XSL=../stylesheet/pdbx2pdbml2rdf.xsl
PDBML2RDF_XSL=../stylesheet/pdbml2rdf.xsl

PDBX2CC2RDF_XSL=../stylesheet/pdbx2cc2rdf.xsl
CC2RDF_XSL=../stylesheet/cc2rdf.xsl

java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2OWL_XSL -o:$PDBX_OWL || ( echo aborted. && exit 1 )

echo Generated: $PDBX_OWL

java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $PDBML2RDF_XSL

java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2CC2RDF_XSL -o:$CC2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $CC2RDF_XSL

