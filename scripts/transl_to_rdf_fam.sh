#!/bin/bash

source ./scripts/env.sh

if [ ! -e $SAXON ] ; then
 ./scripts/update_extlibs.sh
fi

if [ ! -e $PDBML_XSD ] || [ ! -e $FAM2RDF_XSL ] ; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

err=pdbx2fam2rdf.err

if [ ! -e $FAM2RDF_XSL ] ; then

 java -jar $SAXON -s:$PDBML_XSD -xsl:$PDBX2FAM2RDF_XSL -o:$FAM2RDF_XSL 2> $err || ( cat $err ; exit 1 )

 rm -f $err

 echo
 echo Generated: $FAM2RDF_XSL

fi

if [ ! -d $PDBML_FAM ] ; then
 ./scripts/update_bird.sh
fi

mkdir -p $RDF_FAM

last=`find $RDF_FAM -maxdepth 2 -name '*.rdf.gz' | wc -l 2> /dev/null`
total=`find $PDBML_FAM -maxdepth 1 -name '*.xml' | wc -l 2> /dev/null`
err=`find $RDF_FAM -maxdepth 1 -name '*.err' | wc -l 2> /dev/null`

if [ $err != 0 ] || [ $total != $last ] ; then

 echo
 echo Translating PDBML to FAM/RDF...

 pdbml_file_list=pdbml_to_rdf_fam_file_list

 find $PDBML_FAM -maxdepth 1 -name '*.xml' > $pdbml_file_list

 for proc_id in `seq 1 $MAXPROCS` ; do

  ./scripts/transl_to_rdf_fam_worker.sh -d $RDF_FAM -l $pdbml_file_list -n $proc_id"of"$MAXPROCS -t $total &

 done

 if [ $? != 0 ] ; then

  echo $0 aborted.
  exit 1

 fi

 wait

 echo

 rm -f $pdbml_file_list

fi

echo $RDF_FAM is up-to-date.

