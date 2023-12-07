##Generate aggregated land use classes 

library(terra)


lulc<-rast("/LU-CH_2018.tif")   # swiss land use map

reclass<-fread("C:/NOAS04_27_17_labels.csv") #Reclassification matrix based on OFS NOAS04_17

expout<-"C:/data"

template<- rast("C:/SWECO25-standardgrid.tif") #template for extent 

#reclass in 27 cat

m<-as.matrix(reclass[,c(1,3)])

lulc17<-classify(lulc,m)

for(i in 1:17){
  
  #Extract class name
  
  name<-reclass[reclass$AS17==i]$AS17_NAME[1]
  
  #Reclassify in single classes
  
  z<-i-1

  m<-c(0,z,0,
       i,i,1,
       i,Inf,0)
  m1<-matrix(m,byrow=T, ncol=3)
  
  m2<-matrix(c(i,1),byrow=T, ncol=2)
  
  map<-classify(lulc17,m1)
  map2<-classify(map,m2)
  
  names(map2)<-name
  
  #Export
  
  nameout<-paste(name,".tif",sep="")
  nameout<-gsub(", ","_", nameout)
  nameout<-gsub(" ", "_", nameout)
  nameout<-tolower(nameout)
  
  writeRaster(map2, paste(expout, nameout,sep="/"))
  
}

lf<-list.files(expout, full.names = T)

for(i in 1:length(lf)){
  
  a<-rast(lf[i])
  
  a2<-extend(a, ext(template))
  
  writeRaster(a2, lf[i], overwrite=T)
  
  cat("map ", i )
  
}


