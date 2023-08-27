---
title: "GSOC"
collection: projects
type: "Open Source Project"
permalink: /projects/gsoc23
date: 2023-08-21

---



## GSOC @TVB

Project Description: 

 
  The Virtual Brain (TVB) is a scientific simulation platform that provides all
means to generate, manipulate and visualize connectivity and network dynamics
of the brain networks. Researchers in Computational Neuroscience use brain
network models to understand the dynamic behavior of the healthy and diseased
brain, as measured by various neuroimaging techniques such as fMRI, EEG, and
MEG. TVB is currently the only neuroinformatics project providing a platform for
researchers to work together on modeling studies using brain network models
with realistic connectivity. 

  The modeling of the simulations requires datasets generally hosted on
data storage platforms like Zenodo, OpenSourceBrain, EBRAINS, etc. One has
to download the dataset manually, unzip it and then use it inside the web GUI.


  Instead of manually downloading and unzipping the data, the project's goal
is to have a dedicated framework to manage the downloading and unzipping the
dataset from remote sources. Right now, we are focusing on the Zenodo
platform


My work on this feature can be found in [this](https://github.com/the-virtual-brain/tvb-root/tree/TVB-1999-deo) branch or [this](https://github.com/the-virtual-brain/tvb-root/pull/691) pr against the master branch  


## Technical Details and usage: 


In the proposed idea, there is a `Zenodo` class through which one will interact with the Zenodo API. 

The response from the Zenodo API is stored in the `Record` class. 

One can use the above Zenodo and Record classes 


```python

#instantiate the Zenodo class
zen = Zenodo() 

# Suppose you are interested in working with a specific repository.
# for this example lets consider https://zenodo.org/record/4263729 as the repository you are interested in.

#then we can get the `record` object back using the get_record method of the zenodo class. In our case, "4263729" is the record id.

record = zen.get_record("4263729")

print(record)
# 

```

