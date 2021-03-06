getdictionnary=function(learningbase,freq=0.05){

        library(tm)
        data<-read.csv(learningbase, encoding="utf8")
        
        #CONSTRUCTION DU DICTIONNAIRE
        #RECHERCHE MOTS PLUS FREQUENTS
        
        #FREQUENCE MINIMALE D'APPARITION D'UN MOT
        N<-freq*length(data$textStemming)
        
        #CREATION D'UN CORPUS ET TDM
        x<-Corpus(VectorSource(data$textStemming))
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