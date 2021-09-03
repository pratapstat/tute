### Running spades

```
time while read line; 
do 
spOut=`echo "$line" | sed 's/-1 //g' | awk -F/ '{print $2"_"$1"_spades_out"}'`; 
spades.py $line -o $spOut --careful -t 48 ; 
done < <(ls -1 */*/*gz | paste  - - | awk '{print "-1 "$1" -2 "$2}')
```
