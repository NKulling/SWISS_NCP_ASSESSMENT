## POL - pollinator abundance

This ES cartography is based on the potential presence of wild pollinators for pollination. Pollinators (list available in this repository) were selected based on (Kleijn et al., 2015). Output map was produced using the InVEST pollination Python module (Sharp et al., 2020), which estimates the habitat suitability by analysing nesting suitability and available floral resources within each species flight range, in accordance with the pollinators phenology. The different input values were defined by a literature review based on studies made in Switzerland or similar ecoregions. 

Land-use table was based on studies from Groff et al. (2016); Honeck et al. (2020); Zhao et al. (2019). Nesting habits were found in Fortel et al. (S2 - 2014) – *Andrena sp.,* *Bombus sp.* *Lassioglossum sp*. ; Lye et al. (2012) – *Bombus sp*. ; Strohm et al. (2002) – *Osmia sp.* Alpha values (flight range) were taken from aforementioned studies and completed using the “pollimetry” R package (Kendall et al., 2018). 

The R script in this repository computes an aggregation of InVEST output of individual species pollination supply. 



----

Fortel, L., Henry, M., Guilbaud, L., Guirao, A. L., Kuhlmann, M., Mouret, H., Rollin, O., & Vaissière, B. E. (2014). Decreasing Abundance, Increasing Diversity and Changing Structure of the Wild Bee Community (Hymenoptera: Anthophila) along an Urbanization Gradient. *PLoS ONE*, *9*(8), e104679. https://doi.org/10.1371/journal.pone.0104679

Groff, S. C., Loftin, C. S., Drummond, F., Bushmann, S., & McGill, B. (2016). Parameterization of the InVEST Crop Pollination Model to spatially predict abundance of wild blueberry (Vaccinium angustifolium Aiton) native bee pollinators in Maine, USA. *Environmental Modelling & Software*, *79*, 1–9. https://doi.org/10.1016/j.envsoft.2016.01.003

Honeck, E., Moilanen, A., Guinaudeau, B., Wyler, N., Schlaepfer, M. A., Martin, P., Sanguet, A., Urbina, L., von Arx, B., Massy, J., Fischer, C., & Lehmann, A. (2020). Implementing Green Infrastructure for the Spatial Planning of Peri-Urban Areas in Geneva, Switzerland. *Sustainability*, *12*(4), Article 4. https://doi.org/10.3390/su12041387

Kendall, L. K., Rader, R., Gagic, V., Cariveau, D. P., Albrecht, M., Baldock, K. C. R., Freitas, B. M., Hall, M., Holzschuh, A., Molina, F. P., Morten, J. M., Pereira, J. S., Portman, Z. M., Roberts, S. P. M., Rodriguez, J., Russo, L., Sutter, L., Vereecken, N. J., & Bartomeus, I. (2018). *Pollinator size and its consequences: Predictive allometry for pollinating insects* [Preprint]. Ecology. https://doi.org/10.1101/397604

Kleijn, D., Winfree, R., Bartomeus, I., Carvalheiro, L. G., Henry, M., Isaacs, R., Klein, A.-M., Kremen, C., M’Gonigle, L. K., Rader, R., Ricketts, T. H., Williams, N. M., Lee Adamson, N., Ascher, J. S., Báldi, A., Batáry, P., Benjamin, F., Biesmeijer, J. C., Blitzer, E. J., … Potts, S. G. (2015). Delivery of crop pollination services is an insufficient argument for wild pollinator conservation. *Nature Communications*, *6*(1), Article 1. https://doi.org/10.1038/ncomms8414

Lye, G. C., Osborne, J. L., Park, K. J., & Goulson, D. (2012). Using citizen science to monitor Bombus populations in the UK: Nesting ecology and relative abundance in the urban environment. *Journal of Insect Conservation*, *16*(5), 697–707. https://doi.org/10.1007/s10841-011-9450-3

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.

Strohm, E., Daniels, H., Warmers, C., & Stoll, C. (2002). Nest provisioning and a possible cost of reproduction in the megachilid bee *Osmia rufa* studied by a new observation method. *Ethology Ecology & Evolution*, *14*(3), 255–268. https://doi.org/10.1080/08927014.2002.9522744

Zhao, C., Sander, H. A., & Hendrix, S. D. (2019). Wild bees and urban agriculture: Assessing pollinator supply and demand across urban landscapes. *Urban Ecosystems*, *22*(3), 455–470. https://doi.org/10.1007/s11252-019-0826-6