#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1



### String DB: https://string-db.org/cgi/download.pl

# Download multiple version of the TSV protein.actions containing protein interactions

# Download latest version 10.5
wget -N -a download.log https://stringdb-static.org/download/protein.actions.v10.5/9606.protein.actions.v10.5.txt.gz

# Download previous version 9.1 and 10
wget -N -a download.log http://version10.string-db.org/download/protein.actions.v10/9606.protein.actions.v10.txt.gz
wget -N -a download.log http://string91.embl.de/newstring_download/protein.actions.v9.1/9606.protein.actions.v9.1.txt.gz


### Old way: download whole SQL database, but too big (more than 500G)
# players (proteins, species, COGs,...). 4.9G
#wget -N -a download.log https://stringdb-static.org/download/items_schema.v10.5.sql.gz
# networks (nodes, edges, scores,...). 41.3G
#wget -N -a download.log https://stringdb-static.org/download/network_schema.v10.5.sql.gz
# interaction evidence (but: excluding license-restricted data). 6.9G
#wget -N -a download.log https://stringdb-static.org/download/evidence_schema.v10.5.sql.gz
# homology data (all-against-all SIMAP similarity searches). 460G
#wget -N -a download.log https://stringdb-static.org/download/homology_schema.v10.5.sql.gz



find . -name "*.gz" -exec gzip -d  {} +

rename s/\.txt/.tsv/ *.txt