#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


wget -N -a download.log -N ftp://ftp.ncbi.nih.gov/genbank/

array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -N -a download.log -N ${var}
done

# Unzip all files in subdir with name of the zip file
gzip -d *.gz