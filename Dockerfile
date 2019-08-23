FROM ubuntu:18.04

LABEL maintainer  "Vincent Emonet <vincent.emonet@maastrichtuniversity.nl>"

RUN apt-get update -y && \
  apt-get install -y apt-utils curl rename gzip unzip bzip2 wget jq

WORKDIR app

COPY . .

RUN chmod +x download_datasets.sh

ENTRYPOINT ["./download_datasets.sh"]
CMD []
