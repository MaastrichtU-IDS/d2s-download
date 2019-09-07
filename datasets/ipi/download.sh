#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="ftp://ftp.ebi.ac.uk/pub/databases/IPI/last_release/current/"
genes_array=( "ARATH" "BOVIN" "CHICK" "DANRE" )
species_array=( "ARATH" "BOVIN" "CHICK" "DANRE" "HUMAN" "MOUSE" "RAT" )

# Download all gene an species files
for gene in "${genes_array[@]}"
do
  echo "Downloading Gene... ${gene}"
  GENE_URI=ipi.genes.${gene}.xrefs.gz
  wget -N -a download.log $BASE_URI$GENE_URI
done

for specie in "${species_array[@]}"
do
  echo "Downloading Specie... ${specie}"
  SPECIE_URI=ipi.${specie}.xrefs.gz
  wget -N -a download.log $BASE_URI$SPECIE_URI
done

find . -name "*.gz" -exec gzip -d  {} +

# Rename extension to tsv because it is tsv and more convinient for future processing
rename s/\.xrefs/.tsv/ *.xrefs