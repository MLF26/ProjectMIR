extract.twitter = function(subDir, words, ntweets = 10000000, startDate = Sys.Date()-10)
{
        library(twitteR)
        library(stringi)
        library( stringr)
        library(SnowballC)
        library(tm)
        
        #Twitter Authentication 
        perso<-scan(file="C:/Projet/perso.txt",what="character")
        api_key <- perso[1] 
        api_secret <- perso[2]
        access_token <- perso[3]
        access_token_secret <- perso[4]      
        setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
               
        #Repertory of the project
        mainDir <- perso[5]
        setwd(mainDir)
        
        days = seq(startDate, Sys.Date()-1, "days")
        
        # Create the folder
        if(file.access(subDir)!=0)
        {
          dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
        }
        setwd(file.path(mainDir, subDir)) 
        
        
        
        n <- c("keyword","text","favorited","favoriteCount","replyToSN","created","truncated",
               "replyToSID", "id", "replyToUID", "statusSource", "screenName",
               "retweetCount","isRetweet","retweeted","longitude","latitude")    
        
        result <- data.frame(matrix(0,0,17))
        names(result)<-n
        
        
        for(day in days)
        {
          # Prepare date formats for Twitter and output file        
          currDay = format(as.Date(day, origin="1970-01-01"), "%Y-%m-%d")
          currNextDay = format(as.Date(day+1, origin="1970-01-01"), "%Y-%m-%d")
          fileName = format(as.Date(day, origin="1970-01-01"), "%Y%m%d.csv")
        
        
          n <- c("keyword","text","favorited","favoriteCount","replyToSN","created","truncated",
                 "replyToSID", "id", "replyToUID", "statusSource", "screenName",
                 "retweetCount","isRetweet","retweeted","longitude","latitude")    
        
          d <- data.frame(matrix(0,0,17))
          names(d)<-n
          
          # Loop over the keywords
          for(word in words)
          {
                  tweets = searchTwitter(word, n = ntweets, lang="fr",since=currDay, until=currNextDay)
                  tweets.df <- do.call("rbind", lapply(tweets, as.data.frame))
                  tweets.df$keyword <- word
                  d <- rbind(d,tweets.df)
          }

          d$text<-stri_encode(d$text, "", "UTF-8")
        
          #Text cleaning
          d$text <- clean.text(d$text)
      
       
          #Remove frequent words
          d$textStemming<-removeWords(d$text,stopwords("fr"))
       
          #Stemming
          for (i in 1:length(d$textStemming)){
            x<-wordStem(as.vector(strsplit(d$textStemming[i],split=" ")[[1]]),language="french")
            d$textStemming[i]<-paste(x,collapse=" ")
          }
          
          result = rbind(result, d)

          con<-file(fileName,encoding="UTF-8")  
          write.csv(d,file=con)
        }
    return(result)
}


clean.text = function(text)
{
  
  text = gsub('[^[:alnum:]]', ' ', text)
  text = gsub('[[:punct:]]', '', text)
  text = gsub('[[:cntrl:]]', '', text)
  text<-gsub("\n","",text)
  text = tolower(text)
  text = gsub('[יטךכ]', 'e', text)
  text = gsub('[פצ]', 'o', text)
  text = gsub('[גהא]', 'a', text)
  text = gsub('[מ]', 'i', text)
  text = gsub('[ח]', 'c', text)
  text = gsub('[üûש]', 'u', text)
  
  return(text)
}