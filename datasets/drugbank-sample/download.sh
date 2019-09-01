#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

wget -a download.log https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/drugbank-sample/drugbank.zip

# Download providing user login and password
#curl -Lfv -o drugbank.zip -u $USERNAME:$PASSWORD https://www.drugbank.ca/releases/5-1-1/downloads/all-full-database


# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
mv drugbank/* .
rmdir drugbank