#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# BindingDB https://www.bindingdb.org/bind/chemsearch/marvin/SDFdownload.jsp?all_download=yes
wget -N -a download.log "https://www.bindingdb.org/bind/chemsearch/marvin/SDFdownload.jsp?all_download=yes"

mv "SDFdownload.jsp?all_download=yes" index.html

# In the html file: downloads/BindingDB_All_2018m6.tsv.zip">BindingDB_All_2018m6.tsv.zip</a> ( 254.56 MB, updated 2018-07-01 )</li>
array=( $(cat index.html | sed -r -n 's/.*>(BindingDB_All_[^"]*?.\.tsv\.zip).*/\1/p') )
#( IFS=$'\n'; echo "${array[*]}" )

wget -N -a download.log "https://www.bindingdb.org/bind/downloads/${array[0]}"
# Download something like https://www.bindingdb.org/bind/downloads/BindingDB_All_2018m6.tsv.zip

find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
