#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_XSD=resource/pdbx-v50.xsd
PDBX2PDBML2RDF_XSL=stylesheet/pdbx2pdbml2rdf.xsl
PDBML2RDF_XSL=stylesheet/pdbml2rdf.xsl

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

RDF=RDF

mkdir -p $WORK_DIR/$RDF

for pdbml_file in $WORK_DIR/$PDBML/*.xml ; do

 pdbid=`basename $pdbml_file -noatom.xml`

 exptl_method=`java -jar $SAXON -s:$pdbml_file -xsl:stylesheet/exptl_method.xsl`
 wurcs_array=(`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`)

 if [ ! -z $wurcs_array ] ; then

  temp_file=`mktemp`

  echo '<mapping>' > $temp_file

  for wurcs in ${wurcs_array[@]} ; do
    glytoucan=`grep -F "$wurcs" $GLYTOUCAN_TSV 2> /dev/null | cut -f 2 2> /dev/null | xargs`
    echo '<wurcs id="'$wurcs'">'$glytoucan'</wurcs>' >> $temp_file
  done

  echo '</mapping>' >> $temp_file

 fi

 echo
 echo Processing PDB ID: ${pdbid^^}, "Exptl. method: "$exptl_method" ..."

 rdf_file=$WORK_DIR/$RDF/$pdbid.rdf

 if [ ! -z $wurcs_array ] ; then

  java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$temp_file || ( echo $0 aborted. && exit 1 )

  rm -f $temp_file

 else

  java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2RDF_XSL -o:$rdf_file || ( echo $0 aborted. && exit 1 )

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

