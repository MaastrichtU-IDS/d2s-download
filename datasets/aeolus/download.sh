#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

########## Download SQL database files

wget -a download.log https://datadryad.org/bitstream/handle/10255/dryad.105332/aeolus_v1.zip

########## UNCOMPRESS

# ZIP
# Recursive in subdir
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;

### TODO

# Then the TSV files need to be loaded into a MySQL database
# See instructions in the README.txt
# The SQL script used to load the data can be found in this directory as load_database.sql


########## Download JSON from API: direct pair reaction
# http://smart-api.info/ui/b2dd6372009df54206670648e16eaa90

wget -a download.log -O drugReactionCounts_1.json "https://www.nsides.io/api/v1/aeolus/drugReactionCounts?q=1" --no-check-certificate --header  "accept: */*"

wget -a download.log -O drugpairList.json "https://www.nsides.io/api/v1/aeolus/drugpairList" --no-check-certificate --header  "accept: */*"

wget -a download.log -O drugpairReactionCounts_1.json "https://www.nsides.io/api/v1/aeolus/drugpairReactionCounts?q=1" --no-check-certificate --header  "accept: */*"

wget -a download.log -O drugpairReactionListMedDRA.json "https://www.nsides.io/api/v1/aeolus/drugpairReactionListMedDRA" --no-check-certificate --header  "accept: */*"

wget -a download.log -O ingredientList.json "https://www.nsides.io/api/v1/aeolus/ingredientList" --no-check-certificate --header  "accept: */*"

wget -a download.log -O reactionListMedDRA.json "https://www.nsides.io/api/v1/aeolus/reactionListMedDRA" --no-check-certificate --header  "accept: */*"

wget -a download.log -O reactionListSNOMED.json "https://www.nsides.io/api/v1/aeolus/reactionListSNOMED" --no-check-certificate --header  "accept: */*"