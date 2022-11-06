# Project name: Week4 R extra practice for Data Management and Visualization

## Brief Description
It's for the week3 extra R practices and works in the Data Management and Visualization module.
There are total Four practices in this section.

The first one is about modify the old DataWrang.R file to apply tidyverse package 
and renamed it with DataWrangTidy.R

The second task is create codes in PP_Dists.R that output three pdf which including few subplots selected by feeding types and a csv that including data about mean and median with predator mass, prey mass and their ratio.

The third assignment is to visualizing the regression analyses by coding in PP_Regress.R. Then, output a pdf to show the graph and a file PP_Regress_Results.csv to store the results. 

## Languages
Generally use bash and R that work in the both terminal and VSC.


## Dependencies and installation
Under this paractice, more packages are applied in the R.
1. the package "tidyverse"
```R
require("tidyverse")
```
2. the package"ggplot2"
```R
require("ggplot2")
```
3. the package"dplyr"
```R
require("dplyr")
```
4. the package"tidyr"
```R
require("tidyr")
```
5. the package"maps"
```R
require("maps")
```

## Project stucture and Usage

1. In the first practice, use tidyverse package instead of old method, as below using gather() than melt():
``` R
MyWrangledData<- gather(TempData,key = "Species",value="Count", -Cultivation,-Block,-Plot, -Quadrat,factor_key = TRUE)
```

To run the whole file obtain the results and find a csv file in the results folder
``` R
source("DataWrangTidy.R")
```

2. In this practice, first filter each attribute of Predator, prey and ratio under feeding types, for example in Predator.mass under insectivorous:
``` R
Pred_insectivorous <- filter(Mydf1, Type.of.feeding.interaction =="insectivorous")$Predator.mass
```
then to draw the histogram of this distribution:
```R
pdf("../results/Pred_Subplots.pdf", 12, 8)    
hist(log10(Pred_insectivorous),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'insectivorous feeding type')
dev.off()                                     
```
after plot all the graphs, calculate mean ,median of each factor using tidyverse and save it into a csv file:
```R
t1<- MyDF %>% 
        group_by(Type.of.feeding.interaction) %>% 
            summarise(Predator_mean= mean(Predator.mass),
            Predator_median= median(Predator.mass),
            Prey_mean=mean(Prey.mass),
            Prey_median= median(Prey.mass),
            ratio_mean= mean(Prey.mass/Predator.mass),
            ratio_median= median(Prey.mass/Predator.mass))

write.csv( t1, "../results/PP_Results.csv")
```

finally, run the whole code to clearly understanding, 
``` R
source("PP_Dists.R")
```

3. In this practice, the graph is plotted by ggplot package:

```R
p <- ggplot(MyDF, aes(x=log(Prey.mass),
                y=log(Predator.mass),
                colour = Predator.lifestage)) +theme_bw()
p1<- p+ xlab("Prey Mass in grams") +ylab("Predator Mass in grams")
p2<-p1 + geom_point(shape= I(3)) + facet_grid(Type.of.feeding.interaction ~.) 
p3<- p2 + geom_smooth(method="lm", fullrange=TRUE)
p3
```
then create a pdf to store it.
```R
pdf("../results/regression_analyses.pdf")
print(p3)
dev.off()
```
Ultimately, output the detailed linear model information into a csv file
```R
 t1<- MyDF %>% 
    group_by(Type.of.feeding.interaction,Predator.lifestage) %>% 
        summarise(intercept=lm(Predator.mass ~ Prey.mass)$coefficients[1][1],
        slope = lm(Predator.mass~Prey.mass)$coefficients[2][1],
        Ftest_value=lm(Predator.mass~Prey.mass$fstatistic),
        R_squared=cor.test(Prey.mass, Predator.mass)$estimate ** 2,
        p_value=cor.test(Prey.mass, Predator.mass)$p.value, na.rm = TRUE)
write.csv(t1,"../results/PP_Regress_Results.csv")
```

run the whole code to clearly understanding, 
```R
source("PP_Regress.R")
```
4. In the last practice, the goal is to print a world map and input some points on it. The maps() package is applied. core code as below:
```R
map(database = "world")
points(x=gpdd$lat, y = gpdd$long, col = "red")
```
the whole file is run by:
```R
source("GPDD_Data.R")
```

Finished

## Author name and Contact
Author name: Jintao Lu

Contact: jl8722@ic.ac.uk

