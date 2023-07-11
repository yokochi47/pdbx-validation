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

err=xsd2merge_pdbml_sifts.err

if [ ! -e $MERGE_PDBML_SIFTS_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$XSD2MERGE_PDBML_SIFTS_XSL -o:$MERGE_PDBML_SIFTS_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $MERGE_PDBML_SIFTS_XSL

fi

mkdir -p $PDBML_NOATOM_SIFTS

if [ ! -d $SIFTS_XML ] ; then
 ./scripts/update_sifts.sh
fi

if [ ! -d $PDBML_NOATOM ] ; then
 ./scripts/update_pdbml.sh
fi

last=`find $PDBML_NOATOM_SIFTS -maxdepth 2 -name '*.xml.gz' | wc -l 2> /dev/null`
err=`find $PDBML_NOATOM_SIFTS -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`
total=`find $PDBML_NOATOM -maxdepth 2 -name '*.xml.gz' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Merging PDBML and SIFTS...

 pdbml_file_list=merge_pdbml_file_list

 find $PDBML_NOATOM -maxdepth 2 -name '*-noatom.xml.gz' | sort -R > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/merge_pdbml_sifts_worker.sh -d $PDBML_NOATOM_SIFTS -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

else

 echo $PDBML_NOATOM_SIFTS is up-to-date.
 exit 2

fi

echo $PDBML_NOATOM_SIFTS is up-to-date.

