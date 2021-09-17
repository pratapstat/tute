### How to add quotes around each word in a string in R?

```
% words <- "Aminoglycoside, Beta-lactam,Carbapenem,Disinfectant, Fluoroquinolone_and_aminoglycoside, Fosfomycin, Macrolide,Phenicol,Quinolone,Rifampicin,Sulphonamide,Tetracycline,Trimethoprim"

% cat(gsub("(\\w+)", '"\\1"', words))

"Aminoglycoside", "Beta"-"lactam","Carbapenem","Disinfectant", "Fluoroquinolone_and_aminoglycoside", "Fosfomycin", "Macrolide","Phenicol","Quinolone","Rifampicin","Sulphonamide","Tetracycline","Trimethoprim"
```
