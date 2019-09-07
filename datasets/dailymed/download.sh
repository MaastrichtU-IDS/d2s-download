#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1


# DailyMed SPL (Structured Product Labeling) resources https://dailymed.nlm.nih.gov/dailymed/spl-resources-all-drug-labels.cfm
wget -N -a download.log ftp://public.nlm.nih.gov/nlmdata/.dailymed/dm_spl_release_human_rx_part1.zip
wget -N -a download.log ftp://public.nlm.nih.gov/nlmdata/.dailymed/dm_spl_release_human_rx_part2.zip
wget -N -a download.log ftp://public.nlm.nih.gov/nlmdata/.dailymed/dm_spl_release_human_rx_part3.zip

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;

# Unzip the zip files that were in the previous zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
