#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


BASE_URI="http://data.wikipathways.org/current/rdf/"


########## Download files

## FTP DOWNLOAD recursively all files in ftp that have the given extension
wget -a download.log -r -A bz2 -nH ftp://ftp.ebi.ac.uk/pub/databases/RDF/reactome/r67/

# Bz2
find . -name "*.bz2" | while read filename; do bzip2 -f -d "$filename"; done;

# .owl files for species: Homo_sapiens.owl, Mus_musculus.owl