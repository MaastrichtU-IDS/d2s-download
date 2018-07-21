#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=ftp://ftp.ncbi.nlm.nih.gov/refseq/release/complete/

wget -a download.log $BASE_URI

# Extract download links from HTML
array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?gpff(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log ${var}
done

find . -name "*.gz" -exec gzip -d  {} +
