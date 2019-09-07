#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

BASE_URI=https://archive.monarchinitiative.org/latest/ttl

# 74 files downloaded. Each dataset and a small file to describe the dataset. So 32 datasets
# Download file list in HTML
wget -O index.html -a download.log "$BASE_URI/"


wget -N -a download.log http://purl.obolibrary.org/obo/upheno/monarch.owl
wget -N -a download.log http://purl.obolibrary.org/obo/upheno/mammal.owl
wget -N -a download.log http://purl.obolibrary.org/obo/upheno/vertebrate.owl
wget -N -a download.log https://www.ebi.ac.uk/ols/ontologies/mondo/download
mv download mondo.owl

# Extract ttl filename from HTML
array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?.(\.ttl|\.nt)).*/\1/p') )

# Remove test files and wormbase.ttl
array=( ${array[@]//*test.ttl/} )
array=( ${array[@]//wormbase.ttl/} )

#( IFS=$'\n'; echo "${array[*]}" )

# 25G total download
for var in "${array[@]}"
do
  wget -N -a download.log "$BASE_URI/${var}"
done


# flybase old download XML
#wget -N -a download.log -r -A xml.gz -nH --cut-dirs=5 ftp://ftp.flybase.net/releases/current/chado-xml/
#find . -name "*.gz" -exec gzip -d  {} +
