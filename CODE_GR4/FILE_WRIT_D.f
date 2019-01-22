! File writing subroutine
! Aim: writing the output file of the daily State-Space model containing all internal fluxes
! Author: Leonard Santos, Irstea-HBAN, France (leonard.santos@irstea.fr)
! Date: 2017/09/28

      Subroutine FILE_WRIT_D
      
      Use MODULE_GR4
      
      Implicit none
      
** ! Variables declaration
      
      Character*40 NAM_FILE,PERF_FILE
      Character*8 CODE
      
      Integer ll,i

**

** ! Output file
      NAM_FILE="../OUTPUT_GR4/L0123003_GR4out_Day.txt" ! name of the file
      
      open(1,file=trim(NAM_FILE),status="unknown")

    2 format("    DATE;        Qcalc;         Qobs;     Pot Evap;       
     &  Rain;            S;         S/X1;          ETR;         Perc;   
     &        Ps;           Pr;           Q9;           Q1;            R
     &;         R/X3;         Exch;        AExch;           QR;       
     &  QD;         Sna1;         Snan")
     
      ! Header format
        !     DATE ! date with format YYYYMMDD
        !    Qcalc ! simulated flow [mm/d]
        !     Qobs ! observed flow [mm/d]
        ! Pot Evap ! potential evapotranspiration [mm/d]
        !     Rain ! total precipitation [mm/d]
        !        S ! production store level [mm]
        !     S/X1 ! production store ratio level [-]
        !      ETR ! actual evapotranspiration [mm/d]
        !     Perc ! percolation from production store [mm/d]
        !       Ps ! rain in production store [mm/d]
        !       Pr ! precipitation inflow of the Nash cascade [mm/d]
        !       Q9 ! inflow in the main routing branche [mm/d]
        !       Q1 ! inflow in the secondary routing branche [mm/d]
        !        R ! routing store level [mm]
        !     R/X3 ! routing store level ratio [-]
        !     Exch ! potential semi-exchange between catchments [mm/d]
        !    AExch ! actual total exchange between catchments [mm/d]
        !       QR ! outflow from routing store [mm/d]
        !       QD ! outflow from secondary branch after exchange [mm/d]
        !     Sna1 ! first Nash cascade store level [mm]
        !     Snan ! last Nash cascade store level [mm]
     
    3 format(I4,2(I2.2),20(A1,F13.3))  ! format to write the data in the file
    
      write(1,2)  ! write the file header
      
** ! Loop on all simulation days (w/o warm-up)
      do ll=(Nwup_Day+1),Ndata_Day
      
        ! write all the internal variables at each time-step
        write(1,3) Year(ll),Month(ll),Day(ll),";",MISCO(ll,17),";",Obs_F
     &l(ll),(';',MISCO(ll,i),i=1,16),(';',MISCO(ll,i),i=18,19)
      
      enddo
**

      close(1) ! close the output file
**

      
** ! Performances file

      PERF_FILE="../OUTPUT_GR4/L0123003_perf_Day.txt" ! name of the file
      
      CODE="L0123003"  ! catchment code
      
      open(4,file=trim(PERF_FILE),status="unknown")
      
    5 format("   CATCH;    SqrKGE;       KGE;    LogKGE;    InvKGE;    S
     &qaKGE;    SqrNSE;       NSE;    LogNSE;    InvNSE;    SqaNSE")
     
      ! Header format
      ! KGE' calculated by the formulation of Kling et al., 2012
      ! NSE calculated by the fomrmulation of Nash and Sutcliffe, 1970
      ! transformations used in Pushpalatha et al., 2012
        !    CATCH ! catchment code
        !   SqrKGE ! KGE' value using square root of flow (promote intermediate flows)
        !      KGE ! KGE' value using non-transformed flow (promote high flows flows)
        !   LogKGE ! KGE' value using logaritmic transformation of flow (promote low flows)
        !   InvKGE ! KGE' value using inverse of flow (promote low flows)
        !   SqaKGE ! KGE' value using square of flow (promote peak flows)
        !   SqrNSE ! NSE value using square root of flow (promote intermediate flows)
        !      NSE ! NSE value using non-transformed flow (promote high flows flows)
        !   LogNSE ! NSE value using logaritmic transformation of flow (promote low flows)
        !   InvNSE ! NSE value using inverse of flow (promote low flows)
        !   SqaNSE ! NSE value using square of flow (promote peak flows)
    
    6 format(A8,10(A1,F10.3))  ! format to write the data in the file
      
      write(4,5)  ! write the file header
      
      write(4,6) CODE,(";",Perf(i),i=1,10)  ! filling of the file
      
      close(4)  ! close performance file
      
**

      end subroutine FILE_WRIT_D
