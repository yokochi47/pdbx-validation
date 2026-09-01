#!/bin/bash

source ./scripts/env.sh

MTIME=
FULL=false

ARGV=`getopt --long -o "m:f" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -m)
  MTIME=$2
  shift
 ;;
 -f)
  FULL=true
 ;;
 *)
  break
 ;;
 esac
 shift
done

DB_NAME=UniChem

SRC_DIR=$XML_CC
UNICHEM_DIR=$UNICHEM_SRCS

weekday=`date -u +"%w"`

if [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -d $SRC_DIR ] ; then
 echo Not found $SRC_DIR.
 exit 1
fi

mkdir -p $UNICHEM_DIR

last=`find $UNICHEM_DIR -maxdepth 1 -name '*.json' | wc -l 2> /dev/null`
total=`find $SRC_DIR -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
err=`find $UNICHEM_DIR -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Querying UniChem using InChI code in chem_comp/XML...

 pdbml_file_list=pdbml_cc_file_list
 find $SRC_DIR -maxdepth 1 -name '*.xml' > $pdbml_file_list

 while read pdbml_file
 do

  cc_id=`basename $pdbml_file .xml`

  com_file=$UNICHEM_DIR/$cc_id.com
  json_file=$UNICHEM_DIR/$cc_id.json
  xml_file=$UNICHEM_DIR/$cc_id.xml
  err_file=$UNICHEM_DIR/$cc_id.err
  ign_file=$UNICHEM_DIR/$cc_id.ign
  rdf_gz_file=$RDF_CC/${cc_id:-1}/$cc_id.rdf.gz

  if [ -e $ign_file ] ; then
   continue
  fi

  if [ ! -e $json_file ] || [ -e $err_file ] ; then

   inchikey=`xsltproc $INCHIKEY_DESC_XSL $pdbml_file`

   echo $cc_id

   echo "#!/bin/bash" > $com_file
   echo curl -X POST \"$UNICHEM_API\" -H \"accept: application/json\" -H \"Content-Type: application/json\" -d \"\{\\\"compound\\\":\\\"$inchikey\\\",\\\"type\\\":\\\"inchikey\\\"\}\" -s >> $com_file
   chmod +x $com_file

   ./$com_file > $json_file 2> $err_file && ( rm -f $com_file $err_file ) || ( rm -f $com_file $json_file; cat $err_file )

   if [ -e $json_file ] && [ ! -e $err_file ] ; then

    test1=`grep "Something has gone wrong" $json_file 2> /dev/null`

    if [ $? = 0 ] ; then
     echo $test1 > $err_file
     rm -f $json_file

     sleep 2

    else

     test2=`grep "Not found" $json_file 2> /dev/null`

     if [ $? = 0 ] ; then
      echo $test2 > $err_file
      rm -f $json_file

      sleep 1

     else
      rm -f $rdf_gz_file
     fi

    fi

   fi

  fi

  if [ ! -e $json_file ] || [ -e $err_file ] ; then

   inchi=`xsltproc $INCHI_DESC_XSL $pdbml_file`

   echo "#!/bin/bash" > $com_file
   echo curl -X POST \"$UNICHEM_API\" -H \"accept: application/json\" -H \"Content-Type: application/json\" -d \"\{\\\"compound\\\":\\\"$inchi\\\",\\\"type\\\":\\\"inchi\\\"\}\" -s >> $com_file
   chmod +x $com_file

   ./$com_file > $json_file 2> $err_file && ( rm -f $com_file $err_file ) || ( rm -f $com_file $json_file; cat $err_file )

   if [ -e $json_file ] && [ ! -e $err_file ] ; then

    test1=`grep "Something has gone wrong" $json_file 2> /dev/null`

    if [ $? = 0 ] ; then
     echo $test1 > $err_file
     rm -f $json_file

     touch $ign_file

     sleep 2

    else

     test2=`grep "Not found" $json_file 2> /dev/null`

     if [ $? = 0 ] ; then
      echo $test2 > $err_file
      rm -f $json_file

      touch $ign_file

      sleep 1

     else
      rm -f $rdf_gz_file
     fi

    fi

   fi

  fi

  if [ -e $json_file ] && [ ! -e $xml_file ] ; then
   python -c "import json, dicttoxml; print(dicttoxml.dicttoxml(json.load(open('$json_file'))).decode())" > $xml_file
  fi

 done < $pdbml_file_list

fi

echo $SRC_DIR is up-to-date.

