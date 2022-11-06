rm(list=ls())
##load the file and data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded
str(MyDF)
head(MyDF)
#apply dplyr to tidy the data
require(tidyverse)
glimpse(MyDF)
## remember to turn some column to factor to set them as grouping variables.
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
glimpse(MyDF)


## dataset of distributions of predator mass, prey mass, and the size ratio of prey mass over predator mass by feeding interaction type
glimpse(MyDF$Type.of.feeding.interaction)
Mydf1<- dplyr::as_tibble(MyDF)
Mydf1

##list all classified data into different sets
Pred_insectivorous <- filter(Mydf1, Type.of.feeding.interaction =="insectivorous")$Predator.mass
Pred_piscivorous<- filter(Mydf1, Type.of.feeding.interaction =="piscivorous")$Predator.mass
Pred_planktivorous<- filter(Mydf1, Type.of.feeding.interaction =="planktivorous")$Predator.mass
Pred_predacious<- filter(Mydf1, Type.of.feeding.interaction =="predacious")$Predator.mass
Pred_pp<- filter(Mydf1, Type.of.feeding.interaction =="predacious/piscivorous")$Predator.mass

Prey_insectivorous <- filter(Mydf1, Type.of.feeding.interaction =="insectivorous")$Prey.mass
Prey_piscivorous <- filter(Mydf1, Type.of.feeding.interaction =="piscivorous")$Prey.mass
Prey_planktivorous <- filter(Mydf1, Type.of.feeding.interaction =="planktivorous")$Prey.mass
Prey_predacious <- filter(Mydf1, Type.of.feeding.interaction =="predacious")$Prey.mass
Prey_pp <- filter(Mydf1, Type.of.feeding.interaction =="predacious/piscivorous")$Prey.mass

ratio_insectivorous<- c(Prey_insectivorous/Pred_insectivorous)
ratio_piscivorous<- c(Prey_piscivorous/Pred_piscivorous)
ratio_planktivorous<- c(Prey_planktivorous/Pred_planktivorous)
ratio_predacious<- c(Prey_predacious/Pred_predacious)
ratio_pp<- c(Prey_pp/Pred_pp)


#### 1.in Predator figure
pdf("../results/Pred_Subplots.pdf", 12, 8)     #open with create pdf
par(mfcol=c(2,3))                              #set the total subplot arrange
par(mfg = c(1,1))
hist(log10(Pred_insectivorous),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'insectivorous feeding type')
par(mfg = c(1,2))
hist(log10(Pred_piscivorous),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'piscivorous feeding type')
par(mfg = c(1,3))
hist(log10(Pred_planktivorous),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'planktivorous feeding type')
par(mfg = c(2,1))
hist(log10(Pred_predacious),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'predacious feeding type')
par(mfg = c(2,2))
hist(log10(Pred_pp),
    xlab = "log10(Predator Mass (g))", ylab = "Count", 
    main = 'predacious/piscivorous feeding type')
dev.off()                                               # turn off the pdf setting

#### 2.in Prey figure
pdf("../results/Prey_Subplots.pdf", 12, 8)
par(mfcol=c(2,3))
par(mfg = c(1,1))
hist(log10(Prey_insectivorous),
    xlab = "log10(Prey Mass (g))", ylab = "Count", 
    main = 'insectivorous feeding type')
par(mfg = c(1,2))
hist(log10(Prey_piscivorous),
    xlab = "log10(Prey Mass (g))", ylab = "Count", 
    main = 'piscivorous feeding type')
par(mfg = c(1,3))
hist(log10(Prey_planktivorous),
    xlab = "log10(Prey Mass (g))", ylab = "Count", 
    main = 'planktivorous feeding type')
par(mfg = c(2,1))
hist(log10(Prey_predacious),
    xlab = "log10(Prey Mass (g))", ylab = "Count", 
    main = 'predacious feeding type')
par(mfg = c(2,2))
hist(log10(Prey_pp),
    xlab = "log10(Prey Mass (g))", ylab = "Count", 
    main = 'predacious/piscivorous feeding type')
dev.off()

####3. in size ratio figure
pdf("../results/Sizeratio_Subplots.pdf", 12, 8)
par(mfcol=c(2,3))
par(mfg = c(1,1))
hist(log10(ratio_insectivorous),
    xlab = "log10(size ratio)", ylab = "Count", 
    main = 'insectivorous feeding type')
par(mfg = c(1,2))
hist(log10(ratio_piscivorous),
    xlab = "log10(size ratio)", ylab = "Count", 
    main = 'piscivorous feeding type')
par(mfg = c(1,3))
hist(log10(ratio_planktivorous),
    xlab = "log10(size ratio)", ylab = "Count", 
    main = 'planktivorous feeding type')
par(mfg = c(2,1))
hist(log10(ratio_predacious),
    xlab = "log10(size ratio)", ylab = "Count", 
    main = 'predacious feeding type')
par(mfg = c(2,2))
hist(log10(ratio_pp),
    xlab = "log10(size ratio)", ylab = "Count", 
    main = 'predacious/piscivorous feeding type')
dev.off()

##dealing with csv file

##apply dplyr to arrange the data in the data frame and do the calculate of mean and median
t1<- MyDF %>% 
        group_by(Type.of.feeding.interaction) %>% 
            summarise(Predator_mean= mean(Predator.mass),
            Predator_median= median(Predator.mass),
            Prey_mean=mean(Prey.mass),
            Prey_median= median(Prey.mass),
            ratio_mean= mean(Prey.mass/Predator.mass),
            ratio_median= median(Prey.mass/Predator.mass))

t1
#write the results into file store in results floder
write.csv( t1, "../results/PP_Results.csv")
