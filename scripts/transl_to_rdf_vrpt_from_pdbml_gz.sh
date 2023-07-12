#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_VALIDATION_XSD ] ; then
 ( cd schema; ./update_schema.sh )
fi

err=vrpt2pdbml2rdf.err

if [ ! -e $VRPTML2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBX_VALIDATION_XSD -xsl:$VRPTX2VRPTML2RDF_XSL -o:$VRPTML2RDF_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $VRPTML2RDF_XSL

fi

if [ ! -d $XML_VALID ] ; then
 ./scripts/merge_pdbml_info.sh
fi

mkdir -p $RDF_VALID

last=`find $RDF_VALID -mindepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
total=`find $XML_VALID -mindepth 2 -name '*.xml.gz' | wc -l 2> /dev/null`
err=`find $RDF_VALID -mindepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating compressed VRPT PDBML to VRPT/RDF...

 pdbml_file_list=pdbml_gz_to_rdf_file_list

 find $XML_VALID -mindepth 2 -name '*.xml.gz' > $pdbml_file_list

 rm -f $RDF_VALID/*.lock
 cat $pdbml_file_list | sort -R > $pdbml_file_list~

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_vrpt_from_pdbml_gz_worker.sh -d $RDF_VALID -l $pdbml_file_list -n $proc_id"of"$MAXPROCS -t $total &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list $pdbml_file_list~

fi

echo $RDF_VALID is up-to-date.

