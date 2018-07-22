#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# Not the one from the php script, but it is the BioModels database in RDF
wget -a download.log "ftp://ftp.ebi.ac.uk/pub/databases/biomodels/releases/2017-06-26/BioModels_Database-r31_pub-rdf_files.tar.bz2"

find . -name "*.bz2" | while read filename; do bzip2 -f -d "$filename"; done;
