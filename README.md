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
## On Linux
./run.sh config.yaml

## On Windows
# Copy the config.yaml file to the root of the volume shared with the container (here /data)
cp $CONFIG /data/config.yaml
docker run -it --rm -v /data:/data kraken-download /data/config.yaml
```

### Docker command in detail

* `/data/config.yaml` is the path to config.yaml INSIDE the container. So here `config.yaml` needs to be put at the root of the shared volume.
* You can ask to delete all previously downloaded files by adding the `-d` flag

```shell
docker run -it --rm -v /data:/data kraken-download /data/config.yaml -d
```



### Add a new dataset

* Copy and rename the affymetrix directory, then change the download.sh to download what you want.
* Add the new dataset to your config.yaml
* To add a new login and password key just add them in the yaml. Then use them as variables in the download.sh.

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

wget -r -A gz -nH ftp://ftp.ncbi.nlm.nih.gov/snp/

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

