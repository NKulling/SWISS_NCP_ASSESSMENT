###################
#
# The aim of this script is to apply an "ecocrop" model to each crop of interest to generate suitability maps
#
###################

library(Recocrop)
library(data.table)
library(terra)

#setting working directory

wd<-"./"
setwd(wd)

#--local variables

sm_fold <- paste(wd,"results",sep="/") 

pavg95	<- paste(wd,"pavg_95/13_18/lv95",sep="/") # precipitations
tavg95	<- paste(wd,"tavg_95/13_18/lv95",sep="/") # temperature
ph		<- paste(wd,"edaph_eiv_r.tif",sep="/") 	    # pH

crops_data<- paste(wd,"crops.txt",sep="/")        #crops names
lulc18<-rast("C:/LU-CH_2018.tif")                 # Land use map

results<-paste(wd,"results/ES_map",sep="/")       #result ES map folder 


####----- 1) Running individual ecocrop models

#List of food of interest

#read table containing crops list

crops<-t(fread(crops_data,sep=";", header=FALSE))
rownames(crops)<-c(1:nrow(crops))
colnames(crops)<-"crop"
crops<-as.data.frame(crops)

#Environmental variables (Temp, prec, ph)

ta<-rast(paste(tavg95,list.files(tavg95),sep="/"))
ta<-ta/10 # adjusting values (originally multiplied by 10)

pr<-rast(paste(pavg95,list.files(pavg95),sep="/"))
pr<-pr/100*16 # adjusting values (originally multiplied by 100 and for 100m raster cells)

ph <-rast(paste(ph,list.files(ph),sep="/"))


##---- Ecocrop model on each crop type

z<-1
for(i in 1:nrow(crops)){
  a<-crops$crop[i]
  c_name<-substr(a, start = 1, stop = 3)
  if(c_name %in% crops$mod_name == TRUE){
    crops$mod_name[i]<-paste(c_name,z,sep="_")
    z<-z+1}
  else{
  crops$mod_name[i]<-c_name #mod_name becomes a column with each model name
  }
  pars<-ecocropPars(a)
  m_name<-ecocrop(pars)#model
  control(m_name, get_max=TRUE)
  #-predict
  pred<-predict(m_name, tavg=ta, prec=pr, ph=ph, wopt=list(names=c_name))
  #-export
  ex_name<-paste(c_name, ".tif",sep="")
  terra::writeRaster(pred,paste(sm_fold,ex_name,sep="/") , overwrite=TRUE)
  #-print
  print(paste("model:",a,"done.",round((i*100)/nrow(crops),1), "%", sep=" "))
gc()
}


####----- 2) Aggregate map outputs from ecocrop models and mask aggregated map with only agricultural land

r_stack_2<-rast(list.files(sm_fold, full.names=T, pattern="\\.tif$")) ##Ecocrop map outputs
crs(r_stack_2)<-"epsg:2056"

# Reclassify agriculture categories of landuse to 1, rest to 0

m<-c(0,37,0,
     37,48,1,
     48,Inf,0)

m1<-matrix(m, byrow=TRUE, ncol=3)

lulc_agr<-classify(lulc18,m1)

# adapt extent

lulc_agr<-crop(lulc_agr,ext(r_stack_2[[1]]))
lulc_agr<-extend(lulc_agr,ext(r_stack_2[[1]]))

# Mask for agricultural areas and apply a mean

ff_agr<-mean(r_stack_2)

ff_agr_masked<-lulc_agr*ff_agr

# Normalize value

nx <- minmax(ff_agr_masked)    
rn <- (ff_agr_masked - nx[1,]) / (nx[2,] - nx[1,])

#Export

writeRaster(rn,paste(results,"FF.tif",sep="/"))


