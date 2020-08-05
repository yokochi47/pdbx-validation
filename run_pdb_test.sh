#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_XSD ] || [ ! -e $PDBML2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

if [ ! -e $PDBML2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL || ( echo $0 aborted. && exit 1 )

 echo Generated: $PDBML2RDF_XSL

fi

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

# PDB/RDF

WORK_DIR=test

for arg ; do

 pdbid=${arg,,}

 if [[ $pdbid =~ [0-9][0-9a-z]{3} ]] ; then

   pdbml_file=$WORK_DIR/$PDBML/$pdbid-noatom.xml

   if [ ! -e $pdbml_file ] ; then

    wget ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/$pdbid-noatom.xml.gz -P $WORK_DIR/pdbml; gunzip $pdbml_file.gz

   fi

 fi

done

mkdir -p $WORK_DIR/$RDF

for pdbml_file in $WORK_DIR/$PDBML/*.xml ; do

 pdbid=`basename $pdbml_file -noatom.xml`

 #exptl_method=`java -jar $SAXON -s:$pdbml_file -xsl:stylesheet/exptl_method.xsl`
 exptl_method=`xsltproc stylesheet/exptl_method.xsl $pdbml_file`
 has_glycan=`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`

 echo
 echo Processing PDB ID: ${pdbid^^}, "Exptl. method: "$exptl_method" ..."

 rdf_file=$WORK_DIR/$RDF/$pdbid.rdf

 if [ -z "$has_glycan" ] ; then
  xsltproc -o $rdf_file --param wurcs2glytoucan $_GLYTOUCAN_XML $PDBML2RDF_XSL $pdbml_file
 else
  java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$GLYTOUCAN_XML || ( echo $0 aborted. && exit 1 )
 fi

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. && exit 1 )
  echo " validated: "$rdf_file
 fi

 xml_pretty $rdf_file

done

echo
echo Done.

