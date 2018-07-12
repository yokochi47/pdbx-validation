#!/bin/bash

source ./scripts/env.sh

SRC_DIR=$VALID_REPORT
XML_DIR=$VALID_INFO

pdb_id_list=pdb_id_list

if [ -d $XML_DIR ] ; then

 find $XML_DIR -name '*.xml' | cut -d '/' -f 2 | cut -d '_' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $XML_DIR/$pdb_id"_validation.xml"
   rm -f $XML_DIR/$pdb_id"_validation.xml"
  fi
 done < $pdb_id_list

fi

if [ -d $PDBML_EXT ] ; then

 find $PDBML_EXT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $PDBML_EXT/$pdb_id-noatom-ext.xml
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  fi
 done < $pdb_id_list

fi

if [ -d $VALID_INFO_ALT ] ; then

 find $VALID_INFO_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $VALID_INFO_ALT/$pdb_id-validation-alt.xml
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $XML_VALID_ALT/$pdb_id-validation-alt.xml
   rm -f $XML_VALID_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $XML_VALID/$pdb_id-validation-full.xml
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $RDF_VALID/$pdb_id-validation.rdf
   rm -f $RDF_VALID/$pdb_id-validation.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
   rm -f $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf.gz' | cut -d '/' -f 4 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id/$pdb_id"_validation.xml.gz" ] ; then
   echo deleting $RDF_VALID/${pdb_id:1:2}/$pdb_id/$pdb_id-validation.rdf.gz
   rm -rf $RDF_VALID/${pdb_id:1:2}/$pdb_id
  fi
 done < $pdb_id_list

fi

rm -f $pdb_id_list

