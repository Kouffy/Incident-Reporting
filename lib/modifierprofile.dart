import 'package:flutter/material.dart';
import 'package:gestion_inscidents/profile.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:gestion_inscidents/drawer.dart';
import 'package:http/http.dart' as http;
import 'colors.dart';
import 'main.dart';

class ModifierProfile extends StatefulWidget {
  

  @override
  _ModifierProfileState createState() => _ModifierProfileState();
}

class _ModifierProfileState extends State<ModifierProfile> {


TextEditingController cnom= new TextEditingController();
  TextEditingController cprenom= new TextEditingController();
  TextEditingController cemail= new TextEditingController();
  TextEditingController ctel= new TextEditingController();

  



  Future editData() async {
     var uri = Uri.parse("http://soufiixinc.com/incident/editData2.php");
    var request = new http.MultipartRequest("POST", uri);
    request.fields['id'] =idd;
    request.fields['nom'] =cnom.text;
         request.fields['prenom'] = cprenom.text;
         request.fields['email'] = cemail.text;
         request.fields['tel'] = ctel.text;
     var response = await request.send();
    if (response.statusCode == 200) {
      print("uploaded");
    } else {
      print("failed");
    }
   
  }

 @override
  void initState() {
    cnom.text=nom;
    cprenom.text =prenom;
    cemail.text=emailu;
    ctel.text=tel;

   
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            children: <Widget>[
              Container(width: 10.0,),
              Image.asset('assets/ic.png',width: 50.0,height: 50.0,),
              Container(width: 5.0,),
              new Text("Modifier Votre Profile"),
            ],
          ),
          backgroundColor: appbarvolor,
        ),
        drawer: MonDrawer(),
        body:Padding(
          padding: const EdgeInsets.only(top: 40.0,left: 40.0,right: 40.0),
          child: Builder(
            builder: (context){
    return ListView(
            children: <Widget>[
              
              new Column(
                children: <Widget>[
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
                  TextField(
                    controller: cnom,
                    decoration: new InputDecoration(hintText: "nom",labelText: "nom"),
                  ),
                  TextField(
                    controller: cprenom,
                    decoration: new InputDecoration(hintText: "prenom",labelText: "prenom"),
                  ),
                  TextField(
                    controller: cemail,
                    decoration: new InputDecoration(hintText: "email",labelText: "email"),
                  ),
                
                   TextField(
                    controller: ctel,
                    decoration: new InputDecoration(hintText: "tel",labelText: "tel"),
                  ),
                 Container(height: 20.0,),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        child: new Text("Effectué"),
                        onPressed: () {
                          try{
                            editData();
                           
                          Toast.show("Modifié avec Succés", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Profile()));
                                 
                          }
                          catch(e)
                          {
                            Toast.show("Erreur de Modification", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                          }
                          
                        },
                      ),
                      Container(
                        width: 20.0,
                      ),
                      RaisedButton(
                        child: new Text("Annuler"),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new Profile()));
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          );
            }
           ),
        ),
         );
  }
}