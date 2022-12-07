setwd("~/Documents/CMEECourseWork/MiniProject/code")
getwd()
rm(list=rm())
## load te package
library(ggplot2)
library(ggthemes)
library(plyr)
library(dplyr)
library(minpack.lm)

#plot one figure as an example to show the fitting
dt1 <- read.csv("../data/subset1.csv")

vec_time <- dt1$Time    

##first linear model
linfit <- lm(PopBio~ Time, data = dt1)
predict.lin <- predict.lm(linfit, data.frame(Time = vec_time))

##then the quadratic model
quafit <- lm(PopBio ~poly(Time, 2), data=dt1)
predict.qua <- predict.lm(quafit, data.frame(Time = vec_time))

#data organization
#plot 
df1 <- data.frame(vec_time , predict.qua)
df1$model <- "Quadratic model"
names(df1) <- c("Time","N","model")

df2 <- data.frame(vec_time, predict.lin)
df2$model <- "linear model"
names(df2) <- c("Time","N","model")

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

fit_logistic <- nlsLM(PopBio ~ Logistic_m(t = Time, r_max, K, N_0), dt1,
      list(r_max=r_max_start, N_0 = N_0_start, K = K_start),
      control = nls.control(maxiter = 100))
##then try the Gompertz model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   
N_0_start <- min(dt1$PopBio) 
K_start <- max(dt1$PopBio) 
r_max_start <- esti_r
t_lag_start <- dt1$Time[which.max(diff(diff(dt1$PopBio)))] 

fit_gompertz <- nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), dt1,
      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start),
        control = nls.control(maxiter = 100))
# orgranization with output
timepoints <- dt1$Time
logistic_points <- Logistic_m(t = timepoints, 
         r_max = coef(fit_logistic)["r_max"], 
         K = coef(fit_logistic)["K"], 
         N_0 = coef(fit_logistic)["N_0"])

df3 <- data.frame(timepoints, logistic_points)
df3$model <- "Logistic equation"
names(df3) <- c("Time", "N", "model")

gompertz_points <- gompertz_model(t = timepoints, 
         r_max = coef(fit_gompertz)["r_max"], 
         K = coef(fit_gompertz)["K"], 
         N_0 = coef(fit_gompertz)["N_0"], 
         t_lag = coef(fit_gompertz)["t_lag"])

df4 <- data.frame(timepoints, gompertz_points)
df4$model <- "Gompertz model"
names(df4) <- c("Time", "N", "model")

################################  under log scale

dt1$LPop <- log(dt1$PopBio)
Loglinfit <- lm(LPop~ Time, data = dt1)
predict.lin2 <- predict.lm(Loglinfit, data.frame(Time = vec_time))

###quadratic one
Logquafit <- lm(LPop ~poly(Time, 2), data=dt1)
predict.qua2 <- predict.lm(Logquafit, data.frame(Time = vec_time))

df5 <- data.frame(vec_time , predict.qua2)
df5$model <- "Quadratic model"
names(df5) <- c("Time","LogN","model")

df6 <- data.frame(vec_time, predict.lin2)
df6$model <- "linear model"
names(df6) <- c("Time","LogN","model")

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

Logfit_logistic <- nlsLM(LPop ~ Logistic_m(t = Time, r_max, K, N_0), dt1,
      list(r_max=r_max_start, N_0 = N_0_start, K = K_start),
      control = nls.control(maxiter=100))
## then try with Gompertz model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}   

N_0_start <- min(dt1$LPop) 
K_start <- max(dt1$LPop) 
r_max_start <- esti_r
t_lag_start <- dt1$Time[which.max(diff(diff(dt1$LPop)))] 

Logfit_gompertz <- nlsLM(LPop ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), dt1,
      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start),
        control = nls.control(maxiter = 100))
timepoints <- dt1$Time

logistic_points <- Logistic_m(t = timepoints, 
         r_max = coef(Logfit_logistic)["r_max"], 
         K = coef(Logfit_logistic)["K"], 
         N_0 = coef(Logfit_logistic)["N_0"])

df7 <- data.frame(timepoints, logistic_points)
df7$model <- "Logistic equation"
names(df7) <- c("Time", "LogN", "model")

gompertz_points <- gompertz_model(t = timepoints, 
         r_max = coef(Logfit_gompertz)["r_max"], 
         K = coef(Logfit_gompertz)["K"], 
         N_0 = coef(Logfit_gompertz)["N_0"], 
         t_lag = coef(Logfit_gompertz)["t_lag"])

df8 <- data.frame(timepoints, gompertz_points)
df8$model <- "Gompertz model"
names(df8) <- c("Time", "LogN", "model")

##total graph
# plot the lines under normal 

pdf("../code/example1.pdf")
model_frame1 <- rbind(df1,df2,df3,df4)

ggplot(dt1, aes(x = Time, y = PopBio)) +
 geom_point(size = 3) +
 geom_line(data = model_frame1, aes(x = Time, y = N, col = model), size = 1) +
 theme(aspect.ratio=1)+ 
 labs(title="the models fitting example under norm scale")+
 xlab ('time') +
 ylab ('popBio number')

