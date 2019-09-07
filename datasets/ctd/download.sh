#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


BASE_URI=http://ctdbase.org/reports/

#array=( "chem_gene_ixns" "chem_gene_ixn_types" "chemicals_diseases" "chem_go_enriched" "chem_pathways_enriched" "genes_diseases" "genes_pathways" "diseases_pathways" "chemicals" "diseases" "genes" "pathways" )

wget -O index.html -a download.log $BASE_URI

# Download Exposure ontology in OWL (instead of OBO)
wget -N -a download.log https://www.ebi.ac.uk/ols/ontologies/exo/download

mv download exo.owl

# Extract URL from the HTML document to an array. Feel free to change the regex
array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?(\.xml|\.xml\.gz))".*/\1/p') )
for var in "${array[@]}"
do
  wget -N -a download.log ${var}
done


gzip -d *.gz
