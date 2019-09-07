#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1



wget -N -a download.log ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdmp.zip

unzip -o \*.zip
rename s/\.dmp/.psv/ *.psv