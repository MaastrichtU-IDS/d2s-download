#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# ClinVar
wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/xml/ClinVarFullRelease_00-latest.xml.gz


find . -name "*.gz" -exec gzip -d  {} +
