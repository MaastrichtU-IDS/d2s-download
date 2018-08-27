docker run -it --rm -v /data/kraken/download/:/data -v %1:/app/config.yaml kraken-download
:: To delete all file previously download add the flag "-d" at the end