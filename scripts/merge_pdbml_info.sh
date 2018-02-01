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

XSD2MRG_PDBML_INFO_XSL=stylesheet/xsd2merge_pdbml_info.xsl
XSD2MRG_PDBML_INFO_XSL_ERR=xsd2merge_pdbml_info.err

MRG_PDBML_INFO_XSL=stylesheet/merge_pdbml_info.xsl

if [ ! -e $MRG_PDBML_INFO_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2MRG_PDBML_INFO_XSL -o:$MRG_PDBML_INFO_XSL 2> $XSD2MRG_PDBML_INFO_XSL_ERR

 if [ $? = 0 ] ; then
  rm -f $XSD2MRG_PDBML_INFO_XSL_ERR
 else
  cat $XSD2MRG_PDBML_INFO_XSL_ERR
  exit 1
 fi

 echo
 echo Generated $EXT_PDBML_XSL

fi

PDBML_EXT_DIR=pdbml_ext

if [ ! -d $PDBML_EXT_DIR ] ; then
 ./scripts/extract_pdbml.sh
fi

VALID_INFO_EXT=validation_info_ext

if [ ! -d $VALID_INFO_EXT ] ; then
 ./scripts/extract_info.sh
fi

PDBML_VALIDATION=pdbml-validation

mkdir -p $PDBML_VALIDATION

echo
echo Merging PDBML and wwPDB Validation Information...

pdbml_file_list=pdbml_file_list

find $PDBML_EXT_DIR -name '*.xml' > $pdbml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/merge_pdbml_info_worker.sh -d $PDBML_VALIDATION -e $VALID_INFO_EXT -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALIDATE_OPT &

done

if [ $? != 0 ] ; then
 echo "$0 aborted."
 exit 1
fi

wait

echo

rm -f $pdbml_file_list

echo $PDBML_VALIDATION is update.

