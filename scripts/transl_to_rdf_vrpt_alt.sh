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

if [ ! -d $XML_VALID_ALT ] ; then
 ./scripts/extract_info.sh
fi

mkdir -p $RDF_VALID_ALT

last=`find $RDF_VALID_ALT -maxdepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
#total=`find $VALID_INFO_ALT -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
total=`find $XML_VALID_ALT -maxdepth 2 -name '*.xml.gz' | wc -l 2> /dev/null`
err=`find $RDF_VALID_ALT -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating VRPT PDBML-alt to VRPT/RDF-alt...

 pdbml_file_list=pdbml_to_rdf_alt_file_list

# find $VALID_INFO_ALT -maxdepth 1 -name '*.xml' > $pdbml_file_list
 find $XML_VALID_ALT -maxdepth 2 -name '*.xml.gz' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_vrpt_alt_worker.sh -d $RDF_VALID_ALT -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF_VALID_ALT is up-to-date.

