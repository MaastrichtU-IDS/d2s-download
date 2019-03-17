# data2services-download

A project to automate download of datasets for the Data2Services project using Shell scripts.

## Run on Docker

### Build

```shell
docker build -t data2services-download .
```

### Run

Download files in `/data/data2services`.

```shell
docker run -it --rm -v /data/data2services:/data data2services-download \
	--download-datasets aeolus,pharmgkb,ctd \
	--username my_login --password my_password \
	--clean # to delete all files in /data/data2services
```

Datasets bundles:

```shell
# XML
docker run -it --rm -v /data/data2services:/data data2services-download --download-datasets clinicaltrials,pubmed,interpro,bioproject,clinvar,dailymed,dbsnp,flybase,orphanet,pdb

# TSV
docker run -it --rm -v /data/data2services:/data data2services-download --download-datasets stitch,pharmgkb,drugcentral,bindingdb,ncbigene,ndc,stitch,genage,ncbigene,irefindex

# NCATS Translator program
docker run -it --rm -v /data/data2services:/data data2services-download --download-datasets gote,disgenet,pathwaycommons,biogrid,wikipathways,preppi,clinicaltrials,pubmed,kegg
```

More datasets can be found in `./datasets`

### Add a new dataset

Shell scripts are executed to download each dataset. Add your own.

* Copy and rename the TEMPLATE directory, then change the `download.sh` accordingly, you will find a lot of simple operations to download files already covered.
* Use the name of the directory to pass it as a dataset to download.
* Use `$USERNAME` and `$PASSWORD` variables if you need one.

See the [Wiki](https://github.com/MaastrichtU-IDS/data2services-download/wiki) for more details on common Shell download operations.
