#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

########## Download SQL database files

#wget -a download.log https://datadryad.org/bitstream/handle/10255/dryad.105332/aeolus_v1.zip

# Uncompress SQL DB (TSV files to be loaded using the script in data2services-download)
#find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;

### TODO
# Then the TSV files need to be loaded into a MySQL database
# See instructions in the README.txt
# The SQL script used to load the data can be found in this directory as load_database.sql


########## Download JSON from API: direct pair reaction
# http://smart-api.info/ui/b2dd6372009df54206670648e16eaa90


## List of reactions and drug pairs

# Count of phenotypes observed (SNOMED?) when drug 
wget -a download.log -O drugReactionCounts_1.json "https://www.nsides.io/api/v1/aeolus/drugReactionCounts?q=0" --no-check-certificate --header  "accept: */*"
# [{"nrows": [631743], "result": [{"nreports": 11, "outcome_concept_id": 35104067, "drug_concept_id": 904453, "ndrugreports": 448710}

wget -a download.log -O drugpairReactionCounts_1.json "https://www.nsides.io/api/v1/aeolus/drugpairReactionCounts?q=0" --no-check-certificate --header  "accept: */*"
# [{"nrows": [7920200], "results": [{"n_d1d2": 722, "drug1_concept_id": 19111620, "n_d1d2ae": 38, "outcome_concept_id": 37622529, "drug2_concept_id": 19122121}


# List of drug pair? Does this means those drugs are associated?
wget -a download.log -O drugpairList.json "https://www.nsides.io/api/v1/aeolus/drugpairList" --no-check-certificate --header  "accept: */*"
# {"results": [{"drug1_concept_id": 19111620, "drug2_concept_id": 19122121}



## Lists of concepts

wget -a download.log -O drugpairReactionListMedDRA.json "https://www.nsides.io/api/v1/aeolus/drugpairReactionListMedDRA" --no-check-certificate --header  "accept: */*"
# {"results": [{"valid_end_date": "2099-12-31", "concept_class_id": "PT", "outcome_concept_id": 37622529, "valid_start_date": "1970-01-01", "domain_id": "Condition", "concept_id": 37622529, "vocabulary_id": "MedDRA", "concept_name": "Hypertension", "invalid_reason": "", "standard_concept": "C", "concept_code": 10020772}

wget -a download.log -O ingredientList.json "https://www.nsides.io/api/v1/aeolus/ingredientList" --no-check-certificate --header  "accept: */*"
# {"results": [{"valid_end_date": "2099-12-31", "concept_class_id": "Ingredient", "valid_start_date": "1970-01-01", "domain_id": "Drug", "concept_id": 501343, "vocabulary_id": "RxNorm", "concept_name": "hepatitis B immune globulin", "invalid_reason": "", "standard_concept_id": 501343, "standard_concept": "S", "concept_code": 26744}

wget -a download.log -O reactionListMedDRA.json "https://www.nsides.io/api/v1/aeolus/reactionListMedDRA" --no-check-certificate --header  "accept: */*"
# {"results": [{"valid_end_date": "2099-12-31", "concept_class_id": "LLT", "outcome_concept_id": 36718526, "valid_start_date": "1970-01-01", "domain_id": "Condition", "concept_id": 36718526, "vocabulary_id": "MedDRA", "concept_name": "Convulsion", "invalid_reason": "", "snomed_outcome_concept_id": 377091, "standard_concept": "C", "concept_code": 10010904}

wget -a download.log -O reactionListSNOMED.json "https://www.nsides.io/api/v1/aeolus/reactionListSNOMED" --no-check-certificate --header  "accept: */*"
# {"results": [{"valid_end_date": "2099-12-31", "concept_class_id": "Clinical Finding", "outcome_concept_id": 36718526, "valid_start_date": "1970-01-01", "domain_id": "Condition", "concept_id": 377091, "vocabulary_id": "SNOMED", "concept_name": "Seizure", "invalid_reason": "", "snomed_outcome_concept_id": 377091, "standard_concept": "S", "concept_code": 91175000}