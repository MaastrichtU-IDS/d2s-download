#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

TARGET_DIR=$1

mkdir -p $TARGET_DIR
cd $TARGET_DIR
rm -rf *

BASE_URI="https://downloads.yeastgenome.org/curation/"

files_to_download=( "chromosomal_feature/dbxref.tab" "chromosomal_feature/SGD_features.tab" "calculated_protein_info/domains/domains.tab"
  "calculated_protein_info/protein_properties.tab" "literature/gene_association.sgd.gz" "literature/go_slim_mapping.tab"
  "literature/go_protein_complex_slim.tab" "literature/interaction_data.tab" "literature/phenotype_data.tab"
  "literature/biochemical_pathways.tab" )

for file in "${files_to_download[@]}"
do
  cd $TARGET_DIR
  echo "Downloading... $BASE_URI${dir}/"
  wget -a download.log "$BASE_URI${dir}/"

done

cd $TARGET_DIR
rename s/\.tab/.tsv/ *.tab
