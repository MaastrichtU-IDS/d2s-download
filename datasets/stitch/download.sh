#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1

# TODO: use curl?
# https://superuser.com/questions/908293/download-file-via-http-only-if-changed-since-last-update

# Stitch: http://stitch.embl.de/cgi/download.pl

# CHEMICAL NETWORK

# Chemical-chemical links
wget -N -a download.log http://stitch.embl.de/download/chemical_chemical.links.v5.0.tsv.gz

# Protein-chemical links. Taking only for human specie at the moment to make it lighter (too big otherwise)
wget -N -a download.log http://stitch.embl.de/download/protein_chemical.links.detailed.v5.0/9606.protein_chemical.links.detailed.v5.0.tsv.gz
# Complete 30G version: wget -N -a download.log http://stitch.embl.de/download/protein_chemical.links.v5.0.tsv.gz

# chemical-protein network data (incl. distinction: direct vs. interologs)
#wget -N -a download.log http://stitch.embl.de/download/protein_chemical.links.transfer.v5.0/9606.protein_chemical.links.transfer.v5.0.tsv.gz
# Complete 30G version: wget -N -a download.log http://stitch.embl.de/download/protein_chemical.links.transfer.v5.0.tsv.gz

# Interaction types for links 
#wget -N -a download.log http://stitch.embl.de/download/actions.v5.0/9606.actions.v5.0.tsv.gz
# Complete 66G version: wget -N -a download.log http://stitch.embl.de/download/actions.v5.0.tsv.gz



# GENERAL FLATFILES

# names and SMILES strings of STITCH's chemicals (2G)
#wget -N -a download.log http://stitch.embl.de/download/chemicals.v5.0.tsv.gz

# InChIKeys for STITCH compounds (for 'flat' and stereo-specific compounds) (1.3G)
wget -N -a download.log http://stitch.embl.de/download/chemicals.inchikeys.v5.0.tsv.gz

# aliases (synonyms) for chemicals (1.5G)
#wget -N -a download.log http://stitch.embl.de/download/chemical.aliases.v5.0.tsv.gz

# links to other chemical databases (2G)
wget -N -a download.log http://stitch.embl.de/download/chemical.sources.v5.0.tsv.gz



find . -name "*.gz" -exec gzip -d  {} +