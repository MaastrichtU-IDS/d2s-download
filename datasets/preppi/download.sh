#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1



BASE_URI="http://data.wikipathways.org/current/rdf/"


########## Download files

wget -N -a download.log https://honiglab.c2b2.columbia.edu/PrePPI/ref/preppi_final600.txt.tar.gz


# UNTAR recursively all files in actual dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;


## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt