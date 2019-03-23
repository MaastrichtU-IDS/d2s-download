#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

#wget -a download.log -r -A xml.gz -nH --cut-dirs=1 ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/

wget -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0001.xml.gz
wget -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0002.xml.gz

# Unzip all files in subdir with name of the zip file
#find . -name "*.gz" -exec gzip -d  {} +
