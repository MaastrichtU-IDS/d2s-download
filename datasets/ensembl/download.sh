#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# ensembl
# Download ftp://ftp.ensembl.org/pub/current_rdf/aotus_nancymaae/aotus_nancymaae.ttl.gz and ftp://ftp.ensembl.org/pub/current_rdf/aotus_nancymaae/aotus_nancymaae_xrefs.ttl.gz.graph
wget -N -a download.log -r -A ttl.gz -nH --cut-dirs=2 ftp://ftp.ensembl.org/pub/current_rdf
