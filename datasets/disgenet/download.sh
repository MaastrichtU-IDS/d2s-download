#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


wget -N -a download.log http://rdf.disgenet.org/download/v5.0.0/void-disgenet.ttl

# TODO: sort dir from download and take the latest version
#wget -O index.html -a download.log http://rdf.disgenet.org/download/
#array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Disgenet
wget -N -a download.log http://rdf.disgenet.org/download/v5.0.0/disgenetv5.0-rdf-v5.0.0-dump.tar.gz

find . -name "*.tar.gz" -exec tar -xzvf {} \;