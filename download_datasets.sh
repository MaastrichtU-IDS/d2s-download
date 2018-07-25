#!/bin/bash

# Parse yaml
param_array=( $(cat $1 | sed -r -n 's/([^#]*?):(.+)/\1\2/p') )
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

PROJECT_DIR=$( "pwd" )

echo "Download datasets: ${download_datasets}"
echo "Download directory: $download_workdir"
echo "Project directory: $PROJECT_DIR"

# To reset all downloads at each run
rm -rf $download_workdir
mkdir -p $download_workdir

for dataset in "${download_datasets[@]}"
do
  DATASET_DIR=$download_workdir/${dataset}
  echo "Downloading dataset to $DATASET_DIR"
  cd $PROJECT_DIR
  source datasets/${dataset}/download.sh $DATASET_DIR
done

cd $download_workdir

# Go through the logs to check for error or failed download
grep -rl --include \*.log ERROR > download_failed.log
grep -rl --include \*.log failed >> download_failed.log

cat $PROJECT_DIR/ascii_kraken.txt

echo " "
echo "Download done!"
echo "Check out failed download at $download_workdir/download_failed.log"
echo "    Failed download"
cat download_failed.log