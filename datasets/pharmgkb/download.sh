#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


# The Licensed Annotation Data are intereting but need license. How to use them in the license scope? License will changed after august. Michel has an account
# https://www.pharmgkb.org/downloads
BASE_URI=https://api.pharmgkb.org/v1/download/file/data/
array=( "pathways-biopax.zip" "clinicalVariants.zip" "genes.zip" "variants.zip" "phenotypes.zip" "drugs.zip" "chemicals.zip" )
# Original: drugs|genes|diseases|pathways|relationships|annotations|rsid
# Not downloaded: pathways-tsv.zip, dosingGuidelines.json.zip, drugLabels.zip


# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -a download.log $BASE_URI${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;