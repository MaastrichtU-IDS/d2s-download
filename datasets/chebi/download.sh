#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# We don't want to ddl all .owl file so those are manually added
wget -a download.log ftp://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi-disjoints.owl
wget -a download.log ftp://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi-in-bfo.owl
wget -a download.log ftp://ftp.ebi.ac.uk/pub/databases/chebi/ontology/chebi-proteins.owl

# Download recursively all ttl.gz files in ftp
wget -a download.log -r -A owl.gz -nH --cut-dirs=4 ftp://ftp.ebi.ac.uk/pub/databases/chebi/ontology/

find . -name "*.gz" -exec gzip -d  {} +
