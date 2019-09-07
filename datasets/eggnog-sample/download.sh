#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


### EggNOG

# http://eggnogdb.embl.de/#/app/downloads

wget -N -a download.log https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/eggnog-sample/NOG.annotations.tsv.gz

wget -N -a download.log https://github.com/MaastrichtU-IDS/data2services-download/raw/master/datasets/eggnog-sample/NOG.members.tsv.gz

find . -name "*.gz" -exec gzip -d  {} +

# Add columns name
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tProteinIDs\n/' NOG.members.tsv
sed -i '1s/^/TaxonomicLevel\tGroupName\tProteinCount\tSpeciesCount\tCOGFunctionalCategory\tConsensusFunctionalDescription\n/' NOG.annotations.tsv
