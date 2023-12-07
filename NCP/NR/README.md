## NR - nutrient retention by landscape

One main factor affecting water quality is the amount of nutrient being washed off to the river stream. Higher nutrient loads due to runoff or excess fertilization of nearby lands can cause eutrophication of the river ecosystem. We used the InVEST nutrient delivery ratio Python module (Sharp et al., 2020) to assess the environment filtration capability of nitrogen annually. We used information from Jaligot et al. (2019) for land-use biophysical table  as well as model parametrization (table 1).  Biophysical table is available in this repository. 

**Table 1**Nutrient retention model parameters

| Parameter                                           | Value |
| --------------------------------------------------- | ----- |
| Borselli K                                          | 2     |
| Subsurface Critical Length (nitrogen)               | 100   |
| Subsurface Maximum Retention Efficiency  (nitrogen) | 0.75  |
| Threshold Flow Accumulation                         | 200   |

----

Jaligot, R., Chenal, J., & Bosch, M. (2019). Assessing spatial temporal patterns of ecosystem services in Switzerland. *Landscape Ecology*, *34*(6), 1379–1394. https://doi.org/10.1007/s10980-019-00850-7

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.