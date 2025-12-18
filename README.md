# P79003
P79003 IBM i AS400 RPGLE Production Line Box Optimization Module


AS400 RPGLE Üretim Hattı Kutu Optimizasyon Modülü
Projenin Amacı:
Bu geliştirmeyi, üretim sahasındaki operasyonel verimliliği artırmak ve paketleme sürecindeki insan hatasını minimize etmek amacıyla tasarladım. Yazdığım bu backend modülü, üretimden çıkan ürünün özelliklerine ve üretildiği hattın yeteneklerine göre en ideal kutu sayısını ve kutu içi metrajı otomatik olarak hesaplar.
Entegrasyon ve Çalışma Yapısı:
Bu modül, üretim sistemimizin ana ekran programı olan P79003X ile entegre çalışmaktadır. P79003X üzerinden kullanıcı veri girişi yaptığında, bu programı CALL ederek parametre olarak Ürün Numarasını (pPRDNUM) gönderir. Benim yazdığım algoritma arka planda hesaplamayı yapar ve sonucu (pFIXBOX) ana programa geri döndürür.
Geliştirdiğim Teknik Mantık ve Senaryolar:
Veritabanı ile haberleşerek ürünün istatistiksel verilerini analiz eden dinamik bir yapı kurdum. Algoritmam şu kritik senaryoları yönetmektedir:
  1- Çift Sarım (Double Winding) Kontrolü: Üretim hattındaki makine çift sarım yapıyorsa (İstatistik kodu 1-1 veya 1-3), sistemin fiziksel dengesini korumak adına hesaplanan kutu sayısını zorunlu olarak çift sayıya yuvarlayan bir mantık geliştirdim.
  2- 10KG Altı ve Özel Hatlar: Belirli hat kodlarında (Örn: Hat 130 ve alt kırılımları) sistemin standart hesaplama yerine, önceden tanımlı kurallara (sabit tek kutu) uymasını sağlayan filtreler ekledim.
  3- Kapasite Aşım Yönetimi: Hesaplanan metrajın, tanımlı kutu kapasitesini (MKUTW2) aşması durumunda döngüsel (DOW) bir kontrol mekanizması ile kutu sayısını optimize ederek kapasite ihlalini engelledim.

  NOT: Kodun ITEMKONTROL alt yordamında bulunan "Çift Sayı Kontrolü" bloğu oldukça kritiktir. Çift sarım yapan makinelerde (1-1 ve 1-3 durumları) kutu sayısının tek sayı çıkması fiziksel olarak üretim hatasına yol açacağı için, kod burada matematiksel      yuvarlama yerine zorunlu artırım (ADD 1) uygulamaktadır.
 
Bu modül sayesinde üretim planlama sürecinde manuel hesaplama ihtiyacı ortadan kalkmış ve yanlış paketleme riski sıfıra indirilmiştir.

-----------------------------------------------------------------------------------------------

AS400 RPGLE Production Line Box Optimization Module
Project Goal:
I designed this module to enhance operational efficiency on the production floor and minimize human error during the packaging process. This backend utility automatically calculates the optimal number of boxes and meterage per box based on the product specifications and the production line's capabilities.
Integration and Architecture:
This module is fully integrated with our main production interface program, P79003X. When a user enters data into P79003X, it triggers a CALL to my program, passing the Product Number (pPRDNUM) as a parameter. My algorithm performs the complex calculations in the background and returns the calculated Box Count (pFIXBOX) back to the main application via *ENTRY PLIST.
Technical Logic and Key Scenarios:
I established a dynamic structure that interacts with the database (F9G00, FA000) to analyze product statistics. The algorithm I developed handles the following critical scenarios:
  1- Double Winding Control: For machines capable of double winding (Stat codes 1-1 or 1-3), I implemented logic that forces the box count to be an even number. This ensures physical balance on the winding machine.
  2- Special Line Constraints (Under 10kg): For specific production lines (e.g., Line 130 sub-codes), I created filters that bypass standard calculations to strictly follow pre-defined rules (e.g., fixed single box).
  3- Capacity Overflow Management: I implemented a loop mechanism (DOW) to detect if the calculated meterage exceeds the maximum box capacity (MKUTW2). The system automatically adjusts the box count until it fits within safe limits.

  NOTE: The "Even Number Check" block in the ITEMKONTROL subroutine of the code is quite critical. In machines that perform double winding (1-1 and 1-3 cases), an odd number of boxes will physically lead to a production error; therefore, the code applies a mandatory increment (ADD 1) instead of mathematical rounding.

Through this module, I successfully eliminated the need for manual calculations in production planning and reduced packaging errors to zero.
