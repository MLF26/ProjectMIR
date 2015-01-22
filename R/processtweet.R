processtweet=function(fichier,dico){ #!!!LE DICO DOIT ETRE ISSU DE GETDICTIONNARY!!!
        
        library(tm)
        data<-read.csv(fichier)
        
        #CASSE
        data$text<-tolower(data$text) #passage en minuscule
        data$text<-gsub("<u\\+[[:alnum:]]{4}>","",data$text)
        
        #NOMBRE ET URL
        data$text<-gsub("http[s]?(://[[:alnum:]]*(.com|.fr|.net|.org|.co)?(/[[:alnum:]]*)*)?"," httpaddr ",data$text) #gestion des URL
        data$text<-removeNumbers(data$text) #gestion des chiffres
        
        data$text<-gsub("@","1234",data$text) #conserver les @ et #
        data$text<-gsub("#","5678",data$text)
        data$text<-gsub("(???|$|£)","money",data$text)
        
        #CARACTERE SPECIAUX
        data$text<-gsub("(é|è|ê|ë)","e",data$text)
        data$text<-gsub("ç","c",data$text)
        data$text<-gsub("(à|â)","a",data$text)
        data$text<-gsub("ù","u",data$text)
        data$text<-gsub("ô","o",data$text)
        data$text<-gsub("î","i",data$text)
        
        #PONCTUATION
        data$text<-removePunctuation(data$text) #on retire la ponctuation
        data$text<-gsub("('|"|"|-)","",data$text) #autre ponctuation
        data$text<-gsub(".","",data$text)
        data$text<-gsub("1234"," @",data$text)
        data$text<-gsub("5678"," #",data$text)
        
        #MOTS TROP COURANTS
        data$text<-removeWords(data$text,stopwords("fr"))
        
        #STEMMING
        library(SnowballC)
        for (i in 1:length(data$text)){
                x<-wordStem(as.vector(strsplit(data$text[i],split=" ")[[1]]),language="french")
                data$text[i]<-paste(x,collapse=" ")
        }
        
        #DEBUT TWEET/ESPACES
        data$text<-gsub("(^[[:space:]]+|^rt[[:space:]]+)","",data$text) #début de tweet
        data$text<-stripWhitespace(data$text) #espaces en un seul espace + espace insécable
       
        #CONSTRUCTION VECTEUR DE MOTS / AU DICTIONNAIRE
        library(RecordLinkage)
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
