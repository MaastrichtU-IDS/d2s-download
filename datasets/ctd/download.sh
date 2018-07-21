#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=http://ctdbase.org/reports/

array=( "chem_gene_ixns" "chem_gene_ixn_types" "chemicals_diseases" "chem_go_enriched" "chem_pathways_enriched"
  "genes_diseases" "genes_pathways" "diseases_pathways" "chemicals" "diseases" "genes" "pathways" )

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -a download.log "$BASE_URI${var}.tsv.gz"
done

gzip -d *.gz
