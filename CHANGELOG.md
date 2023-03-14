# Change Log

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
