#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *

# Get genes_to_phenotype
wget -N -a download.log -O genes_to_phenotype.tsv http://compbio.charite.de/jenkins/job/hpo.annotations.monthly/lastSuccessfulBuild/artifact/annotation/ALL_SOURCES_ALL_FREQUENCIES_genes_to_phenotype.txt

# Replace first line to put proper column names
sed -i -e '1,1d' genes_to_phenotype.tsv
sed -i '1s/^/entrezGeneId\tentrezGeneSymbol\thpoTermName\thpoTermId\n/' genes_to_phenotype.tsv


## Other HPO_annotations files

# Not monthly
# Download annotations file from https://hpo.jax.org/app/download/annotation
# wget -N -a download.log -O phenotype_annotation.tsv http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab
# wget -N -a download.log -O phenotype_annotation_hpoteam.tsv http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation_hpoteam.tab


# Add columns name from https://hpo.jax.org/app/help/annotation
#sed -i '1s/^/DB\tDB_Object_ID\tDB_Name\tQualifier\tHPO_ID\tDB_Reference\tEvidence_Code\tOnset_modifier\tFrequency\tSex\tModifier\tAspect\tDate_Created\tAssigned_By\n/' phenotype_annotation*.tsv

# Monthly
# http://compbio.charite.de/jenkins/job/hpo.annotations.monthly/


# Columns header for Genes to diseases
#sed -i -e '1,1d' genes_to_diseases.tsv
#sed -i '1s/^/diseaseId\tgeneId\tgeneSymbol\n/' genes_to_diseases.tsv