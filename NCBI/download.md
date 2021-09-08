### How to download a genbank file using NCBI nucleotide accession
```
i=NG_060513
curl -s  "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=${i}&rettype=gb&retmode=txt">$i.gbk
```


```
