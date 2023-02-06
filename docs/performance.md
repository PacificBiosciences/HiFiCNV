# Performance
This document captures relevant performance metrics for HiFiCNV.

## Accuracy
### Data summary
HiFiCNV was primarily evaluated with copy number variants from [Gross et al., 2019](https://doi.org/10.1038/s41436-018-0295-y).
This includes 17 reference samples with 36 CNV events (gain/duplication or loss/deletion) with reported coordinates in hg19.
Of the 36 reported events, 3 were removed due to liftover failures, 1 was removed because the sample was not sequenced, 5 were removed due to lack of evidence following manual inspection of array and/or sequence data, and 2 were removed due to fully residing within the HiFiCNV exclude regions.
The remaining 25 events were analyzed using both HiFiCNV.
The full list of variants with liftover coordinates and annotations regarding exclusion is availabe [here](./supporting_data/Gross_2019_CNVs.csv).

Note that this collection includes a wide range of clinically relevant events with sizes from as small as 13kbp to as large as whole chromosome duplications.
While we evaluated on the full filtered set, HiFiCNV is primarily designed to capture events larger than 100kbp.

### Data collection
All samples were ordered from Coriell and sequenced on the PacBio Sequel IIe platform with a target coverage of 30x.
One of the 17 samples (ND01037) was not ordered and therefor not sequenced.

### Benchmark comparison
We used a combination of [Truvari](https://github.com/ACEnglish/truvari), [witty.er](https://github.com/Illumina/witty.er), and internal scripts to evaluate the performance of HiFiCNV on this benchmark.
Due to the size of these events and imprecision in event reporting, Truvari was run in a mode focused on finding events with large overlaps (as opposed to precise coordinates). 
Specifically, we increased all distance thresholds regarding coordinates and set reciprocal overlap to 50% (specific options: `--pctsim 0.0 --pctsize 0.5 --pctovl 0.5 --refdist 1000000000 --sizemax 1000000000 --chunksize 1000000000`).
We often found for especially large events that there may be multiple calls composing the event.
To evalute the accuracy of the combined calls, Witty.er was run to gather additional statistic on basepair-level overlaps (options: `--bpd 10000`).
Finally, internal scripts were written and used to confirm the results from these two tools and provide additional information on the split calls (e.g. number of calls, CN difference, etc.).

The main results from this analysis are in the following table:

| Metric | Tool | Value |
| - | - | - |
| Recall (TP / total) | Truvari | 80% (20* / 25) |
| False positives* | Truvari | 1304 |
| Base recall | Witty.er | 97.43% |
| Base precision | Witty.er | 58.52% |
| Cumulative calls used* | Internal script | 34 |

* *Recall - Of the 5 missed events, all were below HiFiCNV's detection threshold (100kbp), with the largest at ~40kbp.  All of them were also detected by the structural variant caller `pbsv`.
* *False positives - These are _presumed_ false positives as measured by Truvari. This count includes fragmented events, events with non-PASS filter, and likely some true positive events as well.
* *Cumulative calls used - This value is mainly a measure of event fragmentation.  If call overlaps an event by at least 50% (one-directional, _non_-reciprocal), then the call is counted. In this benchmark, this means there are 14 additional calls (on top of the 20 counted as TP) that are supporting calls that overlap the event but do not reach the reciprocal threshold of 50%.  Note that these calls are used by Witty.er to measure the combined base level recall and precision.

## Compute
In benchmarks, we ran HiFiCNV on a cluster providing 8 cores and 16 GB of memory (2 GB per core).
The run-time of HiFiCNV is primarily a function of coverage, but most samples with ~30x coverage finished in well under an hour.
