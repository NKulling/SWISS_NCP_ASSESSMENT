#####
#
# The aim of this script is to reunite different InVEST models in one final map
#
#####

library(terra)

# Folder paths
wd <- "C:/CAR"
setwd(wd)

fold18<-paste(wd,"scratch/Invest_models",sep="/") #folder containing invest models
res18<-paste(wd, "results",sep="/") #result folder
n18<-"CAR.tif"   #output name

# Function to apply for each time period

carbon_process_3<-function(in_folder, results, name_out){

#--- move all final outputs to new folder (this part scraps outputs from invest folders and thus copies the outputs. /!\ generates a copy of the files)

list_files<-list.files(in_folder)
dir.create(paste(in_folder,"tot_c_united",sep="/"))

print("directory created")

for(i in 1:length(list_files)){
  print(list_files[i])
  path1<- paste(in_folder,list_files[i],sep="/")
  name<- paste("tot_c_cur_", list_files[i],".tif",sep="")
  path2<- paste(path1,name,sep="/")
  file.copy(path2,paste(in_folder,"tot_c_united",sep="/"))
}

print("files copied")

#--- bind together each file

#creating empty raster to fill
bind<-rast()
crs(bind)<-"epsg:2056"
ext(bind)<-c(2480000, 2840000, 1070000, 1300000) #Swiss extent
res(bind)<-25


#merging each raster

list_lu<- list.files(paste(in_folder,"tot_c_united",sep="/"))

for(i in 1:length(list_lu)){
  name<-list_lu[i]
  nr<-rast(paste(in_folder,"tot_c_united",name,sep="/"))
  crs(nr)<-"epsg:2056"
  bind<-mosaic(bind,nr,fun="max")
  print(paste(name, " added"))
}

crs(bind)<-"epsg:2056"
bind<-extend(bind,c(2480000, 2840000, 1070000, 1300000))

writeRaster(bind,(paste(results,name_out, sep="/")),overwrite = TRUE)

print("final raster written")
}

#--- Applying for each period

carbon_process_3(fold18,res18,n18)
