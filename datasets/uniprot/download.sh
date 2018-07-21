#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=http://www.uniprot.org/

array=( "uniprot" "uniparc" "uniref" "citations" "keywords" "locations" "taxonomy" "tissues" )

# Use URL slightly different for uniprot database (query=active:)?
#wget -a download.log "http://www.uniprot.org/uniprot/?query=active:*&format=nt&compress=yes" --output-document=uniprot.n3.gz

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}/?query=*&format=nt&compress=yes"
  wget -a download.log "$BASE_URI${var}/?query=*&format=nt&compress=yes" --output-document=${var}.n3.gz
done

find . -name "*.gz" -exec gzip -d  {} +
