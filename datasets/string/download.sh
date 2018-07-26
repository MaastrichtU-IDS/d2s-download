#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


# String DB: https://string-db.org/cgi/download.pl

# All files, except PSICQUIC files (tsv), are 1 space separated value files
# INTERACTION DATA

# Links: protein network data (incl. distinction: direct vs. interologs) (108M)
wget -a download.log https://stringdb-static.org/download/protein.links.full.v10.5/9606.protein.links.full.v10.5.txt.gz
# All species: 29G
#wget -a download.log https://stringdb-static.org/download/protein.links.full.v10.5.txt.gz

# Actions: interaction types for protein links (21M)
wget -a download.log https://stringdb-static.org/download/protein.actions.v10.5/9606.protein.actions.v10.5.txt.gz
# All species: 12G
#wget -a download.log https://stringdb-static.org/download/protein.actions.v10.5.txt.gz


# ACCESSORY DATA

# orthologous groups (COGs,NOGs,KOGs,...) and their proteins  
wget -a download.log https://stringdb-static.org/download/COG.mappings.v10.5.txt.gz

# presence / absence of orthologous groups in species  (127M)
wget -a download.log https://stringdb-static.org/download/species.mappings.v10.5.txt.gz

# aliases for STRING proteins: locus names, accessions, descriptions... (12M)
wget -a download.log https://stringdb-static.org/download/protein.aliases.v10.5/9606.protein.aliases.v10.5.txt.gz
# All species: 622M
#wget -a download.log https://stringdb-static.org/download/protein.aliases.v10.5.txt.gz

# [tsv file] protein network data in PSI-MI MITAB2.5 (PSICQUIC) format (30M)
wget -a download.log https://stringdb-static.org/download/psicquic-mitab_2.5.v10.5/9606.psicquic-mitab_2.5.v10.5.txt.gz
# All species 97G
#wget -a download.log https://stringdb-static.org/download/psicquic-mitab_2.5.v10.5.tar

find . -name "*.gz" -exec gzip -d  {} +
#find . -name "*.tar.gz" -exec tar -xzvf {} \;