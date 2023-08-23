# User Guide
Table of contents:

* [Quickstart](#quickstart)
* [Supported upstream processes](#supported-upstream-processes)
* [Output files](./outputs.md)
* [FAQ](#faq)

# Quickstart
```
hificnv \
    --bam {BAM} \
    --ref {REF_FASTA} \
    --exclude {EXCLUDE} \
    --expected-cn {EXPECTED_CN} \
    --threads {THREADS} \
    --output-prefix {OUTPUT_PREFIX}
```
Parameters:
* `{BAM}` - a BAM file containing reads from the sample
* `{REF_FASTA}` - a FASTA file containing the reference genome, gzip allowed
* `{EXCLUDE}` - a BED file of excluded regions, recommended for hg38: [cnv.excluded_regions.common_50.hg38.bed.gz](../data/excluded_regions/cnv.excluded_regions.common_50.hg38.bed.gz)
* `{EXPECTED_CNV}` - a BED file specifying expected copy-number by region (two copy is the default if unspecified), example files for human XX/XY karyotypes are provided in the [expected_cn](../data/expected_cn) folder
* `{THREADS}` - number of threads to use
* `{OUTPUT_PREFIX}` - the prefix for all output files

## Auxiliary data files

See [auxiliary file generation](aux_data.md) for details on the above recommended data files.

## Example

Example of running HiFiCNV on an HG002 WGS sample.  An optional VCF file is provided for minor-allele frequency outputs in this example:

```
$ hificnv \
>     --bam /path/to/HG002.GRCh38.deepvariant.haplotagged.bam \
>     --maf /path/to/HG002.GRCh38.deepvariant.phased.vcf.gz \
>     --ref /path/to/human_GRCh38_no_alt_analysis_set.fasta \
>     --exclude /path/to/cnv.excluded_regions.common_50.hg38.bed.gz \
>     --expected-cn /path/to/expected_cn.hg38.XY.bed \
>     --threads 8 \
>     --output-prefix dtracks
[2022-09-29][06:22:57][hificnv][INFO] Starting hificnv
[2022-09-29][06:22:57][hificnv][INFO] cmdline: hificnv --bam /path/to/HG002.GRCh38.deepvariant.haplotagged.bam --ref /path/to/human_GRCh38_no_alt_analysis_set.fasta --exclude /path/to/cnv.excluded_regions.common_50.hg38.bed.gz --expected-cn /path/to/expected_cn.hg38.XY.bed --threads 8 --output-prefix dtracks
[2022-09-29][06:22:57][hificnv][INFO] Running on 8 threads
[2022-09-29][06:22:57][hificnv][INFO] Reading reference genome from file '/path/to/human_GRCh38_no_alt_analysis_set.fasta'
[2022-09-29][06:23:29][hificnv][INFO] Reading excluded regions from file '/path/to/cnv.excluded_regions.common_50.hg38.bed.gz'
[2022-09-29][06:23:29][hificnv][INFO] Reading expected CN regions from file '/path/to/expected_cn.hg38.XY.bed'
[2022-09-29][06:23:29][hificnv][INFO] Processing alignment file '/path/to/HG002.GRCh38.deepvariant.haplotagged.bam'
[2022-09-29][06:37:47][hificnv][INFO] Writing depth track to bigwig file: 'dtracks.HG002.depth.bw'
[2022-09-29][06:37:48][hificnv][INFO] Scanning minor allele frequency data from file '/path/to/HG002.GRCh38.deepvariant.phased.vcf.gz'
[2022-09-29][06:38:01][hificnv][INFO] Writing bigwig maf track to file: 'dtracks.HG002.maf.bw'
[2022-09-29][06:38:18][hificnv][INFO] Segmenting copy number
[2022-09-29][06:38:18][hificnv][INFO] Haploid coverage estimates for sample 'HG002', iteration 1. Uncorrected: 14.955 GC-Corrected: 15.708
[2022-09-29][06:38:21][hificnv][INFO] Haploid coverage estimates for sample 'HG002', iteration 2. Uncorrected: 14.955 GC-Corrected: 15.708
[2022-09-29][06:38:23][hificnv][INFO] Writing bedgraph copy number track to file: 'dtracks.HG002.copynum.bedgraph'
[2022-09-29][06:38:23][hificnv][INFO] Writing copy number variants to file: 'dtracks.HG002.vcf.gz'
[2022-09-29][06:38:23][hificnv][INFO] hificnv completed. Total Runtime: 00:15:26.323
$ ls
dtracks.HG002.copynum.bedgraph  dtracks.HG002.depth.bw  dtracks.HG002.maf.bw  dtracks.HG002.vcf.gz  dtracks.log
```

These tracks visualized in IGV appear as follows:

![](../img/hg002_chr7_tracks.png)

# Supported upstream processes
The following upstream processes are supported as inputs to HiFiCNV:

* Aligners (BAM files):
  * [pbmm2](https://github.com/PacificBiosciences/pbmm2) (recommended)
  * [minimap2](https://github.com/lh3/minimap2)
* Variant callers (for MAF)
  * [DeepVariant](https://github.com/google/deepvariant) - for SNV/indel

Other upstream processes may work with HiFiCNV, but there is no official support for them at this time.

# FAQ
## What does the error "Diploid chromosome regex does not match any sample chromosome names" mean?
By default, HiFiCNV tries to find autosomes for determining normal single-copy coverage in a sample.
The default regular expression searches for contigs named like "chr1" or "11" and uses those for normalization.
If your reference is using a different contig labeling system (e.g. an NCBI name), then you will need to alter the `--cov-regex` option.
Using `--cov-regex "."` is the easiest option, as it will match _all_ chromosomes available in your files.
However, this can lead to subtle differences in the output files, primarily because it may match sex chromosomes (which are not always diploid) or decoy/alt contigs that are frequently packaged in reference genome files.
