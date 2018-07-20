#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

TARGET_DIR=$1

mkdir -p $TARGET_DIR
cd $TARGET_DIR
rm -rf *

BASE_URI="ftp://ftp.ebi.ac.uk/pub/databases/GO/goa/"

dir_to_download=( "ARABIDOPSIS" "CHICKEN" "COW" "DICTY" "DOG" "FLY" "HUMAN" "MOUSE" "PDB" "PIG" "RAT" "UNIPROT" "WORM" "YEAST" "ZEBRAFISH" )

for dir in "${dir_to_download[@]}"
do
  cd $TARGET_DIR
  mkdir -p ${dir}
  cd ${dir}
  echo "Downloading... $BASE_URI${dir}/"
  wget -a download.log "$BASE_URI${dir}/"

  #<a href="ftp://ftp.ebi.ac.uk:21/pub/databases/GO/goa/ARABIDOPSIS/goa_arabidopsis.gpa.gz"
  array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

  for file in "${array[@]}"
  do
    wget -a download.log ${file}
  done
done

cd $TARGET_DIR
find . -name "*.gz" -exec gzip -d  {} +
