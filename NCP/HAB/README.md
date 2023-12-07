## HAB- habitat quality

This index was computed using InVEST Python module habitat quality (Sharp et al., 2020), which calculates an index value for each raster cell based on its relative habitat score, its [sensitivity to threats](https://github.com/NKulling/SWISS_NCP_ASSESSMENT/blob/main/NCP/HAB/BPTABLE/hab_sensitivity.csv) and its proximity to threats. 

The habitat quality index is based on a land-use land-cover map of Switzerland at 25m resolution. Each category was attributed an habitat score based on its naturality score (expert-based, ranging 0-1, adapted from naturality scores defined in the Geneva region (GE-21, 2020). [The threats](https://github.com/NKulling/SWISS_NCP_ASSESSMENT/blob/main/NCP/HAB/BPTABLE/18_threats.csv) considered in the analysis  were primary and secondary roads (Berta Aneseyee et al., 2020; Forman & Deblinger, 2000), rural residential, urban, and agricultural areas (Gong et al., 2019) representing the main anthropic threats found in Switzerland. The threats effect on habitats were assigned by reviewing literature for the maximum distance of influence (Palomino & Carrascal, 2007; Shilling & Waetjen, 2012), the relative decay of the threat effect (Berta Aneseyee et al., 2020) and the weight given to threat parameters (Terrado et al., 2016). 

The maximal degradation of habitat coefficient was 0.15 doing a first run with default half saturation constant. As suggested by Sharp et al. (2020), the final model was done based on half this coefficient (0.075).  

The [script](https://github.com/NKulling/SWISS_NCP_ASSESSMENT/blob/main/NCP/HAB/threat_layers_generation.R) used to generate threat layers based on land-use is available in this repository. 

----

Berta Aneseyee, A., Noszczyk, T., Soromessa, T., & Elias, E. (2020). The InVEST Habitat Quality Model Associated with Land Use/Cover Changes: A Qualitative Case Study of the Winike Watershed in the Omo-Gibe Basin, Southwest Ethiopia. *Remote Sensing*, *12*(7), 1103. https://doi.org/10.3390/rs12071103

Forman, R. T. T., & Deblinger, R. D. (2000). The Ecological Road-Effect Zone of a Massachusetts (U.S.A.) Suburban Highway. *Conservation Biology*, *14*(1), 36–46. https://doi.org/10.1046/j.1523-1739.2000.99088.x

GE-21. (2020). *Indicateurs Services Ecosystémiques Genève*. https://www.ge21.ch/projets/Indicateurs-Services-Ecosyst%C3%A9miques-Gen%C3%A8ve

Gong, J., Xie, Y., Cao, E., Huang, Q., & Li, H. (2019). Integration of InVEST-habitat quality model with landscape pattern indexes to assess mountain plant biodiversity change: A case study of Bailongjiang watershed in Gansu Province. *Journal of Geographical Sciences*, *29*(7), 1193–1210. https://doi.org/10.1007/s11442-019-1653-7

Palomino, D., & Carrascal, L. M. (2007). Threshold distances to nearby cities and roads influence the bird community of a mosaic landscape. *Biological Conservation*, *140*(1), 100–109. https://doi.org/10.1016/j.biocon.2007.07.029

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.

Shilling, F. M., & Waetjen, D. P. (2012). *The Road Effect Zone GIS Model*. https://escholarship.org/uc/item/4537d6vj

Terrado, M., Sabater, S., Chaplin-Kramer, B., Mandle, L., Ziv, G., & Acuña, V. (2016). Model development for the assessment of terrestrial and aquatic habitat quality in conservation planning. *Science of The Total Environment*, *540*, 63–70. https://doi.org/10.1016/j.scitotenv.2015.03.064

 
