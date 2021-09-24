#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $CC2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

err=pdbx2cc2rdf.err

if [ ! -e $CC2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2CC2RDF_XSL -o:$CC2RDF_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $CC2RDF_XSL

fi

#if [ ! -d $PDBML_CC ] ; then
# ./scripts/update_cc.sh
#fi

if [ ! -d $XML_CC ] ; then
 ./scripts/update_cc.sh
fi

mkdir -p $RDF_CC

last=`find $RDF_CC -maxdepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
#total=`find $PDBML_CC -maxdepth 1 -name '*.xml.gz' | wc -l 2> /dev/null`
total=`find $XML_CC -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
err=`find $RDF_CC -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML to chem_comp/RDF...

 pdbml_file_list=pdbml_to_rdf_cc_file_list

 #find $PDBML_CC -maxdepth 1 -name '*.xml.gz' > $pdbml_file_list
 find $XML_CC -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_cc_worker.sh -d $RDF_CC -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF_CC is up-to-date.

