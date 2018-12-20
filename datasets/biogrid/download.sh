#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


wget -a download.log https://archive.monarchinitiative.org/latest/ttl/biogrid.ttl
wget -a download.log https://archive.monarchinitiative.org/latest/ttl/biogrid_dataset.ttl

# Download ontology
wget -a download.log http://purl.obolibrary.org/obo/upheno/monarch.owl