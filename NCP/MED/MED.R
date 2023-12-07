###################
#
# Aggregating species of interest of Medicinal resources NCP
#
###################

# Load required libraries
library(terra)
library(data.table)

# Set working directory
start <- Sys.time()
wd <- "/home"
setwd(wd)

# Output folder
outfold <- "/results"

# SDM map folder
sdm_fold <- "/current"

# Read species list 
list_sp <- fread("/list_sp.csv", sep = ";")

# Format species names and add filename column

list_sp$fullfilename <- paste(sdm_fold, list_sp$filename, sep = "/")

list_sp <- na.omit(list_sp)
list_sp <- list_sp[-which(duplicated(list_sp$fullfilename)), ]

# Stack rasters
stack_sdm_med <- rast(list_sp$fullfilename)

# Calculate values
med_mean <- mean(stack_sdm_med)
print("Calculation of mean done")
med_sum <- sum(stack_sdm_med)
print("Calculation of sum done")

# Write rasters and list
writeRaster(med_mean, paste(outfold, "med_mean.tif", sep = "/"), overwrite = TRUE)
writeRaster(med_sum, paste(outfold, "med_sum.tif", sep = "/"), overwrite = TRUE)
fwrite(list_sp, paste(outfold, "list_sp_mean.csv", sep = "/"))  #export a list of the species aggregated 

print("Rasters and list written")

stop <- Sys.time()
elapsed <- stop - start

print(elapsed)
