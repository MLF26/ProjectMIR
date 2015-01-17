getdictionnary=function(learningbase,freq=0.05){

        library(tm)
        data<-read.csv(learningbase)
                    
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
        
        #CONSTRUCTION DU DICTIONNAIRE
        #RECHERCHE MOTS PLUS FREQUENTS
        
        #FREQUENCE MINIMALE D'APPARITION D'UN MOT
        N<-freq*length(data$text)
        
        #CREATION D'UN CORPUS ET TDM
        x<-Corpus(VectorSource(data$text))
        x<-TermDocumentMatrix(x,control = list(wordLengths = c(3,10))) #on ne considère pas les mots trop longs et trop courts
        
        #CONSTRUCTION DU DICTIONNAIRE DE MOTS
        y<-as.matrix(x)
        y<-sort(rowSums(y), decreasing=TRUE)
        y<-as.data.frame(y)
        mots<-row.names(y)
        
        dico<-data.frame(mots,y,row.names=NULL)
        names(dico)<-c("Mots","Frequence")
        dico<-dico[dico$Frequence>N,]
        
        write.csv(dico,file="dico.csv")
        
}