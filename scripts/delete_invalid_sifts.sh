#!/bin/bash

source scripts/env.sh

if [ ! -d $SIFTS_XML ] ; then
 echo Not found $SIFTS_XML.
 exit 1
fi

CHK_SUM_DIR=chk_sum_valid_sift

mkdir -p $CHK_SUM_DIR

total=`find $SIFTS_XML -name '*.xml' | wc -l 2> /dev/null`

sifts_xml_file_list=sifts_xml_file_list

find $SIFTS_XML -name '*.xml' > $sifts_xml_file_list

for proc_id in `seq 1 $MAXPROCS` ; do

 ./scripts/delete_invalid_sifts_worker.sh -c $CHK_SUM_DIR -l $sifts_xml_file_list -n $proc_id"of"$MAXPROCS -t $total &

done

if [ $? != 0 ] ; then

 echo $0 aborted.
 exit 1

fi

wait

rm -f $sifts_xml_file_list

