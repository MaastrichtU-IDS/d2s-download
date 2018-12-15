# data2services-download

A project to automate download of datasets for the Data2Services project.

## Run on Docker

### Build

```shell
./build.sh
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

* Copy and rename the TEMPLATE directory, then change the download.sh accordingly, you will find a lot of simple operations to download files already covered.
* Use the name of the directory to pass it as a dataset to download.
* Use `$USERNAME` and `$PASSWORD` variables if you need one.

## Todo

* Testing if the download properly worked
* Use Python to handle errors, test and running the pipeline?



## Extract bio2rdf URLs

See https://github.com/bio2rdf/bio2rdf-scripts

Link to exact license file

Check PSICQUIC because a lot of references (irefindex)

2 kind of datasets: aggregators (iproclass, irefindex) vs descriptive db



## Common operations

### Download files with wget

* `-a download.log` redirect console output to file

* `-r` for recursive download
* `-O index.html` rename the downloaded file 
* `-A` to only ddl ttl.gz files. 
* `-nH` to remove the URL from filename (and keep only directories)
* `--cut-dirs=2` to remove dirs from filename
* Example: ftp.xemacs.org/pub/xemacs/
  * `-nH` : pub/xemacs/
  * `-nH --cut-dirs=1` : xemacs/
  * `-nH --cut-dirs=2` : .
* `-P compound` save all dir and subdir downloaded by this wget to this dir

```shell
# Rename single file download
wget -a download.log -O index.html ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBL-RDF/latest/

# Download recursively all files in ftp that have the given extension
wget -a download.log -r -A gz -nH ftp://ftp.ncbi.nlm.nih.gov/pubchem/

# To properly name the dir created during download
wget -a download.log -r -A ttl.gz -R reject_this -nH --cut-dirs=3 -P compound ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/compound/general
# -nH to remove `ftp.ncbi.nlm.nih.gov`
# --cut-dirs=3 to remove `pubchem/RDF/compound`
# -P to store in the compound dir
```



### Extract and iterate over files URL in HTML

```shell
# Extract URL from a HTML page to an array
array=( $(cat index.html | sed -r -n 's/.*((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

for var in "${array[@]}"
do
  # Download each URL
  wget -a download.log ${var}
done

## Manipulate array
# Remove file finishing by test.ttl from the array
array=( ${array[@]//*test.ttl/} )
# Display array
( IFS=$'\n'; echo "${array[*]}" )
```



### Authentication

* wget (affymetrix)

```shell
# Affymetrix example. Log in to the server. This only needs to be done once.
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=vincent.emonet@maastrichtuniversity.nl&password=maasitest12' \
     --delete-after \
     https://www.thermofisher.com/oam/server/auth_cred_submit
     
wget --load-cookies cookies.txt  https://www.thermofisher.com/file_to_download
```

* curl (drugbank)

```shell
curl -Lfv -o drugbank.zip -u $drugbank_login:$drugbank_password https://www.drugbank.ca/releases/5-1-1/downloads/all-full-database
```



### Uncompress

##### Unzip in files with same name

```shell
# Recursive in subdir
find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;

# All in same dir
unzip -o \*.zip
```

##### Gzip recursively in subdirectories

Gzip are for single files (unless it is .tar.gz), so no need to put extract in directory

```shell
find . -name "*.gz" -exec gzip -d  {} +
```

##### Untar

```shell
# Recursively untar all files in actual dir
find . -name "*.tar.gz" -exec tar -xzvf {} \;
find . -name "*.tgz" -exec tar -xzvf {} \;
```

##### Bz2

```shell
find . -name "*.bz2" | while read filename; do bzip2 -f -d "$filename"; done;
```

### Rename extensions

```shell
rename s/\.txt/.tsv/ *.txt
```

### Parse JSON

```shell
# [] to iterate over array
cat ontologies.json | jq -r '.[].links.download'
```

