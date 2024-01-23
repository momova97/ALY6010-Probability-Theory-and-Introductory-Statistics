install.packages("MASS")

# Module 4

#1 Call Libraries
install.packages('FSA')
install.packages("magrittr")
install.packages("dplyr")
install.packages("plyr")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages('outliers')


library(FSA)
library(magrittr)
library(dplyr)
library(plyr)
library(tidyverse)
library(outliers)
library(ggplot2)
library(psych)



### PART1
#Importing dataset
library(MASS)
cats
data(cats)
# first of all wwe delete duplicate rows
cats <- cats[!duplicated(cats), ]
#then we delete outliers
boxplot(cats$Bwt)$out
d <- boxplot(cats$Bwt, plot=FALSE)$out
# no outlier data so we proceed 
summary(cats)
library(psych)
describe(cats)
# we create subsets
males <- cats$Bwt[cats$Sex == "M"]
females <- cats$Bwt[cats$Sex == "F"]
# we see the summary and description of the subseetd
summary(males)
describe(males)
summary(females)
describe(females)
hist(males)
hist(females)
#the T-test
t.test(males,females)

###part2
scores_before=c(4.6, 7.8, 9.1, 5.6, 6.9, 8.5, 5.3, 7.1, 3.2, 4.4)
scores_after= c(6.6, 7.7, 9.0, 6.2, 7.8, 8.3, 5.9, 6.5, 5.8, 4.9)

### Visualization
#11 Histogram plot for Female's Height
hist(scores_before, col = "blue", xlab="Average sleeping Quality Scores before the Workshop")
m<-mean(scores_before)
abline(v = m,col="red")

hist(scores_after, col = "green", xlab="Average sleeping Quality Scores after the Workshop")
m<-mean(scores_after)
abline(v = m,col="red")

 
 
 #### Average sleeping Quality Scores before the Workshop Boxplot
 
 boxplot(scores_before, col= "cyan", border= "red", 
         main="BoxPlot of Average Sleeping Quality Scores Before the Workshop", 
         xlab="Sleeping Quality Scores", horizontal = T)
 
 #### Average sleeping Quality Scores after the Workshop Boxplot
 
 boxplot(scores_after, col= "green", border= "red", 
         main="BoxPlot of Average Sleeping Quality Scores After the Workshop", 
         xlab="Sleeping Quality Scores",
         horizontal = T)



  t.test(scores_before,scores_after,pair=TRUE)
  
  ## changing alpha to 0.1
  
  
  t.test(scores_before,scores_after,pair=TRUE,conf.level = 0.90)
  
  

