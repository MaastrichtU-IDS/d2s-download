#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=http://ctdbase.org/reports/

wget -a download.log -N $BASE_URI

# Extract download links from HTML
array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar))".*/\1/p') )

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -a download.log -N "$BASE_URI${var}"
done

gzip -d *.gz
