#!/bin/bash

OXI_SERV_PORT_PDB=8010
OXI_SERV_PORT_CC=8011
OXI_SERV_PORT_BIRD=8012
OXI_SERV_PORT_VRPT=8013

RDF_FORMAT=application/rdf+xml

cur_dir=`pwd`

# locations of triple store
LOCATION_PDB=$cur_dir/pdb
LOCATION_CC=$cur_dir/cc
LOCATION_BIRD=$cur_dir/bird
LOCATION_VRPT=$cur_dir/vrpt

