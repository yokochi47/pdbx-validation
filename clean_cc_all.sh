#!/bin/bash

source ./scripts/env.sh

echo
echo "Do you want to clean? (y [n]) "

read ans

case $ans in
 y*|Y*)
  ;;
 *)
  echo skipped.;;
esac

if [ `which DictToSdb` ] && [ `which Dict2XMLSchema` ] && [ `which Dict2XMLSchema` ]; then
 ( cd resource; ./update_pdbx_xsd.sh; ./update_pdbx_owl.sh )
fi

rm -f *_list *_total url_mirror

rm -rf extlibs

rm -f $CC2RDF_XSL

WORK_DIR=.

rm -rf $WORK_DIR/$COMPONENTS_RDF

WORK_DIR=test

rm -rf $WORK_DIR/$COMPONENTS_RDF

rm -rf $WORK_DIR/chk_sum_*

