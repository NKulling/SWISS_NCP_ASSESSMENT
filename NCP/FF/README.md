## FF- Landscape suitability for agriculture

Mapping of food and feed supply was done using a method similar than that of Briner et al., (2012). We selected a list of the most cultivated crops in Switzerland (table 1)  based on data from Agristat, by the Swiss Farmers Union (USP, 2021). We used the ECOCROP database (FAO, 2007) to extract species-specific optimal growing conditions (monthly precipitations and temperature, soil pH), and we fit a crop yield curve for each selected species. We modeled optimal growing conditions maps for each species using the “Recocrop” package on R (Hijmans, 2021). The obtained maps represent climatic and edaphic suitability for the selected crops, and are aggregated by averaging the value of all maps. They are then masked to be applied only to food and feed production land-use classes (table 2). 

R script used to generate the ES map is available in this repository. It required heavy computing capacities and was run in HPC environment using provided shell script. 

 

**Table 1** Selected crop species

|                     |
| ------------------- |
| *Brassica napus*    |
| *Beta vulgaris*     |
| *Hordeum vulgare*   |
| *Zea mays*          |
| *Solanum tuberosum* |
| *Triticum aestivum* |
| *Secale cereale*    |
| *Avena sativa*      |
| *Nicotiana tabacum* |
| *Triticum spelta*   |
| *Helianthus annuus* |
| *Glycine max*       |
| *Pisum sativum*     |
| *Vicia faba*        |

 

**Table 2** Selected food and feed production land use classes

| **Land use classes** | Name                             |
| -------------------- | -------------------------------- |
| 37                   | Intensive orchards               |
| 38                   | Field fruit trees                |
| 39                   | Vineyards                        |
| 40                   | Horticulture                     |
| 41                   | Arable land                      |
| 42                   | Meadows                          |
| 43                   | Farm pastures                    |
| 44                   | Brush meadows and farm  pastures |
| 45                   | Alpine meadows                   |
| 46                   | Favorable alpine pastures        |
| 47                   | Brush alpine pastures            |
| 48                   | Rocky alpine pastures            |

-----



Briner, S., Elkin, C., Huber, R., & Grêt-Regamey, A. (2012). Assessing the impacts of economic and climate changes on land-use in mountain regions: A spatial dynamic modeling approach. *Agriculture, Ecosystems & Environment*, *149*, 50–63. https://doi.org/10.1016/j.agee.2011.12.011

FAO. (2007). *Ecocrop: The Crop Environmental Requirements Database, the Crop Environmental Response Database.* Food and Agriculture Organization of the UN, Rome.

Hijmans, R. J. (2021). *Recocrop: Estimating Environmental Suitability for Plants. R package version 0.4-0.* https://github.com/cropmodels/Recocrop/

USP. (2021). *Archive Statistiques et évaluations*. Union Suisse des Paysans. https://www.sbv-usp.ch/fr/service/agristat/statistiques-et-evaluations-seaa/archive-statistiques-et-evaluations/