#!/bin/bash

source ./scripts/env.sh

pdb_id_list=sync_mmcif_pdb_id_list

SRC_DIR=$MMCIF_VALID
src_file_ext=-validation-full.cif.gz

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID/$pdb_id-validation-full.xml
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID/$pdb_id-validation-full.rdf
   rm -f $RDF_VALID/$pdb_id-validation-full.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.rdf.gz
   rm -f $RDF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.rdf.gz
  fi
 done < $pdb_id_list

fi

SRC_DIR=$MMCIF_VALID_ALT
src_file_ext=-validation-alt.cif.gz

if [ -d $VALID_INFO_ALT ] ; then

 find $VALID_INFO_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $VALID_INFO_ALT/$pdb_id-validation-alt.xml
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID_ALT/$pdb_id-validation-alt.xml
   rm -f $XML_VALID_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
   rm -f $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
   rm -f $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -name '*.rdf.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
   rm -f $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
  fi
 done < $pdb_id_list

fi

rm -f $pdb_id_list

