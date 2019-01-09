#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


### EggNOG

# http://eggnogdb.embl.de/#/app/downloads

wget -a download.log http://eggnogdb.embl.de/download/latest/data/NOG/NOG.members.tsv.gz

wget -a download.log http://eggnogdb.embl.de/download/latest/data/NOG/NOG.annotations.tsv.gz

wget -a download.log http://eggnogdb.embl.de/download/latest/data/NOG/NOG.trees.tsv.gz


# Only FASTA sequences (.fa or .hmm files)
#wget -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.trimmed_algs.tar.gz
#wget -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.raw_algs.tar.gz
#wget -a download.log http://eggnogdb.embl.de/download/eggnog_4.5/data/NOG/NOG.hmm.tar.gz

find . -name "*.gz" -exec gzip -d  {} +