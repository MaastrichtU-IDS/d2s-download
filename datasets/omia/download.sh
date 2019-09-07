#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# OMIA - ONLINE MENDELIAN INHERITANCE IN ANIMALS
wget -N -a download.log http://omia.org/dumps/omia.xml.zip

unzip -o \*.zip
