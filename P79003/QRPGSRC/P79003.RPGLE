     H DFTACTGRP(*NO) ACTGRP(*NEW)
     FF9G00     IF   E           K DISK
     FP790W2    IF   E           K DISK
     FP79003D   CF   E             WORKSTN
      *
     D pPRDNUM         S             10A
     D pFIXBOX         S              2S 0
     D eITMCOD         S              7A
     D EITMCW2         S              7A
     D ITMCW2          S              7A
     D MESAJ           S             50A
     D MKUTW2          S              6S 0
     D HERKUTU         S              6  2
      *
     D KUTUBOL         S             10S 2
     D KUTUBL          S             50A
      *- -------------------------------------------------------------------------------------------
      *---------------------------------------------------------------------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    pPRDNUM          10
     C                   PARM                    pFIXBOX           2 0
      *
     C                   EXSR      Ini_000
     C                   EXSR      Prc_100
      * hesaplama gonder
     C                   EVAL      pFIXBOX = KUTSAY
      *
     C                   SETON                                        LR
      *---------------------------------------------------------------------------------------------
     C     Ini_000       BEGSR
     C                   EVAL      ePRDNUM = *BLANKS                            //
     C                   EVAL      eITMCOD = *BLANKS                            //
     C                   EVAL      TOPMTR = 0                                   //
     C                   EVAL      KUTMTR = 0                                   //
     C                   EVAL      KUTSAY = 0                                   //
     C                   ENDSR
      *---------------------------------------------------------------------------------------------
     C     Prc_100       BEGSR
      * hesapla
     C                   EXSR      Prc_200
      * goster
     C                   WRITE     HDRLIN
     C                   WRITE     FNCLIN
     C                   WRITE     MSGLIN
     C                   EXFMT     DSP001
     C                   ENDSR
      *---------------------------------------------------------------------------------------------
     C     Prc_200       BEGSR
      *
     C     pPRDNUM       CHAIN     F9G00R                             99
      *
     C                   IF        *IN99 = *OFF
     C                   IF        LN1C9G = '130' AND
     C                             LN2C9G = '20'  OR
     C                             LN2C9G = '25'  OR
     C                             LN2C9G = '26'  OR
     C                             LN2C9G = '30'  OR
     C                             LN2C9G = '31'  OR
     C                             LN2C9G = '32'  OR
     C                             LN2C9G = '33'  OR
     C                             LN2C9G = '35'  OR
     C                             LN2C9G = '40'  OR
     C                             LN2C9G = '45'
     C                   EVAL      ePRDNUM = pPRDNUM
     C*                  EVAL      TOPMTR  = PSHQ9G
     C                   EXSR      ITEMKONTROL
     C                   ENDIF
     C                   EVAL      KUTSAY  = KUTUBOY
     C                   ELSE
     C                   EVAL      MESAJ = 'PR BULUNAMADI'
     C                   ENDIF
      *
     C                   ENDSR
      *---------------------------------------------------------------------------------------------
     C     ITEMKONTROL   BEGSR
     C     ITMC9G        CHAIN     P790W2R                            98
     C                   IF        *IN98 = *OFF
     C                   EVAL      eITMCOD = ITMCW2
     C                   EVAL      KUTMTR = MKUTW2
     C                   EVAL      TOPMTR  = PSHQ9G
     C
     C                   Z-ADD     0             INITIALN         10 0
     C                   Z-ADD     0             DKALAN            6 2
     C                   Z-ADD     0             KUTUBOY          10 0
     C     TOPMTR        DIV       KUTMTR        INITIALN
     C                   MVR                     DKALAN
     C     DKALAN        IFGT      0
     C                   ADD       1             INITIALN
     C                   ENDIF
     C                   IF        %REM(INITIALN : 2) <> 0
     C                   ADD       1             INITIALN
     C                   ENDIF
     C                   EVAL      KUTUBOY = INITIALN
     C                   EVAL      KUTMTR = TOPMTR / KUTUBOY
     C                   ENDIF
     C                   ENDSR
      *---------------------------------------------------------------------------------------------