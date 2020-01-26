import 'package:flutter/material.dart';
import 'package:gestion_inscidents/colors.dart';
import 'package:gestion_inscidents/home.dart';
import 'dart:convert';
import 'main.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'hexcolor.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController confpass = new TextEditingController();
  TextEditingController tel = new TextEditingController();

File _image;


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
    var uri = Uri.parse("http://soufiixinc.com/incident/addtestreg.php");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
        request.fields['nom'] = nom.text;
         request.fields['prenom'] = prenom.text;
         request.fields['email'] = email.text;
         request.fields['pass'] = pass.text;
         request.fields['tel'] = tel.text;
         
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("image uploaded");
    } else {
      print("upload failed");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var ic = new AssetImage('assets/ic.png');
    final theme = Theme.of(context);
 Future<List> _logins() async {
    final response =
        await http.post("http://soufiixinc.com/incident/conn2.php", body: {
      "email": emailu,
    });

    var donnes = json.decode(response.body);

      setState(() {
        nom = donnes[0]['nom'];
        prenom = donnes[0]['prenom'];
        emailu = donnes[0]['email'];
        tel = donnes[0]['tel'];
        pdp = donnes[0]['photo'];
      });
    
    return donnes;
  }

    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context);
        return false;
      },
          child: new Scaffold(
        appBar: new AppBar(backgroundColor: new HexColor("FFB838"),),
        backgroundColor: back,
        body: ListView(
          children: <Widget>[
            Padding(
            padding: const EdgeInsets.only(top: 40.0,left: 40.0,right: 40.0),
            child: new Column(
             
              children: <Widget>[
                new Row(
               
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                   new Image(
                      image: ic,
                      width: 100,
                      height: 100,
                    ),
                    new Text(
                      "  INCIDENT\n  REPORTING",
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
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: nom,
                            decoration: new InputDecoration(
                              hintText: 'nom',
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: prenom,
                            decoration: new InputDecoration(
                              hintText: "prenom",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: email,
                            decoration: new InputDecoration(
                              hintText: "email",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextFormField(
                            controller: pass,
                            decoration: new InputDecoration(
                              hintText: "mot de passe",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                            obscureText: true,
                          ),
                          
                        ),
                        new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextFormField(
                            controller: confpass,
                            decoration: new InputDecoration(
                              hintText: "confirmation mot de passe",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                            obscureText: true,
                          ),
                        ),
                     new Theme(
                          data: theme.copyWith(primaryColor: Colors.red),
                          child: new TextField(
                            controller: tel,
                            decoration: new InputDecoration(
                              hintText: "tel",
                              labelStyle: theme.textTheme.caption
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                        ),
                        Container(height: 20.0,),
                        new Text("selectionner une photo de profile :"),
                  
                         Padding(
                            padding: const EdgeInsets.only(top: 15.0),
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
                         Container(height: 20.0,),
                          new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RaisedButton(
                                child: Icon(Icons.image),
                                onPressed: getImageGallery,
                              ),
                              Container(width: 20.0,),
                              RaisedButton(
                                child: Icon(Icons.camera),
                                onPressed: getImageCamera,
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: new RaisedButton(
                            onPressed: () {
                               if(pass.text != confpass.text)
                {
                  Toast.show("le mot de passe et le confirmation\ndoivent etre identiques ", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                }
                else
                {
                  addData(_image);
                  Toast.show("Inscrit avec succès", context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
                  setState(() {
                  emailu = email.text;
                  _logins();
                  });
                  Navigator.pop(context);
                   Navigator.push(context, new MaterialPageRoute(
                            builder: (context)=>Home(emailu: email.text,nom: nom.text,prenom: prenom.text,)));
                }
                            }, 
                            color: Theme.of(context).accentColor,
                            child: new Text(
                              'S\'inscrire',
                              style: new TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          ],
             
        ),
       
      ),
    );
  }
}
