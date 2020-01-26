import 'dart:io';
import 'package:gestion_inscidents/mes_rapports.dart';
import 'package:flutter/material.dart';
import 'package:gestion_inscidents/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'colors.dart';

class Modifier extends StatefulWidget {
  final List list;
  final int index;
  Modifier({this.list, this.index});
  @override
  _ModifierState createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  TextEditingController controllerTitre;
  TextEditingController controllerDesc;
  TextEditingController controllerDate;
  TextEditingController cTitle;
  File _image;
  String dropdownValue;



  Future editData() async {
     var uri = Uri.parse("http://soufiixinc.com/incident/editData.php");
    var request = new http.MultipartRequest("POST", uri);
     request.fields['id'] = widget.list[widget.index]['id'];
         request.fields['txt1'] = dropdownValue;
         request.fields['txt2'] = controllerTitre.text;
         request.fields['txt3'] = controllerDesc.text;
         request.fields['txt4'] = controllerDate.text;
    request.fields['titre'] = cTitle.text;
     var response = await request.send();
    if (response.statusCode == 200) {
      print("image uploaded");
    } else {
      print("upload failed");
    }
   
  }

  @override
  void initState() {
    dropdownValue = widget.list[widget.index]['type'];
    controllerTitre =
        new TextEditingController(text: widget.list[widget.index]['titre']);
    controllerDesc = new TextEditingController(
        text: widget.list[widget.index]['description']);
    controllerDate =
        new TextEditingController(text: widget.list[widget.index]['date']);
    cTitle = new TextEditingController(
        text: widget.list[widget.index]['titrephoto']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            children: <Widget>[
              Container(width: 55.0,),
              Image.asset('assets/ic.png',width: 50.0,height: 50.0,),
              Container(width: 5.0,),
              new Text("Modifier"),
            ],
          ),
          backgroundColor: appbarvolor,
        ),
        drawer: MonDrawer(),
        body:Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0),
          child: Builder(
            builder: (context){
return ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[

                      DropdownButton<String>(
                        value: dropdownValue,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'routes',
                          'canaux egout',
                          'ordures',
                          'eclairage',
                          'environnement'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),

             
      
    
                  TextField(
                    controller: controllerTitre,
                    decoration: new InputDecoration(hintText: "titre"),
                  ),
                  TextField(
                    controller: controllerDesc,
                    decoration: new InputDecoration(hintText: "desc"),
                  ),
                  TextField(
                    controller: controllerDate,
                    decoration: new InputDecoration(hintText: "date"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 120.0,
                          child: Center(
                            child: _image == null
                                ? new Text('Pas d\'image selectionne ')
                                : new Image.file(_image),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: cTitle,
                    decoration: new InputDecoration(
                      hintText: "Titre",
                      labelText: "titre de la photo",
                    ),
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        child: new Text("Modifier"),
                        onPressed: () {
                          try{
                            editData();
                          Toast.show("Modifié avec Succés", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MesRapports()));
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/mes_rapports');
                        },
                        child: new Text("Retour"),
                      ),
                    ],
                  )
                ],
              )
            ],
          );
            },
          ),
        ),
         );
  }
}
