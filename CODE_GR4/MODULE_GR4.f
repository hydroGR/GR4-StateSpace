! Module for the whole program
! Aim: declaring the  variables that are common between the subroutines
! Author: Leonard Santos, Irstea-HBAN, France (leonard.santos@irstea.fr) 
! Date: 2017/09/28

      Module MODULE_GR4

* ! Modelling time-step information
      Character*1 Tstep
     
  ! Tstep="H" for hourly time-step
  ! Tstep="D" for daily time-step
*
           
* ! Number of data values at the different time-steps (total number and warm-up)
      Integer Ndata_Hour,Ndata_Day,Nwup_Hour,Nwup_Day
      Parameter(Ndata_Hour=43848,Ndata_Day=1827)
      Parameter(Nwup_Hour=8784,Nwup_Day=366)

  ! Ndata_Hour: Total number of time-steps for hourly modelling
  ! Ndata_Day: Total number of time-steps for daily modelling
  ! Nwup_Hour: Warm-up number of time-steps for hourly modelling
  ! Nwup_Day: Warm-up number of time-steps for daily modelling
*

* ! Number of stores of the Nash cascade
      Integer nres
      Parameter(nres=11)
*

* ! Parameters and state vectors of the model
      Double precision Param(4),State(nres+2)
     
  ! Param(1): x1 ! Max capacity of the production store [mm]
  ! Param(2): x2 ! Inter-catchment exchange coefficient [mm/t]
  ! Param(3): x3 ! Max capacity of the routing store [mm]
  ! Param(4): x4 ! Base time of the unit hydrograph [t]
  
  ! State(1):          S ! Production store level [mm]
  ! State(2:nres+1): Sh ! Nash cascade stores levels [mm]
  ! State(nres+2):    R ! Routing store level [mm]
*

* ! Input data
      Integer, dimension(:), allocatable :: Year,Month,Day,Hour
      Double precision, dimension(:), allocatable :: Precip,Pot_Ev
      Double precision, dimension(:), allocatable :: Obs_Fl

  ! Year(:): year at each time-step
  ! Month(:): month number at each time-step
  ! Day(:): day number at each time-step
  ! Hour(:): hour at each time-step
  
  ! Precip(:): Rainfall amount at each time-step [mm]
  ! Pot_Ev(:): Potential evapotranspiration at each time-step [mm]
  
  ! Obs_Fl(:): Observed flow at each time-step [mm]
*

* ! Output data
      Double precision MISC(19)
      Double precision, dimension(:,:), allocatable :: MISCO
     
  ! MISC( 1): PE     ! potential evapotranspiration [mm/t]
  ! MISC( 2): Precip ! total precipitation [mm/t]
  ! MISC( 3): Prod   ! production store level [mm]
  ! MISC( 4): RatPro ! production store ratio level [-]
  ! MISC( 5): ETR    ! actual evapotranspiration [mm/t]
  ! MISC( 6): Perc   ! percolation from production store [mm/t]
  ! MISC( 7): PS     ! rain in production store [mm/t]
  ! MISC( 8): PR     ! precipitation inflow of the Nash cascade [mm/t]
  ! MISC( 9): Q9     ! inflow in the main routing branche [mm/t]
  ! MISC(10): Q1     ! inflow in the secondary routing branche [mm/t]
  ! MISC(11): Rout   ! routing store level [mm]
  ! MISC(12): RatRou ! routing store level ratio [-]
  ! MISC(13): Exch   ! potential semi-exchange between catchments [mm/t]
  ! MISC(14): AExch  ! actual total exchange between catchments [mm/t]
  ! MISC(15): QR     ! outflow from routing store [mm/t]
  ! MISC(16): QD     ! outflow from secondary branch after exchange [mm/t]
  ! MISC(17): Qsim   ! outflow at catchment outlet [mm/t]
  ! MISC(18)
  ! MISC(19): Casc   ! Nash cascade stores levels [mm]
  
  ! MISCO(:,k): MISC variable number k at each time-step
*

* ! Catchment informations
      Double precision Utils(2)

  ! Utils(1): Catchment area [km2]
  ! Utils(2): Men observed flow [mm]
*

* ! Performances array
      Double precision Perf(10)
*

      end module MODULE_GR4
