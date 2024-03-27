# Change Log

## v1.0.0 - 2024-03-27

This release includes minor ease-of-use improvements, CNV output should be unchanged. The release version is updated to 1.0 to reflect that HiFiCNV is now operating as a stable part of our HiFi WGS pipeline.

### Added
- Add progress reporter to alignment scan

### Changed
- Accelerate depth bin GC content computation
  - Improve and parallelize algorithm to reduce fixed runtime overhead by ~5 min for human genome analysis with typical thread counts.

### Fixed
- Improve error message for failed depth estimation (#25)
- Improve error message for unmapped BAM input (#24)
- Improve error message for mismatched reference and BAM chromosomes (#23)
- Improve error message when BAM index is missing (#22)

## v0.1.7 - 2023-08-22

### Added
- Add new data files to partially support hg19 and hs37d5

### Changed
- Rename expected copy number example files from male/female to XY/XX

### Fixed
* New FAQ section to explain common errors
* Improved error message for cov-regex mismatch
* Improved error messaging for mismatches between aligned BAM contigs and provided reference file contigs

## v0.1.6 - 2023-03-29
### Additions
* Added support for minimap2-aligned BAM files
* Updated quickstart to specify supported upstream tools

### Fixed
* Improved error messaging for cov-regex mismatch

## v0.1.5 - 2023-03-14
### Fixed
* Adjust linux release build process to improve portability

## v0.1.4 - 2023-03-13
### Fixed
* Fixes a bug where optional files were being treated as required ([HIFICNV-2](https://github.com/PacificBiosciences/HiFiCNV/issues/2))

## v0.1.3 - Initial release
### Additions
* Segmentation and calling optimized for HiFi germline WGS
* Automatic GC-bias estimation and correction
* Generates bigwig tracks for depth and allele frequency to visualize CNV-scale events in IGV
* CNV output in bedgraph and VCF formats
* Efficient multi-threaded analysis
