#!/bin/bash

SRC_DIR=XML-noatom

XML_DIR=pdbml
PDBML_EXT=pdbml-ext
VALID_INFO_ALT=validation-info-alt
PDBML_VALID=pdbml-validation
RDF_VALID=rdf-validation

id_list=id_list

if [ -d $XML_DIR ] ; then

 find $XML_DIR -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_DIR/$pdb_id-noatom.xml
   rm -f $XML_DIR/$pdb_id-noatom.xml
  fi
 done < $id_list

fi

if [ -d $PDBML_EXT ] ; then

 find $PDBML_EXT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $PDBML_EXT/$pdb_id-noatom-ext.xml
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  fi
  done < $id_list

fi

if [ -d $VALID_INFO_ALT ] ; then

 find $VALID_INFO_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $VALID_INFO_ALT/$pdb_id-validation-alt.xml
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  fi
 done < $id_list

fi

if [ -d $PDBML_VALID ] ; then

 find $PDBML_VALID -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $PDBML_VALID/$pdb_id-validation-full.xml
   rm -f $PDBML_VALID/$pdb_id-validation-full.xml
  fi
 done < $id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $RDF_VALID/$pdb_id-validation.rdf
   rm -f $RDF_VALID/$pdb_id-validation.rdf
  fi
 done < $id_list
fi

rm -f $id_list

