##This file is firstly set up and clean the dataset.
##Then, according to the equation of Power-Law and 
##Fractal dimension, plot four graphs to obtain the 
##final results.

require(tidyverse)
require(ggplot2)
library("ggpubr")
library(patchwork)

##add the ####experiment data####
mydata1<- read.csv("experimentdata/1_50.csv", header = T)
#head(mydata1)
mydata2<- read.csv("experimentdata/51_100.csv", header = T)
mydata3<- read.csv("experimentdata/101_150.csv", header = T)
mydata4<- read.csv("experimentdata/151_200.csv", header = T)
mydata5<- read.csv("experimentdata/201_250.csv", header = T)
mydata6<- read.csv("experimentdata/251_300.csv", header = T)
mydata7<- read.csv("experimentdata/301_350.csv", header = T)
mydata8<- read.csv("experimentdata/351_400.csv", header = T)
mydata9<- read.csv("experimentdata/401_486.csv", header = T)


##add the ####GSW data####
Data1<-read.csv("GSWdata/1.csv",header=T)
Data2<-read.csv("GSWdata/2.csv",header=T)
Data3<-read.csv("GSWdata/3.csv",header=T)
Data4<-read.csv("GSWdata/4.csv",header=T)
Data5<-read.csv("GSWdata/5.csv",header=T)
Data6<-read.csv("GSWdata/6.csv",header=T)
Data7<-read.csv("GSWdata/7.csv",header=T)
Data8<-read.csv("GSWdata/8.csv",header=T)
Data9<-read.csv("GSWdata/9.csv",header=T)
Data10<-read.csv("GSWdata/10.csv",header=T)
Data11<-read.csv("GSWdata/11.csv",header=T)
Data12<-read.csv("GSWdata/12.csv",header=T)
Data13<-read.csv("GSWdata/13.csv",header=T)


######Bind all data together in ####my experiment data####
DT1<-rbind(mydata1,mydata2,mydata3,mydata4,mydata5,mydata6,
            mydata7,mydata8,mydata9)

#glimpse(DT1)

#area<- DT1$A
#glimpse(area)
#summary(area)
#hist(log10(area))
#boxplot(log10(area))

DT2<- filter(DT1,A <= 10^6)

#glimpse(DT2)

#area2<- DT2$A
#perimeter2<-DT2$P
#hist(log10(area2))
#boxplot(log10(area2))
#hist(log10(perimeter2))


#####bind all data together in the ####GSW data####
DT3<-rbind(Data1,Data2,Data3,Data4,Data5,Data6,
            Data7,Data8,Data9,Data10,Data11,Data12,Data13)

hist(log10(DT3$A))
#boxplot(log10(DT3$A))

####### clean the dataset 

DT4<- filter(DT3,A >= 1)
#glimpse(DT4$A)
hist(log10(DT4$A))
boxplot((log10(DT4$A)))

## to do the plot

#######c####umulative graph

###For  ### my experiment data###
# Define the list of given area thresholds
given_area_thresholds <- seq(from=0,to=6,by=0.05)
given_area_thresholds
# Calculate cumulative frequency for each given area threshold
cumulative_frequencies <- sapply(given_area_thresholds, function(threshold) {
  num_ponds_greater_than_threshold <- sum(log10(DT2$A) > threshold)
  num_ponds_greater_than_threshold
})
# Create a dataframe to store the results
comparison_data <- data.frame(
  Given_Area = given_area_thresholds,
  Cumulative_Frequency = cumulative_frequencies
  #Total_Lake_Area = sum(log10(DT2$A))
)
##plot
#glimpse(comparison_data)
#comparison_data$Cumulative_Frequency
#plot(comparison_data$Given_Area,log10(comparison_data$Cumulative_Frequency))
#abline( a= 9.7, b=-1.25)

df1<-comparison_data[-121,]
df2<-df1[-c(1:106),]
glimpse(df2)
fit1<- lm(log10(df2$Cumulative_Frequency) ~df2$Given_Area)
summary(fit1)
## the alpha value is 2.058, whihc is 10^5.15 < 10^5.2(key) <10^5.25 
##  which is 0.1412, 0.1584, 0.1778
#abline(v=5.2,lty=2)

png( "Cumulative VS A1.png", width=8, height=6,units = "in", res=600)


#do the plot
l1<- ggplot(comparison_data, aes(x=Given_Area,y=log10(Cumulative_Frequency)))
l2<- l1+
geom_point(aes(color="Points"))+
theme_bw()+
theme(aspect.ratio=1)+
l3<-l2+
geom_abline(aes(intercept = 13.9, slope = -2.05, color = "power-law"), linetype = "solid", show.legend = TRUE)
l4<-l3+
geom_vline(aes(xintercept = 5.2,color = "Abline"), linetype = "dashed", show.legend = TRUE)

#l4
l5<-l4+
scale_color_manual(values = c("Points" = "blue", "power-law" = "red","Abline"= "black"),
                     labels = c("My dataset \nlake data", "r=2.05", "Transition \nArea(5.2)")) +
labs(x ="log10(area) m^2",
     y="log10(Abundance) ",
    color = "Legend:") +
guides(color = guide_legend(override.aes = list(
    linetype = c("blank", "solid", "dashed"), 
    color=c("blue", "red","black"),   
    size = c(1.5, 1.5, 0.8)  
  )))

#l5

### For GSW dataset###

