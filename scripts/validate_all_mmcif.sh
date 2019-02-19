#!/bin/bash

source ./scripts/env.sh

if [ $has_cifcheck_command = "false" ] ; then

 echo "CifCheck: command not found..."
 echo "Please install MMCIF Dictionary Suite (http://sw-tools.pdb.org/)."
 exit 1

fi

MMCIF_DIR=
DELETE=true

ARGV=`getopt --long -o "d:r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  MMCIF_DIR=$2
  shift
 ;;
 -r)
  DELETE=false
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ ! -z $MMCIF_DIR ] ; then

 total=`find $MMCIF_DIR -name '*.cif' | wc -l`

 if [ $total != 0 ] ; then

  for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

   if [ ! -e $MMCIF_DIR/$dicfile ] ; then
    ( cd $MMCIF_DIR; ln -s ../schema/$dicfile . )
   fi

  done

  echo mmCIF syntax validation: *.cif documents in $MMCIF_DIR...

  sdb_realpath=`realpath $MMCIF_DIR/$pdbx_validation_sdb`
  cif_file_list=check_${MMCIF_DIR,,}_cif_file_list

  find $MMCIF_DIR -name '*.cif' > $cif_file_list

  while read cif_file
  do

   cif_dir=`dirname $cif_file`
   diag_log=$cif_file-diag.log
   parser_log=$cif_file-parser.log

   rm -f $cif_dir/$diag_log $cif_dir/$parser_log

   ( cd $cif_dir ; CifCheck -f $cif_file -dictSdb $sdb_realpath > /dev/null ; [ -e $diag_log ] && [ `grep -v 'has invalid value "?" in row' $diag_log | sed -e /^$/d | wc -l` = 0 ] && rm -f $diag_log )
   ( cd $cif_dir ; [ -e $parser_log ] && ( [ $DELETE = "ture" ] && rm -f $cif_file ; cat $parser_log ) ; [ -e $diag_log ] && ( [ $DELETE = "ture" ] && rm -f $cif_file ; cat $diag_log ) )

  done < $cif_file_list

  rm -f $cif_file_list

  for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

   if [ -e $MMCIF_DIR/$dicfile ] ; then
    rm -f $MMCIF_DIR/$dicfile
   fi

  done

 fi

fi

