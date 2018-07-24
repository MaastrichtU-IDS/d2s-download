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

See 

https://github.com/bio2rdf/bio2rdf-scripts

26 done

6 found but needing validation 

2 need  more work

7 not found



Link to exact license file

Check PSICQUIC because a lot of references (irefindex)

Classify aggregators (iproclass, irefindex) vs descriptive db

#### Done

* Affymetrix: csv
* Bioportal: xml rdf
* clinicaltrials: xml
* ctd: tsv
* dbpedia: nt. Whats the diffrence with wikidata?
* genage: csv
* genbank: seq
* gendr: csv
* goa: gpa (, careful special col)
* hgnc: txt converted to tsv
* homologene: data (each column seems separated by spaces, no column name). Also in XML format with more infos
* interpro: xml
* ipi: xrefs (tsv without column name). To remove. Not updated anymore
* iproclass: tb. Todo: ddl also column readme file
* irefindex: txt converted to tsv
* kegg: tsv only rpair dataset missing (1 out of 14). Once ddled get the file under the ID `ds:H00001`
* lsr: google spreadsheet downloaded as csv. Used to build Bio2RDF rdf, will use https://prefixcommons.org/?q=id:go later
* miriam: xml. Will be handled by prefixcommons
* ncbigene: no extension converted to tsv
* pdb: xml. Todo: setup rsync
* pharmgkb: tsv (but not exactly the same filename as in the php script)
* pubchem: xml. Can be download directly in RDF. RDF files can be found here: ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/
* refseq: gpff
* sider: tsv
* sgd: tab converted to tsv. Mapping file missing. Something on BioPortal
* taxonomy: dmp converted to psv (no column name)

#### Done but need validation

* ndc: txt converted to tsv. Not important anymore (only a few infos in it)

  Not sure this is the right URL. From http://www.fda.gov/downloads/Drugs/DevelopmentApprovalProcess/UCM070838.zip

  to https://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM527389.zip from https://www.fda.gov/drugs/informationondrugs/ucm079750.htm

* BioModels: xml rdf

  Problem: can't find the file to download in the provided URL: http://www.ebi.ac.uk/biomodels/models-main/

  But I found a FTP server ftp://ftp.ebi.ac.uk/pub/databases/biomodels/ with Biomodels database as RDF file:

  ftp://ftp.ebi.ac.uk/pub/databases/biomodels/releases/2017-06-26/BioModels_Database-r31_pub-rdf_files.tar.bz2

* pathwaycommons: xml, owl...

  It is saying that I should download those files: `homo-sapiens|hprd|humancyc|nci-nature|panther-pathway|phosphositeplus|reactome` at http://www.pathwaycommons.org/pc2/downloads/

  But the URL is returning a 404. 

  I found the download endpoint to be http://www.pathwaycommons.org/archives/PC2/v10/ . With only few of the requested files are there (humancyc, panther, reactome) in xml, owl or others but no JSON file

  What should I do?

* mesh: nt

  We can find n-triples here:

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/
  ```

  Only .bin files at

  ```shell
  ftp://nlmpubs.nlm.nih.gov/online/mesh/.asciimesh/
  ```

* pubmed: xml

  Nothing interesting at the given address ftp://ftp.nlm.nih.gov/nlmdata

  But here it seems good ftp://ftp.ncbi.nlm.nih.gov/pubmed/baseline in xml

* chembl: sql

  In php: MySQL Database connection from ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/latest

  New in .ttl RDF: ftp://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBL-RDF/latest

#### Need more work

* mgi: csv

  To get the column we have to extract them from the HTML and add it on the top of the csv

  http://www.informatics.jax.org/downloads/reports/index.html

  Use XPath xslt to extract

* Drugbank

  Problems with authentication


#### Not found

* dbsnp

  Nothing found. Need an ID to complete the download URL

  ftp://ftp.ncbi.nlm.nih.gov/snp/Entrez/snp_omimvar.txt not found

  Maybe in ftp://ftp.ncbi.nlm.nih.gov/snp/Entrez/eLinks/ ?

* linkedSPLs

  A lot of directories, with nt, py, xml rdf. And instructions not clear

* omim

  I applied to get an account, waiting for an answer

* orphanet

  Need a license http://www.orphadata.org/

* sabiork

  REST API, not clear. Example of how it seems to be queried in the php

  http://sabiork.h-its.org/sabioRestWebServices/

  http://sabiork.h-its.org/sabioRestWebServices/searchKineticLaws/biopax?q=SabioReactionID:

* toxkb

  Not clear which file to download. A lot of scripts written in ruby. 

* Unists

  The txt in ftp://ftp.ncbi.nih.gov/repository/UniSTS/UniSTS_MapReports/?

# Common operations

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
wget -a download.log -r -A ttl.gz -nH --cut-dirs=3 -P compound ftp://ftp.ncbi.nlm.nih.gov/pubchem/RDF/compound/general
# -nH to remove `ftp.ncbi.nlm.nih.gov`
# --cut-dirs=3 to remove `pubchem/RDF/compound`
# -P to store in the compound dir
```



### Extract and iterate over files URL in HTML

```shell
array=( $(cat index.html | sed -r -n 's/.*((http|ftp)[^"]*?(\.zip|\.gz|\.csv|\.tsv|\.tar)).*/\1/p') )

for var in "${array[@]}"
do
  wget -a download.log ${var}
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

