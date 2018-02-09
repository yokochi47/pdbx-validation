#!/bin/bash

MAXPROCS=`cat /proc/cpuinfo 2> /dev/null | grep 'cpu cores' | wc -l`

if [ $MAXPROCS = 0 ] ; then
 MAXPROCS=1
fi

VALID_OPT=

ARGV=`getopt --long -o "v" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -v)
  VALID_OPT=$1
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

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 (cd schema; ./update_schema.sh)
fi

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
 echo Generated: $EXT_PDBML_XSL

fi

PDBML_EXT=pdbml-ext

mkdir -p $PDBML_EXT

PDBML=pdbml

if [ ! -d $PDBML ] ; then
 ./scripts/update_pdbml.sh
fi

VALID_INFO=validation_info

if [ ! -d $VALID_INFO ] ; then
 ./scripts/update_validation.sh
fi

echo
echo Extracting PDBML...

pdbml_file_list=pdbml_file_list

find $PDBML -name '*.xml' > $pdbml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/extract_pdbml_worker.sh -d $PDBML_EXT -e $VALID_INFO -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

done

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

wait

echo

rm -f $pdbml_file_list

echo $PDBML_EXT is up-to-date.

