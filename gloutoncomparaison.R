n<-60
A<-matrix(0,n,2)
colnames(A)<-c("DeltaD","DeltaT")

A[1,]=gloutoncomparaison(3)[1,]
for (i in 1:n){
        A[i,]=gloutoncomparaison(i)[1,]
}

par(mfrow=c(2,1))
matplot(A[,"DeltaD"],pch=4,col="red",ylab="Variation Distance",xlab="Nombre de villes")
matplot(A[,"DeltaT"],pch=4,col="red",ylab="Variation Retard",xlab="Nombre de villes")

