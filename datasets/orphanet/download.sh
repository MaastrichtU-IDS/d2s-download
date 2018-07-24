#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Orphanet (disease)
wget -a download.log http://www.orphadata.org/data/xml/en_product1.xml
wget -a download.log http://www.orphadata.org/data/xml/en_product4.xml
wget -a download.log http://www.orphadata.org/data/xml/en_product6.xml