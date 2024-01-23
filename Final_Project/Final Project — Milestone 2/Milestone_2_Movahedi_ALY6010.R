print("Mohammad Hossein Movahedi")
print("Milestone 2")
#importing and instaling libraries
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
#importing dataset
data <- read.csv("https://raw.githubusercontent.com/momova97/ALY6010_Movahedi/main/Robbery_2014_to_2019.csv")
# first of all I delete duplicate rows
rob <- data[!duplicated(data), ]
#Now I clean offence columns by deleting the "Robbery -" part
rob <- data %>%
  mutate_at("offence", str_replace, "Robbery - ", "")
#Now i delete the useless columns
nolist <- c("Index_","event_unique_id","occurrencedate","reporteddate",
            "ucr_code","ucr_ext","reportedyear","reportedmonth","reportedday",
            "reporteddayofyear","reporteddayofweek","reportedhour",
            "MCI","ObjectId")
rob <- rob[,!(names(rob) %in% nolist)]
#Now I combine time columns to make them one
rob$datatime <-paste(rob$occurrenceday," ",rob$occurrencemonth," ",
                      rob$occurrenceyear," ",rob$occurrencehour)

rob$datatime <- parse_date_time(rob$datatime, orders = "dmy_h")
#Now I can delete the rest of columns
notimelist <- c("occurrenceyear" ,"occurrencemonth","occurrenceday",
                "occurrencedayofyear","occurrencedayofweek","occurrencehour")
rob <- rob[,!(names(rob) %in% notimelist)]
rob1<- rob
#Now I set premise, Hood_Id,Neighbourhood  and Division  as factor
rob$premisetype<-as.factor(rob$premisetype)
rob$Division<-as.factor(rob$Division)
rob$Hood_ID<-as.factor(rob$Hood_ID)
rob$Neighbourhood<-as.factor(rob$Neighbourhood)
# Now I group by neighbourhood
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

Hood<- rob %>%
  group_by(Neighbourhood,Hood_ID) %>%
  summarize(NumberOfRobbery = n(),MostOffence = Mode(offence),Division = Mode(Division),Datemean = Mode(datatime),
            Long = mean(Long),Lat = mean(Lat))
head (Hood)
# Now I group by offence
Offence<- rob %>%
  group_by(offence) %>%
  summarize(NumberOfRobbery = n(),MostHood = Mode(Neighbourhood),MostHood_ID = Mode(Hood_ID),Division = Mode(Division),Datemean = Mode(datatime),
            Long = mean(Long),Lat = mean(Lat))
head (Offence)
# Now I group by date
Date<- rob %>%
  group_by(year(datatime),month(datatime)) %>%
  summarize(NumberOfRobbery = n(),MostOffence = Mode(offence),MostHood = Mode(Neighbourhood),MostHood_ID = Mode(Hood_ID),Division = Mode(Division),
            Long = mean(Long),Lat = mean(Lat))
Date <- Date[-c(1,82),]
Date$ym <- paste(Date$`year(datatime)`,"-",Date$`month(datatime)`)
Date$ym <- parse_date_time(Date$ym,order = "ym")
head (Date)
#New we calculate crime rate
ggplot(Date, aes(x= ym , y =NumberOfRobbery)) + geom_point()+geom_smooth()+
  labs(title ="Number Of Robbery in time", x="", y = "Number of Robbery")
lead(Date$`month(datatime)`)

Date <- Date %>%
  mutate(crime_change = (NumberOfRobbery/lead(NumberOfRobbery) - 1) * 100)
# now I delete outliers
boxplot(Date$crime_change)$out
Date$crime_change <- rm.outlier(Date$crime_change, fill = TRUE, median = FALSE, opposite = FALSE)
ggplot(Date, aes(x= ym , y =crime_change)) + geom_point()+geom_smooth()+
  labs(title ="crime change", x="",y="changes")
# now testing connection between crimes and locations
p<-ggplot(data=Hood, aes(x=Division, y=NumberOfRobbery,fill=MostOffence)) +
  geom_bar(stat="identity")
p
#milestone 2
print("milestone 2")
#calculate the mean of all latitudes and then compare them to each area's mean and group the neighbourhoods.
clong <- mean(rob$Long)
clat<- mean(rob$Lat)
ehoods<-filter(Hood,Long >= clong)
whoods<-filter(Hood,Long < clong)
nhoods<-filter(Hood,Lat >= clat)
shoods<-filter(Hood,Lat < clat)
#testing part
t.test(ehoods$NumberOfRobbery,whoods$NumberOfRobbery)
t.test(nhoods$NumberOfRobbery,shoods$NumberOfRobbery)
#testing based on time
robout<- filter(rob,rob$premisetype =="Outside")
robday<- filter(robout,(hour(datatime)>=6 & hour(datatime) < 18)) 
robnight<- filter(robout,(hour(datatime)>18 | hour(datatime) < 6)) 
#grouping
Hoodday<- robday %>%
  group_by(Neighbourhood,Hood_ID) %>%
  summarize(NumberOfRobbery = n(),MostOffence = Mode(offence),Division = Mode(Division),Datemean = Mode(datatime),
            Long = mean(Long),Lat = mean(Lat))
Hoodnight<- robnight %>%
  group_by(Neighbourhood,Hood_ID) %>%
  summarize(NumberOfRobbery = n(),MostOffence = Mode(offence),Division = Mode(Division),Datemean = Mode(datatime),
            Long = mean(Long),Lat = mean(Lat))
#testing
t.test(Hoodday$NumberOfRobbery,Hoodnight$NumberOfRobbery,paired = T)
