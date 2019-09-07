#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


# Wormbase
# Download ontologies in OBO
wget -N -a download.log -r -A obo -nH --cut-dirs=5 ftp://ftp.wormbase.org/pub/wormbase/releases/current-production-release/ONTOLOGY/

# Old way:
# BASE_URI="ftp://ftp.wormbase.org/pub/wormbase"
# geneIDs wget -N -a download.log $BASE_URI/species/c_elegans/annotation/geneIDs/c_elegans.PRJNA13758.current.geneIDs.txt.gz
# functional_descriptions wget -N -a download.log $BASE_URI/species/c_elegans/annotation/functional_descriptions/c_elegans.PRJNA13758.current.functional_descriptions.txt.gz
# gene_interactions wget -N -a download.log $BASE_URI/species/c_elegans/annotation/gene_interactions/c_elegans.PRJNA13758.current.gene_interactions.txt.gz

#gene_association wget -N -a download.log $BASE_URI/releases/current-production-release/ONTOLOGY/gene_association.WS264.wb
# phenotype_association wget -N -a download.log $BASE_URI/releases/current-production-release/ONTOLOGY/phenotype_association.WS264.wb


find . -name "*.gz" -exec gzip -d  {} +
