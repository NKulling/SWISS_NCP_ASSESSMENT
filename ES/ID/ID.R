

library(terra)

# Set working directory
wd <- "C:/"
setwd(wd)

# folder containing all SDM output maps
sdm_fold <- "D:/"

# result folder
outfold_18 <- "C:/18"

# Loading sp list
list_sp <- fread("C:/sp_list.csv", sep = ";")
list_sp <- list_sp[list_sp$ES == "SYM", ] # Keep only symbolic species (also referred to as emblematic)

# Format species names and add filename column
list_sp <- as.data.frame(lapply(list_sp, function(y) gsub(" ", ".", y)))
list_sp$filename <- NA

# Get list of SDM files
list_sdm <- list.files(sdm_fold, pattern = "\\.tif$")

# Get maps paths
for (i in 1:nrow(list_sp)) {
  a <- list_sp$binom_name[i]
  b <- grep(a, list_sdm)
  
  if (length(b) == 0) {
    next
  } else {
    list_sp$filename[i] <- list_sdm[b]
  }
}

# Remove rows with missing filenames
list_sp <- na.omit(list_sp)
list_sp$fullname <- paste(sdm_fold, list_sp$filename, sep = "/")

# Stacking symbolic species SDM maps
stack_sdm_pc <- rast(list_sp$fullname)
sym_1 <- mean(stack_sdm_pc)

# Set CRS and write raster
crs(sym_1) <- "epsg:2056"
writeRaster(sym_1, paste(outfold_18, "ID_S_CH_18.tif", sep = "/")) 