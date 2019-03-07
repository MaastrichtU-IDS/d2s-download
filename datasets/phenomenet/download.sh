#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/download"
  exit 1
fi
mkdir -p $1
cd $1
rm -rf *


# Download ontology
wget -a download.log http://aber-owl.net/media/ontologies/PhenomeNET/1/phenomenet.owl

# Download annotations file from https://hpo.jax.org/app/download/annotation
wget -a download.log -O phenotype_annotation.tsv http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation.tab
wget -a download.log -O phenotype_annotation_hpoteam.tsv http://compbio.charite.de/jenkins/job/hpo.annotations/lastStableBuild/artifact/misc/phenotype_annotation_hpoteam.tab


# Add columns name from https://hpo.jax.org/app/help/annotation
sed -i '1s/^/DB\tDB_Object_ID\tDB_Name\tQualifier\tHPO_ID\tDB_Reference\tEvidence_Code\tOnset_modifier\tFrequency\tSex\tModifier\tAspect\tDate_Created\tAssigned_By\n/' *.tsv
