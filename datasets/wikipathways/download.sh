#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="http://data.wikipathways.org/current/rdf/"
wget -a download.log -O index.html $BASE_URI

# Extract download links from HTML: href='./wikipathways-20180710-rdf-gpml.zip'>
array=( $(cat index.html | sed -r -n "s/.*href='\.\/(.*?(\.zip|\.ttl))'.*/\1/p") )

uniq_array=($(echo "${array[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))


# Download all extracted links
for var in "${uniq_array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -a download.log $BASE_URI${var}
done

# Download ontology
wget -a download.log -O wikipathways_ontology.ttl http://www.w3.org/2012/pyRdfa/extract?uri=http://vocabularies.wikipathways.org/wp#


# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
