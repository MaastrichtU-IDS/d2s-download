#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# Download ontologies in OBO
wget -a download.log -r -A xml.gz -nH --cut-dirs=5 ftp://ftp.flybase.net/releases/current/chado-xml/

find . -name "*.gz" -exec gzip -d  {} +
