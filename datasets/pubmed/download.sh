#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

wget -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline/

# Extract download links from HTML
array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.xml\.gz)).*/\1/p') )

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log ${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.gz" -exec gzip -d  {} +
