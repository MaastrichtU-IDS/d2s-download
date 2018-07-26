#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

TARGET_DIR=$1

mkdir -p $TARGET_DIR
cd $TARGET_DIR
rm -rf *

# Go annotation in psv without columns
wget -a download.log http://geneontology.org/gene-associations/goa_human.gaf.gz

find . -name "*.gz" -exec gzip -d  {} +
