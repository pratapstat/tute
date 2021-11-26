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