graphics.off()
# plot the lines under Log scale

pdf("../example2.pdf")

model_frame2 <- rbind(df5,df6,df7,df8)

ggplot(dt1, aes(x = Time, y = LPop)) +
 geom_point(size = 3) +
 geom_line(data = model_frame2, aes(x = Time, y = LogN, col = model), size = 1) +
 theme(aspect.ratio=1)+ 
 labs(title = "the models fiting example under Log scale",xlab = "Time", ylab = "Log PopBio number")

graphics.off()

############################ AIC and AICc csv files analysis
## to collect all the data from the csv files after models fitting 
getwd()

####### imput and tidy data for analysis
files1 <- dir("../results/results1")
files1
length(files1)

setwd("../results/results1")
n <- length(files1)

for (k in 1: length(files1)) {
    new.data <- read.csv(file = files1[k], header = T, sep=",")

    write.csv(new.data, file= paste0("../results1.2/", k, ".csv"), row.names= TRUE)
}

## AIC with AICc difference  between normal and Log scale

diffinnorm <- c()
diffinLog <- c()

setwd("../results1.2")
files2 <- dir("../results1.2")
files2

for (i in seq(1,length(files2)) ) {

dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')

diffinnorm[i] = abs(mean(dt2$AIC_norm - dt2$AICc_norm, na.rm= TRUE))
diffinLog[i] = abs(mean(dt2$AIC_Log - dt2$AICc_Log, na.rm= TRUE))

}

diffinnorm
diffnorm <- diffinnorm[!is.infinite(diffinnorm)]

diffinLog
diffLog <- diffinLog[!is.infinite(diffinLog)]

dt3 <- data.frame(diffnorm, diffLog)
dt3$ID <- c(1:length(diffnorm))
dt3

#draw the graph

pdf("../difference_between_AICand AICc.pdf")

p1<- ggplot(dt3)+
        geom_point(aes( ID,  diffnorm), color = "red")+
        geom_smooth(aes( ID,  diffnorm), color = "#ff5100")+
        geom_point(aes( ID, diffLog), color = "blue")+
        geom_smooth(aes( ID, diffLog), color = "#008cff")+
        labs(color = "different calculate methods")+
        theme(aspect.ratio=1)+       
        labs(title= "differenc between AIC and AICc calculation about the model fitting") +
        xlab('ID')+
        ylab('diff between AIC and AICc')

p1

graphics.off()

#after the discussion, we choose AICc to do the rest analyse

## compare which model is the best in normal scale
low1 <- list()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')

low1[i] = dt2[which.min(dt2$AIC_norm),]

}

low2 <- list()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')

low2[i] = dt2[which.min(dt2$AICc_norm),]

}

## compare which model is the best in Log scale

low3 <- list()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
low3[i] = dt2[which.min(dt2$AIC_Log),]

}

low4 <- list()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
low4[i] = dt2[which.min(dt2$AICc_Log),]

}

bestfitV1 <- c(sum(low1 =="1"), sum(low1 =="2"),sum(low1 =="3"), sum(low1 =="4"))
model_name <- c("linear model", "quadratic model", "logistic model", "gompertz model")
T1 <- data.frame(model_name, bestfitV1)
T1_2 <- T1 %>% mutate(percentage = scales::percent(bestfitV1/sum(bestfitV1)))


pdf("../AIC_norm.pdf")

p1_2<- ggplot(T1_2, aes(x = '', y = bestfitV1, fill = model_name))+
         geom_bar(stat = 'identity',width = 1,position = 'stack')+ 
         geom_text(aes(y=c(76,27,60,150),label=percentage),size=5)+
         scale_y_continuous(expand = c(0,0))+
         theme_bw()+
         labs(x=NULL,y=NULL,title = 'models evaluated by AIC under normal scale')+
         theme(legend.title = element_blank(),
            legend.position = 'bottom',
            legend.text = element_text(colour = 'black',size = 12),
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20))+
         coord_polar(theta = 'y', start = 0, direction = 1)

p1_2
graphics.off()

bestfitV2 <- c(sum(low2 =="1"), sum(low2 =="2"),sum(low2 =="3"), sum(low2 =="4"))
model_name <- c("linear model", "quadratic model", "logistic model", "gompertz model")
T2 <- data.frame(model_name,bestfitV2)
T2_2 <- T2 %>% mutate(percentage = scales::percent(bestfitV2/sum(bestfitV2)))

T2_2

pdf("../AICc_norm.pdf")

p2_2<- ggplot(T2_2, aes(x = '', y = bestfitV2, fill = model_name))+
         geom_bar(stat = 'identity',width = 1,position = 'stack')+ 
         geom_text(aes(y=c(110,25,70,210),label=percentage),size=5)+
         scale_y_continuous(expand = c(0,0))+
         theme_bw()+
         labs(x=NULL,y=NULL,title = 'models evaluated by AICc under normal scale')+
         theme(legend.title = element_blank(),
            legend.position = 'bottom',
            legend.text = element_text(colour = 'black',size = 12),
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20))+
         coord_polar(theta = 'y', start = 0, direction = 1)

