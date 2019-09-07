#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# RDF dump 2G from https://www.genome.jp/oc/
wget -N -a download.log https://www.genome.jp/oc/files/oc_rdf_170605.tar.gz

find . -name "*.tar.gz" -exec tar -xzvf {} \;


#BASE_URI="http://rest.kegg.jp/list/"
#array=( "pathway" "disease" "drug" "compound" "genome" "genes" "enzyme" "reaction" "ko" "module" "environ" "glycan" "rclass" )

# Get all IDs to download
#for database in "${array[@]}"
#do
#  echo "Downloading database... ${database}"
#  wget -N -a download.log $BASE_URI$database -O "$database.html"
  # Download each ID as seq file
#  ids=( $(cat $database.html | sed -r -n 's/(gn:.*?)[\s].*/\1/p') )
#  for id in "${ids[@]}"
#  do
#    echo "Downloading ID... ${id}"
#    wget -N -a download.log http://rest.kegg.jp/get/#{id}
#  done
#done
