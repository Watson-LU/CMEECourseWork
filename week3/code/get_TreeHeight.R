# Author: 01_Awesome_Aardvarks
# Script: get_TreeHeight.R
# Date: Dec 2022
# Desc: 
# Function to calculate tree height and strip the .csv

#Function to calculate tree height and strip the .csv
Cal_TH <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    
    return(height)
}

#By creating an interactive interface, R programs can be run on LInux with command line parameters
args <- commandArgs(trailingOnly = TRUE)

output <- gsub("/|../data/|.csv","",args) #Remove file extension and relative path



Treedata <- read.csv(args)
Treedata$Tree.Height.m <- Cal_TH(Treedata$Angle.degrees, Treedata$Distance.m)

#put the result into a file in results folder
write.csv(Treedata, paste("../results/", output, "_treeheights.csv", sep = ""), row.names = FALSE)