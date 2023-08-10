#!/bin/bash

source ./oxigraph_scripts/oxigraph_env.sh

which oxigraph_server &> /dev/null

if [ $? != 0 ] ; then

 echo "oxigraph_server: command not found..."
 echo "Please install Oxigraph Server."
 exit 1

fi

if [ ! -e $LOCATION_CC ] ; then

 echo $LOCATION_CC does not exist.
 exit 1

fi

oxigraph_server optimize --location $LOCATION_CC

