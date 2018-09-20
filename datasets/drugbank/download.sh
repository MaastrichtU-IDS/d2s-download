#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# Download providing user login and password
curl -Lfv -o drugbank.zip -u $drugbank_login:$drugbank_password https://www.drugbank.ca/releases/5-1-1/downloads/all-full-database

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;