# Project name: CMEE Miniproject

## Brief Description
It's for the miniproject, fitting model to data.
The microbial growth number with time is going to fitted by linear and non-linear models,thus, this package is to fit those model to data and compile the LaTeX file.

## Languages
Generally use bash and R and python3 that work in the both terminal and VSC.

## Dependencies and installation
In python3,
```python
import pandas as pd
```

In R,
```R
library(minpack.lm)
library(AICcmodavg)
library(ggplot2)
library(ggthemes)
library(plyr)
library(dplyr)
```

## Project stucture and Usage
1. In Data_preparation.py, the raw data is sorted with their unique ID and finally output.

2. In Model_fitting.R , three wrong csv files are deleted, the rest data are going to be fitted by four models and calculated the AIC and AICc value.

3. In plot_analysis.R, firstly, the example fitting graphs are drawn. Then, the chart of AIC , AICc, different scales are drawn to compare.

4. In run_Miniproject.sh , the whole work is running by the code in it.



Finished

## Author name and Contact
Author name: Jintao Lu

Contact: jl8722@ic.ac.uk

