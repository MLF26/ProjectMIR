codingTweets=function(fichier,dico){ #!!!LE DICO DOIT ETRE ISSU DE GETDICTIONNARY!!!
{        
  
  library(tm)
  data<-read.csv(fichier)
  dico<-read.csv(dico)
  
  tweetfeature<-data.frame(matrix(0,0,length(dico$Mots)),row.names=NULL)
  
  for (i in 1:length(data$text)){
    
    vectexti=as.vector(strsplit(data$text[i],split=" ")[[1]])
    vecmotsi=c()
    
    for (j in 1:length(dico$Mots)){
      
      vecmotsi=c(vecmotsi,0)
      
      for (k in 1:length(vectexti)){
        
        if (jarowinkler(vectexti[k],as.character(dico$Mots[j]))==1){
          vecmotsi[j]=1
        }
        
      }
      
    }
    
    tweetfeature<-rbind(tweetfeature,vecmotsi)
  }
  
  names(tweetfeature)<-dico$Mots
  
  fichierfeatures=paste0(sub(".[[:alnum:]]*$","",fichier),"features.csv")
  
  write.csv(tweetfeature,file=fichierfeatures)
        
}
