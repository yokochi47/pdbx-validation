#!/bin/bash

source ./scripts/env.sh

SRC_DIR=$PDBML_NOATOM
XML_DIR=$PDBML

pdb_id_list=pdb_id_list

if [ -d $XML_DIR ] ; then

 find $XML_DIR -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_DIR/$pdb_id-noatom.xml
   rm -f $XML_DIR/$pdb_id-noatom.xml
  fi
 done < $pdb_id_list

fi

if [ -d $PDBML_EXT ] ; then

 find $PDBML_EXT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $PDBML_EXT/$pdb_id-noatom-ext.xml
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  fi
 done < $pdb_id_list

fi

if [ -d $VALID_INFO_ALT ] ; then

 find $VALID_INFO_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $VALID_INFO_ALT/$pdb_id-validation-alt.xml
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_VALID_ALT/$pdb_id-validation-alt.xml
   rm -f $XML_VALID_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_VALID/$pdb_id-validation-full.xml
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
   rm -f $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $RDF_VALID/$pdb_id-validation-full.rdf
   rm -f $RDF_VALID/$pdb_id-validation-full.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID_ALT ] ; then

 find $MMCIF_VALID_ALT -name '*.cif' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $MMCIF_VALID_ALT/$pdb_id-validation-alt.cif
   rm -f $MMCIF_VALID_ALT/$pdb_id-validation-alt.cif
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID ] ; then

 find $MMCIF_VALID -name '*.cif' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $MMCIF_VALID/$pdb_id-validation-full.cif
   rm -f $MMCIF_VALID/$pdb_id-validation-full.cif
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
   rm -f $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -name '*.rdf.gz' | cut -d '/' -f 4 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id/$pdb_id-validation-alt.rdf.gz
   rm -rf $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -name '*.rdf.gz' | cut -d '/' -f 4 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $RDF_VALID/${pdb_id:1:2}/$pdb_id/$pdb_id-validation-full.rdf.gz
   rm -rf $RDF_VALID/${pdb_id:1:2}/$pdb_id
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID_ALT ] ; then

 find $MMCIF_VALID_ALT -name '*.cif.gz' | cut -d '/' -f 4 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $MMCIF_VALID_ALT/${pdb_id:1:2}/$pdb_id/$pdb_id-validation-alt.cif.gz
   rm -rf $MMCIF_VALID_ALT/${pdb_id:1:2}/$pdb_id
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID ] ; then

 find $MMCIF_VALID -name '*.cif.gz' | cut -d '/' -f 4 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id-noatom.xml.gz ] ; then
   echo deleting $MMCIF_VALID/${pdb_id:1:2}/$pdb_id/$pdb_id-validation-full.cif.gz
   rm -rf $MMCIF_VALID/${pdb_id:1:2}/$pdb_id
  fi
 done < $pdb_id_list

fi

rm -f $pdb_id_list

