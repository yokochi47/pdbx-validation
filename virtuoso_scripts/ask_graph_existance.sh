#!/bin/bash

sparql=ask_graph_existance.sparql
result=ask_graph_existance.result

echo "ASK { GRAPH <$1> { ?s ?p ?o . } }" > $sparql

./virtuoso_scripts/run_sparql.sh -s yes -q $sparql > $result || ( echo "Couldn't connect server." && exit 1 )

tail -n 1 $result

rm -f $sparql $result

