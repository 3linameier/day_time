///
/// Autor: Elina Meier
///
/// CGI päeva pikkuse leidmise rakendus
///
/// mai 2021
///

import 'package:flutter/material.dart';
import 'package:sunrise_sunset/sunrise_sunset.dart';
import 'package:duration/duration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Rakenduse juur
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'len(päev)',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Päeva pikkuse leidja'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Siin on erinevad meetodid ja rakenduse muutumised
class _MyHomePageState extends State<MyHomePage> {
  DateTime hetkeKuupaev = DateTime.now();
  final latController = TextEditingController();
  final longController = TextEditingController();
  double lat = 0;
  double long = 0;
  String paiksetous = "";
  String paikseloojang = "";
  String paevapikkus = "";


  /// Meetod leiab SunriseSunset API-st vastavalt kuupäevale ja
  /// lokatsioonile päiksetõusu ja -loojangu aja ning päeva pikkuse
  Future<void> _leiaPaevaPikkus() async {
    try {
      final response = await SunriseSunset.getResults(date: hetkeKuupaev ,latitude: lat, longitude: long);

      if (response.success) {
        DateTime dataSR = response.data.sunrise.toLocal();
        DateTime dataSS = response.data.sunset.toLocal();
        Duration dayLen = dataSS.difference(dataSR);
        setState(() {
          paiksetous = '${dataSR.hour}:${dataSR.minute}:${dataSR.second}';
          paikseloojang = '${dataSS.hour}:${dataSS.minute}:${dataSS.second}';
          paevapikkus = prettyDuration(dayLen, abbreviated: true);
        });
      } else setState(() {paiksetous = response.error;});
    } catch (err) {
      setState(() {paiksetous = "Failed to get data."+err;});
    }
  }

   /// meetod kontrollib, kas kasutaja sisestatud koordinaadid sobivad
   String _kontrollKoordinaate() {
    try {
      lat = double.parse(latController.text);
      long = double.parse(longController.text);
    } on FormatException {
      return (new FormatException('Palun sisesta koordinaat komakohaga arvuna, kus koma asemel on punkt! (nt 59.3734800)')).toString();
    } on Exception {
      return (new Exception('Palun sisesta koordinaadid õigesti!')).toString();
    }
    return null;
  }

  /// Meetod implementeerib kuupäeva valimiseks kalendri
  Future<void> _valiKuupaev(BuildContext context) async {
    final DateTime valitud = await showDatePicker(
        context: context,
        initialDate: hetkeKuupaev,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100, 12, 31));
    if (valitud != null && valitud != hetkeKuupaev)
      setState(() {
        hetkeKuupaev = valitud;
      });
  }

  /// Meetod on popup akna kuvamiseks errori puhul
  Future<void> _naitaErrorit(BuildContext context, String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Viga!'),
            content: Text(error),
            elevation: 10,
            actions: <Widget>[
              TextButton(
                child: Text('nu davaika!'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
    );
  }


  /// Siin toimub põhiline rakenduse ehitamine
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tere! Kui tahad leida päeva pikkust,\nsiis täida järgmised väljad.',
                  style: TextStyle(fontSize: 20)
                ),
                SizedBox(height: 50),
                Text("${hetkeKuupaev.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20)),
                //SizedBox(height: 20.0,),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 5),
                  onPressed: () => _valiKuupaev(context),
                  child: Text('Vali kuupäev', style: TextStyle(fontSize: 30)),
                ),
                SizedBox(height: 30),
                Text('Sisesta koordinaadid:', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextField(
                    controller: latController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'laiuskraad'
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  child: TextField(
                    controller: longController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'pikkuskraad'
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 5),
                  onPressed: () {
                    if (_kontrollKoordinaate() != null) _naitaErrorit(context, _kontrollKoordinaate());
                    else _leiaPaevaPikkus();
                  },
                  child: Text('Leia päeva pikkus!', style: TextStyle(fontSize: 30))
                ),
                SizedBox(height: 30),
                Card(
                  color: Colors.white,
                  elevation: 10,
                  child: Container(
                    width: 263,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Päiksetõus: ' + paiksetous, style: TextStyle(fontSize: 20)),
                          Text('Päikseloojang: ' + paikseloojang, style: TextStyle(fontSize: 20)),
                          Text('Päeva pikkus: ' + paevapikkus, style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Siia tuleb kaart'),
              ]
            ),
          ),
        ],
      ),
    );
  }
}


