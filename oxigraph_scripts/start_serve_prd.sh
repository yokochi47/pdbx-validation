#!/bin/bash

source ./oxigraph_scripts/oxigraph_env.sh

if [ $? != 0 ] ; then
 exit 1
fi

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

if [ ! -e $LOCATION_PRD ] ; then

 echo $LOCATION_PRD does not exist.
 exit 1

fi

oxigraph_server serve-read-only --location $LOCATION_PRD --bind 0.0.0.0:$OXI_SERV_PORT_PRD

