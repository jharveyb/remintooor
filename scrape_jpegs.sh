#!/bin/bash

# Fetch a list of images, with numerical incrementing suffixes

STARTVAL=100
ENDVAL=10000

echo "Image count: $ENDVALEXCLUDING"

PATH_SUFFIX="punk"
FILE_TYPE=".png"
OUT_DIR=$(pwd)/$PATH_SUFFIX/

# Create output dir
if [[ ! -d $OUT_DIR ]]; then
        mkdir -p "$OUT_DIR"
fi

echo "Output dir: $OUT_DIR"

# Fill out URLs and paths
BASE_URL="https://unpkg.com/cryptopunk-icons@1.1.0/app/assets/"
EXTENDED_URL=$BASE_URL$PATH_SUFFIX

for ((i=STARTVAL; i<ENDVAL; i++)); do
        FULL_URL=$EXTENDED_URL$i$FILE_TYPE
        FILE_NAME=$OUT_DIR$i$FILE_TYPE
        wget -qO "$FILE_NAME" "$FULL_URL"

        if ((i % 100 == 0)); then
                echo "Finished $i images."
        fi
done

echo "Scraped $ENDVAL images."
