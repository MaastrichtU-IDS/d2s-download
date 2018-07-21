#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=https://api.pharmgkb.org/v1/download/file/data/
array=( "dosingGuidelines.json.zip" "drugLabels.zip" "pathways-biopax.zip" "pathways-tsv.zip" "clinicalVariants.zip" "genes.zip"
"variants.zip" "phenotypes.zip" "drugs.zip" "chemicals.zip" )
# Original: drugs|genes|diseases|pathways|relationships|annotations|rsid

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -a download.log $BASE_URI${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;