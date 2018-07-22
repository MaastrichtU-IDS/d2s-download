#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download/bio2rdf"
  exit 1
fi

mkdir -p $1
cd $1
rm -rf *

# Log in to the server. This only needs to be done once.
wget -a download.log --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'public_user[email]=$drugbank_login&public_user[password]=$drugbank_password&public_user[remember_me]=1&authenticity_token=duGIJGcyaSmNlV9gl4l0kJPIaXZy8osM405HmEjZhQTIMUwxrwXvnaZ61zQKq0kWo9HhuvqGLo9VODFYrMX5Kg&commit=Signin' \
     https://www.drugbank.ca/public_users/sign_in
     #--delete-after \
# Seems to work better when credentials are hard coded (see cookies.txt)...

# Download all extracted links
wget -a download.log -O drugbank_all_full_database.xml.zip --load-cookies cookies.txt "https://drugbank.s3.us-west-2.amazonaws.com/public_downloads/downloads/000/002/022/original/drugbank_all_full_database.xml.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJTZC3DSCEEG75A6Q%2F20180719%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20180719T003719Z&X-Amz-Expires=10&X-Amz-SignedHeaders=host&X-Amz-Signature=9fb60bf8ac341884d1b00375e23d576902834d2735ddc14d1ed08f588c12b186"

# Returns 403 Forbidden

# Unzip all files in subdir with name of the zip file
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;