#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# HPO Mammelian Phenotype Ontology
wget -N -a download.log https://www.ebi.ac.uk/ols/ontologies/mp/download

mv download mpo.owl