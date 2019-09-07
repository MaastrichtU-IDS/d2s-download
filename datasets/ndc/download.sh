#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# NDC
wget -N -a download.log https://www.accessdata.fda.gov/cder/ndctext.zip
#wget -N -a download.log https://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM527389.zip

unzip -o \*.zip
rename s/\.txt/.tsv/ *.txt