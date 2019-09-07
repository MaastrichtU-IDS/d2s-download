#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

wget -N -a download.log http://tatonettilab.org/resources/DATE/date_resource.zip


########## UNCOMPRESS

# ZIP
# All in same dir
unzip -o \*.zip

# Should contains 2 tsv
# date_resource/Drug_target_reactome_pathway.tsv
# date_resource/Drug_target_reactome_pathway_filtered.tsv