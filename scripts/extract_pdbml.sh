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

err=xsd2extract_pdbml.err

if [ ! -e $EXT_PDBML_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$XSD2EXT_PDBML_XSL -o:$EXT_PDBML_XSL 2> $err || ( cat $err && exit 1 )

 rm -f $err

 echo
 echo Generated: $EXT_PDBML_XSL

fi

mkdir -p $PDBML_EXT

if [ ! -d $PDBML ] ; then
 ./scripts/update_pdbml.sh
fi

if [ ! -d $VALID_INFO ] ; then
 ./scripts/update_validation.sh
fi

last=`find $PDBML_EXT -maxdepth 1 -name '*.xml' | wc -l`
err=`find $PDBML_EXT -maxdepth 1 -name '*.err' | wc -l`
total=`find $VALID_INFO -maxdepth 1 -name '*.xml' | wc -l`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Extracting PDBML...

 pdbml_file_list=extract_pdbml_file_list

 find $PDBML -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/extract_pdbml_worker.sh -d $PDBML_EXT -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

else

 echo $PDBML_EXT is up-to-date.
 exit 2

fi

echo $PDBML_EXT is up-to-date.

