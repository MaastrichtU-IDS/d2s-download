#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

wget -N -a download.log -r -A gpff.gz -nH --cut-dirs=3 ftp://ftp.ncbi.nlm.nih.gov/refseq/release/complete/

find . -name "*.gz" -exec gzip -d  {} +
