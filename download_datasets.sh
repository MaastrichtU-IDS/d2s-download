#!/bin/bash

PROJECT_DIR=$( "pwd" )
DDL_WORKDIR=/data/download/datasets

mkdir -p $DDL_WORKDIR



# Parse YAML
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
   # Careful: it takes all lines starting with a "-". So no other array
   download_datasets=( $(sed -n -e 's/^\s*- //p' $1) )
 }

parse_yaml config.yaml
echo $download_datasets_string
echo "Download datasets: ${download_datasets[1]}"

for dataset in "${download_datasets[@]}"
do
  cd $PROJECT_DIR
  DATASET_DIR=$DDL_WORKDIR/${dataset}
  echo "Downloading dataset $DATASET_DIR"
  source datasets/${dataset}/download.sh $DATASET_DIR
done

cd $DDL_WORKDIR

# Go through the logs to check for error or failed download
grep -rl --include \*.log ERROR > download_failed.log
grep -rl --include \*.log failed >> download_failed.log

# Change cmd output stream 
# | sed -e "s/\/download.log//g"