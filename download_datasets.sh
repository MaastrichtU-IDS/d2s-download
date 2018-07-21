#!/bin/bash

PROJECT_DIR=$( "pwd" )
DDL_WORKDIR=/data/download/datasets

mkdir -p $DDL_WORKDIR

all_datasets=( "affymetrix" "clinicaltrials" "ctd" "dbpedia" "drugbank" "genage" "gendr" "genbank" "goa" "hgnc" 
  "interpro" "homologene" "ipi" "irefindex" "kegg" "lsr" "mgi" "ncbigene" "pharmgkb" "pubchem" "refseq" "sider" "taxonomy" "uniprot" "wormbase" )

download_datasets=( "drugbank" )

for dataset in "${download_datasets[@]}"
do
  cd $PROJECT_DIR
  DATASET_DIR=$DDL_WORKDIR/${dataset}
  echo "Downloading dataset $DATASET_DIR"
  source datasets/${dataset}/download.sh $DATASET_DIR
done

cd $DDL_WORKDIR
echo "  Failed downloads" > download_failed.log

# Go through the logs to check for error or failed download
grep -rl ERROR >> download_failed.log
grep -rl failed >> download_failed.log
echo "yeaaah"
grep -rl "*ERROR*"