#!/bin/bash
DELETE_PREVIOUS_DDL=false
# Iterate over arguments
for arg in "$@"
do
  # If -d flag then we delete all the files previously downloaded
  if [ "$arg" = "-d" ]; then 
    DELETE_PREVIOUS_DDL=true
  fi
done
YAML_PATH="/app/config.yaml"



# Parse yaml
echo "---------------------------------"
echo "  YAML configuration:"
param_array=( $(cat $YAML_PATH | sed -r -n 's/([^#]*?):(.+)/\1\2/p') )
i=0  
while [ $i -le ${#param_array[@]} ]  
do  
  VAR_NAME=${param_array[$i]}
  i=$(( $i + 1 ))
  if [[ -z "$VAR_NAME" ]]; then
    continue
  fi
  echo "$VAR_NAME = ${param_array[$i]}"
  eval "$VAR_NAME"="\"${param_array[$i]}\""
  # Show an error but works at naming the var with another var
  i=$(( $i + 1 ))
done
# Careful: it takes all lines starting with a "-". So no other array
download_datasets=( $(sed -n -e 's/^\s*- //p' $YAML_PATH) )



PROJECT_DIR=$( "pwd" )

echo "Download datasets: ${download_datasets}"
echo "Download directory: $download_workdir"
#echo "Project directory: $PROJECT_DIR"
echo "---------------------------------"

# Delete all previously downloaded file
if [ $DELETE_PREVIOUS_DDL = true ]; then 
  rm -rf $download_workdir
  echo "Deleting all previous downloads"
else
  echo "Keeping previous downloads"
fi
mkdir -p "$download_workdir"

for dataset in "${download_datasets[@]}"
do
  DATASET_DIR=$download_workdir/${dataset}
  echo "---------------------------------"
  echo "Downloading dataset to $DATASET_DIR"
  cd $PROJECT_DIR
  source datasets/${dataset}/download.sh $DATASET_DIR
done

cd $download_workdir

# Go through the logs to check for error or failed download
grep -rl --include \*.log ERROR > download_failed.log
grep -rl --include \*.log failed >> download_failed.log

# Print a nice kraken in ascii
cat $PROJECT_DIR/ascii_kraken.txt

echo " "
echo "Download complete!"
echo "Check out failed download at $download_workdir/download_failed.log"
echo "---------------------------------"
echo "    Failed download:"
cat download_failed.log