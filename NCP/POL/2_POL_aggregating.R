# Put together pollination information
library(terra)

#Local variables

setwd("C:/")

data_folder<-paste(getwd(),"/invest",sep="")

files <- list.files(data_folder, pattern = "supply", full.names = T) #Getting every supply map for each species

#output folder

out18<-paste(getwd(),"18",sep="/")


# Stack rasters

p_list<-rast(files)

#calculate sum value

pol_sum <- sum(p_list)

# Normalize
nx <- minmax(pol_sum)    
rn <- (pol_sum - nx[1,]) / (nx[2,] - nx[1,])

#export raster
writeRaster(rn,paste(out18,"POL.tif",sep="/"))

