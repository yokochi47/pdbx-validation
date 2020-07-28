#!/bin/bash

source ./scripts/env.sh

./scripts/update_pdbml.sh || exit $?

if [[ $(find wurcs2glytoucan/glytoucan.xml -mtime +4) ]] ; then
 ( cd wurcs2glytoucan; ./update_glytoucan.sh )
fi

./scripts/translate_to_pdb_rdf.sh

./scripts/compress_pdb_rdf.sh

echo
echo Everything is up-to-date.

