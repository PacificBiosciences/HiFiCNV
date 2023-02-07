# Output files
All outputs are based on the provided `{OUTPUT_PREFIX}` and a inferred `{sample_name}`.
The `{sample_name}` is extracted from the alignment file. 
The name is taken from the first `@RG` tag in the alignment file header including a sample name.

## Primary outputs
* `{OUTPUT_PREFIX}.{sample_name}.vcf.gz` - the primary VCF output containing copy number variant calls for the sample
* `{OUTPUT_PREFIX}.{sample_name}.depth.bw` - a bigwig file containing the depth measurements
* `{OUTPUT_PREFIX}.{sample_name}.copynum.bedgraph` - the copy number values calculated for each region

## Secondary outputs
* `{OUTPUT_PREFIX}.log` - the log file generated from running HiFiCNV
* `{OUTPUT_PREFIX}.{sample_name}.maf.bw` - a bigwig file containing the minor allele frequency measurements, only generated if a VCF file is provided

## VCF notes
HiFiCNV follows VCF format specification 4.2.
The `QUAL` field is reported as an average of the next-most-likely copy-number state for each bin from the HMM (see Methods).
It also includes a `TARGET_SIZE` filter flag for events that are smaller than 100kbp.
