rm(list=ls()) #first empty all variables

#load the tree.csv
Tdata<- read.csv("../data/trees.csv")
str(Tdata)                             ##clearfy the structure of data


# calculation functions setting up
TreeHeight <- function(degrees, distance) {
    radians <- degrees *pi /180
    height <- distance * tan(radians)
    return (height)
}

# apply the function to calculate the tree height in trees.csv
Tree.Height.m<- TreeHeight(Tdata$Angle.degrees, Tdata$Distance.m)
Tree.Height.m
Tdata$Tree.Height.m <- Tree.Height.m
str(Tdata)

# write the output into a new file
write.table(Tdata[1:2,],"../results/TreeHts.csv",row.names = FALSE )

