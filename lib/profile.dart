import 'package:flutter/material.dart';
import 'package:gestion_inscidents/modifierprofile.dart';

import 'main.dart';
import 'colors.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

void _refreshh() async {
  try{ final response =
        await http.post("http://soufiixinc.com/incident/refreshprofile.php", body: {
          "id" : idd
    });

    var donnes = json.decode(response.body);


      setState(() {  
        nom = donnes[0]['nom'];
        prenom = donnes[0]['prenom'];
        emailu = donnes[0]['email'];
        tel = donnes[0]['tel'];
        pdp = donnes[0]['photo'];
      });
    // return donnes;
   
    }catch(e){Toast.show("Erreur d'actualisation des informations'", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);}
   
  }
  @override
  void initState() {
      _refreshh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(),
      backgroundColor: back,
      body: new ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "photo de profile :\n ",
                      style: new TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'http://soufiixinc.com/incident/uploads/$pdp'),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          Container(height: 10.0,),
          Card(
              child: ListTile(
            title: new Text(
              "prenom :\n ",
              style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: new Text(
              " $prenom",
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: titlecolore),
            ),
          )),
          Card(
              child: ListTile(
            title: new Text(
              "nom :\n ",
              style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: new Text(
              " $nom",
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: titlecolore),
            ),
          )),
          Card(
              child: ListTile(
            title: new Text(
              "email :\n ",
              style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: new Text(
              " $emailu",
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: titlecolore),
            ),
          )),
          Card(
              child: ListTile(
            title: new Text(
              "numero de telephone :\n ",
              style: new TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            subtitle: new Text(
              " $tel",
              style: new TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: titlecolore),
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ModifierProfile()));
                  },
                  child: new Text("MODIFIER"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
