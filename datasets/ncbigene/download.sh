#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


BASE_URI="ftp://ftp.ncbi.nih.gov/gene/DATA/"
array=( "gene_info" "gene2accession" "gene2ensembl" "gene2go" "gene2pubmed" "gene2refseq" "gene2sts" "gene2unigene" "gene2vega" )


# Download all gene files
for gene in "${array[@]}"
do
  echo "Downloading Gene... ${gene}"
  wget -N -a download.log "$BASE_URI${gene}.gz"
done


find . -name "*.gz" -exec gzip -d  {} +
# Add tsv extension
find ./gene* -type f -exec mv {} {}.tsv \;
