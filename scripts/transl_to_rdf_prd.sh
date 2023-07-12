#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $PRD2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

err=pdbx2prd2rdf.err

if [ ! -e $PRD2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PRD2RDF_XSL -o:$PRD2RDF_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $PRD2RDF_XSL

fi

if [ ! -d $PDBML_PRD ] ; then
 ./scripts/update_bird.sh
fi

mkdir -p $RDF_PRD

last=`find $RDF_PRD -maxdepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
total=`find $PDBML_PRD -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
err=`find $RDF_PRD -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML to PRD/RDF...

 pdbml_file_list=pdbml_to_rdf_prd_file_list

 find $PDBML_PRD -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_prd_worker.sh -d $RDF_PRD -l $pdbml_file_list -n $proc_id"of"$MAXPROCS -t $total &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF_PRD is up-to-date.

