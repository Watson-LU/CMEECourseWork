# Author: 01_Awesome_Aardvarks
# Script: PP_Regress_loc.R
# Date: Dec 2022
# Desc: 
# Do the same thing as PP_Regress.R, but the analysis this time
# should be separate by the dataset’s Location field.

rm(list=ls())  #empty the all variables

#1a. load package
require(tidyverse)

#1b. import dataset
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

#------------------------------------
##calculating regression statistic
#2a.
for (i in 1:nrow(MyDF)){
    if(MyDF$Prey.mass.unit[i] == "mg"){
        MyDF$Prey.mass.unit[i] <- "g"   # chenge with mg to g
        MyDF$Prey.mass[i] <- MyDF$Prey.mass[i] / 1000 # change the number correctly
    }
}

#2b. Feeding, lifestage and location subgroups
FLL_groups <- MyDF %>% group_by(Type.of.feeding.interaction,Predator.lifestage,Location) %>% count()

#2c. running linear model
linear_models <- MyDF %>% 
  group_by(Type.of.feeding.interaction,Predator.lifestage,Location) %>%
  do(model = lm(Predator.mass ~ Prey.mass, data= .))

#2d. creating table
FLL_stats <- data.frame(Feeding_Type = FLL_groups$Type.of.feeding.interaction,
                        Predator_Lifestage=FLL_groups$Predator.lifestage,
                        Location =FLL_groups$Location,
                        Intercept=NA,Slope=NA,P_value_overall=NA, R_squared=NA,
                        F_statistic=NA)

#2e. excluding rows with sample size of 5 or less
  #too few data points for accurate sample size
#examining rows to exclude
FLL_groups[FLL_groups$n <= 5,]
#   Type.of.feeding.interaction Predator.lifestage Location                n
# 1 piscivorous                 postlarva/juvenile Antarctic Peninsula     2
# 2 planktivorous               juvenile           Gulf of Alaska          2
# 3 predacious                  adult              Gulf of Maine, New England     5
#row numbers of rows to exclude
which(FLL_groups$n <= 5,) #21 24 36
#row numbers of rows to include - to calculate statistics for
i_values <- c(1:nrow(FLL_groups))[-which(FLL_groups$n <= 5,)]

#2f. combining results into table
for (i in i_values){
#for (i in c(1:20,22:23,25:35,37:nrow(FLL_groups))){
  #browser()
  FLL_stats[i,"Intercept"] <- summary(linear_models$model[[i]])$coef[1,1] #Intercept
  FLL_stats[i,"Slope"] <- summary(linear_models$model[[i]])$coef[2,1]  # slope
  FLL_stats[i,"P_value_overall"] <- summary(linear_models$model[[i]])$coef[2,4]  #p value, slope significance
  FLL_stats[i,"R_squared"] <- summary(linear_models$model[[i]])$r.squared #r squared
  FLL_stats[i,"F_statistic"] <- summary(linear_models$model[[i]])$fstatistic[[1]] #f statistic
}

#2g. making results csv 
write.csv(FLL_stats, "../results/PP_Regress_loc_Results.csv")


print("Script complete!")