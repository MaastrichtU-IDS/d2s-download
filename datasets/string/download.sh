#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


### String DB: https://string-db.org/cgi/download.pl

# full database, part I: the players (proteins, species, COGs,...). 4.9G
wget -a download.log https://stringdb-static.org/download/items_schema.v10.5.sql.gz

# full database, part II: the networks (nodes, edges, scores,...). 41.3G
wget -a download.log https://stringdb-static.org/download/network_schema.v10.5.sql.gz

# full database, part III: interaction evidence (but: excluding license-restricted data). 6.9G
wget -a download.log https://stringdb-static.org/download/evidence_schema.v10.5.sql.gz

# full database, part IV: homology data (all-against-all SIMAP similarity searches). 460G
wget -a download.log https://stringdb-static.org/download/homology_schema.v10.5.sql.gz


find . -name "*.gz" -exec gzip -d  {} +
