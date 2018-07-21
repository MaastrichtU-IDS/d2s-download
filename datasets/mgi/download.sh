#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="http://www.informatics.jax.org/downloads/reports/"
array=( "MGI_Strain" "MGI_PhenotypicAllele" "MGI_GenePheno" "MRK_Sequence" "MGI_Geno_DiseaseDO" "MGI_Geno_NotDiseaseDO" )


# Download all gene an species files
for file in "${array[@]}"
do
  echo "Downloading... ${file}"
  wget -a download.log "$BASE_URI$file.rpt"
done

# WARNING
# To get the column we have to extract them from the HTML and add it on the top of the csv
#http://www.informatics.jax.org/downloads/reports/index.html

# Rename extension to tsv because it is tsv and more convenient for future processing
rename s/\.rpt/.tsv/ *.xrefs