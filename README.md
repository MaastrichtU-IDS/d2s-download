# kraken-download

A project to automate download of datasets for the data2services/kraken project

## Run on Docker

### Build

```shell
./build.sh
```

### Run

Change the datasets you want to download and databases credentials in the config.yaml file

```shell
./run.sh config.yaml
```

### Add a new dataset

* Copy and rename the affymetrix directory, then change the download.sh to download what you want.
* Add the new dataset to your config.yaml
* To add a new login and password key just add them in the yaml. Then use them as variables in the download.sh.

## Todo

* Testing if the download properly worked
* Use Python to handle errors, test and running the pipeline?



## Extract bio2rdf URLs

https://github.com/bio2rdf/bio2rdf-scripts

26 done

4 found but needing validation or more work

11 not found

#### Done

* Affymetrix: csv
* Bioportal: xml rdf
* clinicaltrials: xml
* ctd: tsv
* dbpedia: nt
* genage: csv
* genbank: seq
* gendr: csv
* goa: gpa
* hgnc: txt converted to tsv
* homologene: data (each column seems separated by spaces, no column name)
* interpro: xml
* ipi: xrefs (tsv without column name)
* iproclass: tb
* irefindex: txt converted to tsv
* kegg: tsv only rpair dataset missing (1 out of 14)
* lsr: google spreadsheet downloaded as csv
* miriam: xml
* ncbigene: no extension converted to tsv
* pdb: xml
* pharmgkb: tsv (but not exactly the same filename as in the php script)
* pubchem: xml
* refseq: gpff
* sider: tsv
* sgd: tab converted to tsv. Mapping file missing. Something on BioPortal
* taxonomy: dmp converted to psv (no column name)

#### Done but...

* mgi: csv

  To get the column we have to extract them from the HTML and add it on the top of the csv

  http://www.informatics.jax.org/downloads/reports/index.html

  Use XPath xslt to extract

* ndc: txt converted to tsv

  Not sure this is the right URL. From http://www.fda.gov/downloads/Drugs/DevelopmentApprovalProcess/UCM070838.zip

  to https://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM527389.zip

* Drugbank

  Problems with authentication (that I need to fix)

* pubmed

  Nothing interesting at the given address ftp://ftp.nlm.nih.gov/nlmdata

  But here it seems good ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline in xml

#### Not found

* BioModels

  Login: vincent.emonet@maastrichtuniversity.nl

  Pw: maasitest12

  Problem: can't find the file to download

  http://www.ebi.ac.uk/biomodels/models-main/

* chembl

  MySQL Database connection

* dbsnp

  Nothing found. Need an ID to complete the download URL

  ftp://ftp.ncbi.nlm.nih.gov/snp/Entrez/snp_omimvar.txt not found

  Maybe in ftp://ftp.ncbi.nlm.nih.gov/snp/Entrez/eLinks/ ?

* linkedSPLs

  A lot of directories, with nt, py, xml rdf. And instructions not clear

* mesh

  We can find n-triples here:

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/
  ```

  Only .bin files at

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/.asciimesh/
  ```

* omim

  I applied to get an account, waiting for an answer

* orphanet

  Need a license http://www.orphadata.org/

* pathwaycommons

  It is saying that I should download those files: `homo-sapiens|hprd|humancyc|nci-nature|panther-pathway|phosphositeplus|reactome` at http://www.pathwaycommons.org/pc2/downloads/

  But the URL is returning a 404. 

  I found the download endpoint to be http://www.pathwaycommons.org/archives/PC2/v10/ . With only few of the requested files are there (humancyc, panther, reactome) in xml, owl or others but no JSON file

  What should I do?

* sabiork

  REST API, not clear. Example of how it seems to be queried in the php

  http://sabiork.h-its.org/sabioRestWebServices/

  http://sabiork.h-its.org/sabioRestWebServices/searchKineticLaws/biopax?q=SabioReactionID:

* toxkb

  Not clear which file to download. A lot of scripts written in ruby. 

* Unists

  Guidelines not clear, which file should we ddl? ftp://ftp.ncbi.nih.gov/repository/UniSTS/

  The txt in ftp://ftp.ncbi.nih.gov/repository/UniSTS/UniSTS_MapReports/?

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

### Parse JSON

```shell
# [] to iterate over array
cat ontologies.json | jq -r '.[].links.download'
```

