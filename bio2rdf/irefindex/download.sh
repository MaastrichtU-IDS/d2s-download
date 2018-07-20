#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="http://irefindex.org/download/irefindex/data/current/psi_mitab/MITAB2.6/"
TO_DDL="All|10090|10116|4932|559292|562|6239|7227|9606"

wget -a download.log $BASE_URI

array=( $(cat index.html | sed -r -n 's/.*href="((All|10090|10116|4932|559292|562|6239|7227|9606)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Download all extracted files
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log $BASE_URI${var}
done

# Extract directly in the dir
unzip -o \*.zip

# Rename extension to tsv because it is tsv and more convinient for future processing
rename s/\.txt/.tsv/ *.txt