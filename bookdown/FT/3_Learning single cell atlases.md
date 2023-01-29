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

**Lung atlas**

each line is subject - cell type frequency - Sungnak et al. - Single cell eQTLs 

**Problems of cell atlas**

Single cell data integrations

Multiple study and multiple cell types - data integrations - So,we want to create a integrated cell atlas - 

**Unsupervised deep learning** - 

Deep learning for latent space modeling and integration - NeurIPS -
For perturbation - check perturbation behavior of control one cell and predict perturbation behavior of other cell types

**Integrating Lung cell atlas**

- Deep learning based integration
- 14 datasets
- 500,000 cells with annotations. The problem here is people call different types may be sometime high level and sometimes detailed level. Like immunologist - many cell types - hierarchical notion

What to do with cell atlas?

- Rare cell type identities
- Variant-cell type association
- Gene module detection
- Map new data on top of the atlas

**HLCA --> HLCA + New data**

Transfer learning -

**Learning from single cell multi-omics**

scverse - 
scArches- multi-modal reference atlas - multimodal integration (multigrate)

**Spatial transcriptomics**

FISH based assay - even subcellular resolution - we can see cells in context and map in particular regions but analysis is not trivial.

Spatial components of molecular tissue biology

cell interactions - cellphonedb - correlation of ligands/receptors averaged over - squidpy
Multimodal version of spatial transcriptomics

**Interactive visualization with interface to napari**

visium dataset - genes - anndata information - project on the screen - export to squidpy analysis.

**defacto computer vision is deep learning model**

graph convolution

```
Question: (?)

what aspects do you consider in integrating cell atlas apart from talking to cell community?
```
How do you deal with the disease? Is that disease cell atlas integrated?

```
integrated template
```
time series information - 

```

```















