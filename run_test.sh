#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

if [ ! -e $EXT_PDBML_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2EXT_PDBML_XSL -o:$EXT_PDBML_XSL || ( echo $0 aborted. && exit 1 )

 echo Generated: $EXT_PDBML_XSL

fi

if [ ! -e $MERGE_PDBML_INFO_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2MERGE_PDBML_INFO_XSL -o:$MERGE_PDBML_INFO_XSL || ( echo $0 aborted. && exit 1 )

 echo Generated: $MERGE_PDBML_INFO_XSL

fi

if [ ! -e $PDBMLV2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$PDBXV2PDBMLV2RDF_XSL -o:$PDBMLV2RDF_XSL || ( echo $0 aborted. && exit 1 )

 echo Generated: $PDBMLV2RDF_XSL

fi

if [ $has_xml2mmcif_command = "false" ] ; then

 echo "xml2mmcif: command not found..."
 echo "Please install PDBML2MMCIF (https://sw-tools.rcsb.org/apps/PDBML2CIF/index.html) to generate mmCIF version of wwPDB validation reports."

fi

WORK_DIR=test

for arg ; do

 pdbid=${arg,,}

 if [[ $pdbid =~ [0-9][0-9a-z]{3} ]] ; then

   pdbml_file=$WORK_DIR/$PDBML/$pdbid-noatom.xml
   info_file=$WORK_DIR/$VALID_INFO/$pdbid"_validation.xml"

   if [ ! -e $pdbml_file ] ; then

    wget ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/$pdbid-noatom.xml.gz -P $WORK_DIR/pdbml; gunzip $pdbml_file.gz

   fi

   if [ ! -e $info_file ] ; then

    wget ftp://ftp.wwpdb.org/pub/pdb/validation_reports/${pdbid:1:2}/$pdbid/$pdbid"_validation.xml.gz" -P $WORK_DIR/$VALID_INFO; gunzip $info_file.gz

   fi

 fi

done

mkdir -p $WORK_DIR/$PDBML_EXT
mkdir -p $WORK_DIR/$VALID_INFO_ALT
mkdir -p $WORK_DIR/$XML_VALID

if [ ! -d $WORK_DIR/$XML_VALID_ALT ] ; then
 ( cd $WORK_DIR; ln -s $VALID_INFO_ALT $XML_VALID_ALT )
fi

mkdir -p $WORK_DIR/$RDF_VALID
mkdir -p $WORK_DIR/$RDF_VALID_ALT

if [ $has_xml2mmcif_command != "false" ] ; then

 for dirname in $WORK_DIR/$XML_VALID $WORK_DIR/$XML_VALID_ALT ; do

  if [ ! -e $dirname/$pdbx_validation_xsd ] ; then
   ( cd $dirname; ln -s ../../$PDBX_VALIDATION_XSD . )
  fi

 done

 for dirname in $WORK_DIR/$MMCIF_VALID $WORK_DIR/$MMCIF_VALID_ALT ; do

  mkdir -p $dirname

  for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

   if [ ! -e $dirname/$dicfile ] ; then
    ( cd $dirname; ln -s ../../schema/$dicfile . )
   fi

  done

 done

fi

for pdbml_file in $WORK_DIR/$PDBML/*.xml ; do

 pdbid=`basename $pdbml_file -noatom.xml`

 exptl_method=`java -jar $SAXON -s:$pdbml_file -xsl:stylesheet/exptl_method.xsl`

 echo
 echo Processing PDB ID: ${pdbid^^}, "Exptl. method: "$exptl_method" ..."

 pdbml_ext_file=$WORK_DIR/$PDBML_EXT/$pdbid-noatom-ext.xml
 info_file=../$WORK_DIR/$VALID_INFO/$pdbid"_validation.xml"

 java -jar $SAXON -s:$pdbml_file -xsl:$EXT_PDBML_XSL -o:$pdbml_ext_file info_file=$info_file || ( echo $0 aborted. && exit 1 )

 echo " extracted: "$pdbml_ext_file

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_ext_file > /dev/null || ( echo $0 aborted. && exit 1 )

 echo " validated: "$pdbml_ext_file

 info_file=$WORK_DIR/$VALID_INFO/$pdbid"_validation.xml"
 info_alt_file=$WORK_DIR/$VALID_INFO_ALT/$pdbid-validation-alt.xml
 pdbml_ext_file=../$pdbml_ext_file # add relative path (../) from directory contains target styleseet

 java -jar $SAXON -s:$info_file -xsl:$EXT_INFO_XSL -o:$info_alt_file pdbml_ext_file=$pdbml_ext_file || ( echo $0 aborted. && exit 1 )

 echo " extracted: "$info_alt_file

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $info_alt_file > /dev/null || ( echo $0 aborted. && exit 1 )

 echo " validated: "$info_alt_file

 pdbml_ext_file=$WORK_DIR/$PDBML_EXT/$pdbid-noatom-ext.xml
 info_alt_file=../$info_alt_file # add relative path (../) from directory contains target stylesheet
 pdbml_valid_file=$WORK_DIR/$XML_VALID/$pdbid-validation-full.xml

 java -jar $SAXON -s:$pdbml_ext_file -xsl:$MERGE_PDBML_INFO_XSL -o:$pdbml_valid_file info_alt_file=$info_alt_file || ( echo $0 aborted. && exit 1 )

 echo " merged   : "$pdbml_valid_file

 java -classpath $XSD2PGSCHEMA xmlvalidator --xsd $PDBX_VALIDATION_XSD --xml $pdbml_valid_file > /dev/null || ( echo $0 aborted. && exit 1 )

 echo " validated: "$pdbml_valid_file

 rdf_valid_file=$WORK_DIR/$RDF_VALID/$pdbid-validation-full.rdf

 java -jar $SAXON -s:$pdbml_valid_file -xsl:$PDBMLV2RDF_XSL -o:$rdf_valid_file || ( echo $0 aborted. && exit 1 )

 echo " generated: "$rdf_valid_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_valid_file 2> /dev/null || ( echo $0 aborted. && exit 1 )
  echo " validated: "$rdf_valid_file
 fi

 info_alt_file=$WORK_DIR/$VALID_INFO_ALT/$pdbid-validation-alt.xml
 rdf_valid_alt_file=$WORK_DIR/$RDF_VALID_ALT/$pdbid-validation-alt.rdf

 java -jar $SAXON -s:$info_alt_file -xsl:$PDBMLV2RDF_XSL -o:$rdf_valid_alt_file || ( echo $0 aborted. && exit 1 )

 echo " generated: "$rdf_valid_alt_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_valid_alt_file 2> /dev/null || ( echo $0 aborted. && exit 1 )
  echo " validated: "$rdf_valid_alt_file
 fi

 if [ $has_xml2mmcif_command != "false" ] ; then

  pdbml_valid_file=$pdbid-validation-full.xml
  mmcif_valid_file=$pdbid-validation-full.cif

  ( cd $WORK_DIR/$MMCIF_VALID ; xml2mmcif -xml ../$XML_VALID/$pdbml_valid_file -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && mv ../$XML_VALID/$pdbml_valid_file.cif $mmcif_valid_file )

  if [ $? = 0 ] ; then
   echo " generated: "$WORK_DIR/$MMCIF_VALID/$mmcif_valid_file
  else
   exit 1
  fi

  if [ $has_cifcheck_command != "false" ] ; then

   diag_log=$mmcif_valid_file-diag.log
   parser_log=$mmcif_valid_file-parser.log

   rm -f $WORK_DIR/$MMCIF_VALID/$diag_log $WORK_DIR/$MMCIF_VALID/$parser_log

   ( cd $WORK_DIR/$MMCIF_VALID ; CifCheck -f $mmcif_valid_file -dictSdb $pdbx_validation_sdb > /dev/null ; [ -e $diag_log ] && [ `grep -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l` = 0 ] && rm -f $diag_log )
   ( cd $WORK_DIR/$MMCIF_VALID ; [ ! -e $diag_log ] && [ ! -e $parser_log ] && echo " validated: "$WORK_DIR/$MMCIF_VALID/$mmcif_valid_file || exit 1 )

  fi

  info_alt_file=$pdbid-validation-alt.xml
  mmcif_valid_alt_file=$pdbid-validation-alt.cif

  ( cd $WORK_DIR/$MMCIF_VALID_ALT ; xml2mmcif -xml ../$VALID_INFO_ALT/$info_alt_file -dict $pdbx_validation_dic -df $pdbx_validation_odb > /dev/null && mv ../$VALID_INFO_ALT/$info_alt_file.cif $mmcif_valid_alt_file )

  if [ $? = 0 ] ; then
   echo " generated: "$WORK_DIR/$MMCIF_VALID_ALT/$mmcif_valid_alt_file
  else
   exit 1
  fi

  if [ $has_cifcheck_command != "false" ] ; then

   diag_log=$mmcif_valid_alt_file-diag.log
   parser_log=$mmcif_valid_alt_file-parser.log

   rm -f $WORK_DIR/$MMCIF_VALID_ALT/$diag_log $WORK_DIR/$MMCIF_VALID_ALT/$parser_log

   ( cd $WORK_DIR/$MMCIF_VALID_ALT ; CifCheck -f $mmcif_valid_alt_file -dictSdb $pdbx_validation_sdb > /dev/null ; [ -e $diag_log ] && [ `grep -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l` = 0 ] && rm -f $diag_log )
   ( cd $WORK_DIR/$MMCIF_VALID_ALT ; [ ! -e $diag_log ] && [ ! -e $parser_log ] && echo " validated: "$WORK_DIR/$MMCIF_VALID_ALT/$mmcif_valid_alt_file || exit 1 )

  fi

fi

done

echo
echo Done.

