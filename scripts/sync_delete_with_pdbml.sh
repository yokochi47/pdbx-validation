#!/bin/bash

source ./scripts/env.sh

pdb_id_list=sync_pdbml_pdb_id_list

SRC_DIR=$PDBML_NOATOM
src_file_ext=-noatom.xml.gz

if [ -d $PDBML ] ; then

 find $PDBML -maxdepth 1 -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $PDBML/$pdb_id-noatom.xml
   rm -f $PDBML/$pdb_id-noatom.xml
  fi
 done < $pdb_id_list

fi

if [ -d $PDBML_EXT ] ; then

 find $PDBML_EXT -maxdepth 1 -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $PDBML_EXT/$pdb_id-noatom-ext.xml
   rm -f $PDBML_EXT/$pdb_id-noatom-ext.xml
  fi
 done < $pdb_id_list

fi

if [ -d $VALID_INFO_ALT ] ; then

 find $VALID_INFO_ALT -maxdepth 1 -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $VALID_INFO_ALT/$pdb_id-validation-alt.xml
   rm -f $VALID_INFO_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -maxdepth 1 -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID_ALT/$pdb_id-validation-alt.xml
   rm -f $XML_VALID_ALT/$pdb_id-validation-alt.xml
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -maxdepth 1 -name '*.xml' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID/$pdb_id-validation-full.xml
   rm -f $XML_VALID/$pdb_id-validation-full.xml
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -maxdepth 1 -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
   rm -f $RDF_VALID_ALT/$pdb_id-validation-alt.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -maxdepth 1 -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID/$pdb_id-validation-full.rdf
   rm -f $RDF_VALID/$pdb_id-validation-full.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $RDF ] ; then

 find $RDF -maxdepth 1 -name '*.rdf' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF/$pdb_id.rdf
   rm -f $RDF/$pdb_id.rdf
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID_ALT ] ; then

 find $MMCIF_VALID_ALT -maxdepth 1 -name '*.cif' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $MMCIF_VALID_ALT/$pdb_id-validation-alt.cif
   rm -f $MMCIF_VALID_ALT/$pdb_id-validation-alt.cif
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID ] ; then

 find $MMCIF_VALID -maxdepth 1 -name '*.cif' | cut -d '/' -f 2 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $MMCIF_VALID/$pdb_id-validation-full.cif
   rm -f $MMCIF_VALID/$pdb_id-validation-full.cif
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID_ALT ] ; then

 find $XML_VALID_ALT -mindepth 2 -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
   rm -f $XML_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $XML_VALID ] ; then

 find $XML_VALID -mindepth 2 -name '*.xml.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
   rm -f $XML_VALID/${pdb_id:1:2}/$pdb_id-validation-full.xml.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID_ALT ] ; then

 find $RDF_VALID_ALT -mindepth 2 -name '*.rdf.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
   rm -f $RDF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.rdf.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF_VALID ] ; then

 find $RDF_VALID -mindepth 2 -name '*.rdf.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.rdf.gz
   rm -f $RDF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.rdf.gz
  fi
 done < $pdb_id_list

fi

if [ -d $RDF ] ; then

 find $RDF -mindepth 2 -name '*.rdf.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $RDF/${pdb_id:1:2}/$pdb_id.rdf.gz
   rm -f $RDF/${pdb_id:1:2}/$pdb_id.rdf.gz
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID_ALT ] ; then

 find $MMCIF_VALID_ALT -mindepth 2 -name '*.cif.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $MMCIF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.cif.gz
   rm -f $MMCIF_VALID_ALT/${pdb_id:1:2}/$pdb_id-validation-alt.cif.gz
  fi
 done < $pdb_id_list

fi

if [ -d $MMCIF_VALID ] ; then

 find $MMCIF_VALID -mindepth 2 -name '*.cif.gz' | cut -d '/' -f 3 | cut -d '-' -f 1 > $pdb_id_list

 while read pdb_id ; do
  if [ ! -e $SRC_DIR/${pdb_id:1:2}/$pdb_id$src_file_ext ] ; then
   echo deleting $MMCIF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.cif.gz
   rm -f $MMCIF_VALID/${pdb_id:1:2}/$pdb_id-validation-full.cif.gz
  fi
 done < $pdb_id_list

fi

rm -f $pdb_id_list

