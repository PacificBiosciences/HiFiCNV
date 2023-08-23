# Output files
All outputs are based on the provided `{OUTPUT_PREFIX}` and an inferred `{sample_name}`.
The `{sample_name}` is extracted from the alignment file. 
The name is taken from the first `@RG` tag in the alignment file header including a sample name.

## Primary outputs
* `{OUTPUT_PREFIX}.{sample_name}.vcf.gz` - the primary VCF output containing copy number variant calls for the sample
* `{OUTPUT_PREFIX}.{sample_name}.depth.bw` - a bigwig depth track
* `{OUTPUT_PREFIX}.{sample_name}.copynum.bedgraph` - the copy number values calculated for each region

## Secondary outputs
* `{OUTPUT_PREFIX}.log` - the log file generated from running HiFiCNV
* `{OUTPUT_PREFIX}.{sample_name}.maf.bw` - a bigwig file containing the minor allele frequency measurements, only generated if a VCF file is provided

## Debug outputs
Additional outputs related to GC correction can be obtained with the `--debug-gc-correction` option, these are debug
outputs and may change in future updates:
* `{OUTPUT_PREFIX}.gc_frac.bw` - A bigwig track of GC fraction windows (from the reference sequence) shared across all
samples.
* `{OUTPUT_PREFIX}.{sample_name}.gc_scaled_depth.bw` - A bigwig depth track, similar to the standard bigwig depth output 
except that all depths are scaled by their region's GC correction factor. Note that the internal segmentation model uses
GC correction factors directly instead of these adjusted depths, so these depths are only used for visualization.
* `{OUTPUT_PREFIX}.{sample_name}.gc_correction_table.tsv` - Sample GC correction factors as a function of GC fraction
* `{OUTPUT_PREFIX}.{sample_name}.gc_reduction_factor.bw` - A bigwig track of sample GC correction factors by region

## VCF notes
HiFiCNV follows VCF format specification 4.2.
The `QUAL` field is reported as an average of the next-most-likely copy-number state for each bin from the HMM (see Methods).
It also includes a `TARGET_SIZE` filter flag for events that are smaller than 100kbp.
This filter can be disabled using the `--disable-vcf-filters` option.
