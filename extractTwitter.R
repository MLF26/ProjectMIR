extract.twitter = function(subDir, words, startDate = Sys.Date()-1)
{
  library(twitteR)
  
  # Authentification Twitter
  api_key <- "Fol8wpaumR6xvkGGYySfrCufj" 
  api_secret <- ---
  access_token <- "2207967797-2HxVSOWIPQPXFipTBIzep3QModItVHYIB964uK6"
  access_token_secret <- ---

  setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)
  
  # Repertory of the project
  mainDir = "~/Centrale/projet/"
  
  days = seq(startDate, Sys.Date()-1, "days")
  
  # Create the folder
  dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
  setwd(file.path(mainDir, subDir)) 
  
  for(day in days)
  {
    # Prepare date formats for Twitter and output file
    
    currDay = format(as.Date(day, origin="1970-01-01"), "%Y-%m-%d")
    currNextDay = format(as.Date(day+1, origin="1970-01-01"), "%Y-%m-%d")
    fileName = format(as.Date(day, origin="1970-01-01"), "%Y%m%d.csv")
    
    # Prepare the final data frame
    n <- c("keyword","text","favorited","favoriteCount","replyToSN","created","truncated",
           "replyToSID", "id", "replyToUID", "statusSource", "screenName",
           "retweetCount","isRetweet","retweeted","longitude","latitude")    
    
    df <- data.frame(matrix(0,0,17))
    names(df)<-n
    
    # Loop over the keywords
    for(word in words)
    {
      tweets = searchTwitter(word, n = 20, since=currDay, until=currNextDay)
      tweets.df <- do.call("rbind", lapply(tweets, as.data.frame))
      tweets.df$keyword <- word
      df <- rbind(df,tweets.df)
    }
     
    # Write the csv file in the new folder
    write.csv(df, file = fileName)
  }
  
  setwd(mainDir) 
}