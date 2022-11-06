################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
rm(list=ls())
############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0
MyData
############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)
rownames(TempData)<- NULL
head(TempData)
dim(TempData)

############# Convert from wide to long format using tidyverse ###############
require(tidyverse) # load the tidyverse

MyWrangledData<- gather(TempData,key = "Species",value="Count", -Cultivation,-Block,-Plot, -Quadrat,factor_key = TRUE)

head(MyWrangledData);tail(MyWrangledData)

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 

MyWrangledData<- dplyr::as_tibble(MyWrangledData)
MyWrangledData
#which is the same as commond
MyWrangledData<- as_tibble(MyWrangledData)
class(MyWrangledData)
## continue tidy data comond
glimpse(MyWrangledData) #like str(), but nicer!

filter(MyWrangledData, Count>100) #like subset(), but nicer!

slice(MyWrangledData, 10:15) # Look at a particular range of data rows
#group the data and calculate each mean
MyWrangledData %>% group_by(Species) %>% summarise(agv= mean(Count))

