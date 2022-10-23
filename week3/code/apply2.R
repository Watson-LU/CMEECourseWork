SomeOperation <- function(v) {
    if (sum(v) >0) { #should be note that sum(v)is s single value
        return (v * 100)
    } else {
        return (v)
    }
}

M <- matrix(rnorm(100), 10,10)
print(apply(M,1,SomeOperation))
