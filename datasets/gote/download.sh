#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1



BASE_URI="http://tatonettilab.org/resources/GOTE/source_code/results/"


########## Download files

## HTML EXTRACT URL to an array
# Download simple HTML page and name it as index.html
wget -O index.html -a download.log $BASE_URI
# Extract URL fron the HTML document to an array. Feel free to change the regex
array=( $(cat index.html | sed -r -n 's/.*href="([^"]*?\.txt)".*/\1/p') )
for var in "${array[@]}"
do
  # Download each URL
  wget -N -a download.log $BASE_URI${var}
done


## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt


## ADD COLUMNS NAME
sed -i '1s/^/TissueName\tGpcrUniprotId\tPathwayNames\tPathwayPValue\tZscoreHighGpcrExpression\tZscoreSpecificExpression\n/' *.tsv