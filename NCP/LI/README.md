## LI - Landscape suitability for picture-taking

To estimate the spatial distribution of areas fit to provide a service of learning and inspiration by nature, we modeled the landscape potential for picture-taking. We used publicly accessible data from two photo sharing apps centered on photography (*Flickr*) and naturalist observations (*iNaturalist*). [We collected](https://github.com/NKulling/SWISS_ES_ASSESSMENT/tree/main/ES/LI/data_processing/flickr_data_extraction.R) geolocation of pictures taken between 2006 and 2021 from *Flickr* API using the R package “photosearcher” (Fox et al., 2020), with the keywords *"mountains","montagn\*", "berg\*", "foret\*", "foresta", "wald", "natur\*", "landschaft", "paysage", "paesaggio", "landscape".*  We kept one observation per user ID for a total of 6,855 observations. We collected geolocation of pictures uploaded between 2010 and 2021 directly from the *iNaturalist.org* website, keeping one observation per user ID for a total of 3,719 observations. 

[We used](https://github.com/NKulling/SWISS_ES_ASSESSMENT/tree/main/ES/LI/data_processing/flickr_image_recognition.R) automatic image annotation (Schwemmer, 2021) on the geo-referenced pictures to automate the data processing by removing pictures not depicting natural elements (e.g. drawings, vehicle pictures), and to enhance the general quality of the observations (Fox et al., 2021). 

We built a regression model using the “randomForest” R package (Liaw & Wiener, 2002) to infer the landscape suitability for nature picture-taking. We conducted the analysis with 5-fold cross-validation. For each fold, we assessed the model's performance through area under the curve (AUC), mean square error (MSE) and R-squared. Evaluation values are shown in table 1. The set of environmental covariates used in the model are shown in table 2. Correlation cutoff used for the variable selection was set at 0.8. 

Covariates used for the model were based on aggregated land use map categories (see [this script](https://github.com/NKulling/SWISS_ES_ASSESSMENT/tree/main/ES/LI/data_processing/landuse_covariate_creation.R) to generate them), and on topographic variables. 

**Table 1** Model information and evaluation metrics 

| Parameter   | Value   (± Std. deviation) |
| ----------- | -------------------------- |
| Flickr      | 6,855                      |
| iNaturalist | 3,719                      |
| Obs total   | 10,574                     |
| AUC         | 0.880 (0.005)              |
| MSE         | 0.140 (0.0008)             |
| R-squared   | 0.420 (0.003)              |

 **Table 2**  Environmental covariates selected for the model

|                                        |
| -------------------------------------- |
| Average  annual precipitations         |
| Digital  elevation model               |
| Population  density (25m focal)        |
| Terrain  ruggedness index              |
| Landscape  heterogeneity               |
| Landscape  accessibility               |
| Distance  to hiking paths              |
| Alpine  meadows and pastures           |
| Arable  land                           |
| Bare  land                             |
| Brush  forest                          |
| Buildings                              |
| Forest                                 |
| Glaciers  and perpetual snow           |
| Industrial  and commercial areas       |
| Lakes                                  |
| Meadows  and pastures                  |
| Orchards,  vineyards, and horticulture |
| Other  woods                           |
| Recreational  green and leisure areas  |
| Rivers                                 |
| Special  urban areas                   |
| Transport  areas                       |
| Unproductive  vegetation               |

-------

Fox, N., August, T., Mancini, F., Parks, K. E., Eigenbrod, F., Bullock, J. M., Sutter, L., & Graham, L. J. (2020). “photosearcher” package in R: An accessible and reproducible method for harvesting large datasets from Flickr. *SoftwareX*, *12*, 100624. https://doi.org/10.1016/j.softx.2020.100624

Fox, N., Graham, L. J., Eigenbrod, F., Bullock, J. M., & Parks, K. E. (2021). Enriching social media data allows a more robust representation of cultural ecosystem services. *Ecosystem Services*, *50*, 101328. https://doi.org/10.1016/j.ecoser.2021.101328

Liaw, A., & Wiener, M. (2002). *Classification and Regression by randomForest.* R News 2(3), 18--22.

Schwemmer, C. (2021). *Imgrec: An Interface for Image Recognition. R  package version 0.1.2.* https://CRAN.R-project.org/package=imgrec

 