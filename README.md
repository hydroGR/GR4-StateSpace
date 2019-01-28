# GR4-State-space (version 1.0)

This repository presents the code to use to run the state-space version of GR4 (version 1.0). 

GR4J is a lumped rainfall-runoff model developed in the Catchment Hydrology Group of Irstea in Antony (see Perrin et al., 2003 and our website https://webgr.irstea.fr/journalier-gr4j-2/). An hourly version, GR4H, also exists (see our open source airGR R package for both models: https://cran.r-project.org/package=airGR). 

The state-space version of GR4 is a result of the PhD thesis of Léonard Santos (Santos et al., 2018). Usually, the differential equations of the lumped bucket rainfall-runoff models (e.g. HBV, TOPMODEL...) are not explicitly formulated and are solved sequentially by splitting the equations into terms that can be solved analytically with a technique called "operator splitting" (as a result, only the solutions of the split equations are used to present the different models). In the state-space GR4 model, the differential equations are explicit and are solved continuously and the operator splitting is removed. The state-space GR4 model can be applied at the daily and hourly time steps. 

Please note that compared to the GR4J and GR4H models, the unit hydrographs (lag functions) were replaced with a Nash cascade. The equations were solved with a robust numerical integration technique. This version of GR4 ensures a better similarity between applications at different time steps and does not deteriorate results. For more information, see paper in Geoscientific Model Development (Santos et al., 2018). 



References

Perrin, C., Michel, C. and Andréassian, V., 2003. Improvement of a parsimonious model for streamflow simulation. Journal of Hydrology, 279 : 275-289, https://doi.org/10.1016/S0022-1694(03)00225-7.

Santos, L., Thirel, G., and Perrin, C., 2018. Continuous state-space representation of a bucket-type rainfall-runoff model: a case study with the GR4 model using state-space GR4 (version 1.0), Geosci. Model Dev., 11, 1591-1605, https://doi.org/10.5194/gmd-11-1591-2018. 

Run the state-space version of GR4 (version 1.0)

For more information, see paper in Geoscientific Model Development

Santos, L., Thirel, G., and Perrin, C.: Continuous state-space representation of a bucket-type rainfall-runoff model: a case study with the GR4 model using state-space GR4 (version 1.0), Geosci. Model Dev., 11, 1591-1605, https://doi.org/10.5194/gmd-11-1591-2018, 2018. 

