# Projekti tutvustus

Implementeerisin päeva pikkuse arvutamise ja kuvamise veebirakenduse kasutades Flutter tarkvaraarenduskoplekti, mille põhikeeleks on Dart.

Jõudsin valmis vaatega, kus saab valida kuupäeva ja sisestada koordinaate ning vastuseks kuvatakse päiksetõusu ja -loojangu kellaeg ning päeva pikkus vastavatel koordinaatidel. Selleks kulus aega umbes 6h.  
Tegemata jäi veel asukoha valimise võimalus kaardi pealt. Kulutasin küll vähemalt 3h selle peale, et leida ja implementeerida kaardi kuvamise võimalust, mida Flutter veebirakenduse puhul toetaks, aga ei saanudki sellega hakkama. Proovisin ka lihtsalt HTML-il ja JavaScriptil põhinevat leaflet.js kaarti Flutter projekti sisse ehitada, aga see mul ka ei õnnestunud. 

Kuna ma ei ole Flutteriga väga põhjalikult tegelenud, siis tahtsin selle proektiga oma teadmisi Flutteri ja Darti valdkonnas laiendada ja neid paremini tundma õppida. Ma ei olnud varem Flutterit kasutanud internetist andmete saamiseks, seega http requestide tegemine oli vähemalt selles keskkonnas minu jaoks uus. JSON dataga oli mul probleeme, miskipärast andis formatExceptioni ja ma ei osanud sellele kuidagi läheneda. Tükk aega peale sellega mässamist googeldasin, mis võimalusi veel on ja avastasin, et Flutteriga on võimalus kasutada SunriseSunset API-d palju lihtsamini ja ma ei peagi tegelikult vaeva nägema andmete fetchimisega.

_valiKuupaev() meetodi koostamisel sain mõningast abi lehelt https://medium.com/flutter-community/a-deep-dive-into-datepicker-in-flutter-37e84f7d8d6c

Natuke liiga kaua aega läks ka Exceptionitega tegelmise peale, aga vist sain enamvähem asjale pihta.


# Flutter
Projekti käivitamiseks on vaja Flutterit ja AndroidStudiot või IntelliJ IDE-t
Täpsemalt installeerimisest on kirjutatud siin: https://flutter.dev/docs/get-started/install

Ma proovisin teha ka Github Page sellele projektile, aga miskipärast ei tööta see leht päris nii nagu peaks.


# Veebirakendus

Kuna Flutter on mõeldud kasutamiseks ka IOS ja Android äppide loomiseks, siis on projekti kaustas ka vastavalt ios ja android kaustad, aga neid ma ei muutnud. Veebirakenduse jaoks on põhiline fail lib/main.dart.

![Screenshot 2021-05-03 at 19 20 31](https://user-images.githubusercontent.com/56025134/116910484-5e08e580-ac4e-11eb-82aa-9cd219818866.png)

![Screenshot 2021-05-03 at 19 21 12](https://user-images.githubusercontent.com/56025134/116910491-5fd2a900-ac4e-11eb-9396-183c42d5d720.png)
![Screenshot 2021-05-03 at 19 21 22](https://user-images.githubusercontent.com/56025134/116910494-62cd9980-ac4e-11eb-8fda-e5bfd88298f9.png)

