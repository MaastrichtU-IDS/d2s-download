#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *


wget -a download.log http://sideeffects.embl.de/media/download/meddra_all_indications.tsv.gz
wget -a download.log http://sideeffects.embl.de/media/download/meddra_all_se.tsv.gz
wget -a download.log http://sideeffects.embl.de/media/download/meddra_freq.tsv.gz

find . -name "*.gz" -exec gzip -d  {} +
