# Remintooor, reminting batches of images with tap

Download images, mint them as one asset group in one transaction, verify the assets on another node, and display the embedded images.

## Setup

Get a bitcoind, lnd, and tarod running. Fund LND with a few UTXOs.

Scrape images with `scrape_jpegs.sh`.

Mint the assets with `mint_assets.sh`.

Export the proofs with `export_proofs.sh`.

Pick a random asset, and verify it by providing the ID to `verify_asset_jpeg.sh`.
