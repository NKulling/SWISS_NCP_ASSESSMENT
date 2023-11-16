library(terra)
library(stars)
library(rgdal)
library(data.table)
library(fasterRaster)



# 0) Paths and local variables -----------------------------------------------


wd<-"C:/"
setwd(wd)
data_path<- "C:/data"
scratch<- paste(wd,"scratch",sep ="/")
result<- paste(wd,"result", sep = "/")

template<-rast("C:/valparc_grid_LV95.tif")  #Template raster grid

#-- Swiss mask

swiss<-vect("C:/Switzerland_noliechstenstein.shp")  # From file swissBOUNDARIES3D

#--Water component part

lakes<- vect(paste(data_path, "lakes",sep="\\"))
distlakes<- rast("C:/watercomp.tif")  #raster with a 2km  distance buffer around lakes (done in arcgis Pro)
lulc<- rast("C:/LU-CH_2018.tif")

#--Natural area component part

TLM_PA<-  vect("C:/TLMRegio_ProtectedArea.shp")

#-- Naturalness part

lutable_NAT <- fread(paste(wd,"lutable_naturality.csv",sep="/"))


# 1) Water component  -----------------------------------------------------

#-- processing distance layer to give higher value close to the lake
#-- Normalizing values

nx <- minmax(distlakes)    
rn <- (distlakes - nx[1,]) / (nx[2,] - nx[1,])

rn2<- rn

#-- Inverting values 

values(rn2)<-1-values(rn)

#-- Reclassifying NAs in 0

m<-c(NA,0)
m1<-matrix(m,byrow=T, ncol=2)
rn2<-classify(rn2,m1)

#-- Keeping lakes only inside the swiss mask

rn2<-mask(rn2,swiss)



# 2) Degree of naturalness ---------------------------------------------------

m<- data.frame(lutable_NAT$LULC, lutable_NAT$HABITAT)

m1<-data.matrix(m)

nc<-classify(lulc,m1)


# 3) Natural/protected areas -------------------------------------------------

pa<-rasterize(TLM_PA, nc)

m<-c(NA,0)
m1<-matrix(m,byrow=T, ncol=2)
ppa<-classify(pa,m1)

##extent matching

ppa<-extend(ppa,ext(template))
ppa<-crop(ppa,ext(template))

nc<-extend(nc,ext(template))
nc<-crop(nc,ext(template))

rn2<-extend(rn2,ext(template))
rn2<-crop(rn2,ext(template))


# 4) Merging components  --------------------------------------------------


nat<-ppa+nc+rn2

nat<-mask(nat,swiss)

nat2<-nat/3 # to get a 1-0 valuerange

# Export raster
writeRaster(nat2,"C:/REC.tif", overwrite=T)
