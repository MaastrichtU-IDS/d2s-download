#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

wget -a download.log https://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM527389.zip

unzip -o \*.zip
