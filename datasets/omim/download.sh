#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

wget -a download.log https://omim.org/static/omim/data/mim2gene.txt

# Remove the 4 first lines
sed -i -e '1,4d' mim2gene.txt

## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt


## ADD COLUMNS NAME
# CSV
#sed -i '1s/^/column1,column2,column3\n/' *.csv
# TSV
#sed -i '1s/^/column1\tcolumn2\tcolumn3\n/' *.tsv