#####
#
# The aim of this script is to reclassify the Land-use map for the carbon storage NCP mapping, based on altitude (DEM) and production region of Switzerland
# The outputs are one land-use map per Region/elevation 
#
#####

library(terra)

# Loading Local variables and folder paths

dem <- rast("C:/DEM_mean_LV95.tif")
prodreg <- vect("C:/PRODREG.shp") # Production regions from CH
lulc18 <- rast("C:/LU-CH_2018.tif") # Land use 

# Folder paths
wd <- "C:/CAR"
setwd(wd)

# Creating scratch folders
scratch <- paste(wd, "scratch", sep = "/")
dir.create(paste(wd, "scratch", sep = "/"))
dir.create(paste(scratch, "lulc_clip", sep = "/"))
dir.create(paste(scratch, "lulc_clip", "18", sep = "/"))
dir.create(paste(scratch, "Invest_models", sep = "/"))

# 1) Preprocessing data

# Reclassify DEM in 3 altitude classes 
m1 <- c(
  0, 600, 1,
  600, 1200, 2,
  1200, Inf, 3
)
m11 <- matrix(m1, ncol = 3, byrow = TRUE)
dem_r <- classify(dem, m11)

# Convert raster to polygons
dem_p <- as.polygons(dem_r)

# Intersect elevation and production region
regelev <- intersect(dem_p, prodreg)
r <- regelev

# Create new column with region + elevation class in the attribute table of regelev
regelev$ProdregN_1 <- gsub("é", "e", regelev$ProdregN_1) # Remove weird accents
regelev$ProdregN_1 <- gsub(" ", "", regelev$ProdregN_1) # Remove tabs
regelev$regelev_n <- paste(regelev$ProdregN_1, regelev$DEM_mean_LV95, sep = "")

# Function to apply to each LULC map

# Reclassify the LULC map into 18 categories
clip_and_reclassify <- function(lulc, year) {
  m <- c(
    0,  0,  1, 12,  2, 12,  3, 12,  4, 12,  5, 12,  6, 12,  7, 12,  8, 12,  9, 12,
    10, 12, 11, 12, 12, 12, 13, 12, 14, 12, 15, 12, 16, 13, 17, 12, 18, 13, 19, 12,
    20, 12, 21, 13, 22, 12, 23, 13, 24, 12, 25, 12, 26, 12, 27, 12, 28, 12, 29, 12,
    30, 12, 31, 15, 32, 13, 33, 13, 34, 13, 35, 13, 36, 13, 37,  7, 38,  7, 39,  5,
    40,  3, 41,  3, 42, 18, 43, 18, 44,  4, 45, 18, 46, 18, 47,  4, 48,  8, 49, 18,
    50,  1, 51,  1, 52,  0, 53,  1, 54,  1, 55,  1, 56,  2, 57,  2, 58,  2, 59,  1,
    60,  2, 61, 10, 62, 10, 63, 12, 64,  4, 65,  9, 66, 12, 67, 11, 68,  9, 69, 16,
    70, 16, 71, 18, 72, 16
  )
  
  m1 <- matrix(m, ncol = 2, byrow = TRUE)
  lulc_r <- classify(lulc, m1)
  
  # Creating the rasters for each region
  list_reg_elev <- data.frame(unique(regelev$regelev_n))
  colnames(list_reg_elev) <- "regelev"
  
  for (i in 1:nrow(list_reg_elev)) {
    name <- list_reg_elev$regelev[i]
    a <- regelev[regelev$regelev_n == name, ]
    b <- crop(lulc_r, a)
    c <- mask(b, a)
    
    NAflag(c) <- 255
    
    writeRaster(c, paste(scratch, "lulc_clip", year, paste(name, ".tif", sep = ""), sep = "/"), overwrite = TRUE, NAflag = 255)
    print(paste("raster", name, "created", i, "/", nrow(list_reg_elev), sep = " "))
    gc()
  }
}

# Applying the function
clip_and_reclassify(lulc18, "18")