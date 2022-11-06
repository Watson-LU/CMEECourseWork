# Project name: Week3 R practice work

## Brief Description
It's for the week3 R practices and works.
There are total three practices in this section.
The first one is about modify the old TreeHeight.R file to apply it into trees.csv file and store the first two row into TreeHts.csv fiel.
The second task is using *apply family to vectorize the function to short the time, store the code into Vectorize2.R file.
The last assignment is to figure out different between ovserved correlation coefficients with random correlations ones. And then adjust whether the Florida is getting warmer, store the code in Florida.R and writing interpration in the text through is_Florida_getting_war,er.tex, which coding by compilelatex.sh.

## Languages
Generally use bash and R that work in the both terminal and VSC.

## Dependencies and installation
generally no special packages. All the code could be run by the original R packages.


## Project stucture and Usage

1.In the first practice, add new code by applying the function to calculate the tree height in trees.csv and store it in a data.frame, as below:
``` R
Tree.Height.m<- TreeHeight(Tdata$Angle.degrees, Tdata$Distance.m)
Tdata$Tree.Height.m <- Tree.Height.m
```
then, store it into a new csv file in results floder:
``` R
write.table(Tdata[1:2,],"../results/TreeHts.csv",row.names = FALSE )
```
To run the whole file obtain the results and find a csv file in the results folder
``` R
source("TreeHeight.R")
```

2.In this practice, in order to shorten the system running time, the sapply is applied to replace the for loop where the coer code are as below:
``` R
   sapply(1:length(p1), function(pop) {    
      sapply(2:numyears1, function(yr) {
      N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma))
    })
```
then to run the whole file to obtain the results,
``` R
source("Vectorize2.R")
```

3.In this practice, the observed correlation is calcualted by cor().
```R
Oricor<- cor(temp, year, method = "pearson")
```
while 5000 generation is sampled for the random correlation,
```R
nreps<-5000    
T.random<-numeric(nreps)

for (i in 1:nreps) {
    Y <- year
    X <- sample(temp, 100, replace = FALSE)    
    T.random[i] <-cor(X,Y)    
}
```
Ultimately, probabality is calculated between above two and histogram is drawn.
```R
prob <- length(T.random[T.random >= Oricor])/nreps
hist(T.random, breaks = 50, main =  expression(paste("Distribution around ",rho, "= 0")), xlab = "correlation from randomized samples")
```
run the whole code to clearly understanding, 
```R
source("Florida.R")
```
Besides, a latex file is writing in is_Florida_getting_warmer.tex, and a compilelatex.sh file is set to run it into a pdf.
```bash
bash compilelatex.sh is_Florida_getting_warmer.tex
```

Finished

## Author name and Contact
Author name: Jintao Lu

Contact: jl8722@ic.ac.uk


