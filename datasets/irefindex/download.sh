#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


# The web services might be updated more regurlarly
BASE_URI="http://irefindex.org/download/irefindex/data/current/psi_mitab/MITAB2.6/"
# Download separately the databases: "10090|10116|4932|559292|562|6239|7227|9606"

wget -N -a download.log $BASE_URI

# Only download All http://irefindex.org/wiki/index.php?title=README_MITAB2.6_for_iRefIndex_15.0#Directory_contents
array=( $(cat index.html | sed -r -n 's/.*href="((All)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Download http://irefindex.org/download/irefindex/data/archive/release_15.0/psi_mitab/MITAB2.6/All.mitab.$DATE.txt.zip
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -N -a download.log $BASE_URI${var}
done

# Extract directly in the dir
unzip -o \*.zip

# Rename extension to tsv because it is tsv and more convinient for future processing
rename s/\.txt/.tsv/ *.txt