##pre-allocation

#explaint the reason  why they need re-preakllocation
NoPreallocFun <-function(x) {
    a <- vector() #empty vector
    for  (i in 1:x) {
        a <- c(a,i)
        print(a)
        print(object.size(a))
    }
}

system.time(NoPreallocFun(10))


#the true pre-allocation mehthod
PrealloFun <- function(x) {
    a <- rep(NA, x) #pre-allocation for vector
    for (i in 1:x) {
        a[i] <- i #assign
        print(a)
        print(object.size(a))
    }
}


system.time(PrealloFun(10))

