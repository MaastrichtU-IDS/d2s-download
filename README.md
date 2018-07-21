# kraken-download

A project to automate download of datasets for the data2services/kraken project



## Run it

```shell
docker build -t kraken-download .
docker run -it --rm -v /data:/data kraken-download
```

## Todo

* Error handling (if a download fail report it and continue with other download)
* Log (log everything in download.log file)
* Testing if the download properly worked
* Use Python to handle errors, test and running the pipeline?



## Extract bio2rdf URLs

https://github.com/bio2rdf/bio2rdf-scripts

### Simple download

##### FTP

* HGNC

ftp://ftp.ebi.ac.uk/pub/databases/genenames/hgnc_complete_set.txt.gz

##### HTTP

* UniProt

  http://www.uniprot.org/uniref/?query=*&format=nt&compress=yes

  http://www.uniprot.org/uniparc/?query=*&format=nt&compress=yes

  http://www.uniprot.org/uniprot/?query=active:*&format=nt&compress=yes

#### Special

* mgi

  To get the column we have to extract them from the HTML and add it on the top of the csv

  http://www.informatics.jax.org/downloads/reports/index.html

  Use XPath xslt to extract

* ndc

  Not sure this is the right URL. From http://www.fda.gov/downloads/Drugs/DevelopmentApprovalProcess/UCM070838.zip

  to https://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM527389.zip

#### Failed download

* BioModels

  Login: vincent.emonet@maastrichtuniversity.nl

  Pw: maasitest12

  Problem: can't find the file to download

  http://www.ebi.ac.uk/biomodels/models-main/

* Bioportal

  Really different: we get ontologies from the REST API then we download each ontology

* chembl

  MySQL Database connection

* dbsnp

  Nothing found. Need an ID to complete URL

* Drugbank

  Problems with authentication

* linkedSPLs

  A lot of directories, don't know what to do

* mesh

  We can find n-triples here:

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/
  ```

  Only .bin files at

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/.asciimesh/
  ```

* Miriam 

  site could not be reached

* omim

  I applied to get an account, waiting for an answer

* orphanet

  Need a license http://www.orphadata.org/

* pathwaycommons

  It is saying that I should download those files: `homo-sapiens|hprd|humancyc|nci-nature|panther-pathway|phosphositeplus|reactome` at http://www.pathwaycommons.org/pc2/downloads/

  But the URL is returning a 404. 

  I found the download endpoint to be http://www.pathwaycommons.org/archives/PC2/v10/ .

  What should I do?

* pdb

  It is a maven project to run

* pubmed

  Nothing interesting at the given address ftp://ftp.nlm.nih.gov/nlmdata

  But here it seems good ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline

* sabiork

  REST API, not clear

  http://sabiork.h-its.org/sabioRestWebServices/

* sgd

  On BioPortal

* toxkb

  Scripts written in ruby. Some files where found but not the toxcast and toxnet ones

* Unists

  Guidelines not clear, which file should we ddl?

  ftp://ftp.ncbi.nih.gov/repository/UniSTS/

  

# Common operations

### Extract and iterate over files URL in HTML

```shell
array=( $(cat index.html | sed -r -n 's/.*((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

for var in "${array[@]}"
do
  wget -N ${var}
done
```



### Authentication

```shell
# Affymetrix example. Log in to the server. This only needs to be done once.
wget --save-cookies cookies.txt \
     --keep-session-cookies \
     --post-data 'user=vincent.emonet@maastrichtuniversity.nl&password=maasitest12' \
     --delete-after \
     https://www.thermofisher.com/oam/server/auth_cred_submit
     
wget --load-cookies cookies.txt  https://www.thermofisher.com/file_to_download
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



### Rename extensions

```shell
rename s/\.txt/.tsv/ *.txt
```
