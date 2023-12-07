library(progress)
#devtools::install_github("nfox29/photosearcher")
library(photosearcher)

wd<-".../Flickr"
setwd(wd)

#-- Setting API Key from Flickr

api_key = ""
CH_polygon_path<-"...Switzerland.shp" #Swiss boundaries

#-- Setting research terms

datestart = "2006-01-01"
datestop = "2021-01-01"

swissbb<- sf::st_read(CH_polygon_path) # region of interest


#-- Tag list 

tag_list = c("mountains","montagn*", "berg*", "foret*", "foresta", "wald", "natur*", "landschaft", "paysage", "paesaggio", "landscape")


#-- creating an empty dataframe to be filled

list_query<-NA

#-- scraping all pictures (Runtime  ~2h)

for(i in 1:length(tag_list)){
  a<-tag_list[i]
  b<- photo_search(
    mindate_taken = datestart,
    maxdate_taken = datestop,
    text = a,
    #bbox = bb,
    sf_layer = swissbb,
    has_geo = TRUE) 
  list_query_CH<-rbind(list_query_CH,b)
  print(paste(((i*100)/length(tag_list)),"%",sep=" "))
}

#-- Export

write.csv(list_query_CH,paste(wd,"flickr_keywords_06-21_CH.csv",sep="/"))



