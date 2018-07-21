FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y apt-utils rename gzip unzip 

COPY datasets/ /datasets/
COPY download_datasets.sh /download_datasets.sh

RUN chmod +x /download_datasets.sh

CMD ["/download_datasets.sh"]
