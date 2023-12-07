#####
# Reprocessing of Soil layer for water yield model
#####

library(terra)

##- Local path

soilmap<-vect("./Maps.Geo.Soils/Bodeneignungskarte der Schweiz LV95 Shape/Bodeneignungskarte_LV95.shp")

##- 1) Rasterize soil maps

#-generate 100m template

templ<-rast(ext(soilmap), res=100, crs="epsg:2056")

#- 1.1) Plant available water content 

pawc_r<-rasterize(soilmap, templ, field= "WASSERSPEI")

#-1.2) Root restricting depth

rrd_r<-rasterize(soilmap, templ, field= "GRUNDIGKEI")

##- 2) Reclassifcation

#- 2.1) Plant available water content

m<-c(-9999,0,
     1,8,
     2,23,
     3,38,
     4,53,
     5,80,
     6,100)
m1<-matrix(m, byrow=T, ncol= 2)

pawc_r2<-classify(pawc_r, m1) #Final layer used for InVEST model (plant available water content)

#- 2.2) Root restricting depth (soil depth)

mm<- c(-9999,0,
      1,200,
      2,450,
      3,750,
      4,1050,
      5,1450)
mm1<-matrix(mm, byrow= T, ncol=2)

rrd_r2<-classify(rrd_r, mm1) #Final layer used for InVEST model (root restricting depth)
