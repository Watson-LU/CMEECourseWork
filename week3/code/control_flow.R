##if statements

a <- TRUE
if (a == TRUE) {
    print ("a is TRUE")
} else {
    print ("a is FALSE")
}

#write in a single line, just set it in a line.....so silly
z <- runif(1) ## Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}


## in a for loop
for (i in seq(10)) {
    j <- i * i
    print(paste(i, " squared is", j )) # nolint
}


for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
      print(paste('The species is', species))
}

#use for loop by pre-existing vector  
v1 <- c("a", "b","c")
for (i in v1) {print(i)}

##while loops

i <- 0
while (i < 10) {
    i <- i+1
    print(i^2)
}








