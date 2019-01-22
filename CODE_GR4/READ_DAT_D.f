! Data reading subroutine
! Aim: Reading the input meteo and flow data for daily modelling
! Author: Leonard Santos, Irstea-HBAN, France (leonard.santos@irstea.fr)
! Date: 2017/09/28

      Subroutine READ_DAT_D
      
      Use MODULE_GR4
      
      Implicit none
      
** ! Variables declaration 
      Integer ll,Y,M,D,H,ero,counter
     
      Logical QUI

      Double Precision Flo,Pre,Eva
      Double Precision SumFlo,SumPre,SumEva,CountFlo
     
      Character*24 DIR_FILE
**

** ! Data array allocation
      allocate(Year(Ndata_Day))
      allocate(Month(Ndata_Day))
      allocate(Day(Ndata_Day))
      allocate(Hour(Ndata_Day))
      
      allocate(Precip(Ndata_Day))
      allocate(Pot_Ev(Ndata_Day))
      allocate(Obs_Fl(Ndata_Day))
**
      
** ! Open file
      DIR_FILE="../DATA_GR4/L0123003.txt"
      
      ! Verification
      inquire(file=DIR_FILE,exist=QUI)
      If(.not.QUI) then
        Stop "Wrong directory for data file"
      Endif
      !
      
      open(1,file=trim(DIR_FILE),status="old")
**
      
** ! Skip description and read catchment area
      do ll=1,3
        read(1,*)
      enddo
      
      read(1,"(15X,F3.0)") Utils(1)
      
      do ll=1,3
        read(1,*)
      enddo
**

** ! Data array intialization
      Year(:)=-9.99
      Month(:)=-9.99
      Day(:)=-9.99
      Hour(:)=-9.99
      !!
      Precip(:)=-9.99
      Pot_Ev(:)=-9.99
      Obs_Fl(:)=-9.99
   ! Sums initialization
      SumPre=0.
      SumEva=0.
      SumFlo=0.
**
      
** ! Data reading
      counter=1   ! Initialization of a counter of daily time steps

      do ll=1,Ndata_Hour
        read(1,"(I4,3I2,10X,F8.4,1X,F8.4,10X,F8.4)",iostat=ero) Y,M,D,H,
     &Flo,Pre,Eva        
        
        if (ero.eq.-1) exit  ! exit the loop when end of file is reached
        
        !! Calculation of daily variable by summing hourly observations (in mm)
        SumPre=SumPre+Pre
        SumFlo=SumFlo+Flo
        SumEva=SumEva+Eva
        
        !! Recording of data after the last hour of the day
        if (H.eq.23) then
          Year(counter)=Y
          Month(counter)=M
          Day(counter)=D
          !!
          Precip(counter)=SumPre
          Pot_Ev(counter)=SumEva
          Obs_Fl(counter)=SumFlo
          
          !!reinitialization of the sums
          SumPre=0.
          SumEva=0.
          SumFlo=0.
          
          !! update the counter
          counter=counter+1
        endif

      enddo
**

      close(1) ! close the file

** ! Calculation of mean flow
      ! Sum of the observed flow w/o gaps (equal to -9.9 in the file)
      SumFlo=sum(Obs_Fl,mask=Obs_Fl.ge.0.)
      ! Count of the observed flow w/o gaps (equal to -9.9 in the file)
      CountFlo=count(Obs_Fl.ge.0.)
      ! Mean calculation
      Utils(2)=SumFlo/CountFlo
**

      end subroutine READ_DAT_D
