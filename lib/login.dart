import 'dart:convert';
import 'package:gestion_inscidents/hexcolor.dart';
import 'package:gestion_inscidents/register.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  

  Future<List> _logins() async {
    final response =
        await http.post("http://soufiixinc.com/incident/conn.php", body: {
      "email": email.text,
      "password": pass.text,
    });

    var donnes = json.decode(response.body);

    if (donnes.length == 0) {
      
        Toast.show("authentification échouée", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
      
    } else {
      Navigator.pushReplacementNamed(context, '/home');

      setState(() {
        idd = donnes[0]['id'];
        nom = donnes[0]['nom'];
        prenom = donnes[0]['prenom'];
        emailu = donnes[0]['email'];
        tel = donnes[0]['tel'];
        pdp = donnes[0]['photo'];
      });
    }
    return donnes;
  }

  Color backgroundcolor = new HexColor("F7F6EE");
  Color titlecolore = new HexColor("486D87");
  Color potona = new HexColor("FEE5A5");
  @override
  Widget build(BuildContext context) {
    var ic = new AssetImage('assets/ic.png');

    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context,true);
        return false;
      },
      child: new Scaffold(
      appBar: new AppBar(),
      backgroundColor: backgroundcolor,
      body: ListView(
        children: <Widget>[
          Form(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              child: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image(
                        image: ic,
                        width: 100,
                        height: 100,
                      ),
                      new Text(
                        "  REPPORT\n  DES INCIDENTS",
                        style: new TextStyle(
                            fontFamily: "Cooper",
                            color: titlecolore,
                            fontSize: 21),
                      )
                    ],
                  ),
                  new Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Theme(
                              data: theme.copyWith(primaryColor: Colors.red),
                              child: new TextFormField(
                                controller: email,
                                decoration: InputDecoration(labelText: "Email"),
                              )),
                          new Theme(
                              data: theme.copyWith(primaryColor: Colors.red),
                              child: new TextFormField(
                                controller: pass,
                                decoration:
                                    InputDecoration(labelText: "Password"),
                                obscureText: true,
                              )),
                        
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: new RaisedButton(
                              onPressed: () {
                                try{ _logins();}catch(e){  Toast.show("Erreur du serveur", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);}
                                
                              },
                              color: new HexColor("FFB838"),
                              child: new Text(
                                'S\'authentifier',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomAppBar(
        child: new SizedBox(
          width: 1.0,
          height: 50.0,
          child: new RaisedButton(
              color: new HexColor("FFB838"),
              onPressed: () {
                 Navigator.push(context, new MaterialPageRoute(
                            builder: (context)=>Register()));
              },
              padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
              child: new Text(
                'S\'inscrire',
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              )),
        ),
      ),
    ));
  }
}
