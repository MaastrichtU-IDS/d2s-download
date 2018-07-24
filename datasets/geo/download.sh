#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# NCBI GEO download XML file in miniml format
wget -a download.log -r -A xml.tgz -nH --cut-dirs=2 ftp://ftp.ncbi.nlm.nih.gov/geo/series/
# ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE73nnn/GSE73008/miniml/GSE73008_family.xml.tgz

# Recursively untar all files in actual dir
find . -name "*.tgz" -exec tar -xzvf {} \;
