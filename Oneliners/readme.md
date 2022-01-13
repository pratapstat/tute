### Running spades

```
time while read line; 
do 
spOut=`echo "$line" | sed 's/-1 //g' | awk -F/ '{print $2"_"$1"_spades_out"}'`; 
spades.py $line -o $spOut --careful -t 48 ; 
done < <(ls -1 */*/*gz | paste  - - | awk '{print "-1 "$1" -2 "$2}')
```
### Convert plsdb sequence into ABRicate database format

```
cat /storage/data/Storage/plsdb/plsdb.fasta | sed 's/ /#/' | 
sed 's/ /_/g' | 
sed 's/#/ /' | 
awk '{ if ($1 ~ /^>/) { gsub(/>/, "", $1); 
print ">plsdb_v2020_11_19~~~"$1"~~~"$1"~~"$2} else { print $0; } }' >ABRicate_plsdb.fasta
```
### Remove dates after the pipe from a newick file
```
cat file.newick | sed 's/|/\n/g' | sed 's/^[^:]*:/:/g' | tr -d '\n' 

```
### Extract accessory genome from the roary output

##### 1. First generate the locus_tag of the accessory genes (pan_genome_results)

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
Extracting 5477 genes took me around ~19 mins by this way


