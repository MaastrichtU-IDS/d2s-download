#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI=https://clinicaltrials.gov/ct2/

CRAWL_URI=crawl

wget -a download.log $CRAWL_URI

# Extract 2nd crawl link from HTML
crawl_array=( $(cat crawl | sed -r -n 's/.*href="\/ct2\/crawl\/(.*?)".*/\1/p') )
# Working but you need to match everything in the sentence to only keep captured groups (so .* at start and end)

# Download page from extracted URL. Similar to the previous page but with the ID of files to download
for var in "${crawl_array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log "$CRAWL_URI/${var}"

  # Extract IDs to link to XML files
  show_array=( $(cat ${var} | sed -r -n 's/.*href="\/ct2\/(show\/.*?)".*/\1/p') )

  for show_file in "${show_array[@]}"
  do
    # Download XML file
    wget -a download.log "$BASE_URI${show_file}?resultsxml=true"

    #sudo apt install rename
    # Rename files for proper .xml extension
    rename s/.resultsxml=true/.xml/ *resultsxml=true*
  done

done
