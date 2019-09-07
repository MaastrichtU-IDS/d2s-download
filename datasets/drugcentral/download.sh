#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Download drugcentral  http://drugcentral.org/download
wget -N -a download.log http://unmtid-shinyapps.net/download/drug.target.interaction.tsv.gz
wget -N -a download.log http://unmtid-shinyapps.net/download/structures.smiles.tsv

find . -name "*.gz" -exec gzip -d  {} +