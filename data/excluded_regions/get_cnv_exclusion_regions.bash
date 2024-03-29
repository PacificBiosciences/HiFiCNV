#!/usr/bin/env bash

set -o nounset

#
# This script builds a recommended set of exclusion regions for CNV calling.
# It defaults to the hg38 reference.
#

# This script depends on bgzip and tabix, customize these values if they are not already in the path
bgzip=bgzip
tabix=tabix

# The reference tag for the genome version to use. This script has only been tested for ref values 'hg19' and 'hg38'.
# It may work with other reference versions in the UCSC genome browser database, but this hasn't been tested.
ref=hg38

outfile=cnv.excluded_regions.${ref}.bed.gz

base_url=http://hgdownload.cse.ucsc.edu/goldenPath/$ref

# Get UCSC Gaps track, simplify labels and convert to bed format:
get_gaps() {
  wget -O - $base_url/database/gap.txt.gz |\
  gzip -dc |\
  awk -v OFS='\t' '{
    if ($8 ~ /^(clone|contig|scaffold|short_arm)$/) {
       $8 = "gap";
    }
    print $2,$3,$4,$8;
  }'
}

# Get UCSC Centromere track if it exists, simplify labels and convert to bed format
#
# This file is optional because in at least some older genomes, it may not exist. In such cases the centromere
# regions are annotated in the gap track instead.
#
get_centromeres() {
  url=$base_url/database/centromeres.txt.gz
  if wget --quiet --spider $url; then
    wget -O - $url |\
    gzip -dc |\
    awk -v OFS='\t' '{print $2,$3,$4,"centromere";}'
  fi
}

# Get alpha-satellite regions from the UCSC repeatmasker track
get_alpha() {
  wget -O - $base_url/database/rmsk.txt.gz |\
  gzip -dc |\
  awk -v OFS='\t' '$11=="ALR/Alpha" {
    print $6,$7,$8,$11;
  }'
}

cat <(get_gaps) <(get_centromeres) |\
cat - <(get_alpha) |\
sort -k1,1 -k2,2g | $bgzip -c >|\
$outfile

$tabix -p bed $outfile
