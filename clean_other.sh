#!/bin/bash

PDBML2RDF_XSL=stylesheet/pdbml2rdf.xsl

rm -f $PDBML2RDF_XSL

WORK_DIR=test
RDF=RDF

rm -rf $WORK_DIR/RDF

if [ -e $GLYTOUCAN_TSV ] ; then

 echo "Do you want to update $GLYTOUCAN_TSV? (y [n]) "

 read ans

 case $ans in
  y*|Y*) ( cd wurcs2glytoucan; ./LocalGlyTouCanID > glytoucan.tsv );;
  *) exit 0;;
 esac

fi

