
a <-3
a
a * a
a_squared <- a*a
sqrt(a_squared)
v <-(0,1,2,3,4)
v
is.vector(v) #check if v is a vector
mean(v) #calculate mean
var(v)
median(v)
sum(v)
prod(v+1)
length(v)
wing.width.cm <- 1.2  #what means using dot notation
wing.length.cm <-c(4.7,5.2,4.8)
wing.

li = list(c(1,2,3))
class(li)

V <- TRUE
V
class(V)

getwd()

b <- NA
class(b)

is.na(b)

b<- 0/0
b
is.nan(b)


is.infinite(b)
is.finite(b)
is.finite(0/0)
is.finite(1/5)

as.integer(3.1)
as.numeric(4)
as.roman(155)
as.character(155)
as.logical(5)
as.logical(0)

1E4
1e4
5e-2
a <-T
a

### include R vectors...   could only store one type of data, it will merge all 
### data types into one type,,  if notice jihe,  use "c()""
a <-5
is.vector(a)

v1 <- c(0.02, 0.5, 1)
v2 <- c("a", "bc", "def", "ghij")
v3 <- c(TRUE, TRUE, FALSE)
v1;v2;v3

v1 <- c(0.02, TRUE, 1)
v1

v1 <- c(0.02, "Mary", 1)
v1

###intro matrices and arrays
# usually a 2-D dimensional vector

mat1 <-matrix(1:25, 5, 4)   ##in matrix the default is by column
mat1

mat1 <- matrix(1:25 , 5, 5, byrow=TRUE)
mat1

dim(mat1) #get the size of the matrix

arr1<- array(1:50, c(5,5,2))    #arrays  is multiple set of matrix???
arr1[,,1]

print(arr1)

mat1[1,1] <- "one"   #array is also like the vector, the homogeneous types inside
mat1

#### now turn to dataframe, unlike the vector-set matrix, the datafram could save
#### different types of data


#create three vectors
Col1 <- 1:10
Col1

Col2 <- LETTERS[1:10]
Col2

Col3 <- runif(10) # 10 random numbers from a uniform distribution
Col3

##then combine them into a dataframe


MyDF <- data.frame(Col1,Col2, Col3)
MyDF           ##still maintain the default the data types.


#assign name of all the columns of dataframes
names(MyDF)<- c("Myfirstcomumn", "Mysecond column", "My.third.column")
MyDF    ##notice that nanme the frame is also free and casual.


MyDF$Myfirstcomumn  ###could direct use the data inside the frame, BY $$$$

colnames(MyDF)
colnames(MyDF)[2] <-"mysecondcolumn"
MyDF

MyDF$My.Third.Column

MyDF[,1]  ##using numerical indexing

class(MyDF)

str(MyDF)

head(MyDF)

tail(MyDF)


#### intro the list, could be more large , incluse the vector and matrix, frame.

Mylist <- list(species=c("Quercus robur", "Fraxinus excelsior"), age=c(123,84))
Mylist

Mylist[[1]]

Mylist[[1]] [1]

Mylist$species
Mylist[["species"]]
Mylist[1]


pop1<-list(species='Cancer magister',
           latitude=48.3,longitude=-123.1,
           startyr=1980,endyr=1985,
           pop=c(303,402,101,607,802,35))
pop1

##could build lists of lists !!!

pop1<-list(lat=19,long=57,
           pop=c(100,101,99))
pop2<-list(lat=56,long=-120,
           pop=c(1,4,7,7,2,1,2))
pop3<-list(lat=32,long=-10,
           pop=c(12,11,2,1,14))
pops<-list(sp1=pop1,sp2=pop2,sp3=pop3)
pops


pops$sp1

pops[[2]]$lat

pops[[3]]$pop[3] <-102

####different between matrix and dataframe.s

MyMat = matrix(1:8, 4, 4)
MyMat


MyDF = as.data.frame(MyMat)
MyDF

