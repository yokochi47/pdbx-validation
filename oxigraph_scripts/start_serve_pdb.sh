#!/bin/bash

source ./oxigraph_scripts/oxigraph_env.sh

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

if [ ! -e $LOCATION_PDB ] ; then

 echo $LOCATION_PDB does not exist.
 exit 1

fi

oxigraph_server serve-read-only --location $LOCATION_PDB --bind 0.0.0.0:$OXI_SERV_PORT_PDB

