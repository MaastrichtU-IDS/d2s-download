#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


#wget -N -a download.log -r -A xml.gz -nH --cut-dirs=1 ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/

#wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0001.xml.gz
#wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0002.xml.gz
#wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0003.xml.gz

wget -N -a download.log https://raw.githubusercontent.com/MaastrichtU-IDS/data2services-download/master/datasets/pubmed-sample/pubmed19n0001-sample-6k.xml.gz
wget -N -a download.log https://raw.githubusercontent.com/MaastrichtU-IDS/data2services-download/master/datasets/pubmed-sample/pubmed19n0002-sample-6k.xml.gz

# Unzip all files in subdir with name of the zip file
#find . -name "*.gz" -exec gzip -d  {} +
