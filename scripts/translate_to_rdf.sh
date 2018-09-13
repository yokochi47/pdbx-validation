#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

err=pdbxv2pdbmlv2rdf.err

if [ ! -e $PDBMLV2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$PDBXV2PDBMLV2RDF_XSL -o:$PDBMLV2RDF_XSL 2> $err || ( cat $err && exit 1 )

 rm -f $err

 echo
 echo Generated: $PDBMLV2RDF_XSL

fi

if [ ! -d $XML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

mkdir -p $RDF_VALID

last=`find $RDF_VALID -name '*.rdf' | wc -l`
err=`find $RDF_VALID -name '*.err' | wc -l`
total=`find $XML_VALID -name '*.xml' | wc -l`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML-validation to wwPDB/RDF-validation...

 pdbml_file_list=pdbml_file_list

 find $XML_VALID -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/translate_to_rdf_worker.sh -d $RDF_VALID -l $pdbml_file_list -n $proc_id"of"$MAXPROCS $VALID_OPT &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF_VALID is up-to-date.

