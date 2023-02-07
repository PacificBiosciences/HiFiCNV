# Method Summary

The method takes as input one alignment file which is assumed to correspond to a single sample. All alignments in the
file are scanned. Alignments are filtered from further analysis if they:

- are marked as unmapped, secondary, qc fail or duplicate
- have a gap-compressed sequence identity below 97%

The remaining alignments are used to construct bins of average depth across each chromosome. The bin size is 2kb. Gaps
created by splitting the read into primary and supplementary alignments are accounted for in the depth calculation, but
not the alignment indels.

The GC content of each depth bin is taken from the reference sequence, and used to implement a simple correction factor
in the segmentation process as described below.

## Segmentation

Sample haploid depth is estimated from the depth bins of chromosomes with names matching a given pattern (as specified
by a regular expression). The default pattern selects for all human diploid autosomes. The haploid depth is computed
from the zero-excluded mean depth of this chromosome set. When GC content correction is applied, the haploid depth is
adjusted to reflect the haploid coverage level of the least biased GC window. When available, the depth estimation
process will use copy number state estimates from a previous round of segmentation to further improve its accuracy.

Copy number segmentation is run on each chromosome. The allowed copy number states include copy numbers 0 to 4 and a
'High' state intended to model copy numbers 5 and higher. Segmentation is performed by a Viterbi parse of the depth bins
assuming the bin depth represents a Poisson sampling from a mean depth based on haploid depth, copy number state and
correction for GC bias. The segmentation process does not consider minor allele frequencies.

The combined process of haploid depth estimation and segmentation is iterated until the depth estimate converges.

## GC Bias Correction

For each depth bin, the GC and AT counts are taken from the reference sequence within a window centered on the depth
bin. The GC counts window size is independent of the depth bin size, it is currently set to a default value of
20000 bases. GC counts are also accumulated for the entire genome. 

Next the method iterates over all depth bins to build a mapping between GC fraction and average depth is found. For
this operation the GC fraction is discretized into equal size frequency bins, using 40 bins by default. 
Each depth bin is assigned a GC level, and the depth for all bins at a given GC level is accumulated and averaged. 
Any GC-level with at least 2 million bases of depth bin representation is qualified to be used in GC bias correction process. 
For example, for a depth bin size of 1000, a given GC level would need at least 2000
depth bins observed at that GC level to be qualified for the GC bias correction process. The qualifying GC level with
the highest average depth is found, and the depth at this GC-level is interpreted as being the 'unbiased' coverage
level, and a correction factor is computed for each GC level by taking the average depth for the GC level and dividing
it by the 'unbiased' coverage level from the max depth bin.

For non-qualifying GC-level bins, without sufficient depth bin support, the following method is used ot set a correction
factor. Find the range of continuously qualifying GC-level bins containing the max-depth GC-level. All bins higher than
that range use the correction factor of the highest qualifying bin in the range, all bins lower than that range use the
correction factor of the lowest qualifying bin in the range.

GC bias correction is applied downstream in the segmentation model, the depth values themselves are never adjusted, but
the emission probability of the observed depth given the haploid coverage level and copy number is adjusted to account
for the correction factor.

### Design note

Having a GC fraction window size set to approximately the read size appears to improve GC bias correction compared to
using the smaller depth bin size. Presumably this is because the larger window can capture all GC biases relevant to the
reads intersecting the depth bin.