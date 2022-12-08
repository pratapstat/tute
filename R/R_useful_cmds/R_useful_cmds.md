### 1. How to add quotes around each word in a string in R?

```
% words <- "Aminoglycoside, Beta-lactam,Carbapenem,Disinfectant, Fluoroquinolone_and_aminoglycoside, Fosfomycin, Macrolide,Phenicol,Quinolone,Rifampicin,Sulphonamide,Tetracycline,Trimethoprim"

% cat(gsub("(\\w+)", '"\\1"', words))

"Aminoglycoside", "Beta"-"lactam","Carbapenem","Disinfectant", "Fluoroquinolone_and_aminoglycoside", "Fosfomycin", "Macrolide","Phenicol","Quinolone","Rifampicin","Sulphonamide","Tetracycline","Trimethoprim"
```

### 2. Cast a matrix to wide format

```
reshape2::dcast(Plasmid1~Plasmid2, value.var="Plasmid_similarity") %>% 
```

### 3. Melt a matrix to long format

```
reshape2::melt(variable = "NonCP_Plasmid", value.name = "cooccur_sample_count") %>% 
tidyr::pivot_longer(!CP_Plasmid, names_to = "NonCP_Plasmid", values_to = "cooccur_sample_count") %>% 
```

### 4. Convert a column to rownames

This is particularly useful when trying to input a numerical matrix to some function such as prcomp

```
tibble::column_to_rownames(var="CP_Plasmid") 
```

### 5. Convert all the columns except the column(s) you want to be specific data type

```
mutate(across(-c(CP_Plasmid), as.numeric))
```
