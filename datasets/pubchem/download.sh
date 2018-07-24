#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# RDF files can be found here: ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/

# More info: https://pubchemdocs.ncbi.nlm.nih.gov/rdf
# wget -r -A ttl.gz -nH --cut-dirs=2 ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/substance


databases=( "Compound/CURRENT-Full/XML/" "Substance/CURRENT-Full/XML/" "Bioassay/XML/")

for database in "${databases[@]}"
do
  DATABASE_DIR=$1/$database
  mkdir -p $DATABASE_DIR
  cd $DATABASE_DIR
  wget -a download.log ftp://ftp.ncbi.nlm.nih.gov/pubchem/${database}/

  # Extract download links from HTML
  array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

  # Download all extracted links
  for var in "${array[@]}"
  do
    echo "Downloading... ${var}"
    wget -a download.log ${var}
  done

done

find . -name "*.gz" -exec gzip -d  {} +
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
