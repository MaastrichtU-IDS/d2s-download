#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1



# Download ontology
wget -N -a download.log http://aber-owl.net/media/ontologies/PhenomeNET/1/phenomenet.owl
