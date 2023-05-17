#!/bin/bash

# Create a batch of assets

# TAPCMD="$HOME/tap/tap/tapcli-debug -n regtest -tapddir $HOME/regtest_tapd"
#
TAPCMD="$HOME/tap/tap/tapcli-debug -n testnet -tapddir $HOME/testnet_tapd"

ASSET_MINT="$TAPCMD a m"
MINT_FINALIZE="$TAPCMD a m f"
MINE_BLOCK="bitcoin-cli -regtest -generate 1"

BASE_NAME="cryptopunk"
META_FILE_SUFFIX=".png"
META_FILE="$(pwd)"/"$BASE_NAME"/

NUM_IMAGES=$(ls "$(pwd)"/"$BASE_NAME"/ | wc -l)


mint_group_anchor() {
        $ASSET_MINT --type collectible --supply 1 --name $1 --meta_file_path $2 --enable_emission
}

mint_grouped_asset() {
        $ASSET_MINT --type collectible --supply 1 --name $1 --meta_file_path $2 --group_anchor $3
}

finalize_batch() {
        $MINT_FINALIZE
	sleep 1
	$MINE_BLOCK
	sleep 1
	$MINE_BLOCK
}

echo $NUM_IMAGES

STARTVAL=0
# ENDVAL=NUM_IMAGES
ENDVAL=100
GROUP_ANCHOR="$BASE_NAME"0

for ((i=STARTVAL; i<ENDVAL; i++)); do
        FULL_META_FILE="$META_FILE$i$META_FILE_SUFFIX"
        ASSET_NAME="$BASE_NAME$i"

        if ((i == 0)); then
                mint_group_anchor "$ASSET_NAME" "$FULL_META_FILE"
        else
                mint_grouped_asset "$ASSET_NAME" "$FULL_META_FILE" "$GROUP_ANCHOR"
        fi

        if ((i % 100 == 0)); then
                echo "Submitted $i mint requests."
        fi
done

echo "Finalizing batch."

finalize_batch
