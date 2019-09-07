#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1


# Download recursively all ttl.gz files in ftp
wget -N -a download.log -r -A ttl.gz -nH --cut-dirs=5 ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBL-RDF/latest/

find . -name "*.gz" -exec gzip -d  {} +
