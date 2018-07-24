#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# BindingDB https://www.bindingdb.org/bind/chemsearch/marvin/SDFdownload.jsp?all_download=yes
wget -a download.log https://www.bindingdb.org/bind/downloads/BindingDB_All_2018m6.tsv.zip

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
