getdictionnary=function(learningbase,freq=0.05){
        
        library(tm)
        
        data<-read.csv(learningbase)
        
        #FREQUENCE MINIMALE D'APPARITION D'UN MOT
        N<-freq*length(data$text)
        
        #CREATION D'UN CORPUS ET TDM
        x<-Corpus(VectorSource(data$text))
        x<-TermDocumentMatrix(x,control = list(wordLengths = c(3,10))) #on ne considère pas les mots trop longs et trop courts
        
        #CONSTRUCTION DU DICTIONNAIRE DE MOTS
        y<-as.matrix(x)
        y<-head(sort(rowSums(y), decreasing=TRUE),N)
        y<-as.data.frame(y)
        mots<-row.names(y)
        
        dico<-data.frame(mots,y,row.names=NULL)
        names(dico)<-c("Mots","Frequence")
        
        write.csv(dico,file="dico.csv")
        
}