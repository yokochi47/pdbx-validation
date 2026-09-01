#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

#if [ ! -e $PDBX_PRIMITIVE_TYPE_MAPPING_XML ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2PRIMITIVE_TYPE_MAPPING_XSL -o:$PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )

 echo Generated: $PDBX_PRIMITIVE_TYPE_MAPPING_XML

#fi

#if [ ! -e $CC2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2CC2RDF_XSL -o:$CC2RDF_XSL || ( echo $0 aborted. ; exit 1 )

 echo Generated: $CC2RDF_XSL

#fi

xml_pretty() {

 if [ $has_xmllint_command != "false" ] ; then
  xmllint --format $1 > $1~ ; mv -f $1~ $1
 fi

}

WORK_DIR=test

# chem_comp/RDF

mkdir -p $WORK_DIR/$RDF_CC
mkdir -p $WORK_DIR/$UNICHEM_SRCS

for pdbml_file in $WORK_DIR/$XML_CC/*.xml ; do

 cc_id=`basename $pdbml_file .xml`

 echo
 echo Processing Chem comp ID: ${cc_id^^}" ..."

 rdf_file=$WORK_DIR/$RDF_CC/$cc_id.rdf

 inchikey=`xsltproc $INCHIKEY_DESC_XSL $pdbml_file`

 echo InChIKey: $inchikey

 com_file=$WORK_DIR/$UNICHEM_SRCS/$cc_id.com
 uc_json_file=$WORK_DIR/$UNICHEM_SRCS/$cc_id.json
 uc_xml_file=$WORK_DIR/$UNICHEM_SRCS/$cc_id.xml
 err_file=$WORK_DIR/$UNICHEM_SRCS/$cc_id.err
 ign_file=$WORK_DIR/$UNICHEM_SRCS/$cc_id.ign

 if [ ! -e $uc_json_file ] && [ ! -e $ign_file ] ; then

  echo "#!/bin/bash" > $com_file
  echo curl -X POST \"$UNICHEM_API\" -H \"accept: application/json\" -H \"Content-Type: application/json\" -d \"\{\\\"compound\\\":\\\"$inchikey\\\",\\\"type\\\":\\\"inchikey\\\"\}\" -s >> $com_file
  chmod +x $com_file

  ./$com_file > $uc_json_file 2> $err_file && ( rm -f $com_file $err_file ) || ( rm -f $com_file $uc_json_file; cat $err_file )

  if [ -e $uc_json_file ] && [ ! -e $err_file ] ; then

   test1=`grep "Something has gone wrong" $uc_json_file 2> /dev/null`

   if [ $? = 0 ] ; then
    echo $test1 > $err_file
    rm -f $uc_json_file

    sleep 2

   else

    test2=`grep "Not found" $uc_json_file 2> /dev/null`

    if [ $? = 0 ] ; then
     echo $test2 > $err_file
     rm -f $uc_json_file

     sleep 1

    else
     rm -f $rdf_file
    fi

   fi

  fi

 fi

 if [ ! -e $uc_json_file ] && [ ! -e $ign_file ] ; then

  inchi=`xsltproc $INCHI_DESC_XSL $pdbml_file`

  echo "#!/bin/bash" > $com_file
  echo curl -X POST \"$UNICHEM_API\" -H \"accept: application/json\" -H \"Content-Type: application/json\" -d \"\{\\\"compound\\\":\\\"$inchi\\\",\\\"type\\\":\\\"inchi\\\"\}\" -s >> $com_file
  chmod +x $com_file

  ./$com_file > $uc_json_file 2> $err_file && ( rm -f $com_file $err_file ) || ( rm -f $com_file $uc_json_file; cat $err_file )

  if [ -e $uc_json_file ] && [ ! -e $err_file ] ; then

   test1=`grep "Something has gone wrong" $uc_json_file 2> /dev/null`

   if [ $? = 0 ] ; then
    echo $test1 > $err_file
    rm -f $uc_json_file

    touch $ign_file

    sleep 2

   else

    test2=`grep "Not found" $uc_json_file 2> /dev/null`

    if [ $? = 0 ] ; then
     echo $test2 > $err_file
     rm -f $uc_json_file

     touch $ign_file

     sleep 1

    else
     rm -f $rdf_file
    fi

   fi

  fi

 fi

 if [ -e $uc_json_file ] && [ ! -e $uc_xml_file ] ; then
  python -c "import json, dicttoxml; print(dicttoxml.dicttoxml(json.load(open('$uc_json_file'))).decode())" > $uc_xml_file
 fi

 if [ -e $uc_xml_file ] ; then

  #java -jar $SAXON -s:$pdbml_file -xsl:$CC2RDF_XSL -o:$rdf_file unichem_xml=../$uc_xml_file primitive_type_mapping=$_PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )
  xsltproc -o $rdf_file --stringparam unichem_xml ../$uc_xml_file --stringparam primitive_type_mapping $_PDBX_PRIMITIVE_TYPE_MAPPING_XML $CC2RDF_XSL $pdbml_file || ( echo $0 aborted. ; exit 1 )

 else

  #java -jar $SAXON -s:$pdbml_file -xsl:$CC2RDF_XSL -o:$rdf_file primitive_type_mapping=$_PDBX_PRIMITIVE_TYPE_MAPPING_XML || ( echo $0 aborted. ; exit 1 )
  xsltproc -o $rdf_file --stringparam primitive_type_mapping $_PDBX_PRIMITIVE_TYPE_MAPPING_XML $CC2RDF_XSL $pdbml_file || ( echo $0 aborted. ; exit 1 )

 fi

 echo " generated: "$rdf_file

 if [ $has_rapper_command != "false" ] ; then
  rapper -q -c $rdf_file 2> /dev/null || ( echo $0 aborted. ; exit 1 )
  echo " validated: "$rdf_file
 fi

 #xml_pretty $rdf_file

done

echo
echo Done.

