#!/bin/bash

source ./scripts/env.sh

./scripts/update_pdbml.sh || exit $?

if [[ $(find wurcs2glytoucan/glytoucan.xml -mtime +4) ]] ; then
 ( cd wurcs2glytoucan; ./update_glytoucan.sh )
fi

./scripts/transl_to_rdf_pdb.sh

./scripts/compress_rdf_pdb.sh

echo
echo Everything is up-to-date.

