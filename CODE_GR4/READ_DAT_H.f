! Data reading subroutine
! Aim: Read the input meteo and flow data for hourly modelling
! Author: Leonard Santos (leonard.santos@irstea.fr)
! Date: 2017/09/28

      Subroutine READ_DAT_H
      
      Use MODULE_GR4
      
      Implicit none
      
** ! Variables declaration 
      Integer ll,Y,M,D,H,ero
     
      Logical QUI

      Double Precision Flo,Pre,Eva
      Double Precision SumFlo,CountFlo
     
      Character*24 DIR_FILE
**

** ! Data array allocation
      allocate(Year(Ndata_Hour))
      allocate(Month(Ndata_Hour))
      allocate(Day(Ndata_Hour))
      allocate(Hour(Ndata_Hour))
      
      allocate(Precip(Ndata_Hour))
      allocate(Pot_Ev(Ndata_Hour))
      allocate(Obs_Fl(Ndata_Hour))
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
**

** ! Data reading
      do ll=1,Ndata_Hour
        read(1,"(I4,3I2,10X,F8.4,1X,F8.4,10X,F8.4)",iostat=ero) Y,M,D,H,
     &Flo,Pre,Eva        
        
        if (ero.eq.-1) exit  ! exit the loop when end of file is reached
        
        Year(ll)=Y
        Month(ll)=M
        Day(ll)=D
        Hour(ll)=H
        !!
        Precip(ll)=Pre
        Pot_Ev(ll)=Eva
        Obs_Fl(ll)=Flo

      enddo
**

** ! Calculation of mean flow
      ! Sum of the observed flow w/o gaps (equal to -9.9 in the file)
      SumFlo=sum(Obs_Fl,mask=Obs_Fl.ge.0.)
      ! Count of the observed flow w/o gaps (equal to -9.9 in the file)
      CountFlo=count(Obs_Fl.ge.0.)
      ! Mean calculation
      Utils(2)=SumFlo/CountFlo
**

      end subroutine READ_DAT_H
