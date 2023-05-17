#!/bin/bash

# Export asset proofs

# TAPCMD="$HOME/tap/tap/tapcli-debug -n regtest -tapddir $HOME/regtest_tapd"

TAPCMD="$HOME/tap/tap/tapcli-debug -n testnet -tapddir $HOME/testnet_tapd"

ASSET_LIST="$(pwd)/full_asset_list.txt"
$TAPCMD a l > "$(pwd)"/full_asset_list.txt
PROOF_EXPORT="$TAPCMD p e"

ASSET_JSON_ARRAY="$(cat "$ASSET_LIST" | jq '.assets')"
NUM_ASSETS="$(cat "$ASSET_LIST" | jq '.assets | length')"

echo "Current asset count: $NUM_ASSETS"

fetch_asset_info() {
	IND=$2
	QUERY=".[$IND]"
	echo "$1" | jq "$QUERY"
}

fetch_script_key() {
	echo "$1" | jq '.script_key' | tr -d '"'
}

fetch_asset_id() {
	echo "$1" | jq '.asset_genesis | .asset_id' | tr -d '"'
}

export_proof() {
	$PROOF_EXPORT --asset_id $1 --script_key $2 --proof_file $3
}

BASE_FILE_NAME="cryptopunk"
PROOF_SUFFIX=".tap"

# Offset to ignore test assets
STARTVAL=0

ASSET_COUNT=$(($NUM_ASSETS-$STARTVAL))
echo "Verifying $ASSET_COUNT assets."

for ((i=STARTVAL; i<NUM_ASSETS; i++)); do
	PROOF_FILE="$BASE_FILE_NAME$i$PROOF_SUFFIX"
	ASSET_INFO=$(fetch_asset_info "$ASSET_JSON_ARRAY" "$i")
	SCRIPT_KEY=$(fetch_script_key "$ASSET_INFO")
	ASSET_ID=$(fetch_asset_id "$ASSET_INFO")

	export_proof "$ASSET_ID" "$SCRIPT_KEY" "$PROOF_FILE"
done
