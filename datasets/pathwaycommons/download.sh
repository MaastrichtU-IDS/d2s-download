#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


### Pathwaycommons

# Download Biopax OWL file 1.3G
wget -N -a download.log http://www.pathwaycommons.org/archives/PC2/v10/PathwayCommons10.All.BIOPAX.owl.gz

find . -name "*.gz" -exec gzip -d  {} +