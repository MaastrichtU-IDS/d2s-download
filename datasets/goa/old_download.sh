#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi
TARGET_DIR=$1
mkdir -p $TARGET_DIR
cd $TARGET_DIR


# Go annotation
BASE_URI="ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/"

dir_to_download=( "ARABIDOPSIS" "CHICKEN" "COW" "DICTY" "DOG" "FLY" "HUMAN" "MOUSE" "PDB" "PIG" "RAT" "UNIPROT" "WORM" "YEAST" "ZEBRAFISH" )

for dir in "${dir_to_download[@]}"
do
  cd $TARGET_DIR
  mkdir -p ${dir}
  cd ${dir}
  echo "Downloading... $BASE_URI${dir}/"
  wget -N -a download.log "$BASE_URI${dir}/"
  # Download only gaf files
  wget -N -a download.log -r -A gaf.gz -nH --cut-dirs=5 "$BASE_URI${dir}/"
done

cd $TARGET_DIR

find . -name "*.gz" -exec gzip -d  {} +
