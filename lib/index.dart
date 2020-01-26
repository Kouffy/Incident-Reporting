import 'package:flutter/material.dart';

import 'package:gestion_inscidents/appbar.dart';
import 'package:gestion_inscidents/login.dart';
import 'package:gestion_inscidents/nv_rapport.dart';
import 'package:gestion_inscidents/register.dart';

import 'colors.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
 
  @override
  Widget build(BuildContext context) {
    var ic = new AssetImage('assets/ic.png');


      return new Scaffold(
        backgroundColor: back,
        appBar: MonAppBar(),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: new Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image(
                        image: ic,
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "    INCIDENT\n  REPORTING",
                        style: new TextStyle(
                          fontFamily: "Cooper",
                          color: titlecolore,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("choisir le type d\'identification",
                      style: new TextStyle(
                          fontSize: 20,
                          color: titlecolore,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (context)=>Login(),
                          ));
                        },
                        child: Image.asset(
                          'assets/user.png',
                          width: 50,
                          height: 50,
                        )),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (context)=>NvRapport(),
                          ));
                        },
                        child: Image.asset(
                          'assets/incognito.png',
                          width: 50,
                          height: 50,
                        )),
                
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context)=> Register()));
                    },
                    color: Theme.of(context).accentColor,
                    child: new Text(
                      'S\'inscrire',
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      );
    
  }
}
