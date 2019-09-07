#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1



# Download this file for column: ftp://ftp.pir.georgetown.edu/databases/iproclass/iproclass.tb.readme

wget -N -a download.log ftp://ftp.pir.georgetown.edu/databases/iproclass/iproclass.tb.gz

# XML version 23 Go (vs. 6 Go for tb.gz)
#ftp://ftp.pir.georgetown.edu/databases/iproclass/iproclass.xml.gz

find . -name "*.gz" -exec gzip -d  {} +

# Rename extension to tsv because it is tsv and more convinient for future processing
#rename s/\.xrefs/.tsv/ *.xrefs