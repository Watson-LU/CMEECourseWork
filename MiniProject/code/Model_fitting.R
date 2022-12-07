##set the work directory, since this part the relative path is important
setwd('/home/hi/Documents/CMEECourseWork/MiniProject/code')
getwd()

rm(list=ls())
#load the package
library(minpack.lm)
library(AICcmodavg)

## remove the unfitted data that would stop the loop below
file.remove("../sandbox/25.csv")
file.remove("../sandbox/26.csv")
file.remove("../sandbox/15.csv")

##read the selected data
setwd('../sandbox')
#go through the whole file
files <- dir("../sandbox/")
files
#loop in the files
for (i in seq(1,length(files)) ) {

dt1 <- read.csv(file = files[i], header = TRUE,sep=',')


################################ under normal scale
################### applying the linear model


##first linear model, use try to skip the error
linfit <- try(lm(PopBio~ Time, data = dt1))

if ("try-error"%in% class(linfit)) {
n_linAIC <- NA
n_linAICc <- NA

} else {
n_linAIC <- AIC(linfit)
n_linAICc <- AICc(linfit)
}
##then the quadratic model
quafit <- try(lm(PopBio ~poly(Time, 2), data=dt1))
if ("try-error"%in% class(quafit)) {
n_quaAIC <- NA
n_quaAICc <- NA
} else{
n_quaAIC <- AIC(quafit)
n_quaAICc <- AICc(quafit)

}
######################### applying non-linear model
## calculate the estimate R_max
esti_r <- max(diff(dt1$PopBio))/ mean(abs(diff(dt1$Time)))

##first try the logistic model

Logistic_m <- function(t, r_max, K, N_0){ 
 return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

#fit with starting parameters for the model
N_0_start <- min(dt1$PopBio)
K_start <- max(dt1$PopBio)
r_max_start <- esti_r

##predict value
fit_logistic <- try(nlsLM(PopBio ~ Logistic_m(t = Time, r_max, K, N_0), dt1,
      list(r_max=r_max_start, N_0 = N_0_start, K = K_start),
      control = nls.control(maxiter = 100)))

if ("try-error"%in% class(fit_logistic)) {
    n_LAIC <- NA
    n_LAICc <- NA
    
} else {
    n_LAIC <- AIC(fit_logistic)    
    n_LAICc <- AICc(fit_logistic)
}

### next try to fit with Gompertz model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   
N_0_start <- min(dt1$PopBio) 
K_start <- max(dt1$PopBio) 
r_max_start <- esti_r
t_lag_start <- dt1$Time[which.max(diff(diff(dt1$PopBio)))] 
# the predict value
fit_gompertz <- try(nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), dt1,
      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start),
        control = nls.control(maxiter = 100)))

if("try-error"%in% class(fit_gompertz)){
    n_GAIC <- NA
    n_GAICc <- NA
    
} else{
    n_GAIC <- AIC(fit_gompertz)  
    n_GAICc <- AICc(fit_gompertz)
}

################################  under log scale

dt1$LPop <- log(dt1$PopBio)

Loglinfit <- try(lm(LPop~ Time, data = dt1))

if ("try-error"%in% class(quafit)) {
L_linAIC <-NA
L_linAICc <-NA
} else{

L_linAIC <-AIC(Loglinfit)
L_linAICc <-AICc(Loglinfit)

}

###quadratic one
Logquafit <- try(lm(LPop ~poly(Time, 2), data=dt1))

if ("try-error"%in% class(quafit)) {
L_quaAIC <- NA
L_quaAICc <- NA
} else{
L_quaAIC <- AIC(Logquafit)
L_quaAICc <- AICc(Logquafit)
}
######################## applying non-linear model

### first try to fit with logistic model
#first using the simple aproach to calculate the initial r_max value
esti_r <- max(diff(dt1$LPop))/ mean(abs(diff(dt1$Time)))

Logistic_m <- function(t, r_max, K, N_0) {
    return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

#fit with starting parameters for the model
N_0_start <- min(dt1$LPop)
K_start <- max(dt1$LPop)
r_max_start <- esti_r


Logfit_logistic <- try(nlsLM(LPop ~ Logistic_m(t = Time, r_max, K, N_0), dt1,
      list(r_max=r_max_start, N_0 = N_0_start, K = K_start),
      control = nls.control(maxiter=100)))

if("tru-error"%in% class(Logfit_logistic)) {
    L_LAIC <- NA
    L_LAICc <- NA
    
} else{
    L_LAIC <- AIC(Logfit_logistic) 
    L_LAICc <- AICc(Logfit_logistic) 
}

##then try to fit with Gompertz model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

N_0_start <- min(dt1$LPop) 
K_start <- max(dt1$LPop) 
r_max_start <- esti_r
t_lag_start <- dt1$Time[which.max(diff(diff(dt1$LPop)))] 
#  predict value
Logfit_gompertz <- try(nlsLM(LPop ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), dt1,
      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start),
        control = nls.control(maxiter = 100)))

if("try-error"%in% class(Logfit_gompertz)){
    L_GAIC <- NA
    L_GAICc <- NA
    next
} else{
    L_GAIC <- AIC(Logfit_gompertz)   
    L_GAICc <- AICc(Logfit_gompertz)
}

###calculate total AIC and AICs

M1 <- data.frame(AIC= c(n_linAIC, n_quaAIC, n_LAIC, n_GAIC), 
                    AICc = c(n_linAICc, n_quaAICc, n_LAICc, n_GAICc) )

M2<- data.frame(AIC = c(L_linAIC, L_quaAIC, L_LAIC, L_GAIC), 
                AICc = c(L_linAICc, L_quaAICc , L_LAICc, L_GAICc))  
## create the data frame to store the results
ModelT <- data.frame(M1,M2)
colnames(ModelT) <- c("AIC_norm","AICc_norm", "AIC_Log", "AICc_Log" )
rownames(ModelT) <- c("linear model", "quadratic model", "logistic model","gompertz model")
##write the write in the new folder
write.csv(ModelT,file=paste0("../results/results1/", i, ".csv"), row.names= TRUE)

}

