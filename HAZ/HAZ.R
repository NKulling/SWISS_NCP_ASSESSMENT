#---Libraries
library(raster)
library(sf)
library(rgdal)
library(fasterize)

#---Local paths

wd<-"C:/"
setwd(wd)
outfold_s<-"C:/"


#---Local variables

#-Natural hazards raster  (rasterized - provided through silvaProtectCH project)
haz<-raster("C:/haz_tot.tif")   
#protective forests (rasterized - provided through silvaProtectCH project)
pf<- raster("C:/srPW_CH_raster.tif")
#flooding areas 
fa<-st_read("C:/Auen_LV95/au.shp")

#extent template

template<-raster("C:/grid_LV95.tif")

#-LULC rasters

lulc18<- raster("C:/LU-CH_2018.tif")#LULC raster


#1) rasterize flooding areas
fa_r<-fasterize(fa,lulc18)

m_fa<- c(NA,0)
rcl<-matrix(m_fa, ncol=2, byrow=TRUE)
fa_r<- reclassify(fa_r, rcl)

#2) reclassify protective forests

m_pf<- c(NA,0)
rcl<-matrix(m_pf, ncol=2, byrow=TRUE)
pf<- reclassify(pf, rcl)

m_pf<- c(0,1,0,
         1,Inf,1)
rcl<-matrix(m_pf, ncol=3, byrow=TRUE)
pf<- reclassify(pf, rcl)

#3) function to obtain HAZ ES

HAZ_f<-function(lulc,year){
  
  lu<-lulc
  
  # reclassify lulc to obtain only forests. forest= 1, other = 0
  
  m1 <- c(1,36,0,
          36,38,1,
          38,49,0,
          49,60,1,
          60,Inf,0)
  recl_mat <-matrix(m1, ncol=3, byrow=TRUE)
  lu_r<- reclassify(lu, recl_mat)
  
  #--flow modelling (Forests in areas of natural hazards, protecting human infrastructure)
  
  origin(pf)<- c(0,0)
  fl<-lu_r+pf # value of 2 is protective forest
  
  fl_m<- c(1,0,
           2,1)
  rcl<-matrix(fl_m, ncol=2, byrow=TRUE)
  haz_fl<- reclassify(fl, rcl)
  fl2<-haz_fl
  
  #--- Supply modeling (Forests in areas of natural hazards)
  
  haz_su<- lu_r + haz
  
  su_m<- c(0,0,
           1,0,
           2,1)
  rcl<-matrix(su_m, ncol=2, byrow=TRUE)
  haz_su<- reclassify(haz_su, rcl)
  
  #adding eventual forest present in PF layer in the supply layer, for consistency
  
  
  haz_s<-haz_su + fl2
  
  sup_m<- c(0,0,
           1,1,
           2,1)
  rcl<-matrix(sup_m, ncol=2, byrow=TRUE)
  haz_su<- reclassify(haz_s, rcl)
  
  # Adding floodplains
  
  haz_su<-haz_su+fa_r
  
  fl_m<- c(0,0,
           1,1,
           2,1)
  rcl<-matrix(fl_m, ncol=2, byrow=TRUE)
  haz_su<- reclassify(haz_su, rcl)
  
  # Adapt extent
  
  haz_su<-extend(haz_su,extent(template))
  
  # supply export
  
  su_nam<-paste("HAZ_S_CH_",year,".tif",sep="")
  su_pth_nam<-paste(outfold_s,year,su_nam,sep="/")
  
  writeRaster(haz_su,su_pth_nam,overwrite =TRUE)
  
  
  
}


#apply function

HAZ_f(lulc18,"18")
