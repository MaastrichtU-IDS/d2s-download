#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


# https://www.pharmgkb.org/downloads
BASE_URI=https://api.pharmgkb.org/v1/download/file/data/

#array=( "relationships.zip" "pathways-biopax.zip" "annotations.zip" "clinicalVariants.zip" "genes.zip" "variants.zip" "phenotypes.zip" "drugs.zip" "chemicals.zip" )

#Execlude genes.zip until implementing the solution
array=( "relationships.zip" "pathways-biopax.zip" "annotations.zip" "clinicalVariants.zip" "variants.zip" "phenotypes.zip" "drugs.zip" "chemicals.zip" )

# Original: drugs|genes|diseases|pathways|relationships|annotations|rsid
# Not downloaded: pathways-tsv.zip, dosingGuidelines.json.zip, drugLabels.zip
# relationships.zip is the most important


# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... $BASE_URI${var}"
  wget -N -a download.log $BASE_URI${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
