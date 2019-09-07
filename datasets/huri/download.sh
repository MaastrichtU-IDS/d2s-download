#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# HuRI: http://interactome.baderlab.org/download

wget -N -a download.log http://interactome.baderlab.org/data/HuRI.tsv
