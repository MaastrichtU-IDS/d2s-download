#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Pathwaycommons download Biopax OWL files only (many other txt files)
wget -a download.log -r -A BIOPAX.owl.gz -nH --cut-dirs=3 http://www.pathwaycommons.org/archives/PC2/v10/

find . -name "*.gz" -exec gzip -d  {} +