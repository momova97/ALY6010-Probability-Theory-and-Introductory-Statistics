print('Mohammad Hossein Movahedi')
#install and load packages
install.packages('FSA')
install.packages('FSAdata')
install.packages('magrittr')
install.packages('dplyr')
install.packages('tidyr')
install.packages('plyr')
install.packages('tidyverse')
install.packages('outliers')
install.packages('ggplot2')
install.packages('lubridate')
install.packages('corrplot')

library(ggplot2)
library(outliers)
library(FSA)
library(FSAdata)
library(magrittr)
library(dplyr)
library(tidyr)
library(dplyr)
library(tidyverse)
library(scales)
library(lubridate)
library(corrplot)
#loading data
data <- read.csv("https://gist.githubusercontent.com/nstokoe/7d4717e96c21b8ad04ec91f361b000cb/raw/bf95a2e30fceb9f2ae990eac8379fc7d844a0196/weight-height.csv")
head(data)
#creating dummy variable
data$Gender[data$Gender == "Male"] = 1
data$Gender[data$Gender == "Female"] = 0
colnames(data)[1]="Maleness"

#regression 
reg <-lm(Height~Weight+Maleness ,data = data)
summary(reg)

#ploting the result

coef <- coef(reg)

plot(Height~Weight, data, pch=16, col=as.numeric(Maleness)+1)
abline(a=coef[1], b=coef[2], col=3)
abline(a=coef[1] + coef[3], b=coef[2], col=4)

#second part
#subseting based on gender
fdata <- filter(data,Maleness ==0)
mdata <- filter(data,Maleness ==1)

#regression models
filter(data,Maleness ==0)
regf <-lm(Height~Weight ,data = fdata)
regm <-lm(Height~Weight ,data = mdata)
summary(regm)
summary(regf)

#ploting
plot(Height~Weight, data, pch=16, col=as.numeric(Maleness)+1)
abline(regm , col=3)
abline(regf , col=4)
#