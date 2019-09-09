#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


# Only 2
# wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0001.xml.gz
# wget -N -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/pubmed19n0972.xml.gz

# Only 10
# wget -N -a download.log -r -A 'pubmed19n000*.xml.gz' -nH --cut-dirs=1 ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/


wget -N -a download.log -r -A xml.gz -nH --cut-dirs=1 ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/

## Download update files
# wget -N -a download.log -r -A xml.gz -nH --cut-dirs=1 ftp://ftp.ncbi.nlm.nih.gov/pubmed/updatefiles/

# Unzip all files in subdir with name of the zip file (not necessary with xml2rdf)
# find . -name "*.gz" -exec gzip -d  {} +
