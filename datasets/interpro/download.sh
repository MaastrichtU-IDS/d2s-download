#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Download interpro https://www.ebi.ac.uk/interpro/download.html
wget -N -a download.log ftp://ftp.ebi.ac.uk/pub/databases/interpro/interpro.xml.gz

find . -name "*.gz" -exec gzip -d  {} +

# To avoid error with not finding interpro.dtd when processing with xml2rdf
sed -i -- 's/interpro.dtd/ftp:\/\/ftp.ebi.ac.uk\/pub\/databases\/interpro\/69.0\/interpro.dtd/g' interpro.xml