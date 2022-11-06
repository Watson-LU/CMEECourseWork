
rm(list=ls())
#load the data file from data folder
load("../data/KeyWestAnnualMeanTemperature.RData")
ls()
class(ats)
head(ats)   #notify the data structure
# extract data from data set
temp<- c(ats$Temp)   
year<- c(ats$Year)

#calculate the correlation using original orders
Oricor<- cor(temp, year, method = "pearson")
Oricor

cat("the obtained correlation is", Oricor, '\n')

#calculate the correlation using randomly re-assigning temperature data

nreps<-5000     #to repeat 5000 times samples
T.random<-numeric(nreps)

for (i in 1:nreps) {
    Y <- year
    X <- sample(temp, 100, replace = FALSE)    #in total 100 numbers of data to sample
    T.random[i] <-cor(X,Y)    # store correlation results into T.random
}

#calculate the probablity of obeained one / sample one
prob <- length(T.random[T.random >= Oricor])/nreps

paste("probablity randomized correlation >= observed one is",prob)
#applying histogram to convince the audience
hist(T.random, breaks = 50, main =  expression(paste("Distribution around ",rho, "= 0")), xlab = "correlation from randomized samples")





