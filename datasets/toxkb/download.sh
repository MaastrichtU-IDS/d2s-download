#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *


# dsstox
wget -N -a download.log ftp://ftp.epa.gov/dsstoxftp/DSSTox_Archive_20150930/CPDBAS_DownloadFiles/CPDBAS_v5d_1547_20Nov2008.zip

# toxcast
# In original file: http://www.epa.gov/ncct/toxcast/files/ToxCast_20110110.zip
# Download page that I found: https://www.epa.gov/chemical-research/exploring-toxcast-data-downloadable-data

unzip -o \*.zip
