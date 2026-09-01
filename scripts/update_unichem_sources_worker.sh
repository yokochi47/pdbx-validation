#!/bin/bash

source ./scripts/env.sh

WORK_DIR=
FILE_LIST=
TOTAL=

ARGV=`getopt --long -o "d:l:n:t:" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  WORK_DIR=$2
  shift
 ;;
 -l)
  FILE_LIST=$2
  shift
 ;;
 -n)
  PROC_INFO=$2
  shift
 ;;
 -t)
  TOTAL=$2
  shift
 ;;
 *)
  break
 ;;
 esac
 shift
done

if ! [[ $PROC_INFO =~ .*of.* ]] ; then

 echo "Invalid thread id ($PROC_INFO)."
 exit 1

fi

MAXPROCS=`echo $PROC_INFO | cut -d 'f' -f 2`
PROC_ID=`echo $PROC_INFO | cut -d 'o' -f 1`
PROC_ID=$(($PROC_ID - 1))

# TOTAL=`wc -l < $FILE_LIST`

proc_id=0

while read pdbml_file
do

 proc_id_mod=$(($proc_id % $MAXPROCS))

 if [ $proc_id_mod = $PROC_ID ] ; then

  if [ ! -e $pdbml_file ] ; then

   let proc_id++
   continue

  fi

  cc_id=`basename $pdbml_file .xml`

  com_file=$WORK_DIR/$cc_id.com
  json_file=$WORK_DIR/$cc_id.json
  xml_file=$WORK_DIR/$cc_id.xml
  err_file=$WORK_DIR/$cc_id.err
  ign_file=$WORK_DIR/$cc_id.ign
  rdf_gz_file=$RDF_CC/${cc_id:-1}/$cc_id.rdf.gz

  if [ -e $ign_file ] ; then

   let proc_id++
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

 fi

 let proc_id++

done < $FILE_LIST

