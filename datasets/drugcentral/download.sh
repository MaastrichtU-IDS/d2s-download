#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Download drugcentral http://drugcentral.org/download
wget -a download.log http://iridium.noip.me/drug.target.interaction.tsv.gz

find . -name "*.gz" -exec gzip -d  {} +