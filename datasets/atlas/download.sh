#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1


# EBI Expression Atlas. The only nice tsv found
wget -N -a download.log ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-GEOD-10019/E-GEOD-10019_A-AFFY-2-analytics.tsv

wget -N -a download.log ftp://ftp.ebi.ac.uk/pub/databases/microarray/data/atlas/experiments/E-GEOD-10019/species.txt

rename s/\.txt/.tsv/ *.txt