p2_2
graphics.off()



bestfitV3 <- c(sum(low3 =="1"), sum(low3 =="2"),sum(low3 =="3"), sum(low3 =="4"))
model_name <- c("linear model", "quadratic model", "logistic model", "gompertz model")
T3 <- data.frame(model_name,bestfitV3)
T3_2 <- T3 %>% mutate(percentage = scales::percent(bestfitV3/sum(bestfitV3)))

T3_2

pdf("../AIC_Log.pdf")

p3_2<- ggplot(T3_2, aes(x = '', y = bestfitV3, fill = model_name))+
         geom_bar(stat = 'identity',width = 1,position = 'stack')+ 
         geom_text(aes(y=c(140,12,80,210),label=percentage),size=5)+
         scale_y_continuous(expand = c(0,0))+
         theme_bw()+
         labs(x=NULL,y=NULL,title = 'models evaluated by AIC under Log scale')+
         theme(legend.title = element_blank(),
            legend.position = 'bottom',
            legend.text = element_text(colour = 'black',size = 12),
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20))+
         coord_polar(theta = 'y', start = 0, direction = 1)

p3_2
graphics.off()

bestfitV4 <- c(sum(low4 =="1"), sum(low4 =="2"),sum(low4 =="3"), sum(low4 =="4"))
model_name <- c("linear model", "quadratic model", "logistic model", "gompertz model")
T4 <- data.frame(model_name,bestfitV4)
T4_2 <- T4 %>% mutate(percentage = scales::percent(bestfitV4/sum(bestfitV4)))

T4_2

pdf("../AICc_Log.pdf")

p4_2<- ggplot(T4_2, aes(x = '', y = bestfitV4, fill = model_name))+
         geom_bar(stat = 'identity',width = 1,position = 'stack')+ 
         geom_text(aes(y=c(230,10,60,170),label=percentage),size=5)+
         scale_y_continuous(expand = c(0,0))+
         theme_bw()+
         labs(x=NULL,y=NULL,title = 'models evaluated by AICc under Log scale')+
         theme(legend.title = element_blank(),
            legend.position = 'bottom',
            legend.text = element_text(colour = 'black',size = 12),
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.border = element_blank(),
            panel.grid = element_blank(),
            plot.title = element_text(hjust = 0.5,size = 20))+
         coord_polar(theta = 'y', start = 0, direction = 1)

p4_2
graphics.off()

## compare which model is better under different scales, in normal or Log scale
#calculate the density and sd, take Gompertz model as an example
files2 <- dir("../results1.2")
files2

setwd("../results1.2")
## calculate AIC value under norm scale
Gom_AIC <- c()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
Gom_AIC[i]<- dt2$AIC_norm[4]

}
## calculate AICc value under norm scale

Gom_AICc <- c()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
Gom_AICc[i]<- dt2$AICc_norm[4]
}

## calculate AIC value under log scale
Gom_LAIC <- c()
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
Gom_LAIC[i]<- dt2$AIC_Log[4]
}


## calculate AICc value under log scale
Gom_LAICc <- rep(NA,259)
for (i in seq(1,length(files2)) ) {
dt2 <- read.csv(file = files2[i], header = TRUE,sep=',')
Gom_LAICc[i]<- dt2$AICc_Log[4]
}

Gom_AIC2 <- Gom_AIC[!is.na(Gom_AIC) & !is.infinite(Gom_AIC)]
Gom_AICc2 <- Gom_AICc[!is.na(Gom_AICc) & !is.infinite(Gom_AICc)]
Gom_LAIC2<- Gom_LAIC[!is.na(Gom_LAIC) & !is.infinite(Gom_LAIC)]
Gom_LAICc2 <- Gom_LAICc[!is.na(Gom_LAICc) & !is.infinite(Gom_LAICc)]
## calculate the standard deviation value
sd(Gom_AIC2)
sd(Gom_AICc2)
sd(Gom_LAIC2)
sd(Gom_LAICc2)

## make the graph

pdf("../GomAIC_norm.pdf")
boxplot(Gom_AIC2 , xlab="normal scale",ylab="AIC value distribution", main="AIC distribution in Gompertz model")
graphics.off()

pdf("../GomAICc_norm.pdf")
boxplot(Gom_AICc2, xlab="normal scale",ylab="AICc value distribution", main="AICc distribution in Gompertz model")
graphics.off()

pdf("../GomAIC_Log.pdf")
boxplot(Gom_LAIC2, xlab="Log scale",ylab="AIC value distribution", main="AIC distribution in Gompertz model")
graphics.off()
``
pdf("../GomAICc_Log.pdf")
boxplot(Gom_LAICc2,xlab="Log scale",ylab="AICc value distribution", main="AIC distribution in Gompertz model")
graphics.off()
