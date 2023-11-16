
library(data.table)
library(terra)

# Set working directory
wd <- "C:/"
setwd(wd)

# SDM map folder
sdm_fold <- "D:/" 

# output folder

outfold<-paste(wd,"output",sep="/")

# Read species list for pest control
sp_list <- fread("C:/sp_list.csv")

# Stack pest control species SDM maps
stack_sdm_pc <- rast()

for (i in 1:nrow(list_sp)) {
  a <- list_sp$filename[i]
  if (is.na(a) == TRUE) {
    next
  } else {
    b <- rast(paste(sdm_fold, a, sep = "/"))
    stack_sdm_pc <- c(stack_sdm_pc, b)
    print(a)
  }
}

list_sp<-na.omit(list_sp)

# Calculate sum and mean
pc_1 <- sum(stack_sdm_pc)
pc_2 <- mean(stack_sdm_pc)

# Export to raster

writeRaster(pc_2, paste(outfold, "PC.tif", sep="/"))
fwrite(list_sp, paste(outfold, "sp_list.tif", sep="/"))  #export a list of the species aggregated 
