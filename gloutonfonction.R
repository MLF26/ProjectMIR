gloutonideal=function(nombre,alea=4) {
        set.seed(alea)
        n=nombre
        ville<-data.frame(cbind(1:n,rnorm(n),rnorm(n))) #positionner les villes
        colnames(ville)=c("id","Latitude","Longitude")
        ville$distance=0
        ville$distanceg=0

        for (j in 1:n) {
                init=j
                v<-as.vector(ville$id)
                u=c(init)
                idp<-init
                v<-v[v!=idp]

                while (length(u)!=n) {
        
                        init=idp
        
                        for (i in v) {
                                ville$distance[i]=(ville$Longitude[init]-ville$Longitude[i])^2+(ville$Latitude[init]-ville$Latitude[i])^2
        
                        }
        
                        idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                        ville$distanceg[j]<-ville$distanceg[j]+ville$distance[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                        v<-v[v!=idp]
                        u=c(u,idp)
        
                }
        
        }
        
        ville$distance=0
        init<-ville$id[ville$distanceg==min(ville$distanceg)][1]
        v<-as.vector(ville$id)
        u=c(init)
        idp<-init
        v<-v[v!=idp]
        
        while (length(u)!=n) {
                
                init=idp
                
                for (h in v) {
                        ville$distance[h]=(ville$Longitude[init]-ville$Longitude[h])^2+(ville$Latitude[init]-ville$Latitude[h])^2
                        
                }
                
                idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                v<-v[v!=idp]
                u=c(u,idp)
                
        }
        
        ordre<-ville[u,]
        ordre[n+1,]<-ordre[1,]
                
        plot(ordre$Longitude,ordre$Latitude,type="l",col="red",lty=2,xlab="Longitude",ylab="Latitude")
        points(ordre$Longitude,ordre$Latitude,col="green",pch=3)
        title("Méthode du glouton")
}        

gloutonreel=function(nombre,alea=4) {
        set.seed(alea)
        n=nombre
        ville<-data.frame(cbind(1:n,rnorm(n),rnorm(n))) #positionner les villes
        colnames(ville)=c("id","Latitude","Longitude")
        ville$distance=0
        ville$distanceg=0
        
        
        init=sample(1:n,1)
        v<-as.vector(ville$id)
        u=c(init)
        idp<-init
        v<-v[v!=idp]
                
        while (length(u)!=n) {
                        
                init=idp
                        
                for (i in v) {
                        ville$distance[i]=(ville$Longitude[init]-ville$Longitude[i])^2+(ville$Latitude[init]-ville$Latitude[i])^2
                                
                }
                
                idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                v<-v[v!=idp]
                u=c(u,idp)    
        }
        
        ordre<-ville[u,]
        ordre[n+1,]<-ordre[1,]
        
        plot(ordre$Longitude,ordre$Latitude,type="l",col="red",lty=2,xlab="Longitude",ylab="Latitude")
        points(ordre$Longitude,ordre$Latitude,col="green",pch=3)
        title("Méthode du glouton")
}        

gloutoncomparaison=function(nombre,alea=4) {
        set.seed(alea)
        n=nombre
        ville<-data.frame(cbind(1:n,rnorm(n),rnorm(n))) #positionner les villes
        colnames(ville)=c("id","Latitude","Longitude")
        
        #IDEAL
        ptm1<-proc.time()
        ville$distance=0
        ville$distanceg=0
        
        for (j in 1:n) {
                init=j
                v<-as.vector(ville$id)
                u=c(init)
                idp<-init
                v<-v[v!=idp]
                
                while (length(u)!=n) {
                        
                        init=idp
                        
                        for (i in v) {
                                ville$distance[i]=(ville$Longitude[init]-ville$Longitude[i])^2+(ville$Latitude[init]-ville$Latitude[i])^2
                                
                        }
                        
                        idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                        ville$distanceg[j]<-ville$distanceg[j]+ville$distance[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                        v<-v[v!=idp]
                        u=c(u,idp)
                        
                }
                
        }
        
        ville$distance=0
        init<-ville$id[ville$distanceg==min(ville$distanceg)][1]
        d1=init
        v<-as.vector(ville$id)
        u=c(init)
        idp<-init
        v<-v[v!=idp]
        
        while (length(u)!=n) {
                
                init=idp
                
                for (h in v) {
                        ville$distance[h]=(ville$Longitude[init]-ville$Longitude[h])^2+(ville$Latitude[init]-ville$Latitude[h])^2
                        
                }
                
                idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                v<-v[v!=idp]
                u=c(u,idp)
                
        }
        
        ordre<-ville[u,]
        ordre[n+1,]<-ordre[1,]
        t1<-proc.time()-ptm1
        
        plot(ordre$Longitude,ordre$Latitude,type="l",col="red",lty=2,xlab="Longitude",ylab="Latitude")
        
        points(ordre$Longitude,ordre$Latitude,col="green",pch=3)
        title("Méthode du glouton")

        # REEL
        ptm2<-proc.time()
        ville$distance=0
        ville$distanceg=0
        
        
        init=sample(1:n,1)
        v<-as.vector(ville$id)
        u=c(init)
        idp<-init
        v<-v[v!=idp]
        d2=0
        
        while (length(u)!=n) {
                
                init=idp
                
                for (i in v) {
                        ville$distance[i]=(ville$Longitude[init]-ville$Longitude[i])^2+(ville$Latitude[init]-ville$Latitude[i])^2
                        
                }
                
                idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                d2=d2+ville$distance[ville$id==idp]
                v<-v[v!=idp]
                u=c(u,idp)    
        }
        
        ordre<-ville[u,]
        ordre[n+1,]<-ordre[1,]
        t2<-proc.time()-ptm2
        
        lines(ordre$Longitude,ordre$Latitude,type="l",col="blue",lty=2,xlab="Longitude",ylab="Latitude")
        legend("bottomleft",c("ideal","reel"),col=c("red","blue"),cex=0.7,pt.cex=1,lty=2,bg="grey")
        
        t<-t1[3]-t2[3]
        comparaison<-matrix(c(d2-d1,t),1,2)
        colnames(comparaison)<-c("DeltaD","DeltaT")
        return(comparaison)

}

gloutonreelpro=function(nombre,alea=4,time=0.8) {
        set.seed(alea)
        n=nombre
        ville<-data.frame(cbind(1:n,rnorm(n),rnorm(n))) #positionner les villes
        colnames(ville)=c("id","Latitude","Longitude")
        ville$distance=0
        ville$distanceg=0
        
        
        init=sample(1:n,1)
        v<-as.vector(ville$id)
        u=c(init)
        idp<-init
        v<-v[v!=idp]
        
        plot(ville$Longitude,ville$Latitude,col="green",pch=3,xlab="Longitude",ylab="Latitude")
        title("Méthode du glouton")
        
        while (length(u)!=n) {
                
                init=idp
                
                for (i in v) {
                        ville$distance[i]=(ville$Longitude[init]-ville$Longitude[i])^2+(ville$Latitude[init]-ville$Latitude[i])^2
                        
                }
                
                idp<-ville$id[ville$distance==min(ville$distance[ville$distance!=0 & ville$id %in% v])][1]
                v<-v[v!=idp]
                u=c(u,idp)
                ordre<-ville[u,]
                lines(ordre$Longitude,ordre$Latitude,type="l",col="blue",lty=2)
                Sys.sleep(time)
        }
        
        ordre<-ville[u,]
        ordre[n+1,]<-ordre[1,]
        
        lines(ordre$Longitude,ordre$Latitude,type="l",col="blue",lty=2)
}

