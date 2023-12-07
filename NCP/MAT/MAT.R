library(data.table)
library(raster)
library(rgdal)
library(stars)
library(terra)

wd<-"C:/"
setwd(wd)

###---- loading local variables

reg18<-fread(paste(wd,"BPTABLE","c_gain_1318.csv",sep="/")) #carbon gain tables from national GHG inventory

prodreg<- readOGR("C:/PRODREG.shp") #production regions from CH

#--LULC rasters

lulc18<- raster("/LU-CH_2018.tif")#Land use

dem<-raster("/DEM_mean_LV95.tif") # Digital elevation model
slope<- readRDS("C:/topo_alti3d_slope_mean2m.rds")

scratch<- paste(getwd(), "scratch",sep="/")


###----- Result folders

Res18<-"C:/18"

#####--- Part 1 :  creating individual rasters based on elevation and region

  
# reclassification of DEM:

m1<- c(0,600, 1, 
       600,1200, 2,
       1200,Inf, 3)
m11 <- matrix(m1,ncol = 3, byrow=TRUE)

dem_r<-reclassify(dem, m11)

# transforming raster to polygon
dem_p <- sf::as_Spatial(sf::st_as_sf(stars::st_as_stars(dem_r), as_points = FALSE, merge = TRUE)) 


# create new polygon intersecting elevation and region
regelev<- intersect(dem_p, prodreg)


for(i in 1:nrow(regelev@data)){
  regelev@data$regelev_n[i]<-paste(regelev@data$ProdregN_1[i], regelev@data$DEM_mean_LV95[i], sep="")
}

regelev@data$regelev_n<- gsub("Ã©", "e", regelev@data$regelev_n) # removing weird accents
regelev@data$regelev_n<- gsub(" ", "", regelev@data$regelev_n) # removing tabs

#-combining lulc and slope raster, to later keep only forests that arent on slope too steep
#- reclassifying slope pixels that are in a slope < 110%  (47 degree) (Dupire et al. 2015)

l_m <- c(0,47, 0,    #Too steep= value of 1000, ok= Value of 0
         47,Inf,1000)
mat_s <- matrix(l_m,ncol = 3, byrow=TRUE)
s_prac<-reclassify(slope, mat_s)


process_part_1<-function(lulc,year){

lulc_2<-lulc+s_prac #adding to the lulc raster


#----Creating the rasters for each region

list_reg_elev<-data.frame(unique(regelev@data$regelev_n))


for(i in 1:nrow(list_reg_elev)){
  
  name<-list_reg_elev$unique.regelev.data.regelev_n.[i]
  a<-regelev[regelev$regelev_n == name,]
  b<-crop(lulc_2,a)
  c<-mask(b,a)
  
  exname<-paste(year,"_",name,".tif",sep="")
  
  writeRaster(c,paste(scratch,"lulc_clip",exname,sep="/"), overwrite = TRUE)
  print(paste("raster", name,"created", i, "/",length(unique(regelev@data$regelev_n)),sep =" "))
}

}

#Applying the function over the time-series

process_part_1(lulc18,"18")

#####-----Part 2. : Attributing average carbon gain values

process_part_2<-function(regyear,year,res_fold){
  
  reg<-regyear
  
for(i in 1:nrow(reg)){
  
  name<-paste(year,reg$name[i],sep="_")
  val<-reg$val_px[i]
  
  print(paste(name, ", C value:", val,sep=" "))
  
  list0<-c(0,49, 100
            ,59,Inf, 100)
  mat0<- matrix(list0, ncol= 3, byrow= TRUE)
  
  list1<-c(50,val,51,val,52,val,53,val,54,val,55,val,56,0,57,0,58,val,59,val,100,0)
  mat<- matrix(list1,ncol = 2, byrow=TRUE)
  
  namext<-paste(name,".tif",sep="")
  rast<- raster(paste(scratch,"lulc_clip",namext,sep="/"))
  
  newrast0<-reclassify(rast,mat0)
  newrast<-reclassify(newrast0,mat)
  
  exp_name<-paste(name,"reclass.rds",sep="_")
  saveRDS(newrast,(paste(scratch,"rast_reclass",exp_name, sep="/")))
  
  
  print(paste(exp_name, "done!",sep=" "))
  
  
}
  
  #-----Creating an empty raster layer before merging all datasets
  
  bind<-raster()
  crs(bind)<-"+proj=somerc +lat_0=46.9524055555556 +lon_0=7.43958333333333 +k_0=1 +x_0=2600000 +y_0=1200000 +ellps=bessel +units=m +no_defs"
  extent(bind)<-c(2480000, 2840000, 1070000, 1300000)
  res(bind)<-25
  origin(bind)<-0
  
  
print(".... Creating final raster ....:")


#------Merging of all raster datasets using mosaic

  for(i in 1:nrow(reg)){
    
    exp_name<-paste(paste(year,reg$name[i],sep="_"),"reclass.rds",sep="_")
    nr<-readRDS(paste(scratch,"rast_reclass",exp_name, sep="/"))
    
    bind<-mosaic(bind,nr,fun=mean,tolerance=0.05)
    print(paste(exp_name, " added"))
  }
  

thecrs<-sp::CRS('+init=epsg:2056')
crs(bind)<- thecrs

resname<-paste("MAT_S_CH_",year,".tif",sep="")

writeRaster(bind,(paste(res_fold,resname, sep="/")), format="GTiff",overwrite = TRUE)

bind_ind<- bind/maxValue(bind)

resname_ind<-paste("MAT_S_CH_",year,"_index.tif",sep="")

writeRaster(bind,(paste(res_fold,resname_ind, sep="/")), format="GTiff",overwrite = TRUE)

print(paste("raster ",resname," created",sep=""))

}


process_part_2(reg18,"18",Res18)