object.size(MyMat) # returns size of an R object (variable) in bytes

object.size(MyDF)

######create and manipulating data

##create sequences
years <- 1990:2009
years

years <- 2009:1990 # or in reverse order 
years

seq(1, 10, 0.5)


?seq

seq(from=1, to=10, by=0.5)

## accessing part of data     include the index, use numerical number
MyVar <- c( 'a' , 'b' , 'c' , 'd' , 'e' )
MyVar[1] # Show element in first position 

MyVar[c(3,2,1)]

v <- c(0, 1, 2, 3, 4) # Create a vector named v
v[1:3] # access sequential elements
v[-3] # remove elements


mat1 <- matrix(1:25, 5, 5, byrow=TRUE) #create a matrix
mat1

mat1[1:2,2:4]


##recycleing calculate methods
a <- c(1,5) + 2
a

x <- c(1,2); y <- c(5,3,9,2)
x;y

x +y


x + c(y,1)

##basic vector-matrix operations

v <- c(0, 1, 2, 3, 4)
v2 <- v*2 # multiply whole vector by 2
v2

v * v2 # element-wise product
t(v)

v %*% t(v)

v3 <- 1:7 # assign using sequence
v3

v4 <- c(v2, v3) # concatenate vectors
v4

##string and pasting

species.name <- "Quercus robur" #You can alo use single quotes
species.name

paste("Quercus", "robur")

paste("Quercus", "robur",seq = "")
paste("Quercus", "robur",sep = "") #Get rid of space

paste("Quercus", "robur",sep = ", ") #insert comma to separate

paste("year names", 1990:2000)


####useful R fucntions

strsplit("String; to; Split",';')# Split the string at ';'

##generating random number

rnorm(10,m=0,sd=1)
dnorm(x,m=0,sd=1)
qnorm(x,m=0,sd=1)
runif(20,min=0,max=2)
set.seed(1234567)
rnorm(11)


##set work directory
head(Mydata)
str(Mydata)

MyData <- read.csv("../data/trees.csv", header = F)

head(MyData)

write.csv(MyData, "../results/MyData.cdv")
dir(("../results/"))

write.table(MyData[1,], file= "../results/MyData.csv", append=TRUE)
write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # write row names
write.table(MyData, "../results/MyData.csv", col.names=FALSE) # ignore col names


source("../code/basic_io.R")




##function with conditionals

#check if an integer is even
is.even <- function(n=2) {
    if (n %%2 ==2){
        return(paste(n,'is even!'))
    } else {
        return(paste(n, 'is odd!'))
    }
}


is.even(6)



# Checks if a number is a power of 2
is.power2 <- function(n = 2) {
  if (log2(n) %% 1==0) {
    return(paste(n, 'is a power of 2!'))
  } else {
  return(paste(n,'is not a power of 2!'))
    }
}

is.power2(4)

#check if a number is prime
is.prime <- function(n) {
    if (n ==0)   {
        return(paste(n ,'is a zero!'))
    }   else if (n==1)  {
        return(paste(n ,'is just a unit'))
    }


    ints <- 2:(n-1)

    if (all(n%%ints !=0))   {
        return(paste(n ,'is a prime'))
    }   else    {
        return(paste(n,'is a composite'))
    }

}

is.prime(3)



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


##apply tapply commond
x <- 1:20
x

y <- factor(rep(letters[1:5], each = 4))
y

#composite the number y in the subgroup of x
tapply(x,y,sum)

#Using by  substitute tapply 
attach(iris)
iris


by(iris[,1:2], iris$Species, colMeans)

by(iris[,1:2], iris$Petal.Width, colMeans)

#using replicate

replicate(10, runif(5))


doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique values!")
        }
    }

set.seed(1345) ##get the game values to illustration
popn <-rnorm(50)

hist(popn)

lapply(1:15 , function(i) doit(popn))

result <- lapply(1:15, function(i) try(doit(popn), FALSE))

class(result)
result


