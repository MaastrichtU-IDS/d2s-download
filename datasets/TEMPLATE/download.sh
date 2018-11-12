#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


BASE_URI="http://data.wikipathways.org/current/rdf/"


########## Download files

## FTP DOWNLOAD recursively all files in ftp that have the given extension
wget -a download.log -r -A gz -nH ftp://ftp.ncbi.nlm.nih.gov/pubchem/


## PROPERLY NAME RECURSIVE DIR created during download
wget -a download.log -r -A ttl.gz -R reject_this -nH --cut-dirs=3 -P compound ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/compound/general
# -nH to remove `ftp.ncbi.nlm.nih.gov`
# --cut-dirs=3 to remove `pubchem/RDF/compound`
# -P to store in the compound dir


## HTML EXTRACT URL to an array
# Download simple HTML page and name it as index.html
wget -a download.log -O index.html $BASE_URI
# Extract URL fron the HTML document to an array. Feel free to change the regex
array=( $(cat index.html | sed -r -n 's/.*((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )
for var in "${array[@]}"
do
  # Download each URL
  wget -a download.log ${var}
done


## Manipulate array
# Remove file finishing by test.ttl from the array
array=( ${array[@]//*test.ttl/} )
# Display array
( IFS=$'\n'; echo "${array[*]}" )



########## UNCOMPRESS

# ZIP
# Recursive in subdir
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
# All in same dir
unzip -o \*.zip


#GZIP recusive in subdir
find . -name "*.gz" -exec gzip -d  {} +


# UNTAR recursively all files in actual dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;
find . -name "*.tgz" -exec tar -xzvf {} \;


# Bz2
find . -name "*.bz2" | while read filename; do bzip2 -f -d "$filename"; done;


## RENAME EXTENSION (e.g.: txt in tsv)
rename s/\.txt/.tsv/ *.txt