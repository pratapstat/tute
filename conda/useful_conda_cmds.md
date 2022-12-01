### List the conda environments
```
conda info --envs
```
### Create a conda environment
```
conda create --name PlasClass
```
### Activate a conda environment
```
conda activate PlasClass
```
### Install a package to a conda environment
```
conda install -n PlasClass poppunk
```
### Install a package in conda environment
```
conda install -c bioconda plasclass
```
### Install multiple packages of specific version while creating a conda environment
```
conda create -n PlasClass python=3.7 scikit-learn=0.21.3 plasclass
```
### Install specific version of package in a conda environment
```
conda install spades=3.9.0
```
###  Search for the package versions available to install in a conda environment
```
conda search spades
```
### Remove an environment 
```
conda env remove -n PlasClass
```
