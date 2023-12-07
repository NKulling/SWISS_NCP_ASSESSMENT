### LEARNING AND INSPIRATION ES -- Landscape suitability for picture-taking

library(terra)
library(data.table)
library(randomForest)
library(ade4)
library(factoextra)
library(corrplot)
library(dismo)


results<-"C:/result"

##-- 1) loading data
# Reference points

obs<-fread("C:/obs_tot_LV95.csv")
obs_vect<-vect(obs, geom= c("longitude","latitude"))

# Covariates

covfile<-fread("C:/covariates.csv")

cov<- rast(covfile$DataPaths)

##-- 2) Extracting values of observation points

pred<-cov 
bfc <- extract(pred, obs)
bfc<-na.omit(bfc)

#- 2.1) Generate background points

set.seed(0)
bg <- spatSample(cov, 15000, ext=ext(obs_vect))
bg<-na.omit(bg)

d <- rbind(cbind(pa=1, bfc[,c(2:ncol(bfc))]), cbind(pa=0, bg)) #pa: presence-absence
d <- data.frame(d)

#- 2.2) Look at variables correlations

# PCA
  pca<- dudi.pca(df = d, scannf = FALSE, nf = 5)
  
#correlation circle
  fviz_pca_var(pca,
             col.var = "contrib", 
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

#correlogram

  M<-cor(d)
  highly_correlated <- which(M > 0.8 & M < 1, arr.ind = TRUE)

#- 2.3) Modifying the df to remove correlated variables
  
  print(highly_correlated) # Removal of slope variable
  
  d<-d[,-3]       #from df
  pred<- cov[[-2]]  #from predictor set

#- 3) Modeling
  
  # dividing in training and testing sets (80/20) (for first run of model)
  
  
  k <- 5
  group <- kfold(d, k)
  group[1:10]
  
  unique(group)
  rf_list<-NA
  
  e <- list()
  st<-Sys.time()
  for (i in 1:k) {
    train <- d[group != i,] # training set
    test <- d[group == i,] # testing set
    
    trf <- tuneRF(train[, 2:ncol(train)], train[, 'pa'])
    mt <- trf[which.min(trf[,2]), 1]
    rrf <- randomForest(train[, 2:ncol(train)], train[, 'pa'], mtry=mt)
    
    tag<-paste("rrf",i,sep="_")
    assign(tag,rrf)
    rf_list[i]<-tag
    
    e[[i]] <- evaluate(test[test$pa==1, ], test[test$pa==0, ], rrf)
  }

  plot(rrf)
  varImpPlot(rrf_1)  
  
#- 3.2) Evaluating the models 
  
  mods<- list(rrf_1,rrf_2,rrf_3,rrf_4,rrf_5)
  
  # R squared
  rsq<-NA
  for(i in 1:length(mods)){
    rsq[i]<-mean(mods[[i]]$rsq)
  }
  
  # MSE
  mse<-NA
  for(i in 1:length(mods)){
    mse[i]<-mean(mods[[i]]$mse)
  }
  
  # AUC
  auc <- sapply(e, function(x){x@auc})
  
  mean(rsq)  #0.42
  sd(rsq)
  mean(mse)#0.14
  sd(mse)
  mean(auc)#0.88
  sd(auc)
  
#-- 3.3) predicting
  
  # Saving the model
  
  saveRDS(rrf, paste(results,"RF_model.rds",sep="/"))
  
  # Predicting to covariates set
  
  colnames(train[,-1])==names(pred) # lost in translation
  
  names(pred)<-  colnames(train[,-1])
  

  
  #Predict
  st<-Sys.time()
  proj_rrf<- terra::predict(pred,rrf, type ="response", cpgk = "randomForest", na.rm=T)
  en<-Sys.time()
  rtime<-en-st # 51 min
  
  
  writeRaster(proj_rrf, paste(results, "LI.tif",sep="/"))
  