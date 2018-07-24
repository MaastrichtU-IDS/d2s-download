#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# HTML: http://sideeffects.embl.de/download/

# Columns here: ftp://xi.embl.de/SIDER/latest/README
wget -a download.log ftp://xi.embl.de/SIDER/latest/meddra_all_indications.tsv.gz
wget -a download.log ftp://xi.embl.de/SIDER/latest/meddra_all_se.tsv.gz
wget -a download.log ftp://xi.embl.de/SIDER/latest/meddra_freq.tsv.gz


find . -name "*.gz" -exec gzip -d  {} +
