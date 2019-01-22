! Model launch subroutine
! Aim: Temporal loop to launch the model at each time-step and get output data
! Author: Leonard Santos, Irstea-HBAN, France (leonard.santos@irstea.fr)
! Date: 2017/09/28

      Subroutine MOD_LAUNCH
      
      Use MODULE_GR4
      
      Implicit none
      
** ! Variables declaration
      Integer ll,ll_tot
      
      Double precision Rain,Evap
**

** ! Choice of the total number of time-steps
   ! and allocate output array
      if (Tstep.eq."H") then
        ll_tot=Ndata_Hour
        allocate(MISCO(Ndata_Hour,19))
      else
        ll_tot=Ndata_Day
        allocate(MISCO(Ndata_Day,19))
      endif
**

** ! Time loop
      do ll=1,ll_tot
        ! Extract input data
        Rain=Precip(ll)
        Evap=Pot_Ev(ll)
        
        ! Launch the model
        Call GR4_STSP(Evap,Rain)
        
        ! Get output data
        MISCO(ll,:)=MISC(:)
      enddo
**

      end subroutine MOD_LAUNCH