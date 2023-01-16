# Notes

### Paper Name : SCENIC+: single-cell multiomic inference of enhancers and gene regulatory networks

SCENIC+ is a new method for studying how genes are controlled in cells. It combines information about how easily certain parts of the genome can be accessed, along with information about which genes are active, to figure out which parts of the genome control which genes. The method uses a lot of data from different types of cells and species, and has been tested and improved to be more accurate. The SCENIC+ method can be used to study how genes are controlled in different types of cells, and how that changes as cells become different types. The SCENIC+ method is available as a set of computer programs that can be used to analyze data.

**chromatin accessibility**: Chromatin is the material that makes up chromosomes, which contain DNA. Chromatin accessibility refers to how easy it is for certain parts of the chromatin (and therefore, certain parts of the DNA) to be read or modified.

**gene expression**: Gene expression refers to the process by which the information in a gene is used to make a functional product, such as a protein. When a gene is "expressed," it means that its information is being used to make a product.

**enhancer-driven gene regulatory networks (eGRN)**: Gene regulatory networks (GRNs) are sets of interactions between different parts of the genome that control when and how genes are expressed. Enhancers are specific parts of the genome that can increase the expression of a gene. An eGRN is a GRN that is controlled by enhancers.

**transcription factors (TF)**: Transcription factors are proteins that can bind to DNA and control when and how genes are expressed.

**scATAC-seq and scRNA-seq**: These are two techniques for studying chromatin accessibility and gene expression, respectively. "sc" stands for "single-cell," meaning that the techniques can be used to study individual cells. "ATAC-seq" stands for "Assay for Transposase-Accessible Chromatin using sequencing," and "RNA-seq" stands for "RNA sequencing."**

SCENIC+ is a computational method for inferring enhancer-driven gene regulatory networks (eGRNs) by jointly profiling chromatin accessibility and gene expression of individual cells. The method utilizes scATAC-seq and scRNA-seq data to predict genomic enhancers, candidate upstream transcription factors (TFs), and links these enhancers to candidate target genes. Specific TFs for each cell type or cell state are inferred based on the concordance of TF binding site accessibility, TF expression, and target gene expression. To improve the recall and precision of TF identification, SCENIC+ employs a curated and clustered set of over 40,000 position weight matrices that are associated with 1,553 human TFs. The SCENIC+ method has been validated and benchmarked on diverse data sets from different species, including human peripheral blood mononuclear cell types, ENCODE cell lines, human melanoma cell states, and Drosophila retinal development. The SCENIC+ suite is available as a set of Python modules that can be used to study the dynamics of gene regulation along differentiation trajectories, map regulatory activities onto tissues using spatial omics data, and predict the effect of TF perturbations on cell state.
