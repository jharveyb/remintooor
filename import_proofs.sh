#!/bin/bash

# Import asset proofs

# TAPCMD_2="$HOME/tap/tap/tapcli-debug -n regtest \
#         --tapddir $HOME/regtest_tapd_2 --rpcserver=localhost:8090 \
#         --tlscertpath=$HOME/regtest_tapd_2/tls.cert"

TAPCMD_2="$HOME/tap/tap/tapcli-debug -n testnet \
        --tapddir $HOME/testnet_tapd_2 --rpcserver=localhost:8090 \
        --tlscertpath=$HOME/testnet_tapd_2/tls.cert"

PROOF_IMPORT="$TAPCMD_2 p i"

import_proof() {
	$PROOF_IMPORT --proof_file $1
}

BASE_FILE_NAME="cryptopunk"
PROOF_SUFFIX=".tap"

NUM_PROOFS=$(ls "$(pwd)" | wc -l)
echo "Importing $NUM_PROOFS asset proofs."

for ((i=0; i<NUM_PROOFS; i++)); do
	PROOF_FILE="$BASE_FILE_NAME$i$PROOF_SUFFIX"

	import_proof "$PROOF_FILE"
done
