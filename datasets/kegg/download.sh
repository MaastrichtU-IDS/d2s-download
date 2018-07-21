#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="http://rest.kegg.jp/list/"
array=( "pathway" "disease" "drug" "compound" "genome" "genes" "enzyme" "reaction" "ko" "module" "environ" "glycan" "rclass" )

# Download all gene an species files
for database in "${array[@]}"
do
  echo "Downloading Gene... ${database}"
  wget -a download.log $BASE_URI$database -O "$database.tsv"
done
