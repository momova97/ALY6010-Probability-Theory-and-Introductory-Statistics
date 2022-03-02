#adding subheading and name
print("Mohammad Hossein Movahedi")
print("week 1 r practice")
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

# importing database for this project aasignment I used Toronto Home Price Index dataset
thpi <- read.csv("MLS.csv")
# cheaking dataset structure
str(thpi)
#change date format from string to date and also location as factor
thpi$Date <- as.Date(thpi$Date,"%Y-%d-%m")
thpi$Location <- as.factor(thpi$Location)
thpi[c("CompYoYChange", "SFDetachYoYChange","SFAttachYoYChange","ApartYoYChange")] <- as.numeric()
# also some clos are in presentages so I change them too
thpi[c("CompYoYChange", "SFDetachYoYChange","SFAttachYoYChange","ApartYoYChange")] <- lapply(thpi[c("CompYoYChange", "SFDetachYoYChange","SFAttachYoYChange","ApartYoYChange")],
                                                                                             function(x){x/100})
#I am ok with names so I wont change them
#deleting duplicated datas
thpi[!duplicated(thpi), ]
summary(thpi)

# I group my data by locations so I can make better plots
th <- thpi[c("Location","SFDetachIndex","SFDetachBenchmark","SFDetachYoYChange","SFAttachIndex",
             "SFAttachBenchmark","SFAttachYoYChange")]
th <- as_tibble(th)
means <- th %>%
  group_by(Location) %>%
  dplyr::summarise_all(mean,na.rm = TRUE)
# from now on I only use means as my dataset
attach(means)



# calculating IQR and Q
IQR(c(means[,2]),na.rm=T)
Q <- means %>%
 summarise_if(is.numeric,~quantile(.,probs=c(.25, .75), na.rm =T))

iqr <- means %>%
  summarise_if(is.numeric,IQR,na.rm=T)

t<- rbind(Q,iqr)
up<- c(t[2,] +1.5*t[3,])
low <- c(t[1,] -1.5*t[3,])
t <-rbind(t,up)
t <-rbind(t,low)
# starting to clean
means_cl <- means
t
means_cl <- rm.outlier(means[2:7], fill = TRUE, median = FALSE, opposite = FALSE)
boxplot(means_cl)$out
# the below process has be repeted until no outlier is detected
means_cl <- rm.outlier(means_cl[1:6], fill = TRUE, median = FALSE, opposite = FALSE)
boxplot(means_cl)$out
# adding the location column again
means_cl['Location']<- means$Location
mcl <- means_cl
head(mcl,5)
#know we can get to the easy part
# histograms
AD <- data.frame(a = mcl$SFDetachBenchmark,b ="FD")
AD1 <-data.frame(a = mcl$SFAttachBenchmark,b = "FA")
AD <- rbind(AD,AD1)
ggplot(AD, aes(x=a))+
  geom_density(data=subset(AD,b == 'FD'),fill = "red", alpha = 0.2) +
  geom_density(data=subset(AD,b == 'FA'),fill = "green", alpha = 0.2)+ 
  labs(title ="Detach vs Attach", x="", y = "Density")
# scatter plot 
ggplot(mcl, aes(x=SFDetachYoYChange, y=SFAttachYoYChange )) + geom_point()+
  labs(title ="YoYChanges", x="DetachYoYChange", y = "AttachYoYChange")+
  geom_smooth(method=lm)

#pie chart
bp<- ggplot(mcl, aes(x="", y=SFDetachBenchmark, fill=Location))+
  geom_bar(width = 1, stat = "identity")
bp + coord_polar("y", start=0) 
