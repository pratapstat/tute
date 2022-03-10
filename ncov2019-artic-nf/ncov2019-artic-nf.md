### Trying the ncov2019-artic-nf workflow on the testdata downloaded from wf-artic

```
time nextflow run epi2me-labs/wf-artic -w WD_cpe_60_mem_256gb -profile standard --fastq /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed --samples /data01/Nanopore_data_ARTIC/artic/test_data/sample_sheet --out_dir test_data_output_cpe_60_mem_256gb/
time nextflow run connor-lab/ncov2019-artic-nf [-profile conda,singularity,docker,slurm,lsf] --nanopolish --prefix "output_file_prefix" --basecalled_fastq /data01/Nanopore_data_ARTIC/artic/test_data/sars-samples-demultiplexed --sequencing_summary test_data_output_ncov2019-artic-nf/sequencing_summary.txt
```
