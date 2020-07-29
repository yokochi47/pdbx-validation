#!/bin/bash

source ./scripts/env.sh

./scripts/update_cc.sh || exit $?

./scripts/transl_to_rdf_cc.sh

./scripts/compress_rdf_cc.sh

echo
echo Everything is up-to-date.

