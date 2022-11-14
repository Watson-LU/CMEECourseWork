rm(list=ls())  #empty the all variables
#load the each packages
require(ggplot2)
require(dplyr)
require(tidyr)
#load the data from data floder
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded
glimpse(MyDF)      #check the structure of the data frame

#create the empty background of the graph
p <- ggplot(MyDF, aes(x=log(Prey.mass),
                y=log(Predator.mass),
                colour = Predator.lifestage)) +theme_bw()
#set the appropriate x and y title
p1<- p+ xlab("Prey Mass in grams") +ylab("Predator Mass in grams")
#set the points from the data frame
p2<-p1 + geom_point(shape= I(3)) + facet_grid(Type.of.feeding.interaction ~.) 
#draw suitable linear lines to these data
p3<- p2 + geom_smooth(method="lm", fullrange=TRUE)
p3

#create the pdf
pdf("../results/regression_analyses.pdf")
print(p3)
dev.off()

##### calculate the results of linear regression


#apply dplyr packages to manipulate data and set them into a data frame
t1<- MyDF %>% 
    group_by(Type.of.feeding.interaction,Predator.lifestage) %>% 
        summarise(intercept=lm(Predator.mass ~ Prey.mass)$coefficients[1][1],
        slope = lm(Predator.mass~Prey.mass)$coefficients[2][1],
        Ftest_value=lm(Predator.mass~Prey.mass$fstatistic),
        R_squared=cor.test(Prey.mass, Predator.mass)$estimate ** 2,
        p_value=cor.test(Prey.mass, Predator.mass)$p.value, na.rm = TRUE)
t1


# write this data frame into resultes file.
write.csv(t1,"../results/PP_Regress_Results.csv")















