setwd("C:/Users/Znogoud/Documents/Pougne/3A/ECL/Option/Projet")
data<-read.csv("~/Pougne/3A/ECL/Option/Projet/20150114.csv")
data$text<-tolower(data$text)
data$text<-gsub("[0-9]"," number",data$text)

x<-"ajrajj http://rjaar.com arar htt://"

x="alloriaj7Njala8"
regexpr("http://[a-z,A-Z]",x)
gsub("http://[a-z,A-Z]*","number",x)
