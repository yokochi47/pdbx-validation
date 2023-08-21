#!/bin/bash

OXI_SERV_PORT_PDB=7878
OXI_SERV_PORT_CC=7879
OXI_SERV_PORT_PRD=7880
OXI_SERV_PORT_FAM=7881
OXI_SERV_PORT_VRPT=7882

RDF_FORMAT=application/rdf+xml

# locations of triple store
LOCATION_PDB=oxigraph_scripts/pdb
LOCATION_CC=oxigraph_scripts/cc
LOCATION_PRD=oxigraph_scripts/prd
LOCATION_FAM=oxigraph_scripts/fam
LOCATION_VRPT=oxigraph_scripts/vrpt

# backup destinations of triple store
BACKUP_PDB=oxigraph_scripts/pdb_bk
BACKUP_CC=oxigraph_scripts/cc_bk
BACKUP_PRD=oxigraph_scripts/prd_bk
BACKUP_FAM=oxigraph_scripts/fam_bk
BACKUP_VRPT=oxigraph_scripts/vrpt_bk

