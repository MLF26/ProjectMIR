processtweet=function(fichier){
        
        data<-read.csv(fichier)
        
        #CASSE
        data$text<-tolower(data$text) #passage en minuscule
        data$text<-gsub("<u\\+[[:alnum:]]{4}>","",data$text)
        
        #NOMBRE ET URL
        data$text<-gsub("http[s]?(://[[:alnum:]]*(.com|.fr|.net|.org|.co)?(/[[:alnum:]]*)*)?"," httpaddr ",data$text) #gestion des URL
        data$text<-gsub("[0-9]+"," number ",data$text) #gestion des chiffres
        
        data$text<-gsub("@","1234",data$text) #conserver les @ et #
        data$text<-gsub("#","5678",data$text)
        
        #CARACTERE SPECIAUX
        data$text<-gsub("(é|è|ê|ë)","e",data$text)
        data$text<-gsub("ç","c",data$text)
        data$text<-gsub("(à|â)","a",data$text)
        data$text<-gsub("ù","u",data$text)
        data$text<-gsub("ô","o",data$text)
        data$text<-gsub("o","oe",data$text)
        data$text<-gsub("î","i",data$text)
        
        #PONCTUATION
        data$text<-gsub("[[:punct:]]"," ",data$text) #on retire la ponctuation
        data$text<-gsub("("|"|'|.|-)","",data$text) #autre ponctuation
        data$text<-gsub("1234"," @",data$text)
        data$text<-gsub("5678"," #",data$text)
        
        #DEBUT TWEET
        data$text<-gsub("(^[[:space:]]+|^rt[[:space:]]+)","",data$text) #début de tweet
        data$text<-gsub("[[:space:]]+", " ", data$text) #espaces en un seul espace + espace insécable
        
        #STEMMING
        library(SnowballC)
        for (i in 1:length(data$text)){
                x<-wordStem(as.vector(strsplit(data$text[i],split=" ")[[1]]),language="french")
                data$text[i]<-paste(x,collapse=" ")
        }
       
        fichierclean=paste0(sub(".[[:alnum:]]*$","",fichier),"clean.csv")
        
        write.csv(data,file=fichierclean)
        
}
