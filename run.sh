#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Using current directory config.yaml"
  CONFIG=config.yaml
else
  CONFIG=$1
fi

cp $CONFIG /data/config.yaml
docker run -it --rm -v /data:/data kraken-download /data/config.yaml -d
