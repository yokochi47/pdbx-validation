#!/bin/bash

source ./scripts/env.sh

if [ $has_cifcheck_command = "false" ] ; then

 echo "CifCheck: command not found..."
 echo "Please install MMCIF Dictionary Suite (https://sw-tools.rcsb.org)."
 exit 1

fi

MMCIF_DIR=
CHK_SUM_DIR=chk_sum_valid_mmcif
DELETE=false

ARGV=`getopt --long -o "d:r" "$@"`
eval set -- "$ARGV"
while true ; do
 case "$1" in
 -d)
  MMCIF_DIR=$2
  shift
 ;;
 -r)
  DELETE=true
 ;;
 *)
  break
 ;;
 esac
 shift
done

if [ -d $MMCIF_DIR ] ; then

 find $MMCIF_DIR -maxdepth 1 -name '*.cif' -size 0 -exec rm {} +

 total=`find $MMCIF_DIR -maxdepth 1 -name '*.cif' | wc -l 2> /dev/null`

 if [ $total != 0 ] ; then

  mkdir -p $CHK_SUM_DIR

  for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

   if [ ! -e $MMCIF_DIR/$dicfile ] ; then
    ( cd $MMCIF_DIR; ln -s ../schema/$dicfile . )
   fi

  done

  echo mmCIF syntax validation: *.cif documents in $MMCIF_DIR...

  cif_file_list=`echo check_${MMCIF_DIR,,}_cif_file_list | tr '-' _`
  dict_sdb=`readlink -f $MMCIF_DIR/$pdbx_validation_sdb`

  find $MMCIF_DIR -name "*.log" -exec rm {} +

  find $MMCIF_DIR -maxdepth 1 -name '*.cif' > $cif_file_list

  rm -f $MMCIF_DIR/*.lock
  cat $cif_file_list | sort -R > $cif_file_list~

  for proc_id in `seq 1 $MAXPROCS` ; do

   if [ $DELETE = "true" ] ; then
    ./scripts/validate_all_mmcif_worker.sh -c $CHK_SUM_DIR -d $MMCIF_DIR -s $dict_sdb -l $cif_file_list -n $proc_id"of"$MAXPROCS -t $total -r &
   else
    ./scripts/validate_all_mmcif_worker.sh -c $CHK_SUM_DIR -d $MMCIF_DIR -s $dict_sdb -l $cif_file_list -n $proc_id"of"$MAXPROCS -t $total &
   fi

  done

  if [ $? != 0 ] ; then

   echo $0 aborted.
   exit 1

  fi

  wait

  echo

  rm -f $cif_file_list $cif_file_list~

  for dicfile in $pdbx_validation_dic $pdbx_validation_odb $pdbx_validation_sdb ; do

   if [ -e $MMCIF_DIR/$dicfile ] ; then
    rm -f $MMCIF_DIR/$dicfile
   fi

  done

  red='\e[0;31m'
  normal='\e[0m'

  errs=`find $MMCIF_DIR -name "*.log" | wc -l 2> /dev/null`

  if [ $errs != 0 ] ; then

   echo -e "${red}$errs errors were detected. Please check the log files for more details.${normal}"
   exit 1

  fi

  echo Done.

 fi

fi

