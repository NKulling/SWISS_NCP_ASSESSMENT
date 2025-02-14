## BD - Species distribution models

 

We constructed species distribution models (SDMs) for 1482 terrestrial species that have been identified as threatened and classified in the red list by the Swiss government. The complete list of selected red list species is available in this repo, and consists mainly of vascular plants, arthropods, fungi, and bird species (figure 1). SDMs were built using the N-SDM software (Adde et al., 2023). A complete list of all species modeled for this study is also avaialable in this repository. 

<img src="https://github.com/NKulling/SWISS_NCP_ASSESSMENT/blob/main/BD/fig/barplot_sp_redlist.jpg" width="600">

**Figure 1** Barplot showing the number of individual species modeled per taxonomic group. 

Model accuracy was assessed through a split-sample approach repeated 100 times, with 30% of the data reserved for validation. The best combination of hyperparameters for each model was determined based on the average score derived from three evaluation metrics: the Area Under the Curve (AUC') or Somers' D, the maximized True Skill Statistic (maxTSS) , and the Continuous Boyce Index (CBI) . The results obtained from the five modelling algorithms were mapped onto a 25-meter resolution grid covering Switzerland. These maps were then ensembled by averaging the predictions from the five models. Detailed results from the evaluation are displayed in figure 2. 

<img src="https://github.com/NKulling/SWISS_NCP_ASSESSMENT/blob/main/BD/fig/metrics_per_ncp.png" width="600">

**Figure 2** Boxplots and violin plots for the four groups of modelled species and the three evaluation metrics, along with the consensus evaluation score. **PC:** Pest control species; **ID:** Emblematic species; **MED:** Medicinal plants; **BD:** Red list species prioritization. 

Covariates used to model the distribution of each species were selected using the “covsel” embedded covariate selection procedure (Adde et al., 2023) included in N-SDM, which drew the best subset of variables per species from the “SWECO25” database (v.1.0) comprising an extensive set of environmental layers for Switzerland (Külling, Adde, et al., 2024). The detailed list of variables selected per species, along with the variable importance in the model, is available in this repo. 

ODMAP protocol (Zurell et al., 2020) as well as settings used in N-SDM in this study are available in this repository.

----

Adde, A., Rey, P.-L., Brun, P., Külling, N., Fopp, F., Altermatt, F., Broennimann, O., Lehmann, A., Petitpierre, B., Zimmermann, N. E., Pellissier, L., & Guisan, A. (2023). N-SDM: A high-performance computing pipeline for Nested Species Distribution Modelling. *Ecography*, *2023*(6), e06540. https://doi.org/10.1111/ecog.06540

Adde, A., Rey, P.-L., Fopp, F., Petitpierre, B., Schweiger, A. K., Broennimann, O., Lehmann, A., Zimmermann, N. E., Altermatt, F., Pellissier, L., & Guisan, A. (2023). Too many candidates: Embedded covariate selection procedure for species distribution modelling with the covsel R package. *Ecological Informatics*, *75*, 102080. https://doi.org/10.1016/j.ecoinf.2023.102080

Külling, N., Adde, A., Fopp, F., Schweiger, A. K., Broennimann, O., Rey, P.-L., Giuliani, G., Goicolea, T., Petitpierre, B., Zimmermann, N. E., Pellissier, L., Altermatt, F., Lehmann, A., & Guisan, A. (2024). SWECO25: A cross-thematic raster database for ecological research in Switzerland. Scientific Data, 11(1), Article 1. https://doi.org/10.1038/s41597-023-02899-1

Zurell, D., Franklin, J., König, C., Bouchet, P. J., Dormann, C. F., Elith, J., Fandos, G., Feng, X., Guillera-Arroita, G., Guisan, A., Lahoz-Monfort, J. J., Leitão, P. J., Park, D. S., Peterson, A. T., Rapacciuolo, G., Schmatz, D. R., Schröder, B., Serra-Diaz, J. M., Thuiller, W., … Merow, C. (2020). A standard protocol for reporting species distribution models. *Ecography*, *43*(9), 1261–1277. https://doi.org/10.1111/ecog.04960
