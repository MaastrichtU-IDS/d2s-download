#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

wget -N -a download.log http://downloads.dbpedia.org/3.7/en/infobox_properties_en.nt.bz2 --output-file=dbpedia-wget.log