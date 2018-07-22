#!/bin/bash

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
 } 


# Parse yaml
param_array=( $(cat $1 | sed -r -n 's/([^#]*?):(.+)/\1\2/p') )


echo ${#param_array[@]}
i=0  
while [ $i -le ${#param_array[@]} ]  
do  
    VAR_NAME=${param_array[$i]}
    i=$(( $i + 1 ))
    echo "$VAR_NAME = ${param_array[$i]}"
    eval "$VAR_NAME"="\"${param_array[$i]}\""
    i=$(( $i + 1 ))
done

# Careful: it takes all lines starting with a "-". So no other array
download_datasets=( $(sed -n -e 's/^\s*- //p' $1) )

#cat config.yaml | sed -r -n 's/(.*?):(.*)/\1\2/p'

#sed -e 's/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' config.yaml


#parse_yaml $1
#eval $(parse_yaml $1)

echo "Download datasets: ${download_datasets}"

# REMOVE download_workdir="/data/kraken-download/datasets"

echo "Download directory: $download_workdir"

PROJECT_DIR=$( "pwd" )

echo "Project directory: $PROJECT_DIR"

mkdir -p $download_workdir

for dataset in "${download_datasets[@]}"
do
  cd $PROJECT_DIR
  DATASET_DIR=$download_workdir/${dataset}
  echo "Downloading dataset to $DATASET_DIR"
  echo $( pwd )
  source datasets/${dataset}/download.sh $DATASET_DIR
  #. ./datasets/${dataset}/download.sh $DATASET_DIR
done

cd $download_workdir

# Go through the logs to check for error or failed download
grep -rl --include \*.log ERROR > download_failed.log
grep -rl --include \*.log failed >> download_failed.log

# Change cmd output stream 
# | sed -e "s/\/download.log//g"