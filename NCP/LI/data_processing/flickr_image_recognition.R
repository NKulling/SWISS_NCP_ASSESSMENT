#devtools::install_github('cschwem2er/imgrec')
#install.packages('imgrec')
library(imgrec)
library(data.table)
library(jpeg)
library(RCurl)

# local

wd<-".../google_vision"
flick_dt<-".../flickr_keywords_06-21_CH.csv"
setwd(wd)

# flickr data

list_query_CH<-fread(flick_dt)

# Removing NAs

list_flickr<-list_query_CH[complete.cases(list_query_CH$url_l),]
list_flickr<-list_flickr[-which(duplicated(list_flickr$owner)),]

### ----- Google Vision - image recognition 

#set up API access
Sys.setenv(gvision_key = "") #Google vision API Key
gvision_init()

#search google vision for labels for Flickr /!!!!/ warning each request can cost the owner of the API KEY
#runtime 11.3 min

start<-Sys.time()

results <- get_annotations(images = paste(list_flickr$url_l), # image url
                           features = "label", 
                           max_res = 10, # maximum number of results per feature
                           mode = 'url') # determine image type
end<-Sys.time()
time_f<-end-start

#parse results
temp_file_path <- tempfile(fileext = '.json')
save_json(results, temp_file_path)
img_data <- parse_annotations(results)

#df of gvision tags
gvision_flickr <- img_data$labels

#save outputs
write.csv(gvision_flickr, paste(wd,"gvision_flickr_CH_10lab.csv",sep="/"))


#------ classifying according to nature words

#-- loading words list

nature<-t(fread("nature_keyword.txt",sep=",", header=FALSE))
rownames(nature)<-c(1:nrow(nature))
colnames(nature)<-"word"

non_nature<-t(fread("non_nature_keyword.txt",sep=",", header=FALSE))
rownames(non_nature)<-c(1:nrow(non_nature))
colnames(non_nature)<-"word"

#---- attributing a value of 1 for nature keyword and 0 for non nature

class<-gvision_flickr

class$nature<-NA

for(i in 1:nrow(class)){
  a<-class$description[i]
  if(a %in% nature == TRUE){class$nature[i]<-1}
  else if(a %in% non_nature ==TRUE){class$nature[i]<-0}
  else{class$nature[i]<-NA}
}

#--- recreating a list of unique pictures, with the percentage of pictures being "nature"

newclass<-class[-which(duplicated(class$img_id)),]
newclass$nature_percent<-NA
newclass$avg_score<-NA
nobs_tot<-NA

for(i in 1:nrow(newclass)){
  a<-newclass$img_id[i]
  b<-subset(class, class$img_id == a)
  b<-subset(b, b$score>0.6) # removing pictures with a score < 0.6
  c<-nrow(b)
  nobs_tot<-append(nobs_tot,c)
  newclass$nature_percent[i]<-sum(b$nature)/c # to get a percentage, with varying nrow
  newclass$avg_score[i]<-mean(b$score)
}

#----- Visuals

hist(newclass$nature_percent, breaks = 10)
which(newclass$nature_percent==0.3)


#----- Merging with original data extracted from flickr


data<-list_flickr

names(data)[names(data) == "url_l"] <- "img_id"

data_class<- merge(data,newclass[ , c("nature_percent", "img_id")], by = "img_id")

#--- Removing pictures with <.25 % nature classification

data_class<-subset(data_class, data_class$nature_percent>0.25)

#save outputs
write.csv(data_class, paste(wd,"results","flickr_CH_classed.csv",sep="/"))

short<-data_class[,c("longitude","latitude","nature_percent")]
write.csv(short, paste(wd,"results","flickr_CH_classed_short.csv",sep="/"))


#----- Manual validation of data for 100 pictures

# Nature >25 %

test<-data_class[sample(nrow(data_class), 100), ]
test$valid<-NA #1 = valid classification, 0 = bad classification

for(i in 1:nrow(test)){
  jj<-readJPEG(getURLContent(test$img_id[i]))
  plot(0:1,0:1,type="n",ann=FALSE,axes=FALSE)
  rasterImage(jj,0,0,1,1)
  print(i)
  x<- as.numeric(readline("For recreation type 1, for non-recreation type 0"))
  test$valid[i]<-x
  dev.off()
}

table(test$valid) #97% accuracy


write.csv(test, paste(wd,"manual_check_100.csv",sep="/"))

# Nature <25 %

test_nn<-subset(newclass, newclass$nature_percent<0.25)
test_nn<-test_nn[sample(nrow(test_nn), 100), ]
test_nn$valid<-NA

for(i in 1:nrow(test_nn)){
  jj<-readJPEG(getURLContent(test_nn$img_id[i]))
  plot(0:1,0:1,type="n",ann=FALSE,axes=FALSE)
  rasterImage(jj,0,0,1,1)
  print(i)
  x<- as.numeric(readline("For non- recreation type 1, forrecreation type 0"))
  test_nn$valid[i]<-x
  dev.off()
}

table(test_nn$valid) # 86% accuracy

write.csv(test_nn, paste(wd,"manual_check_100_nonnature.csv",sep="/"))