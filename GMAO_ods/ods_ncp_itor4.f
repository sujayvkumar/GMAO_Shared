
*...................................................................


      subroutine ODS_NCP_ItoR4 ( ncid,  varid,
     .                           start, count,
     .                           nval,  values, ierr )

      implicit NONE

!-------------------------------------------------------------------------
!         NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-------------------------------------------------------------------------
!
! !ROUTINE:  ODS_NCP_ItoR4
! 
! !DESCRIPTION: 
!     This routine converts native integers to four byte real
!     numbers and calls the NetCDF routine, NCVPT, to write the
!     four byte real numbers to an ODS/HDF file.  This routine
!     insures that the data are correctly passed into the NetCDF
!     routine, irrespective of the machine on which the software
!     is running. 
!
! !INTERFACE:  ODS_NCP_ItoR4 ( ncid,  varid,
!                                     start, count,
!                                     nval,  values, ierr )
!
! !INPUT PARAMETERS: 
      integer            ncid         ! NetCDF file id
      integer            varid        ! NetCDF variable id
      integer            start  ( * ) ! NetCDF file indicies specifying the
                                      !   location of the corner of the
                                      !   hyperslab where the first of the
                                      !   data values will be written.  A
                                      !   hyperslab is a space within
                                      !   ODS/HDF file where the data are
                                      !   to be written.
      integer            count  ( * ) ! The edge lengths of the NetCDF
                                      !   file hyperslab.
      integer            nval         ! Number of values to be written
      integer            values ( * ) ! Values to be written
!
! !OUTPUT PARAMETER:
      integer            ierr         ! Return error code
!
! !LIBRARIES ACCESSED:
!     NetCDF
!
! !FILES USED:
!     netcdf.inc, a header file, for defining NetCDF library 
!            parameters
!     ods_stdio.h, a header file, for defining standard input/output
!            unit numbers
!     ods_worksp.h, a header file, for defining hardwired constants
!            and defining global variables and setting up data
!            structures for work space
!
! !SEE ALSO:
!     ODS_NCG_R4toI  ( The inverse companion of this routine )
!
! !REVISION HISTORY: !
!     02Apr96    C. Redder   Origional code
!
!-------------------------------------------------------------------------

      include 'netcdf.inc'
      include 'ods_stdio.h'
      include 'ods_worksp.h'

*     Other variables
*     ---------------
      real         val     ! Temporary storage
      integer     ival     ! Index variable for do loop

*     Default value for error code
*     ----------------------------
      ierr    = NCNoErr

*     Check to determine if the values are within the range
*     of NetCDF data type
*     -----------------------------------------------------
      do 10, ival = 1, nval
         val      = real ( values ( ival ) )
         if ( val  .lt. R4_Min .or.
     .        val  .gt. R4_Max ) ierr = NCSysErr
 10   continue

*     If a value is out of range then return with an error message
*     ------------------------------------------------------------
      if ( ierr .ne. NCNoErr  ) then
         write ( stderr, 901) 'NCFloat'
         return
      end if

*     Convert to four-byte real numbers and store into work space
*     -----------------------------------------------------------
      do 20, ival = 1, nval
         R4_Val ( ival ) = real ( values ( ival ) )
 20   continue

*     Use NetCDF routine to write the values to file
*     ----------------------------------------------
      call NCVPT ( ncid,   varid, 
     .             start,  count,
     .             R4_Val, ierr )
      if ( ierr .ne. NCNoErr ) return

      return
*     ------

 901  format ( /, ' ODS_NCP_ItoR4: Value to be written as the ',
     .         /, '                NetCDF variable type, ', a,
     .         /, '                is out of range. ' )

      end
