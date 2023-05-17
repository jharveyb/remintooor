#!/bin/bash

# Look up the metadata of an asset we have imported

# TAPCMD_2_BASE="$HOME/tap/tap/tapcli-debug -n regtest \
#         --tapddir $HOME/regtest_tapd_2 --rpcserver=localhost:8090 \
#         --tlscertpath=$HOME/regtest_tapd_2/tls.cert"

TAPCMD_2_BASE="$HOME/tap/tap/tapcli-debug -n testnet \
        --tapddir $HOME/testnet_tapd_2 --rpcserver=localhost:8090 \
        --tlscertpath=$HOME/testnet_tapd_2/tls.cert"

FETCH_META="$TAPCMD_2_BASE a meta --asset_id"

if [[ $1 == "" ]]; then
        echo "Must provide asset ID."
        exit
fi      

fetch_meta() {
        $FETCH_META "$1"
}

parse_meta() {
        META_HEX=$(echo "$1" | jq '.data' | tr -d '"')
        echo "$META_HEX" | xxd -r -p > "$2"
}

META=$(fetch_meta "$1")

echo "Raw metadata from tapd:"
echo ""
echo "$META"

echo ""
echo "Converting metadata to image."

FILE_NAME="$(pwd)/$1.png"
parse_meta "$META" "$FILE_NAME"

echo ""
echo "Wrote parsed metadata to $FILE_NAME."

echo ""
echo "Displaying parsed metadata."

shotwell "$FILE_NAME"