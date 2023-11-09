## CAR- Carbon stored in biomass

Regulation of climate by nature is considered here by the amount of elemental carbon stored in vegetation and soil. We used the InVEST carbon python module (Sharp et al., 2020), which attributes a value of elemental carbon stored in each raster cell based on a land use map and a correspondence table. The land use map was aggregated to fit carbon storage values following the scheme provided by the FOEN, going from base 72 categories to 18 “combination categories” (table 6-6, FOEN, 2020b). The values of carbon stored are based on the Swiss Greenhouse Gas Inventory of the period 1990-2018 (table 6-4, FOEN, 2020b). The Swiss territory was divided by production region (FOEN, 2020a) and elevation regions (<601m, 601-1200m, >1200m) for a better accuracy of corresponding carbon values. One biophysical table was generated per altitude strata and production region (15 total), all biophysical tables are available in this repository

-----

FOEN. (2020a). *Production regions NFI*. Federal Office for the Environment. https://opendata.swiss/en/dataset/produktionsregionen-lfi

FOEN. (2020b). *Switzerland’s Greenhouse Gas Inventory 1990–2018*. Federal Office for the Environment. https://www.bafu.admin.ch/bafu/en/home/topics/climate/state/data/climate-reporting/latest-ghg-inventory.html

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.