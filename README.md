# P79003
Item Max Box Capacity - Item Max Kutu Kapasitesi 


We can think of the program as being integrated into an existing program.

Operation:
The PR number is scanned. 
A message appears on the screen asking how many boxes you want to make.
The operator calculates the meterage written on the form, enters how many boxes there will be, and the system calculates the meterage that will go into each box. When the last box is scanned, the form is finished.

The purpose of the project is to prevent the operator from entering incorrect data.

Information on the maximum box capacities of the desired items will be provided.
Using this information, the system will automatically perform the calculation.

##

It will read from F9G00 PR and retrieve the item information.
It will check the P790W2 table; if the item is in this table, the system will perform the calculation itself.
The rule here is to check the items of PRs coming from certain lines, i.e., products ranging from 10 kg to 210 kg. It will not perform calculations for 1 kg or 8 kg.
Due to double winding, the calculation must be double. If the result is an odd number, it will add +1 and recalculate the meters that will fall into each box.

----------------------------------------------------------------------------------------------------------------

Program, mevcut bir programa entegre gibi düşünebiliriz.

İşleyiş;
PR no okutulur. 
Ekrana mesaj çıkar kaç kutu yapmak istiyorsunuz diye.
Operatör formda yazan metreyi hesaplayıp kaç kutu olacaksa girdiyi yazar ve sistem hesaplar her kutuya düşecek metreyi ve son kutu okutulduğunda form finish olur.

Projenin amacı;
Operatörün yanlış girdi girmesinin önüne geçmek.

İstenilen itemların max kutu kapasitelerinin bilgileri verilecek.
Bu bilgiler sayesinde sistem otomatik olarak hesaplama işlemi yapacak.

##

F9G00 PR 'den okuyacak ve item bilgisini alacak.
P790W2 tablosuna bakacak eğer item bu tabloda mevcut ise sistem kendisi hesaplama işlemini yapacak.
Burada olan kural belli hatlardan çıkan PR 'lerin itemlarını kontrol edecek yani 10 kg. ile 210 kg. aralığında çıkan ürünleri. 1KG. 8 KG. da hesaplama yapmayacak.
Çift sarım olduğundan dolayı hesaplama çift olmak zorundadır. Sonuç tek sayı olursa +1 yapacak ve her kutuya düşecek olan metreyi tekrar hesaplayacak.

