#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


# All studies records (1.3G). No need for HTML crawling
wget -N -a download.log https://clinicaltrials.gov/AllPublicXML.zip


# Download acct files? (800M psv)
wget -O index.html -a download.log https://aact.ctti-clinicaltrials.org/pipe_files
aact_array=( $(cat index.html | sed -r -n 's/.*href="(static\/exported_files\/monthly\/.*?)".*/\1/p') )

echo "Download acct file: ${aact_array[0]}"
wget -N -a download.log ${aact_array[0]}

rename s/\.txt/.psv/ *.txt

#https://aact.ctti-clinicaltrials.org/static/exported_files/monthly/20180701_pipe-delimited-export.zip
#href="/static/exported_files/monthly/20180701_pipe-delimited-export.zip"