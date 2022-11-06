rm(list=ls())  #empty all variables
#loead necessary packages
library(maps)
#loead the data file
load("../data/GPDDFiltered.RData")
ls()
class(gpdd)
head(gpdd)
str(gpdd)    #check the structure of data file


# use map package to draw the world map into R
map(database = "world")
#draw points that writing in the data frame.
points(x=gpdd$lat, y = gpdd$long, col = "red")

### comment:
# Since the projection of the earth is different, the points will be more
# accurate near the equator then the polar. Besides, the points is larger
# then the true points in the map which means a little point in the map 
# could represent Thousands of square Kilometer areas. Thus, the point drawn
# in that map could not reflect to the true location.
