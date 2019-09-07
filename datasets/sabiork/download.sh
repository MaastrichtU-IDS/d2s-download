#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Provide a target directory to store downloaded files as argument. E.g.: /data/kraken-download/datasets"
  exit 1
fi
mkdir -p $1
cd $1


BASE_URI="http://sabiork.h-its.org/sabioRestWebServices"
wget -N -a download.log $BASE_URI/suggestions/SABIOReactionIDs
mv SABIOReactionIDs sabioreactionids.xml

# Extract reaction IDs from XML. <SABIOReactionID>6</SABIOReactionID>
array=( $(cat sabioreactionids.xml | sed -r -n 's/.*SABIOReactionID>([0-9]*)<\/SABIOReactionID.*/\1/p') )


# Download all reaction Biopax OWL: http://sabiork.h-its.org/sabioRestWebServices/searchKineticLaws/biopax?q=SabioReactionID:22
for var in "${array[@]}"
do
  REACTION_URL="$BASE_URI/searchKineticLaws/biopax?q=SabioReactionID:${var}"
  echo "Downloading... $REACTION_URL"
  wget -O "SabioReaction_${var}.owl" -a download.log $REACTION_URL
done
