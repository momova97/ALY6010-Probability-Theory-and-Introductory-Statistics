print('Mohammad Hossein Movahedi')
print('Module 3 R practice')
#importing and instaling libraries
install.packages('FSA')
install.packages('magrittr')
install.packages('dplyr')
install.packages('tidyr')
install.packages('plyr')
install.packages('tidyverse')
install.packages('outliers')
install.packages('ggplot2')
install.packages('lubridate')

library(FSA)
library(magrittr)
library(dplyr)
library(tidyr)
library(plyr)
library(tidyverse)
library(scales)
library(lubridate)
library(ggplot2)
library(outliers)

#Importing dataset
data <- read.csv('openpowerlifting.csv')
#because the dataset is too large I choose firsta 10000 data to work with
data <-head(data,n = 10000)
# first of all I delete duplicate rows
op <- data[!duplicated(data), ]
#first we cheak to see if our data looks normal or not
ggplot(op, aes(x=op$Age)) + geom_histogram()
ggplot(op, aes(x=op$BodyweightKg)) + geom_histogram()
ggplot(op, aes(x=op$TotalKg)) + geom_histogram()
#then we delete outliers in age
boxplot(op$Age)$out
d <- boxplot(op$Age, plot=FALSE)$out
op<- op[-which(op$Age %in% d),]
#then we delete outliers in Bodyweightkg
boxplot(op$BodyweightKg)$out
d <- boxplot(op$BodyweightKg, plot=FALSE)$out
op<- op[-which(op$BodyweightKg %in% d),]
#then we delete outliers in Totol
boxplot(op$TotalKg)$out
d <- boxplot(op$TotalKg, plot=FALSE)$out
op<- op[-which(op$TotalKg %in% d),]
#then we subset the data by sex
mp <- filter(op,op$Sex == "M")
fp <- filter(op,op$Sex == "F")

# now we test to see if there is diffrence between men Bodyweight and the average
aveW <- mean(op$BodyweightKg,na.rm = T)
aveA <- mean(op$Age,na.rm = T)
t.test(mp$BodyweightKg, mu = aveW)
t.test(mp$Age, mu = aveA)
# now the same test for weman
aveW <- mean(op$BodyweightKg,na.rm = T)
aveA <- mean(op$Age,na.rm = T)
t.test(fp$BodyweightKg, mu = aveW)
t.test(fp$Age, mu = aveA)
# now we test if there is relation betweenBestBenchKg and BestDeadliftKg
t.test(op$BestSquatKg,op$BestDeadliftKg,paired = TRUE)
