#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

## Human
# XML human 8G
wget -a download.log -r -A xml.gz -nH --cut-dirs=2 ftp://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606/XML/
# ASN1 Flat for human 2G per file
#wget -a download.log -r -A xml.gz -nH --cut-dirs=2 ftp://ftp.ncbi.nlm.nih.gov/snp/organisms/human_9606/ASN1_flat/


## Chimpanzee
# 20M
#wget -a download.log -r -A xml.gz -nH --cut-dirs=3 ftp://ftp.ncbi.nlm.nih.gov/snp/organisms/archive/chimpanzee_9598/XML/
# 5M
#wget -a download.log -r -A xml.gz -nH --cut-dirs=3 ftp://ftp.ncbi.nlm.nih.gov/snp/organisms/archive/chimpanzee_9598/ASN1_flat/

find . -name "*.gz" -exec gzip -d  {} +