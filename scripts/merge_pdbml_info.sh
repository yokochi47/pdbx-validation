#!/bin/bash

source ./scripts/env.sh

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

if [ ! -e $SAXON ] || [ ! -e $XSD2PGSCHEMA ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

err=xsd2merge_pdbml_info.err

if [ ! -e $MERGE_PDBML_INFO_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2MERGE_PDBML_INFO_XSL -o:$MERGE_PDBML_INFO_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $EXT_PDBML_XSL

fi

if [ ! -d $PDBML_EXT ] ; then
 ./scripts/extract_pdbml.sh
fi

if [ ! -d $XML_VALID_ALT ] ; then
 ./scripts/extract_info.sh
fi

mkdir -p $XML_VALID

last=`find $XML_VALID -maxdepth 2 -name '*.xml.gz' | wc -l 2> /dev/null`
err=`find $XML_VALID -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`
total=`find $PDBML_EXT -maxdepth 1 -name '*.xml.gz' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Merging PDBML and wwPDB Validation Information...

 pdbml_file_list=merge_pdbml_file_list

 find $PDBML_EXT -maxdepth 1 -name '*.xml.gz' > $pdbml_file_list

 rm -f $XML_VALID/*.lock
 cat $pdbml_file_list | sort -R > $pdbml_file_list~

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/merge_pdbml_info_worker.sh -d $XML_VALID -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT -t $total &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list $pdbml_file_list~

fi

echo $XML_VALID is up-to-date.

