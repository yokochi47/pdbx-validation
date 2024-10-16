#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $PDBML2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

#if [ ! -e $PDBX_PRIMITIVE_TYPE_MAPPING_XML ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2PRIMITIVE_TYPE_MAPPING_XSL -o:$PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )

 echo Generated: $PDBX_PRIMITIVE_TYPE_MAPPING_XML

#fi

#if [ ! -e $MERGE_PDBML_SIFTS_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2MERGE_PDBML_SIFTS_XSL -o:$MERGE_PDBML_SIFTS_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $MERGE_PDBML_SIFTS_XSL

#fi

#if [ ! -e $MERGE_PDBML_NEXTGEN_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2MERGE_PDBML_NEXTGEN_XSL -o:$MERGE_PDBML_NEXTGEN_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $MERGE_PDBML_NEXTGEN_XSL

#fi

#if [ ! -e $PDBML2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $PDBML2RDF_XSL

#fi

get_resource() {

 pdb_id=$1

 if [[ $pdb_id =~ [0-9][0-9a-z]{3} ]] ; then

   pdbml_file=$WORK_DIR/$PDBML/$pdb_id-noatom.xml
   sifts_xml_file=$WORK_DIR/$SIFTS_XML/$pdb_id.xml
   pdbml_nextgen_file=$WORK_DIR/$NEXTGEN/$NEXTGEN_FILE_PREFIX$pdb_id$NEXTGEN_FILE_SUFFIX.xml

   if [ ! -e $pdbml_file ] ; then

    wget ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/$pdb_id-noatom.xml.gz -P $WORK_DIR/pdbml; gunzip $pdbml_file.gz

   fi

   if [ ! -e $sifts_xml_file ] ; then

    wget ftp://$SIFTS_XML_URL/$pdb_id.xml.gz -P $WORK_DIR/$SIFTS_XML; gunzip $sifts_xml_file.gz

   fi

   if [ ! -e $pdbml_nextgen_file ] ; then

    wget https://files-nextgen.wwpdb.org/pdb_nextgen/data/entries/divided/${pdb_id:1:2}/$NEXTGEN_FILE_PREFIX$pdb_id/$NEXTGEN_FILE_PREFIX$pdb_id$NEXTGEN_FILE_SUFFIX.xml.gz -P $WORK_DIR/nextgen; gunzip $pdbml_nextgen_file

   fi

 fi

}

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

# PDB/RDF

WORK_DIR=test

for arg ; do

 pdb_id=${arg,,}

 get_resource $pdb_id

done

mkdir -p $WORK_DIR/$PDBML_SIFTS
mkdir -p $WORK_DIR/$RDF

for pdbml_file in $WORK_DIR/$PDBML/*.xml ; do

 pdb_id=`basename $pdbml_file -noatom.xml`

 get_resource $pdb_id

 #exptl_method=`java -jar $SAXON -s:$pdbml_file -xsl:stylesheet/exptl_method.xsl`
 exptl_method=`xsltproc stylesheet/exptl_method.xsl $pdbml_file`
 #has_glycan=`java -jar $SAXON -s:$pdbml_file -xsl:$PDBML2WURCS_XSL`
 has_glycan=`xsltproc $PDBML2WURCS_XSL $pdbml_file`

 echo
 echo Processing PDB ID: ${pdb_id^^}, "Exptl. method: "$exptl_method" ..."

 sifts_xml_file=$WORK_DIR/$SIFTS_XML/$pdb_id.xml
 pdbml_nextgen_file=$WORK_DIR/$NEXTGEN/$NEXTGEN_FILE_PREFIX$pdb_id$NEXTGEN_FILE_SUFFIX.xml
 pdbml_sifts_file=$WORK_DIR/$PDBML_SIFTS/$pdb_id-noatom-sifts.xml

 if [ $PREFER_SIFTS = "true" ] ; then

  #xsltproc stylesheet/check_sifts.xsl $sifts_xml_file
  #echo

  if [ -e $sifts_xml_file ] && [ -s $sifts_xml_file ] ; then
   xsltproc -o $pdbml_sifts_file --stringparam sifts_file ../$sifts_xml_file $MERGE_PDBML_SIFTS_XSL $pdbml_file
   #java -jar $SAXON -s:$pdbml_file -xsl:$MERGE_PDBML_SIFTS_XSL -o:$pdbml_sifts_file sifts_file=../$sifts_xml_file

   echo " generated: "$pdbml_sifts_file

  else
   cp -f $pdbml_file $pdbml_sifts_file
  fi

 else
  if [ -e $pdbml_nextgen_file ] && [ -s $sifts_xml_file ] ; then
   xsltproc -o $pdbml_sifts_file --stringparam nextgen_file ../$pdbml_nextgen_file $MERGE_PDBML_NEXTGEN_XSL $pdbml_file
   #java -jar $SAXON -s:$pdbml_file -xsl:$MERGE_PDBML_NEXGEN_XSL -o:$pdbml_sifts_file nextgen_file=../$pdbml_nextgen_file

   echo " generated: "$pdbml_sifts_file

  else
   cp -f $pdbml_file $pdbml_sifts_file
  fi

 fi

 rdf_file=$WORK_DIR/$RDF/$pdb_id.rdf

 #if [ -z "$has_glycan" ] ; then
  xsltproc -o $rdf_file --stringparam wurcs2glytoucan $WURCS_CATALOG_XML --stringparam primitive_type_mapping $_PDBX_PRIMITIVE_TYPE_MAPPING_XML $PDBML2RDF_XSL $pdbml_sifts_file
 #else
 # java -jar $SAXON -s:$pdbml_sifts_file -xsl:$PDBML2RDF_XSL -o:$rdf_file wurcs2glytoucan=$WURCS_CATALOG_XML primitive_type_mapping=$_PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )
 #fi

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. ; exit 1 )
  echo " validated: "$rdf_file
 fi

 xml_pretty $rdf_file

done

echo
echo Done.

