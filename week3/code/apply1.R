## Build a random matrix
M <-matrix(rnorm(100),10,10)

##take the mean of each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)

##now the variance
RowVars <- apply(M,1,var)
print(RowVars)

##by column
ColMeans <- apply(M, 2, mean)
print(ColMeans)





