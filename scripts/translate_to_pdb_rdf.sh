#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBX_XSD ] || [ ! -e $PDBML2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

err=pdb2pdbml2rdf.err

if [ ! -e $PDBM2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBX_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL 2> $err || ( cat $err && exit 1 )

 rm -f $err

 echo
 echo Generated: $PDBML2RDF_XSL

fi

if [ ! -d $PDBML ] ; then
 ./scripts/update_pdbml.sh
fi

mkdir -p $RDF

last=`find $RDF -maxdepth 1 -name '*.rdf' | wc -l`
total=`find $PDBML -maxdepth 1 -name '*.xml' | wc -l`
err=`find $RDF -maxdepth 1 -name '*.err' | wc -l`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML to wwPDB/RDF...

 pdbml_file_list=pdbml_to_pdb_rdf_file_list

 find $PDBML -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/translate_to_pdb_rdf_worker.sh -d $RDF -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF is up-to-date.

