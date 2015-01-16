extract.twitter = function(dossier, words, ntwit=100000)
{
        library(twitteR)
        setwd(dossier)
        
        #Twitter Authentication 
        ids<-scan(file="idstwitter.txt",what="character")
        api_key <- ids[1] 
        api_secret <- ids[2]
        access_token <- ids[3]
        access_token_secret <- ids[4]
        setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
        
        date.string = format(Sys.Date(), "%Y%m%d.csv")
        date.today = format(Sys.Date(), "%Y-%m-%d")
        date.yesterday = format(Sys.Date()-1, "%Y-%m-%d")
        
        n <- c("keyword","text","favorited","favoriteCount","replyToSN","created","truncated",
               "replyToSID", "id", "replyToUID", "statusSource", "screenName",
               "retweetCount","isRetweet","retweeted","longitude","latitude")    
        
        d <- data.frame(matrix(0,0,17))
        names(d)<-n
        
        for(word in words)
        {
                tweets = searchTwitter(word, n = ntwit, lang="fr",since=date.yesterday, until=date.today)
                tweets.df <- do.call("rbind", lapply(tweets, as.data.frame))
                tweets.df$keyword <- word
                d <- rbind(d,tweets.df)
        }
        
        d$text<-gsub("\n","",d$text)
        write.csv(d, file = date.string)
}