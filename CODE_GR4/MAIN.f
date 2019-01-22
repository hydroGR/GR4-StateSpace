! Fortran program to run the state-space GR4 on example data
! Aim: testing the state-space GR4 at the hourly and daily time-steps
! Author: Leonard Santos, Irstea-HBAN, France (leonard.santos@irstea.fr) 
! Date: 2017/09/28

      Program MAIN
      
      Use MODULE_GR4
      
      Implicit none
      
** ! Variables declaration

      Integer i,ll
      
      Character*3 Crit(2)
      Character*2 Trans(5)

**

** ! Information display
      Write(*,'(''     __________________________________________ '')')
      Write(*,'(''    [                                          ]'')')
      Write(*,'(''    [        Welcome to GR4 state space        ]'')')
      Write(*,'(''    [           (September.  2017)             ]'')')
      Write(*,'(''    [            Irstea, UR HBAN               ]'')')
      Write(*,'(''    [__________________________________________]'')')
      Write(*,'(''                                                '')')
**

** ! Display prompts
      Write(*,"(""**********  Time-step choice   **********"")")
      Write(*,*) "Hourly or Daily ? (H/D)"
      Read(*,"(A1)") Tstep
**

** ! Read the data

**   ! Choice of reading data subroutine, depending on time step
      if (Tstep.eq."H") then
        call READ_DAT_H
      else
        call READ_DAT_D
      endif
**

**

** ! Choice of the parameter values
** ! Please note that they are fixed after an automatic calibration that is not included in this code 

      Param(1)=520.01   ! x1 ! Max capacity of the production store [mm]
      Param(2)=-3.526   ! x2 ! Inter-catchment exchange coefficient [mm/t]
      Param(3)=78.75    ! x3 ! Max capacity of the routing store [mm]
      Param(4)=0.157    ! x4 ! Base time of the unit hydrograph [t]

**
      
** ! Launch the model
      call MOD_LAUNCH
**

** ! Calculate performances

**    ! Transformation names
      Trans(1)="QI"    ! Transitional flows: square root transformation
      Trans(2)="HQ"    ! High flows: no transformation
      Trans(3)="LQ"    ! Low flows: logarithmic transformation
      Trans(4)="IQ"    ! Low flows: inverted transformation
      Trans(5)="PQ"    ! Peak flows: square transformation
**

**   ! Criterion names
      Crit(1)="KGE"     ! Kling and Gupta Efficiency calculated by the formulation of Kling et al., 2012 (KGE')
      Crit(2)="NSE"     ! Nash and Sutcliffe Efficiency calculated by the formulation of Nash and Sutcliffe, 1970 (NSE)
**

**   ! Performances array initialization
       ! Perf( 1) :  SqrKGE ! KGE' value using square root of flows (promotes intermediate flows)
       ! Perf( 2) :     KGE ! KGE' value using non-transformed flows (promotes high flows flows)
       ! Perf( 3) :  LogKGE ! KGE' value using logaritmic transformation of flows (promotes low flows)
       ! Perf( 4) :  InvKGE ! KGE' value using inverse of flows (promotes low flows)
       ! Perf( 5) :  SqaKGE ! KGE' value using square of flows (promotes peak flows)
       ! Perf( 6) :  SqrNSE ! NSE value using square root of flows (promotes intermediate flows)
       ! Perf( 7) :     NSE ! NSE value using non-transformed flows (promotes high flows flows)
       ! Perf( 8) :  LogNSE ! NSE value using logaritmic transformation of flows (promotes low flows)
       ! Perf( 9) :  InvNSE ! NSE value using inverse of flows (promotes low flows)
       ! Perf(10) :  SqaNSE ! NSE value using square of flows (promotes peak flows)
      Perf=-99.
**
      
** ! Loop to fill the perf array
      
      do ll=1,2    ! Criteria
        do i=1,5   ! Transformations
          call CRIT_CALC(MISCO(:,17),Obs_Fl,Trans(i),Crit(ll),Perf((ll-1
     &)*5+i))
        enddo
      enddo

**
      
** ! Output files writing
      if (Tstep.eq."H") then
        call FILE_WRIT_H
      else
        call FILE_WRIT_D
      endif
**

** ! Data array deallocation
      deallocate(Year)
      deallocate(Month)
      deallocate(Day)
      deallocate(Hour)
      
      deallocate(Precip)
      deallocate(Pot_Ev)
      deallocate(Obs_Fl)
      
      deallocate(MISCO)
**

      end program MAIN
