#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# Will be handled by prefixcommons

# A csv file and release.html
wget -O miriam.xml -a download.log https://www.ebi.ac.uk/miriam/main/export/xml/