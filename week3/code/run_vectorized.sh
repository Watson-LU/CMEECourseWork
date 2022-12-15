#!/bin/sh
# Author: 01_Awesome_Aardvarks
# Script: run_vectorized.sh
# Desc: run the R and python version of vectorize1 and vectorize2
# Arguments: none
# Date: Dec 2022

echo " output of Vectorize1.R"
Rscript Vectorize1.R

echo " output of Vectorize2.R"
Rscript Vectorize2.R

echo " output of Vectorize1.py"
python3 Vectorize1.py

echo "output of Vectorize2.py"
python3 Vectorize2.py

echo "finish the run time output"