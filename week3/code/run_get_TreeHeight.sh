#!/bin/sh
# Author: 01_Awesome_Aardvarks
# Script: run_get_TreeHeight.sh
# Description: runs get_TreeHeight.R and get_TreeHeight.py using tree.csv as an argument
# Arguments: None
# Date: Dec 2022

# test the R script
Rscript get_TreeHeight.R ../data/trees.csv

# test the python script
python3 get_TreeHeight.py ../data/trees.csv