# Calculate cumulative frequency for each given area threshold
cumulative_frequencies2 <- sapply(given_area_thresholds, function(threshold) {
  num_ponds_greater_than_threshold <- sum(log10(DT4$A) > threshold)
  num_ponds_greater_than_threshold
})
# Create a dataframe to store the results
comparison_data2 <- data.frame(
  Given_Area = given_area_thresholds,
  Cumulative_Frequency2 = cumulative_frequencies2
  #Total_Lake_Area = sum(log10(DT2$A))
)
##plot
#glimpse(comparison_data2)
comparison_data2$Cumulative_Frequency2
#plot(comparison_data2$Given_Area,log10(comparison_data2$Cumulative_Frequency2))
#abline( a= 12.5, b=-2.05)
df3<-comparison_data2[-c(116:121),]
glimpse(df3)
df4<-df3[-c(1:50),]
glimpse(df4)
fit2<- lm(log10(df4$Cumulative_Frequency) ~df4$Given_Area)
summary(fit2)
## the alpha value is 2.058, whihc is 10^4.4 < 10^4.45(key) <10^4.5 
##which is, key(0.281) 
#abline(v=4.45,lty=2)

## do the plot
j1<- ggplot(comparison_data2, aes(x=Given_Area,y=log10(Cumulative_Frequency2)))
j2<- j1+
geom_point(aes(color="Points"))+
theme_bw()+
theme(aspect.ratio=1)
j3<-j2+
geom_abline(aes(intercept = 12.6, slope = -2.0580, color = "power-law"), linetype = "solid", show.legend = TRUE)
j4<-j3+
geom_vline(aes(xintercept = 4.45,color = "Abline"), linetype = "dashed", show.legend = TRUE)

#j4
j5<-j4+
scale_color_manual(values = c("Points" = "blue", "power-law" = "red","Abline"= "black"),
                     labels = c("GSW dataset \nlake data", "r=2.05", "Transition \nArea (4.45)")) +
labs(x ="log10(area) m^2",
     y="log10(Abundance) ",
    color = "Legend:") +
guides(color = guide_legend(override.aes = list(
    linetype = c("blank", "solid", "dashed"), 
    color=c("blue", "red","black"),   
    size = c(1.5, 1.5, 0.8)  
  )))

#j5

############################# output graph

arrange_plot_CA<- ggarrange(
  l5, j5,labels = c("My data", "GSW data"),
  ncol=2,legend="bottom" )

print2<- 
arrange_plot_CA +
plot_annotation(title="Lake Abundance Vs Area \n compared with power-law in two dataset")
  
print2
print(print2)
dev.off()

##### export final concrete graphs



######## further trial
#DT5<- filter(DT4,A >= 10^5.2)
#glimpse(DT5$A)
#hist(log10(DT5$A))
#DT6<- filter(DT4,A>= 10^4.45)
#hist(log10(DT6$A))

#png( "P VS A1.png", width=8, height=6,units = "in", res=600)

### for ####my experiment dataset####
#q1<- ggplot(DT2, aes(x=log10(A),y=log10(P)))
#q2<- q1+
#geom_point(aes(color="Points"))+
#theme_bw()+
#theme(aspect.ratio=1)+
#geom_smooth(method='lm',aes(color="Fractal line"))
#q3<-q2+
#expand_limits(y = c(0,6))
#q4<-q3+
#geom_abline(aes(intercept = 0.5, slope = 0.5, color = "Abline"), linetype = "dashed", show.legend = TRUE)
#q5<-q4+
#scale_color_manual(values = c("Points" = "blue", "Fractal line" = "red","Abline"= "black"),
#                     labels = c("GSW dataset \nlake data", "d=1.48", "Circular A:P \nd=1")) +
#labs(x ="log10(area) m^2",
#     y="log10(perimeter) m",
#    color = "Legend:") +
#guides(color = guide_legend(override.aes = list(
#    linetype = c("blank", "solid", "dashed"), 
#    color=c("blue", "red","black"),   
#    size = c(1.5, 0.8, 1.2)  
#  )))

#q5

##summary the data model to grab the d which 
## is double of the slope
#model1<- lm(log10(P)~log10(A), data = DT2)
#summary(model1)  

#model1_1<-lm(log10(P)~log10(A),data= DT5)
#summary(model1_1)



### for ####my GSW dataset####

#p1<- ggplot(DT4, aes(x=log10(A),y=log10(P)))
#p2<- p1+
#geom_point(aes(color="Points"))+
#theme_bw()+
#theme(aspect.ratio=1)+
#geom_smooth(method='lm',aes(color="Fractal line"))
#p3<-p2+
#expand_limits(y = c(0,6))
#p4<-p3+
#geom_abline(aes(intercept = 0.5, slope = 0.5, color = "Abline"), linetype = "dashed", show.legend = TRUE)
#p5<-p4+
#scale_color_manual(values = c("Points" = "blue", "Fractal line" = "red","Abline"= "black"),
#                     labels = c("My dataset \nlake data", "d=1.26", "Circular A:P \nd=1")) +
#labs(x ="log10(area) m^2",
#     y="log10(perimeter) m",
#    color = "Legend:") +
#guides(color = guide_legend(override.aes = list(
#    linetype = c("blank", "solid", "dashed"), 
#    color=c("blue", "red","black"),   
#    size = c(1.5, 0.8, 1.2)  
#  )))

#p5

##the summary
#model2<- lm(log10(P)~log10(A), data = DT4)
#summary(model2)  

#model1_2<-lm(log10(P)~log10(A),data= DT6)
#summary(model1_2)


############################# output graph111111111

#arrange_plot_AP<- ggarrange(
#  p5, q5,labels = c("My data", "GSW data"),
#  ncol=2,legend = "bottom")
  
#print1<- 
#arrange_plot_AP +
#plot_annotation(title="Fractal dimensions derived form two dataset")
  
#print1
#print(print1)
#dev.off()
