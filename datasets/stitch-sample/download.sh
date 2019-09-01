#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


# Stitch: http://stitch.embl.de/cgi/download.pl

# Chemical-chemical links
wget -a download.log https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/stitch-sample/chemical_chemical.links.v5.0.tsv.gz


# Protein-chemical links. Taking only for human specie at the moment to make it lighter (too big otherwise)
wget -a download.log https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/stitch-sample/9606.protein_chemical.links.detailed.v5.0.tsv.gz


find . -name "*.gz" -exec gzip -d  {} +