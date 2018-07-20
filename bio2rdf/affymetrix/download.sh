#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

wget -a download.log https://www.thermofisher.com/nl/en/home/life-science/microarray-analysis/microarray-data-analysis/genechip-array-annotation-files.html

# Extract download links from HTML
#array=( $(cat genechip-array-annotation-files.html | grep -oP '((?:http|ftp)[^"|\s]*?(\.zip|\.gz|\.csv|\.tsv))') )
array=( $(cat genechip-array-annotation-files.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Log in to the server. This only needs to be done once.
wget -a download.log --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=vincent.emonet@maastrichtuniversity.nl&password=maasitest12' \
     --delete-after \
     https://www.thermofisher.com/oam/server/auth_cred_submit

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log --load-cookies cookies.txt ${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
