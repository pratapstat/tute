Source video - https://youtu.be/D-fSVYlHdm0

Quantifying states of cellular/organ system using scgenomics - make cell atlas for control cases and see how disease situation acts on top of that - then predict state and treatment using AI/ML

**How does cells take a decision?**

The little computers, how do they take signal then decide?
- Survive
- profilerate
- die

Systems biology - bottom up model - attractive but fails when we try to decompose into understandable units and therefore are not fully generalizable.
So, we want to perturb a situation and see how the cells behaves.

A simple model,

Xnew = Xold + Perturbation (p)

**Single cell analysis of cell fate and death**

because we have now higher resolution, we can know superimpose the control versus disease condition, we can see why in disease condition the causal genes are taking certain route. -interceptive medicine

**Learning dynamics: predicting cell cycle from images**

trajectory recovery - cell division - can we predict based on morphology - 

classifier - CNN - Classification and visualization

Unbiased description of cellular state - with the snapshots of data in single cell - we can predict

another example is learning cellular decisions in gut formation

another application, latent representation - using cell atlas - stems were in the center and differented to progenitor cell types

A high fat diet in mouse vs normal - decrease in the intestinal stem cells using cell atlas

Overall FT lab works on,

1) trajectory inference 
2) DEG across conditions - DESeq using bulk sequencing - "mean" might be the same but the variation in different cell-types.
3) Compositional analysis - dynamics of scvelo using RNA velocity, and cell ranks - which tells about transitionary states and terminal states. 










