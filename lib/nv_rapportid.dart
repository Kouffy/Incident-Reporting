import 'dart:async';
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:toast/toast.dart';
import 'mes_rapports.dart';
import 'main.dart';
import 'colors.dart';


class NvRapportId extends StatefulWidget {
  NvRapportId({this.idd});
  final String idd;
  @override
  _NvRapportIdState createState() => _NvRapportIdState();
}

class _NvRapportIdState extends State<NvRapportId> {
  TextEditingController controllerTitre = new TextEditingController();
  TextEditingController controllerDesc = new TextEditingController();
 
  TextEditingController lat = new TextEditingController();
  TextEditingController long = new TextEditingController();
  File _image;
  TextEditingController cTitle = new TextEditingController();
  DateTime now = DateTime.now();
   TextEditingController controllerDate = new TextEditingController();
  String cid = idd;
  Future getImageGallery() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = new Math.Random().nextInt(100000);
      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, width: 500);
      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      setState(() {
        _image = compressImg;
      });
    } catch (e) {
      print("x");
    }
  }

  Future getImageCamera() async {
    try {
      var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;
      int rand = new Math.Random().nextInt(100000);
      Img.Image image = Img.decodeImage(imageFile.readAsBytesSync());
      Img.Image smallerImg = Img.copyResize(image, width: 500);

      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      setState(() {
        _image = compressImg;
      });
    } catch (e) {
      print("x2");
    }
  }

  Future addData(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://soufiixinc.com/incident/addtestid.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    request.fields['id'] = cid;
    request.fields['txt1'] = dropdownValue;
    request.fields['txt2'] = controllerTitre.text;
    request.fields['txt3'] = controllerDesc.text;
    request.fields['txt4'] = controllerDate.text.toString();
    request.fields['titre'] = cTitle.text;
    request.fields['lat'] =  lat.text;
    request.fields['long'] = long.text;

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("image uploaded");
    } else {
      print("upload failed");
    }
  }

  String dropdownValue = "routes";
  String error;
@override
  void initState() {
    super.initState();
    
    controllerDate.text=now.year.toString()+'/'+now.month.toString()+'/'+now.day.toString();
  }
  @override
  Widget build(BuildContext context) {
    var ic = new AssetImage('assets/ic.png');
    final theme = Theme.of(context);
    return new WillPopScope(
      onWillPop: () async {  Navigator.pop(context,true);
        return false;
      },
      child: Scaffold(
      appBar: new AppBar(),
      backgroundColor: back,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: ListView(
          children: <Widget>[
            new Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

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
                      "  Nouveau Rapport",
                      style: new TextStyle(
                          fontFamily: "Cooper",
                          color: titlecolore,
                          fontSize: 21),
                    )
                  ],
                ),
                new Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Row(
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
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: controllerTitre,
                            decoration: new InputDecoration(
                              hintText: 'titre',
                              labelText: "titre abrégé",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            controller: controllerDesc,
                            decoration: new InputDecoration(
                              hintText: "description textuelle",
                              labelText: "description d'incident",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: controllerDate,
                            decoration: new InputDecoration(
                              hintText: "date",
                              labelText: "YYYYMMDD",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
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
                              child: Icon(Icons.image),
                              onPressed: getImageGallery,
                            ),
                            Container(
                              width: 20.0,
                            ),
                            RaisedButton(
                              child: Icon(Icons.camera),
                              onPressed: getImageCamera,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new RaisedButton(
                                onPressed: () {
                                  try {
                                    addData(_image);
                                    Toast.show("Envoyé avec succès", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new MesRapports()));
                                  } catch (e) {
                                    Toast.show("Erreur d'Ajout ", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }
                                },
                                color: Theme.of(context).accentColor,
                                child: new Text(
                                  'Envoyer',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                width: 20.0,
                              ),
                              new RaisedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                                color: Theme.of(context).accentColor,
                                child: new Text(
                                  'Annuler',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                width: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
