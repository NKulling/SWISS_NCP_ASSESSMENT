## SR - sediment retention by landscape

The protection of soils in Switzerland lies for a part on its preservation from erosion. Erosion is deleterious to soil fertility for agriculture, to the stability of terrains and can lead to pollution of river streams. It is mainly due to precipitations and wind, but is highly influenced by land use modifications which can increase erosion (e.g. by removing stabilizing elements such as forests, or by building artificial surfaces which increase water runoff). We use InVEST sediment delivery ratio Python module (Sharp et al., 2020) to estimate the yearly amount of sediment that is retained by each pixel in the Swiss landscape. Values of model parameters (table 1) and the biophysical table (available in this repository) are based on the study by Jaligot et al. (2019). 

 

**Table 1** Sediment retention model parameters

| Parameter                    | Value |
| ---------------------------- | ----- |
| Borselli K                   | 2     |
| Borselli IC0                 | 0.4   |
| Maximum SDR Value            | 0.75  |
| Maximum L Value              | 100   |
| Threshold Flow  Accumulation | 200   |

------

Jaligot, R., Chenal, J., & Bosch, M. (2019). Assessing spatial temporal patterns of ecosystem services in Switzerland. *Landscape Ecology*, *34*(6), 1379–1394. https://doi.org/10.1007/s10980-019-00850-7

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.