install.packages('twitteR')
install.packages('ggplot2')
install.packages('devtools')

setwd("~/Pougne/3A/ECL/Option/Projet")

#load the packages
library(devtools)
install.packages(c("rjson", "bit64", "httr"))
library(rjson)
library(bit64)
library(htt)
install_github("twitteR", username="geoffjentry")
library(twitteR)
library(ggplot2)

#Twitter Authentication 
api_key <- "IToYEwMIomWmXz1s6pRsgWlaa" 
api_secret <- "anLA5Tz7hiIXq9yFuUgMNQPRnurp8CHdOWwREaoEE71URefjOs"
access_token <- "2913936477-4wX9kQhxFuUVeQa56UvpJjA53tqjm3qGLGylJ6J"
access_token_secret <- "y2cX9hJX68k5QljDxEjzZUhBFLjjk1VD4HC08fiOzvCAl"
setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

tweets = searchTwitter('Benzema', n = 200, lang = 'fr', since='2014-12-24', retryOnRateLimit = 500)
tweets.text= sapply(tweets, function(t){t$getText()})
tweets.dates= sapply(tweets, function(t){as.character(t$getCreated())})
tweets.dates[[length(tweets.dates)]]

rstats.tweets <- searchTwitter(searchString = "Charlie", n = 400)
rstats.tweets.df <- do.call("rbind", lapply(rstats.tweets, as.data.frame))


