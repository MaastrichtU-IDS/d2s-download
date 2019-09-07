#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1


# NCBI Bioproject 
wget -N -a download.log "ftp://ftp.ncbi.nlm.nih.gov/bioproject/bioproject.xml"
