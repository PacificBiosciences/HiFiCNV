# HiFiCNV : Copy number variant caller and depth visualization utility for PacBio HiFi reads

HiFiCNV is a copy number variant (CNV) caller optimized for HiFi reads. Key features include:

- Segmentation and calling optimized for HiFi germline WGS
- Automatic GC-bias estimation and correction
- Generates bigwig tracks for depth and allele frequency to visualize CNV-scale events in IGV
- CNV output in bedgraph and VCF formats
- Efficient multi-threaded analysis

Authors: [Chris Saunders](https://github.com/ctsa), [Matt Holt](https://github.com/holtjma)

## Early release warning
Please note that HiFiCNV is still in early development. 
We are still tweaking the input / output file formats and making changes that can affect the behavior of the program.

## Availability
* [Latest release with binary](https://github.com/PacificBiosciences/HiFiCNV/releases/latest)
* [Auxiliary data files](./data)

## Documentation
* [Installation instructions](docs/install.md)
* [Quickstart example](docs/quickstart.md)
* [Output files](docs/outputs.md)
* [Methods](docs/methods.md)
* [Performance](docs/performance.md)
* [Auxiliary file generation](docs/aux_data.md)

## Need help?
If you notice any missing features, bugs, or need assistance with analyzing the output of HiFiCNV, 
please open a GitHub issue.

## Support information
HiFiCNV is a pre-release software intended for research use only and not for use in diagnostic procedures. 
While efforts have been made to ensure that HiFiCNV lives up to the quality that PacBio strives for, we make no warranty regarding this software.

As HiFiCNV is not covered by any service level agreement or the like, please do not contact a PacBio Field Applications Scientists or PacBio Customer Service for assistance with any HiFiCNV release. 
Please report all issues through GitHub instead. 
We make no warranty that any such issue will be addressed, to any extent or within any time frame.

### DISCLAIMER
THIS WEBSITE AND CONTENT AND ALL SITE-RELATED SERVICES, INCLUDING ANY DATA, ARE PROVIDED "AS IS," WITH ALL FAULTS, WITH NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY WARRANTIES OF MERCHANTABILITY, SATISFACTORY QUALITY, NON-INFRINGEMENT OR FITNESS FOR A PARTICULAR PURPOSE. YOU ASSUME TOTAL RESPONSIBILITY AND RISK FOR YOUR USE OF THIS SITE, ALL SITE-RELATED SERVICES, AND ANY THIRD PARTY WEBSITES OR APPLICATIONS. NO ORAL OR WRITTEN INFORMATION OR ADVICE SHALL CREATE A WARRANTY OF ANY KIND. ANY REFERENCES TO SPECIFIC PRODUCTS OR SERVICES ON THE WEBSITES DO NOT CONSTITUTE OR IMPLY A RECOMMENDATION OR ENDORSEMENT BY PACIFIC BIOSCIENCES.
