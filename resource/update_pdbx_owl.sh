#!/bin/bash

SAXON=../extlibs/saxon9he.jar

if [ ! -e $SAXON ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

PDBX_XSD=pdbx-v50.xsd
PDBX2OWL_XSL=../stylesheet/pdbx2owl.xsl
PDBX_OWL=pdbx-v50.owl

java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2OWL_XSL -o:$PDBX_OWL

if [ $? = 0 ] ; then
 echo Generated: $PDBX_OWL
else
 echo aborted.
 exit 1
fi

