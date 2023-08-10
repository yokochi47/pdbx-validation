#!/bin/bash

source ./oxigraph_scripts/oxigraph_env.sh

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

if [ ! -e $LOCATION_BIRD ] ; then

 echo $LOCATION_BIRD does not exist.
 exit 1

fi

oxigraph_server serve-read-only --location $LOCATION_BIRD --bind 0.0.0.0:$OXI_SERV_PORT_BIRD

