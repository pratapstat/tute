### >1 Running spades

```
time while read line; 
do 
spOut=`echo "$line" | sed 's/-1 //g' | awk -F/ '{print $2"_"$1"_spades_out"}'`; 
spades.py $line -o $spOut --careful -t 48 ; 
done < <(ls -1 */*/*gz | paste  - - | awk '{print "-1 "$1" -2 "$2}')
```
### >2 Convert plsdb sequence into ABRicate database format

```
cat /storage/data/Storage/plsdb/plsdb.fasta | sed 's/ /#/' | 
sed 's/ /_/g' | 
sed 's/#/ /' | 
awk '{ if ($1 ~ /^>/) { gsub(/>/, "", $1); 
print ">plsdb_v2020_11_19~~~"$1"~~~"$1"~~"$2} else { print $0; } }' >ABRicate_plsdb.fasta
```
### >3 Remove dates after the pipe from a newick file
```
cat file.newick | sed 's/|/\n/g' | sed 's/^[^:]*:/:/g' | tr -d '\n' 

```
### >4 Extract accessory genome as fasta files from the roary output

##### 1. First generate the locus_tag of the accessory genes (output file: pan_genome_results)

```
query_pan_genome -a complement -g clustered_proteins *.gff
mv pan_genome_results accessory_genome_locus_tags.list
```

##### 2. Use the locus_tags of the accessory genes to extract the sequences from prokka folder
```
fgrep 'locus_tag=' *.gff >Combined_local_gffs.txt # search 'locus_tag' in all gff file and combine - for speeding purpose

time for locus_tag in $(awk '{print $2}' accessory_genome_locus_tags.list); do 
file=`fgrep -m1 "$locus_tag" Combined_local_gffs.txt | awk -F':' '{print $1}' | sed 's/.gff//g'`; # extract the samplename (foldername) where the gene is present
awk -v var="$locus_tag" 'BEGIN {RS=">"} $0~var {print ">"$0}' Prokka/MySampleFolders/"$file"_prokka_out/"$file".ffn >accessory_gene_representatives/"$locus_tag".fasta;  
done 
```

These genes can be combined and can be functionally characterised for downstream analysis

Extracting 5477 genes took me around ~19 mins by this way

### >5 Replace fasta headers based on the given headers_list.txt
```
head headers_list.txt
lcl|KJ693272.1_cds_AIA12764.1_1	omcdb~~~KJ693272.1~~~AIA12764.1~~~S07_TE.24_364-1143
lcl|KJ693393.1_cds_AIA12941.1_1	omcdb~~~KJ693393.1~~~AIA12941.1~~~S07_TE.28_2-379

awk 'FNR==NR{  a[">"$1]=$2;next}$1 in a{  sub(/>/,">"a[$1]"|",$1)}1' headers_list.txt omc.fa | cut -f1 -d "|" >omc_v2.fa

```
### >6 Annotating hypothetical proteins from Prokka

```
for d in $(awk '{print $2}' clustered_proteins ); do grep "$d" ../gffs/*.gff; done | grep -Po "locus_tag=.*$" | sed -e 's/locus_tag=//g' -e 's/;product=/\t/g' -e 's/ /_/g'

for d in $(awk '{print $2}' clustered_proteins ); do echo $d; awk -v var="$d" 'BEGIN {RS=">"} $0~var {print ">"$0}' Combined_ffn.fasta >>Plasmid_211_Proteins_for_annotation.fasta; done

```

### >7 Find the coverage of between two sequences with Identity ($4) >= 99 and Query Coverage and Subject Coverage >=99

```
makeblastdb -in query.fasta -dbtype nucl -out db.DB 

time blastn -db db.DB -query query.fa -outfmt '6 qseqid sseqid pident nident length mismatch gapopen qstart qend sstart send evalue bitscore qlen slen' -out Self_blast_results.txt -num_threads 48

awk '{print FILENAME"\t"$0}' Self_blast_results.txt | awk '$4>=99' | awk '{print $1"#"$2"#"$3"\t"$9-1"\t"$10"\t"$15"\t"$16}' | sort -k1,1 -k2,2n | mergeBed -c 4,5 -o distinct,distinct | awk '{print $0 "\t" ($3-$2)}' | groupBy -g 1 -c 4,5,6 -o distinct,distinct,sum | awk '{print $0 "\t" ($NF*100)/$2 "\t" ($NF*100)/$3}' | sort -nk5,5 -nk6,6 | awk '$NF>=99 && $(NF-1)>=99' | sed 's/#/\t/g' | awk '!($2==$3)' | cut -f2- >BlastResults_QCov_Scov99_Id99_mergeBed_method2.txt
```
### >8 Place a box in webblogger and to write the code
```
<pre class="pre language-bash" style="background: rgb(245, 242, 240); box-sizing: inherit; hyphens: none; line-height: 1.5; margin-bottom: 0.5em; margin-top: 0.5em; overflow-wrap: normal; overflow: auto; padding: 1em; tab-size: 4; text-shadow: white 0px 1px; word-break: normal;"><span style="font-family: Consolas, Monaco, Andale Mono, Ubuntu Mono, monospace;"><span style="font-size: 14px;">
<span>---------THIS IS A NICE BOX------INSERT YOUR TEXT HERE----------&nbsp;&nbsp; &nbsp;</span>
<span>&nbsp;&nbsp; &nbsp;</span><span>&nbsp;&nbsp; &nbsp;</span><span>&nbsp;&nbsp; &nbsp;</span><span>&nbsp;&nbsp; &nbsp;</span><span>&nbsp;&nbsp; &nbsp;</span><span>&nbsp;&nbsp; &nbsp;</span></span></span></pre>

```

### >9 Extract specific fasta sequence using a string or substring from header

```
awk 'BEGIN {RS=">"} /Chr2/ {print ">"$0}' hg19_genome.fa
```

### >10 Run jobs parallely in unix shell

```
parallel --jobs 48 < runme.sh

```

