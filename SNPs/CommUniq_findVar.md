# 1. Identifying common SNPs from multiple VCF files

#### Method 1: `findCommonVariants(VCF_files)`

Have not tested personally - but one way to do this is by installing Rsubread package from Bioconductor and use the 

https://rdrr.io/bioc/Rsubread/man/findCommonVariants.html

#### Method 2: `bedtools intersect` 

https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html

But caveat with using bedtools is, during intersection, it does not verify if the allele is between the samples is same. Basically, we can check if there is a SNP is a specific position but cannot surely say if the SNP is same for all the strains.

#### Method 3: `bcftools isec`

This tool specifically deals with intersections of VCF/BCF files.

```
 % bgzip -i test1.vcf 
 % bgzip -i test2.vcf 
 % bcftools isec test1.vcf.gz test2.vcf.gz -p dir
 % bcftools index test1.vcf.gz
 % bcftools index test2.vcf.gz
 % bcftools isec test1.vcf.gz test2.vcf.gz -p dir
 % cat README.txt 
 
This file was produced by vcfisec.
The command line was:	bcftools isec  -p dir test1.vcf.gz test2.vcf.gz

Using the following file names:
dir/0000.vcf	for records private to	test1.vcf.gz
dir/0001.vcf	for records private to	test2.vcf.gz
dir/0002.vcf	for records from test1.vcf.gz shared by both	test1.vcf.gz test2.vcf.gz
dir/0003.vcf	for records from test2.vcf.gz shared by both	test1.vcf.gz test2.vcf.gz
```

#### Dealing with multiple VCF files

-n+2 translates to "variants present in 2 or more files among the 3 files" or "all the variants that are in at least 3 files"

-n=2 translates to "variants present in exactly 2 files among the 3 files"

-n-2 translates to "variants present in 2 or less files among the 3 files" or "variants not shared by more than 2 files"

-n~2 translates to "the variants that are altogether shared by 2 files among the 3 files"

-n~110 translates to "find all variants present in the 1st, 2nd but not in 3rd file"



```
% bcftools index test3.vcf.gz

% bcftools isec -n +2 test1.vcf.gz test2.vcf.gz test3.vcf.gz -p dir2 

% cat sites.txt # list of common sites across all the input files
Chr1	3442933	C	GA	011 # See the test1.vcf.gz file
Chr1	3442944	T	TC	111
Chr1	3443103	AG	A	111
Chr1	3443126	TC	T	111
Chr1	3443202	C	CG	111
Chr1	3443309	T	TC	111
Chr1	3443563	T	TC	111
Chr1	3806183	A	C	111

% gunzip -c test1.vcf.gz | grep '3442933'
Chr1	3442933	.	C	CG	1048.38	.	AB=0;AO=33;DP=33;QA=1221;QR=0;RO=0;TYPE=ins	GT:DP:RO:QR:AO:QA:GL	1/1:33:0:0:33:1221:-110.195,-9.93399,0
% gunzip -c test2.vcf.gz | grep '3442933'
Chr1	3442933	.	C	GA	1048.38	.	AB=0;AO=33;DP=33;QA=1221;QR=0;RO=0;TYPE=ins	GT:DP:RO:QR:AO:QA:GL	1/1:33:0:0:33:1221:-110.195,-9.93399,0
% gunzip -c test3.vcf.gz | grep '3442933'
Chr1	3442933	.	C	GA	1048.38	.	AB=0;AO=33;DP=33;QA=1221;QR=0;RO=0;TYPE=ins	GT:DP:RO:QR:AO:QA:GL	1/1:33:0:0:33:1221:-110.195,-9.93399,0
```
So accordingly, if we want the find common variants in all 3 VCF files, we can run the following command.
This would also check if the allele among all the samples is same

```
% bcftools isec -n~111 test1.vcf.gz test2.vcf.gz test3.vcf.gz -p dir3

$ cat sites.txt 
Chr1	3442944	T	TC	111
Chr1	3443103	AG	A	111
Chr1	3443126	TC	T	111
Chr1	3443202	C	CG	111
Chr1	3443309	T	TC	111
Chr1	3443563	T	TC	111
Chr1	3806183	A	C	111
```

Other tools that can do vcf file intersection: [SnpSift Concordance](https://pcingola.github.io/SnpEff/ss_concordance/), [VcfIn](http://lindenb.github.io/jvarkit/VcfIn.html) 


# 2. Identifying unique SNPs from multiple VCF files

#### Method 1:

We know that only position 3442933 in test1.vcf.gz had a unique SNP and the other two files have all SNPs which are common among them.
This can be verified by `-C --complement` option in `bcftools isec`.

```
% bcftools isec -C test1.vcf.gz test2.vcf.gz test3.vcf.gz -p dir4_complement

% cat 0000.vcf

#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	SGH10_pKPC2-km_G300__2
Chr1	3442933	.	C	CG	1048.38	.	AB=0;AO=33;DP=33;QA=1221;QR=0;RO=0;TYPE=ins	GT:DP:RO:QR:AO:QA:GL	1/1:33:0:0:33:1221:-110.195,-9.93399,0
```

But the above command, would give unique SNPs of test1.vcf.gz not the test2.vcf.gz, test3.vcf.gz samples. So, we change the file postions for all the files and rerun the same command.
I adapted code from [here](https://www.perlmonks.org/?node_id=146419): and created a perl script [fileCombinations_generators.pl](https://github.com/ramadatta/tute/blob/main/SNPs/fileCombinations_generators.pl) which generates commands for identifying unique SNPs for each VCF file.

```
% ls *gz >fileList
% perl fileCombinations_generators.pl 
bcftools isec -C test2.vcf.gz test3.vcf.gz test1.vcf.gz >test2.unique.snps.filt.vcf
bcftools isec -C test1.vcf.gz test3.vcf.gz test2.vcf.gz >test1.unique.snps.filt.vcf
bcftools isec -C test3.vcf.gz test2.vcf.gz test1.vcf.gz >test3.unique.snps.filt.vcf

% perl fileCombinations_generators.pl >unique.snps.sh
% bash unique.snps.sh

-rw-rw-r-- 1 user user    0 Aug 27 18:23 test3.unique.snps.filt.vcf
-rw-rw-r-- 1 user user    0 Aug 27 18:23 test2.unique.snps.filt.vcf
-rw-rw-r-- 1 user user   60 Aug 27 18:23 test1.unique.snps.filt.vcf

% cat test1.unique.snps.filt.vcf
Chr1	3442933	C	CG	100
```



