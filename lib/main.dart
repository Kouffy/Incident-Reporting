import 'package:flutter/material.dart';
import 'package:gestion_inscidents/modifier.dart';
import 'package:gestion_inscidents/modifierprofile.dart';
import 'package:gestion_inscidents/nv_rapport.dart';
import 'package:gestion_inscidents/nv_rapportid.dart';
import 'package:gestion_inscidents/profile.dart';
import 'login.dart';
import 'register.dart';
import 'index.dart';
import 'home.dart';
import 'mes_rapports.dart';


void main() => runApp(new MyApp());
String idd = '';
String nom = '';
String prenom = '';
String emailu = '';
String tel = '';
String pdp = '';

Map<int, Color> color = {
  50: Color.fromRGBO(255, 184, 56, .1),
  100: Color.fromRGBO(255, 184, 56, .2),
  200: Color.fromRGBO(255, 184, 56, .3),
  300: Color.fromRGBO(255, 184, 56, .4),
  400: Color.fromRGBO(255, 184, 56, .5),
  500: Color.fromRGBO(255, 184, 56, .6),
  600: Color.fromRGBO(255, 184, 56, .7),
  700: Color.fromRGBO(255, 184, 56, .8),
  800: Color.fromRGBO(255, 184, 56, .9),
  900: Color.fromRGBO(255, 184, 56, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF93cd48, color);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primarySwatch: colorCustom),
      debugShowCheckedModeBanner: false,
      home: Index(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(
              nom: nom,
              prenom: prenom,
              emailu: emailu,
              tel: tel,
              idd: idd,
            ),
        '/mes_rapports': (BuildContext context) => new MesRapports(
              idd: idd,
            ),
        '/profile': (BuildContext context) => new Profile(),
        '/nvrapport': (BuildContext context) => new NvRapport(),
        '/new': (BuildContext context) => new Modifier(),
        '/nvid': (BuildContext context) => new NvRapportId(
              idd: idd,
            ),
        '/register': (BuildContext context) => new Register(),
        '/editprofile': (BuildContext context) => new ModifierProfile(),
        '/login': (BuildContext context) => new Login(),
        '/index': (BuildContext context) => new Index(),
           
      },
    );
  }
}


