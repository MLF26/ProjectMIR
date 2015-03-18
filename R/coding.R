coding = function(fileName, dicoName, isLabel = FALSE)
{
  #Repertory of the project
  perso<-scan(file="C:/Projet/perso.txt",what="character") 
  mainDir <- perso[5]
  setwd(mainDir)
  
  #Create lists of words for dico
  data<-read.csv(fileName)
  dico<-read.csv(dicoName)
  dicoWords = unlist(str_split(dico$Mots, " "))
  
  tweets <- as.character(data$textStemming)  
  
  codeDf <- data.frame(matrix(0,0,length(dicoWords)))
   
  for(tweet in tweets)
  {
    word.list = unlist(str_split(tweet, " "))
    words = as.character(word.list[word.list != ""])
    code <- match(dicoWords,words)
    code[is.na(code)] <- 0
    code[code !=0 ] <- 1
    codeDf <- rbind(codeDf, code)
  }
  
  names(codeDf)<-c(dicoWords)
  
  if(isLabel)
  {
    codeDf$Y <- data$Y
  }
  else
  {
    codeDf$Y <- 0
  }
  
  return(codeDf)
}

