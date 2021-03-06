      subroutine tick (nymd,nhms,ndt)
C***********************************************************************
C  Purpose
C     Tick the Date (nymd) and Time (nhms) by NDT (seconds)
C
C***********************************************************************
C*                  GODDARD LABORATORY FOR ATMOSPHERES                 *
C***********************************************************************

      IF(NDT.NE.0) THEN
      NSEC = NSECF(NHMS) + NDT

      IF (NSEC.GT.86400)  THEN
      DO WHILE (NSEC.GT.86400)
      NSEC = NSEC - 86400
      NYMD = INCYMD (NYMD,1)
      ENDDO
      ENDIF  
              
      IF (NSEC.EQ.86400)  THEN
      NSEC = 0
      NYMD = INCYMD (NYMD,1)
      ENDIF  
              
      IF (NSEC.LT.00000)  THEN
      DO WHILE (NSEC.LT.0)
      NSEC = 86400 + NSEC
      NYMD = INCYMD (NYMD,-1)
      ENDDO
      ENDIF  
              
      NHMS = NHMSF (NSEC)
      ENDIF

      RETURN
      END

      FUNCTION INCYMD (NYMD,M)
C***********************************************************************
C  PURPOSE
C     INCYMD:  NYMD CHANGED BY ONE DAY
C     MODYMD:  NYMD CONVERTED TO JULIAN DATE
C  DESCRIPTION OF PARAMETERS
C     NYMD     CURRENT DATE IN YYMMDD FORMAT
C     M        +/- 1 (DAY ADJUSTMENT)
C
C***********************************************************************
C*                  GODDARD LABORATORY FOR ATMOSPHERES                 *
C***********************************************************************

      INTEGER NDPM(12)
      DATA    NDPM /31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/
      LOGICAL LEAP
      DATA    NY00     / 1900 /
      LEAP(NY) = MOD(NY,4).EQ.0 .AND. (NY.NE.0 .OR. MOD(NY00,400).EQ.0)

C***********************************************************************
C
      NY = NYMD / 10000
      NM = MOD(NYMD,10000) / 100
      ND = MOD(NYMD,100) + M

      IF (ND.EQ.0) THEN
      NM = NM - 1
      IF (NM.EQ.0) THEN
          NM = 12
          NY = NY - 1
      ENDIF
      ND = NDPM(NM)
      IF (NM.EQ.2 .AND. LEAP(NY))  ND = 29
      ENDIF

      IF (ND.EQ.29 .AND. NM.EQ.2 .AND. LEAP(NY))  GO TO 20

      IF (ND.GT.NDPM(NM)) THEN
      ND = 1
      NM = NM + 1
      IF (NM.GT.12) THEN
          NM = 1
          NY = NY + 1
      ENDIF
      ENDIF

   20 CONTINUE
      INCYMD = NY*10000 + NM*100 + ND
      RETURN

C***********************************************************************
C                      E N T R Y    M O D Y M D
C***********************************************************************

      ENTRY MODYMD (NYMD)
      NY = NYMD / 10000
      NM = MOD(NYMD,10000) / 100
      ND = MOD(NYMD,100)

   40 CONTINUE
      IF (NM.LE.1)  GO TO 60
      NM = NM - 1
      ND = ND + NDPM(NM)
      IF (NM.EQ.2 .AND. LEAP(NY))  ND = ND + 1
      GO TO 40

   60 CONTINUE
      MODYMD = ND
      RETURN
      END

      function nhmsf (nsec)
C***********************************************************************
C  Purpose
C     Converts Total Seconds to NHMS format
C
C***********************************************************************
C*                  GODDARD LABORATORY FOR ATMOSPHERES                 *
C***********************************************************************
      implicit none
      integer  nhmsf, nsec
      nhmsf =  nsec/3600*10000 + mod(nsec,3600)/60*100 + mod(nsec,60)
      return
      end

      function nsecf (nhms)
C***********************************************************************
C  Purpose
C     Converts NHMS format to Total Seconds
C
C***********************************************************************
C*                  GODDARD LABORATORY FOR ATMOSPHERES                 *
C***********************************************************************
      implicit none
      integer  nhms, nsecf
      nsecf =  nhms/10000*3600 + mod(nhms,10000)/100*60 + mod(nhms,100)
      return
      end

