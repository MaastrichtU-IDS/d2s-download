FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y apt-utils rename gzip unzip wget

COPY datasets/ /datasets/
COPY download_datasets.sh /download_datasets.sh
COPY config.yaml /config.yaml

RUN chmod +x /download_datasets.sh

ENTRYPOINT ["/download_datasets.sh"]
CMD []
