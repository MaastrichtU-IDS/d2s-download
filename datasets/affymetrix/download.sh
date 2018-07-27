#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

wget -a download.log -O index.html https://www.thermofisher.com/nl/en/home/life-science/microarray-analysis/microarray-data-analysis/genechip-array-annotation-files.html

# Extract download links from HTML
array=( $(cat index.html | sed -r -n 's/.*href="((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

# Log in to the server. This only needs to be done once.
wget -a download.log --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=$affymetrix_login&password=$affymetrix_password' \
     --delete-after \
     https://www.thermofisher.com/oam/server/auth_cred_submit

# Login failed in auth_cred_submit
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=vincent.emonet@maastrichtuniversity.nl&password=maasitest12' \
     https://www.thermofisher.com/oam/server/auth_cred_submit

# Postman wget (returns 200 on Postman)
wget --method POST \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --header 'Cache-Control: no-cache' \
  --header 'Postman-Token: dc889021-6bc4-4760-8095-1bd9b41bdc7e' \
  --body-data 'username=vincent.emonet%40maastrichtuniversity.nl&password=maasitest12' \
  - https://www.thermofisher.com/oam/server/auth_cred_submit

# Postman cURL
curl -X POST \
  https://www.thermofisher.com/oam/server/auth_cred_submit \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Postman-Token: cd3c59ba-b71d-4eaa-ac40-2b0239f07804' \
  -d 'username=vincent.emonet%40maastrichtuniversity.nl&password=maasitest12'

# Download all extracted links
for var in "${array[@]}"
do
  echo "Downloading... ${var}"
  wget -a download.log --load-cookies cookies.txt ${var}
done

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
