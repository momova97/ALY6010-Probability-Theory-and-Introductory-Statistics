print("Mohammad Hossein Movahedi")
Print("week2")
#reading the dataset
data <- read.csv("woodbine_horses.csv")
#installing Important libraries
install.packages('FSA')
install.packages('FSAdata')
install.packages('magrittr')
install.packages('dplyr')
install.packages('tidyr')
install.packages('plyr')
install.packages('tidyverse')
install.packages('outliers')
install.packages('ggplot2')
library(ggplot2)
library(outliers)
library(FSA)
library(FSAdata)
library(magrittr)
library(dplyr)
library(tidyr)
library(plyr)
library(tidyverse)
library(scales)
# cheaking dataset structure
str(data)
names (data)
#selecting varibale of intrest
horse <- data.frame(name = data$name,weight = data$weight,age = data$age,speed = data$speed_rating,sex =data$sex)
names(horse)
#data cleaning part
str (horse)
horse$sex = as.factor(horse$sex)

#deleting duplicated datas
horse <- horse[!duplicated(horse), ]
# I group my data by gender so I can make better plots
gnames <- horse %>%
  group_by(sex)%>%
  dplyr::summarise_if(is.numeric,mean,na.rm = TRUE)

gnames <- na.omit(gnames)
print (gnames)
#density plot
ggplot(horse, aes(x=speed))+
  geom_density(data=subset(horse,sex == 'C'),fill = "red", alpha = 0.2) +
  geom_density(data=subset(horse,sex == 'F'),fill = "green", alpha = 0.2)+ 
  geom_density(data=subset(horse,sex == 'G'),fill = "yellow", alpha = 0.2) +
  geom_density(data=subset(horse,sex == 'H'),fill = "orange", alpha = 0.2)+
  geom_density(data=subset(horse,sex == 'M'),fill = "pink", alpha = 0.2) +
  geom_density(data=subset(horse,sex == 'R'),fill = "purple", alpha = 0.2)
  labs(title ="distibution of speed by genders", x="", y = "Density")

#histogram
ggplot(horse, aes(x=speed, color=sex, fill=sex)) +
  geom_histogram(position="identity", alpha=0.5)


horse$weightbyage <- horse$weight/horse$age
# scatter plot 
ggplot(horse, aes(x=weightbyage, y=speed )) +geom_jitter()
  labs(title ="weightbyage vs speed", x="weightbyage", y = "speed rating")+
  geom_smooth(method=lm)


