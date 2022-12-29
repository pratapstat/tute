
```
sample_contiglengths %>% 
  group_by(sample) %>%
  mutate(count = row_number(sample))
  
# A tibble: 171 × 4
# Groups:   sample [21]
   sample contig                            plasmid_prob     count
   <chr>  <chr>                             <dbl>           <int>
 1 ENT524 Ctg1_len_4812063_depth_1.00x_circ   0.00000823     1
 2 ENT524 Ctg2_len_177191_depth_0.74x_circ    1.00           2
 3 ENT524 Ctg3_len_128018_depth_0.56x_circ    1.00           3
 4 ENT524 Ctg4_len_71861_depth_1.96x_circ     1.00           4
 5 ENT524 Ctg5_len_2806_depth_111.84x_circ    0.653          5
 6 ENT524 Ctg6_len_2495_depth_287.90x_circ    0.931          6
 7 ENT525 Ctg1_len_4814346_depth_1.00x_circ   0.00000791     1
 8 ENT525 Ctg2_len_177188_depth_0.70x_circ    1.00           2
 9 ENT525 Ctg3_len_128014_depth_0.56x_circ    1.00           3
10 ENT525 Ctg4_len_71861_depth_1.88x_circ     1.00           4
  ```


### Code Resources:

1. https://github.com/Snitkin-Lab-Umich/ndm-st147-chicago-ms
