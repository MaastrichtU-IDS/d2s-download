#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

BASE_URI="https://clinicaltrials.gov/ct2"

CRAWL_URI="$BASE_URI/crawl"

# All studies records (1.3G)
wget -a download.log https://clinicaltrials.gov/AllPublicXML.zip



echo "Base URI $BASE_URI"

echo "Crawl URI $CRAWL_URI"
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
    wget -a download.log "$BASE_URI/${show_file}?resultsxml=true"

    #sudo apt install rename
    # Rename files for proper .xml extension
    rename s/.resultsxml=true/.xml/ *resultsxml=true*
  done

done

# Then download acct files (800M psv)
wget -a download.log -O index.html https://aact.ctti-clinicaltrials.org/pipe_files
aact_array=( $(cat index.html | sed -r -n 's/.*href="(static\/exported_files\/monthly\/.*?)".*/\1/p') )

echo "Download acct file: ${aact_array[0]}"
wget -a download.log ${aact_array[0]}

rename s/\.txt/.psv/ *.txt

#https://aact.ctti-clinicaltrials.org/static/exported_files/monthly/20180701_pipe-delimited-export.zip
#href="/static/exported_files/monthly/20180701_pipe-delimited-export.zip"