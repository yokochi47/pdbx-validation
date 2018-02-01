#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

VALIDATE_OPT=

ARGV=`getopt --long -o "v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -v)
  VALIDATE_OPT=$1
 ;;
 *)
  break
 ;;
 esac
 shift
done

SAXON=extlibs/saxon9he.jar
XSD2PGSCHEMA=extlibs/xsd2pgschema.jar

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

PDBX_VALIDATION_XSD=schema/pdbx-validation-v0.xsd

XSD2EXT_PDBML_XSL=stylesheet/xsd2extract_pdbml.xsl
XSD2EXT_PDBML_XSL_ERR=xsd2extract_pdbml.err

EXT_PDBML_XSL=stylesheet/extract_pdbml.xsl

if [ ! -e $EXT_PDBML_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2EXT_PDBML_XSL -o:$EXT_PDBML_XSL 2> $XSD2EXT_PDBML_XSL_ERR

 if [ $? = 0 ] ; then
  rm -f $XSD2EXT_PDBML_XSL_ERR
 else
  cat $XSD2EXT_PDBML_XSL_ERR
  exit 1
 fi

echo
echo Generated $EXT_PDBML_XSL

fi

PDBML_EXT=pdbml_ext

mkdir -p $PDBML_EXT

PDBML_DIR=pdbml

if [ ! -d $PDBML_DIR ] ; then
 ./scripts/update_pdbml.sh
fi

VALID_INFO_DIR=validation_info

if [ ! -d $VALID_INFO_DIR ] ; then
 ./scripts/update_validation.sh
fi

echo
echo Extracting PDBML...

pdbml_file_list=pdbml_file_list

find $PDBML_DIR -name '*.xml' > $pdbml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/extract_pdbml_worker.sh -d $PDBML_EXT -e $VALID_INFO_DIR -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALIDATE_OPT &

done

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

wait

echo

rm -f $pdbml_file_list

echo $PDBML_EXT is update.

