#!/bin/bash

source ../scripts/env.sh

SAXON=../$SAXON

if [ ! -e $SAXON ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

PDBML_XSD=pdbx-v50.xsd

PDBX2OWL_XSL=../stylesheet/pdbx2owl.xsl
PDBX_OWL=pdbx-v50.owl

PDBX2OWL_PREMERGE_XSL=../stylesheet/pdbx2owl_premerge.xsl
PDBX_PREMERGE_OWL=pdbx-v50_premerge.owl

PDBX2PDBML2RDF_XSL=../stylesheet/pdbx2pdbml2rdf.xsl
PDBML2RDF_XSL=../stylesheet/pdbml2rdf.xsl

PDBX2CC2RDF_XSL=../stylesheet/pdbx2cc2rdf.xsl
CC2RDF_XSL=../stylesheet/cc2rdf.xsl

PDBX2PRD2RDF_XSL=../stylesheet/pdbx2prd2rdf.xsl
PRD2RDF_XSL=../stylesheet/prd2rdf.xsl

PDBX2FAM2RDF_XSL=../stylesheet/pdbx2fam2rdf.xsl
FAM2RDF_XSL=../stylesheet/fam2rdf.xsl

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2OWL_XSL -o:$PDBX_OWL || ( echo aborted. && exit 1 )

echo Generated: $PDBX_OWL

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2OWL_PREMERGE_XSL -o:$PDBX_PREMERGE_OWL || ( echo aborted. && exit 1 )

echo Generated: $PDBX_PREMERGE_OWL

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $PDBML2RDF_XSL

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2CC2RDF_XSL -o:$CC2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $CC2RDF_XSL

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PRD2RDF_XSL -o:$PRD2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $PRD2RDF_XSL

java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2FAM2RDF_XSL -o:$FAM2RDF_XSL || ( echo $0 aborted. && exit 1 )

echo Generated: $FAM2RDF_XSL

java -jar $SAXON -s:$PDBML_XSD -xsl:../$XSD2MERGE_PDBML_SIFTS_XSL -o:../$MERGE_PDBML_SIFTS_XSL || ( echo $0 aborted. ; exit 1 )

echo Generated: ../$MERGE_PDBML_SIFTS_XSL

java -jar $SAXON -s:$PDBML_XSD -xsl:../$XSD2MERGE_PDBML_NEXTGEN_XSL -o:../$MERGE_PDBML_NEXTGEN_XSL || ( echo $0 aborted. ; exit 1 )

echo Generated: ../$MERGE_PDBML_NEXTGEN_XSL

rm -f mmcif_ddl.dic-parser.log

