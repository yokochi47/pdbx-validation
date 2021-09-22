#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $PDBML2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

err=pdbx2pdbml2rdf.err

if [ ! -e $PDBML2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2PDBML2RDF_XSL -o:$PDBML2RDF_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $PDBML2RDF_XSL

fi

if [ ! -d $SIFTS_XML ] ; then
 ./scripts/update_sifts.sh
fi

if [ ! -d $PDBML_NOATOM ] ; then
 ./scripts/update_pdbml.sh
fi

if [ ! -d $PDBML_NOATOM_SIFTS ] ; then
 ./scripts/merge_pdbml_sifts.sh
fi

mkdir -p $RDF

last=`find $RDF -maxdepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
#total=`find $PDBML_NOATOM -maxdepth 2 -name '*-noatom.xml.gz' | wc -l 2> /dev/null`
total=`find $PDBML_NOATOM_SIFTS -maxdepth 2 -name '*-noatom-sifts.xml.gz' | wc -l 2> /dev/null`
err=`find $RDF -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML to PDB/RDF...

 pdbml_file_list=pdbml_to_rdf_pdb_file_list

 #find $PDBML_NOATOM -maxdepth 2 -name '*-noatom.xml.gz' > $pdbml_file_list
 find $PDBML_NOATOM_SIFTS -maxdepth 2 -name '*-noatom-sifts.xml.gz' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_pdb_worker.sh -d $RDF -l $pdbml_file_list -n $proc_id"of"$MAXPROCS &

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

