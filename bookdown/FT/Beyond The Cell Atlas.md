Fabian lecture 2 - Beyond The Cell Atlas - https://youtu.be/s7EWKMoNyNM

Pseudotemporal ordering - break up the clusters - cells progress in different states - cut them up - infer the process by looking at the snapshots - it is not movie but gives us the story

RNA velocity - building systems biology model - measure splice and unspliced reads - different techniques - quantify unspliced reads for gene - on average this gene is newly transcribed per cell - basic regulatory model - metabolism of RNA - so steady states are estimated by ratio of splice to unspliced reads - we can get up and down regulation dynamics

Basically, RNA velocity is going to extremes quantifying the steadystates and looking at the ratios.

But what if the steady state is not the extreme (off), for example, shorter splicing kinetics meaning the gene is in the transient state which is after unspliced gene is in the process of becoming spliced gene but is downregulated because of developmental process then the steady state might is earlier than expected. This angle is to be studied which RNA velocity does not take care..

scVelo - does not want to assume only steadystate but beyond that which is using multiple states 

The process is,
1) Allocate the switching points - at which time point which state cells would be
2) Project cell into on/off states - this is to determine the time points, then fix them
3) Estimate rate parameters  and iterate

Done across all genes and all cells at the same time

ODE 

Steady state model
Dynamic model
Stochastic model

dynamic velocity captures differntial paths in neuronal development

Now, we can estimate time points for each gene separately. 

scVelo 
Can we find the time consistent across all the genes?

couple genewise latent times to global one-diamnesional time covariate.

true vs pseudo vs latent time.

These are all for lineages how about latent spaces, 

Men with glasses, computer vision example:

In latent space, subtract men without glasses and add women generate samples with women with glasses. Cannot do this on pixel space.

Similarly, we want to this on the cell level. 

Take perturbed cell, subtract unperturbed cell and add a second celltype, we can predict or approximate 
in machine it is called star transfer. scGen tool

scGen tool - predicting single cell perturbation effects using generative models

trVAE - 

sfaira - 

```
Question:

Hard to parse sets of reecptors and ligands to know which lines of communications are actually active.
Did you use RNA Velocity to check which are the most changing/not changing in the cell population?**
```
Answer: We look at ligand receptor overall expression and look at the downstream response. But small scale systems biology model have used paracrine cell communication. We donot have matched cells, there are some datasets, which sort of doublets they can be used to check these models.

Can look at the cells at the spatial level, to check if the cells are closeby. 

```
Question:

Two time scales
1) overall maturation of the cells
2) phase space of the single gene, it is correct that it is switching on/off faster times?*
```
Answer:

In population gene is turned off, in another population on. It usually takes a few hours to switch on. Single gene time dynamics perspective you see the bursty transcriptions, we can read out them as well.
This in the initial mode we dont capture but we have steady state model (based on stochastic model) especially use markov jump process to model the bursty kinetics. It is linear we can boil down to moment based equation.

since we have relative data it did not give us huge benefit/

```
Question:

Do you look at third dimension as well. Does it help?
```
Latent space is not 2 dimensional. It is 100 dimensional.
UMAP is 2d, for viewing convenience. 

Non dimensional reduction besides gaussian process was diffusion maps. They are very useful in high components. Sometimes it helps. 2d linear does not capture variation. 
