#!/bin/bash

PROJECT_DIR=$( "pwd" )
DDL_WORKDIR=/data/download/datasets

mkdir -p $DDL_WORKDIR

all_datasets=( "affymetrix" "clinicaltrials" "ctd" "dbpedia" "drugbank" "genage" "gendr" "genbank" "goa" "hgnc" 
  "interpro" "homologene" "ipi" "irefindex" "kegg" "lsr" "mgi" "ncbigene" "pharmgkb" "pubchem" "refseq" "sider" "taxonomy" "uniprot" "wormbase" )

download_datasets=( "wormbase" )

for dataset in "${download_datasets[@]}"
do
  cd $PROJECT_DIR
  DATASET_DIR=$DDL_WORKDIR/${dataset}
  echo "Downloading dataset $DATASET_DIR"
  source datasets/${dataset}/download.sh $DATASET_DIR
done

# Go through the logs to check for error or failed download
grep -rl 'failed.*ERROR\|ERROR.*failed' $DDL_WORKDIR > $DDL_WORKDIR/download.log
