#!/bin/bash

source scripts/env.sh

if [ ! -d $SIFTS_XML ] ; then
 echo Not found $SIFTS_XML.
 exit 1
fi

sifts_file_list=sifts_file_list

find $SIFTS_XML -name '*.xml' > $sifts_file_list

while read sifts_file
do

 pdb_id=`basename $sifts_file .xml`

 sed -n 2,2p $sifts_file | grep 'dbAccessionId="'$pdb_id'"' > /dev/null

 if [ $? != 0 ] ; then
  echo deleting $sifts_file
  rm -f $sifts_file
 fi

done < $sifts_file_list

rm -f $sifts_file_list

