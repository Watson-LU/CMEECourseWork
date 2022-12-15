# Author: 01_Awesome_Aardvarks
# Script: TAutoCorr.R
# Date: Dec 2022
# Desc:
# Groupwork Practical: Autocorrelation in Florida weather
# Are temperatures of one year significantly correlated with
# the next year (successive years), across years in Florida?

rm(list = ls())

require(ggplot2)

# view the data
load("../data/KeyWestAnnualMeanTemperature.RData")
pdf("../results/TAutoCorrPlot1.pdf")
plot(ats, main = "Temperature in Florida between 1990-2000")
dev.off()

# permutation test
# test statistic: correlation coefficient between year and temperature
# null hypothesis: Temperatures of one year isn't correlated with the next year across years in Florida
# alternative htpothesis: Temperatures of one year is correlated with the next year across years in Florida
# permutation set: 10000 shuffles of ats$Temp

n <- length(ats$Year) # the total number of years

# get the temperature of successive years
temp_1 <- c(ats[1:(n - 1), 2]) # temperature from year 1 to year 99
temp_2 <- c(ats[2:n, 2]) # temperature from year 2 to year 100

# calculate the correlation between temp_1 and temp_2
temp_cor <- cor(temp_1, temp_2) 

# starting shuffling
cor_of_random <- c()
N <- 10000
# apply the loop to reach as many as time to see the most results
for (i in 1:N) {
    random_sample <- sample(ats$Temp, n, replace = F) 
    temp_1 <- random_sample[1:(n - 1)]
    temp_2 <- random_sample[2:n]
    cr <- cor(temp_1, temp_2)
    cor_of_random <- c(cor_of_random, cr)
}


pdf("../results/TAutoCorrplot2.pdf")
# show the distribution of two parameters'correlation through 10000 times
hist(cor_of_random,
     xlab = "Random correlation coefficients",
     main = "Histogram of Random Correlation Coefficients")
abline(v=temp_cor, col="red")
dev.off()

# hint: you can’t use the standard p-value calculated for a correlation coefficient, 
# because measurements of climatic variables in successive time-points in a time series 
# (successive seconds, minutes, hours, months, years, etc.) are not independent.
estimated_p <- sum(cor_of_random[cor_of_random >= temp_cor]) / length(cor_of_random)

print(paste("The estimated p-value is: ", estimated_p))
# [1] "The estimated p-value is:  0.000108006045209073"
# p-value < 0.05, reject null hypothesis, accept alternative htpothesis

# Results: Temperatures of one year is correlated with the next year across years in Florida