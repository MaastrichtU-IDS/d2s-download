#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Using current directory config.yaml"
  CONFIG=$PWD/config.yaml
else
  CONFIG=$1
fi

docker run -dit --rm -v /data:/data -v $CONFIG:/app/config.yaml kraken-download
# To delete all file previously download add the flag "-d" at the end