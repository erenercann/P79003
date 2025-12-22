     H DFTACTGRP(*NO) ACTGRP(*NEW)            
     FFA000     IF   E           K DISK       
     FF9G00     IF   E           K DISK       
     FP790W2    IF   E           K DISK       
     FP79003D   CF   E             WORKSTN    
      *                                       
     D pPRDNUM         S             10A      
     D pFIXBOX         S              2S 0    
     D eITMCOD         S              7A      
     D EITMCW2         S              7A      
     D MESAJ           S             50A      
     D HERKUTU         S              6  2    
      *                                       
     D KUTUBOL         S             10S 2         
     D KUTUBL          S             50A      
      * hesaplama deðiþkenleri                
     D INITIALN        S             10  0    
     D KUTUBOY         S             10  0    
     D DKALAN          S              6  2    
      *                                                                   
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
      *-------------------------------------------------------------------
     C     Ini_000       BEGSR                                            
     C                   EVAL      ePRDNUM = *BLANKS                      
     C                   EVAL      eITMCOD = *BLANKS                      
     C                   EVAL      TOPMTR = 0                             
     C                   EVAL      KUTMTR = 0                             
     C                   EVAL      KUTSAY = 0                             
     C                   ENDSR                                            
      *-------------------------------------------------------------------
     C     Prc_100       BEGSR                                            
      * hesapla                                                           
     C                   EXSR      Prc_200                                
      * goster                                                            
     C                   WRITE     HDRLIN                                 
     C                   WRITE     FNCLIN                                 
     C                   WRITE     MSGLIN                                 
     C                   EXFMT     DSP001                                 
     C                   ENDSR                                            
      *------------------------------------------------------------------ 
     C     Prc_200       BEGSR                                            
      *                                                                   
     C     pPRDNUM       CHAIN     F9G00R                             99  
      *                                                                   
     C                   IF        *IN99 = *OFF                           
     C                   IF        LN1C9G = '130' AND (                   
     C                             LN2C9G = '20'  OR                      
     C                             LN2C9G = '25'  OR                      
     C                             LN2C9G = '26'  OR                      
     C                             LN2C9G = '30'  OR                      
     C                             LN2C9G = '31'  OR
     C                             LN2C9G = '32'  OR
     C                             LN2C9G = '33'  OR
     C                             LN2C9G = '35'  OR
     C                             LN2C9G = '40'  OR
     C                             LN2C9G = '45'  OR
      *10kg altý hatlar için                        
     C                             LN2C9G = '01'  OR
     C                             LN2C9G = '02'  OR
     C                             LN2C9G = '05'  OR
     C                             LN2C9G = '10'  OR
     C                             LN2C9G = '14'  OR
     C                             LN2C9G = '18'  OR
     C                             LN2C9G = '19'  OR
     C                             LN2C9G = '50'  OR
     C                             LN2C9G = '81'  OR
     C                             LN2C9G = '82'  OR
     C                             LN2C9G = '83'  OR
     C                             LN2C9G = '91'  OR
     C                             LN2C9G = '92'  OR
     C                             LN2C9G = '95' )                      
     C                   EVAL      ePRDNUM = pPRDNUM                    
     C                   EXSR      ITEMKONTROL                          
     C                   EVAL      KUTSAY  = KUTUBOY                    
     C                   ELSE                                           
     C                   EXSR      Ini_000                              
     C                   ENDIF                                          
     C                   ELSE                                           
     C                   EXSR      Ini_000                              
     C                   ENDIF                                          
      *                                                                 
     C                   ENDSR                                          
      *------------------------------------------------------           
     C     ITEMKONTROL   BEGSR                                          
      *P790W2 oku yoksa çýk                                             
     C     ITMC9G        CHAIN     P790W2R                            98
     C                   IF        *IN98 = *ON                          
     C                   EXSR      Ini_000                              
     C                   LEAVESR                                        
     C                   ENDIF                                          
      *                                                                 
      *FA000 oku yksa çýk                                               
     C     ITMC9G        CHAIN     FA000R                             97
     C                   IF        *IN97 = *ON                          
     C                   EXSR      Ini_000                              
     C                   LEAVESR                                        
     C                   ENDIF                                          
      *                                                                 
      * ekran deðerlerini doldur                                        
     C                   EVAL      eITMCOD = ITMCW2                     
     C                   EVAL      TOPMTR  = PSHQ9G                     
      * kapasite hatasi önlem                                           
     C                   IF        MKUTW2 <= 0                          
     C                   EVAL      MKUTW2 = 999999                      
     C                   ENDIF                                          
      * toplam metre 0 ise 1 yap                                        
     C                   IF        TOPMTR <= 0                          
     C                   EVAL      TOPMTR = 1                           
     C                   ENDIF                                          
      *                                                                 
      *10kg altý kontrol                                
     C                   IF        LN1C9G = '130' AND ( 
     C                             LN2C9G = '01'  OR    
     C                             LN2C9G = '02'  OR    
     C                             LN2C9G = '05'  OR    
     C                             LN2C9G = '10'  OR    
     C                             LN2C9G = '14'  OR    
     C                             LN2C9G = '18'  OR    
     C                             LN2C9G = '19'  OR    
     C                             LN2C9G = '50'  OR    
     C                             LN2C9G = '81'  OR    
     C                             LN2C9G = '82'  OR    
     C                             LN2C9G = '83'  OR    
     C                             LN2C9G = '91'  OR    
     C                             LN2C9G = '92'  OR    
     C                             LN2C9G = '95' )      
     C                   EXSR      H10KGALTI            
     C                   LEAVESR                        
     C                   ENDIF                          
     C                                                  
      * (1-1) VEYA (1-3) -> çift kutu zorunlu çift sarýmdan dolayý                   
     C                   IF        (ST1CA0 = '1' AND ST2CA0 = '1') OR                
     C                             (ST1CA0 = '1' AND ST2CA0 = '3')                   
      *                                                                              
     C                   EVAL      INITIALN = %INT(TOPMTR / MKUTW2)                  
     C                   IF        %REM(TOPMTR : MKUTW2) > 0                         
     C                   ADD       1             INITIALN                            
     C                   ENDIF                                                       
      *                                                                              
     C                                                                               
      *******************************************************************************
     C                                                                               
     C                                                                               
      * Cift Sayi Kontrolu (Tek ise +1)                                              
     C                   IF        %REM(INITIALN : 2) <> 0                           
     C                   ADD       1             INITIALN                            
     C                   ENDIF                                                       
     C                   IF        INITIALN <= 0                                     
     C                   EVAL      INITIALN = 2                                      
     C                   ENDIF                                   
      *                                                          
     C                   EVAL      KUTUBOY = INITIALN            
     C                   EVAL      KUTMTR  = TOPMTR / KUTUBOY / 2
      * Kapasite Asim Dongusu (Cift Sayi Koruyarak)              
     C                   DOW       KUTMTR > MKUTW2               
     C                   ADD       1             KUTUBOY         
     C                   IF        %REM(KUTUBOY : 2) <> 0        
     C                   ADD       1             KUTUBOY         
     C                   ENDIF                                   
     C                   EVAL      KUTMTR = TOPMTR / KUTUBOY     
     C                   ENDDO                                   
      *                                                          
     C                   ELSE                                    
      * 1-2 -> INI_001 çaðýracak.                                
     C                   IF        ST1CA0 = '1' AND ST2CA0 = '2' 
     C                   EXSR      Ini_001                       
     C                   ELSE                                    
      * Tanimlanmamis durum                                      
     C                   EXSR      Ini_000                       
     C                   ENDIF                                          
     C                   ENDIF                                          
      *                                                                 
     C                   ENDSR                                          
      *------------------------------------------------------           
     C     Ini_001       BEGSR                                          
      * Bu bölüm sadece istatislik kodu 1-2 durumunda çalýþýr.          
      * sýðýyorsa direkt 1 kutu yap                                     
     C                   IF        TOPMTR <= MKUTW2                     
     C                   EVAL      KUTUBOY = 1                          
     C                   EVAL      KUTMTR  = TOPMTR                     
     C                   ELSE                                           
      * Siðmiyorsa Hesapla                                              
     C                   EVAL      INITIALN = %INT(TOPMTR / MKUTW2)     
     C                   IF        %REM(TOPMTR : MKUTW2) > 0            
     C                   ADD       1             INITIALN               
     C                   ENDIF                                          
     C                   EVAL      KUTUBOY = INITIALN                   
     C                   ENDIF                                          
      *                                                                 
      * Guvenlik                                                      
     C                   IF        KUTUBOY <= 0                       
     C                   EVAL      KUTUBOY = 1                        
     C                   ENDIF                                        
     C                   EVAL      KUTMTR = TOPMTR / KUTUBOY          
      *                                                               
      * Kapasite aþým dongusu                                         
     C                   DOW       KUTMTR > MKUTW2                    
     C                   ADD       1             KUTUBOY              
     C                   EVAL      KUTMTR = TOPMTR / KUTUBOY          
     C                   ENDDO                                        
     C                   ENDSR                                        
      *H10KGALTI SUBROUTINE                                           
     C     H10KGALTI     BEGSR                                        
      *Her durumda 1 Kutu olacak                                      
     C                   EVAL      KUTUBOY = 1                        
      *                                                               
      * (1-1) VEYA (1-3) Kontrolü                                     
     C                   IF        (ST1CA0 = '1' AND ST2CA0 = '1') OR 
     C                             (ST1CA0 = '1' AND ST2CA0 = '3') AND
     C                             (UT6CA0 = 'L')
      * Metreyi 2'ye boluyoruz (Tek kutuda cift goz gibi)         
     C                   EVAL      KUTMTR = TOPMTR / 2            
      *                                                           
     C                   ELSE                                     
      * (1-2) Durumu -> Oldugu gibi atiyoruz                      
     C                   IF        ST1CA0 = '1' AND ST2CA0 = '2'  AND
     C                             UT6CA0 = 'M'
     C                   EVAL      KUTMTR = TOPMTR                
     C                   ELSE                                     
      * Diger durumlar (Guvenlik icin oldugu gibi birakalim)      
     C                   EVAL      KUTMTR = TOPMTR                
     C                   ENDIF                                    
     C                   ENDIF                                    
      *                                                           
     C                   ENDSR                                    


