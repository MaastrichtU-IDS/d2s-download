#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

BASE_URI=https://archive.monarchinitiative.org/latest/ttl

# 74 files downloaded. each dataset and a small file to describe the dataset. So 32 datasets

wget -a download.log -O index.html "$BASE_URI/"

array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?.{3}(?<!_test)(\.ttl|\.nt)).*/\1/p') )
# Not downloading _test files

# 25G total download
for var in "${array[@]}"
do
  if [[ $string = *"My long"* ]]; then
    echo "Not downloading wormbase.ttl because empty"
    continue
  fi
  wget -a download.log "$BASE_URI/${var}"
done



# flybase old download XML
#wget -a download.log -r -A xml.gz -nH --cut-dirs=5 ftp://ftp.flybase.net/releases/current/chado-xml/
#find . -name "*.gz" -exec gzip -d  {} +
