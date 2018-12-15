#!/bin/bash
DELETE_PREVIOUS_DDL=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -d|--download-datasets)
    DOWNLOAD_DATASETS="$2"
    shift # past argument
    shift # past value
    ;;
    -un|--username)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -pw|--password)
    PASSWORD="$2"
    shift # past argument
    shift # past value
    ;;
    --clean)
    DELETE_PREVIOUS_DDL=true
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


IFS=',' read -ra DATASETS_ARRAY <<< "$DOWNLOAD_DATASETS"

PROJECT_DIR=$( "pwd" )

WORKING_PATH="/data"

echo "Download datasets: $DOWNLOAD_DATASETS"
echo "Clean the download directory: $DELETE_PREVIOUS_DDL"

# Delete all previously downloaded file
if [ $DELETE_PREVIOUS_DDL = true ]; then 
  rm -rf $WORKING_PATH/*
fi
mkdir -p "$WORKING_PATH"


for dataset in "${DATASETS_ARRAY[@]}"
do
  DATASET_DIR=$WORKING_PATH/${dataset}
  echo "---------------------------------"
  echo "Downloading dataset to $DATASET_DIR"
  cd $PROJECT_DIR
  source datasets/${dataset}/download.sh $DATASET_DIR
done


cd $WORKING_PATH

# Go through the logs to check for error or failed download
grep -rl --include \*.log ERROR > download_failed.log
grep -rl --include \*.log failed >> download_failed.log

# Print a nice kraken in ascii
cat $PROJECT_DIR/ascii_kraken.txt

echo " "
echo "Download complete!"
echo "Check out failed download at $WORKING_PATH/download_failed.log"
echo "---------------------------------"
echo "    Failed download:"
cat download_failed.log