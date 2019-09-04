#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

### See also: Smart-API http://smart-api.info/ui/9fbeaeabd19b334fa0f1932aa111bf35

### Download SQL database
# https://figshare.com/collections/Columbia_Open_Health_Data_a_database_of_EHR_prevalence_and_co-occurrence_of_conditions_drugs_and_procedures/4151252



### Get TSV:

# Concepts (description and IDs). No column name
wget -O concepts.txt -a download.log https://ndownloader.figshare.com/files/12272921

# Lifetime_data_set_single_concept_count. No column name
wget -O concept_counts.txt -a download.log https://ndownloader.figshare.com/files/12272927

# Lifetime_data_set_paired_concept_counts. No columns name
wget -O concept_pair_counts.txt -a download.log https://ndownloader.figshare.com/files/12272933


# Lifetime_dataset_paired-concept_deviations
wget -O Lifetime_dataset_paired-concept_deviations.txt -a download.log https://ndownloader.figshare.com/files/13154816

# 5-year_dataset_single_concept_deviations
wget -O 5-year_dataset_single_concept_deviations.txt -a download.log https://ndownloader.figshare.com/files/13154819

# Lifetime_dataset_single_concept_deviations
wget -O Lifetime_dataset_single_concept_deviations.txt -a download.log https://ndownloader.figshare.com/files/13154756

# 5-year_dataset_paired-concept_deviations
wget -O 5-year_dataset_paired-concept_deviations.txt -a download.log https://ndownloader.figshare.com/files/13154753

# 5-year_data_set_single_concept_count. No column name
wget -O 5-year_data_set_single_concept_count.txt -a download.log https://ndownloader.figshare.com/files/12272930

# 5-year_data_set_paired_concept_counts
wget -O 5-year_data_set_paired_concept_counts.txt -a download.log https://ndownloader.figshare.com/files/12272924



## RENAME EXTENSION (e.g.: txt in tsv)
#rename s/\.txt/.tsv/ *.txt

## ADD COLUMNS NAME
# TSV
#sed -i '1s/^/column1\tcolumn2\tcolumn3\n/' *.tsv