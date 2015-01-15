library(ggplot2)
library(maps)
library(twitteR)
library(ggmap)

install.packages("ggmap")

api_key <- "Fol8wpaumR6xvkGGYySfrCufj" 
api_secret <- "LaoNwzyq4BDtcu7TmeNHtmQSKg4blEnIGhGLx436F3OxvJ1Qx0"
access_token <- "2207967797-2HxVSOWIPQPXFipTBIzep3QModItVHYIB964uK6"
access_token_secret <- "YI1193okQ29YWKcdM0bTMGnNDsLoqHPgB5FL9iAWJcFQg"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

searchTerm <- "UMP"
searchResults <- searchTwitter(searchTerm, n = 100000, re)  # Gather Tweets 
tweetFrame <- twListToDF(searchResults)  # Convert to a nice dF

userInfo <- lookupUsers(tweetFrame$screenName)  # Batch lookup of user info
userFrame <- twListToDF(userInfo)  # Convert to a nice dF

userFrame$lat <- sapply(userFrame$location, FUN = function(l){gGeoCode(l)[1]})  # Use amazing API to guess
userFrame$long <- sapply(userFrame$location, FUN = function(l){gGeoCode(l)[2]})  # Use amazing API to guess

france <- map('france', fill = TRUE, col = 0:0)
p <- ggplot()
p <- p + geom_polygon( data=france, aes(x=long, y=lat, group = group),colour="black", fill="white" )
#p <- p + geom_point( data=userFrame, aes(x=long, y=lat), color="blue")
#p <- p + geom_point( data=userFrame2, aes(x=long, y=lat), color="black")
p <- p + geom_point( data=userFrame3, aes(x=long, y=lat), color="red")
p <- p + xlim(-5.14209, 9.562665)
p <- p + ylim(41.366005, 51.097523)
p

