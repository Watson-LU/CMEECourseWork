rm(list = ls()) # clean the environment
graphics.off() # shut down all open graphics devices
require(ggplot2) # load ggplot2 package
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv") # import csv data to a data frame

pdf("../results/PP_Regress_Results.pdf") # save the pdf file
p <- ggplot(MyDF, aes(x = Prey.mass,
                      y = Predator.mass,
                      colour = Predator.lifestage))
# create a graphics object p 
q <- p + scale_x_continuous("Prey Mass in grams", trans = 'log10') + 
  scale_y_continuous("Predator mass in grams", trans = 'log10') +
  geom_point(size=I(1), shape=I(3)) + geom_smooth(method = "lm", fullrange = TRUE) +
  theme_bw() + facet_grid(Type.of.feeding.interaction ~., scales = "free") + theme(legend.position = "bottom", legend.box = "horizontal") + theme(aspect.ratio = 0.4) + guides(color = guide_legend(nrow = 1))
# add layers and other plot elements
print(q)
dev.off() # close the graphic window

feedingTypes <- as.list(levels(MyDF$Type.of.feeding.interaction))
# convert factor to list
PredatorLifestage <- as.list(levels(MyDF$Predator.lifestage))
# convert factor to list again

## Initialize vectors ##
Regression_Slope <- c()
Regression_Intercept <- c()
Feeding_Type <- c()
Life_Stage <- c()
R_Squared <- c()
F_Statistic_Value <- c()
P_Value <- c()


for (i in feedingTypes){
  TempDF <- subset(MyDF, Type.of.feeding.interaction == i)
  # subset MyDF to TempDF according to every Type.of.feeding.interaction
  PredatorLifestage <- unique(TempDF$Predator.lifestage)
  # under each feeding type, extract the corresponding predator lifestage
  for (j in PredatorLifestage){
    TempDF1 <- subset(TempDF, Predator.lifestage == j)
    # subset TempDF to TempDF1 according to every existing predator lifestage
    modelTemp <- lm(Predator.mass~Prey.mass, data = TempDF1)
    # fit the linear regression model
    SumTemp <- summary(modelTemp)
    # use the summary function
    if (length(SumTemp$fstatistic[1]) == 0){
      SumTemp$fstatistic[1] <- NA
    } # if f-statistic doesn't exist, assign NA to it
    Feeding_Type<- append(Feeding_Type, i) # append feeding type
    Life_Stage <- append(Life_Stage, j) # append life stage
    Regression_Slope <- append(Regression_Slope, SumTemp$coefficients[2]) # append regression slope
    Regression_Intercept <- append(Regression_Intercept, SumTemp$coefficients[1]) # append regression intercept
    R_Squared <- append(R_Squared, SumTemp$r.squared) # append R^2
    F_Statistic_Value <- append(F_Statistic_Value, SumTemp$fstatistic[1]) # append F-statistic value
    P_Value <- append(P_Value, SumTemp$coefficients[8]) # append p-value
    
    }
}

PPDF <- data.frame(Feeding_Type, Life_Stage, Regression_Slope, Regression_Intercept, R_Squared, F_Statistic_Value, P_Value)
# create a dataframe of regression results corresponding to the lines fitted in the figure
write.csv(PPDF, "../results/PP_Regress_Results.csv") # save the dataframe to a csv delimited table