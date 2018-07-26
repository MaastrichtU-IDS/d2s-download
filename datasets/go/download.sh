#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

TARGET_DIR=$1

mkdir -p $TARGET_DIR
cd $TARGET_DIR
rm -rf *

wget -a download.log http://purl.obolibrary.org/obo/go/go-basic.obo
wget -a download.log http://purl.obolibrary.org/obo/go.obo
wget -a download.log http://purl.obolibrary.org/obo/go.owl
wget -a download.log http://purl.obolibrary.org/obo/go/extensions/go-plus.owl

find . -name "*.gz" -exec gzip -d  {} +
