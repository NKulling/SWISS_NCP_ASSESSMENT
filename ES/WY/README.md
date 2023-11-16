## WY - annual water yield

Water quantity regulation is fundamental for human welfare. Indeed, sufficient water is needed for household consumption, agricultural irrigation, industry, and hydropower production. Instead, excessive water flow in river networks modifies the river ecosystem and can induce floods. To model this ES, we calculated the relative contribution of each pixel to the water yield of the watershed this pixel is on. This was done using InVEST water yield Python module (Sharp et al., 2020). The model was calibrated using data at the watershed level from official hydrological surveys (Schädler & Weingartner, 2002), for the selection of 287 available watersheds (figure 1), by modifying the Kc parameter (crop coefficient) in the biophysical table (biophysical table is available in this repository). The calibration was done using land-use and climatic data from the 1992-1997 period to fit with the hydrological survey. The final model used in the analysis was done with the calibrated parameters but with current period data. The Z parameter was set at 25, computed as the mean Z-score based on MeteoSwiss climate normals of days with precipitations, for the available weather stations  (MeteoSwiss, 2020). 

<img src="https://github.com/NKulling/SWISS_ES_ASSESSMENT/blob/main/ES/WY/A1_wy.jpg" width="600">

**Figure 1** Comparison between calibrated InVEST output (water yield and precipitation output) and official hydrological survey on 287 watersheds across Switzerland. 

----

MeteoSwiss. (2020). *Normal values per measured parameter. Climate normals 1981-2010: Days with precipitation (>=1mm)*. https://www.meteoswiss.admin.ch/services-and-publications/applications/ext/climate-normtables.html

Schädler, B., & Weingartner, R. (2002). *Components of the Natural Water Balance 1961-1990*. https://hydrologicalatlas.ch/products/printed-issue/water-balance/table6-3-1

Sharp, R., Douglass, J., Wolny, S., Arkema, K., Bernhardt, J., Bierbower, W., Chaumont, N., Denu, D., Fisher, D., Glowinski, K., Griffin, R., Guannel, G., Guerry, A., Johnson, J., Hamel, P., Kennedy, C., Kim, C. K., Lacayo, M., Lonsdorf, E., … Wyatt, K. (2020). *InVEST 3.9.2.post16+ug.g64072c4 User’s Guide*. The Natural Capital Project, Stanford University, University of Minnesota, The Nature Conservancy, and World Wildlife Fund.