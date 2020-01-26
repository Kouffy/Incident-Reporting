
import 'main.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'appbar.dart';
import 'colors.dart';
class Home extends StatefulWidget {
  Home(
      {this.nom,
      this.prenom,
      this.emailu,
      this.tel,
      this.idd,
     });
  final String nom,
      prenom,
      emailu,
      tel,
      idd;
      
    

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 
  

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var ic = new AssetImage('assets/ic.png');
    return  WillPopScope(
      onWillPop: () async {  Navigator.pop(context,true);
        return false;
      },
      child:new Scaffold(
      appBar: MonAppBar(),
      drawer: MonDrawer(),
      backgroundColor: back,
      body: new ListView(
      
        children: <Widget>[
          ListTile(
                      title: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new Image(
                          image: ic,
                          width: 100,
                          height: 100,
                        ),
                        new Text(
                          "Dashboard",
                          style: new TextStyle(
                              color: titlecolore,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Card(
                      child: ListTile(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:  pdp == '' ? Image.asset(
                          'assets/incognito.png',
                          width: 50,
                          height: 50,
                        ):NetworkImage(
                          'http://soufiixinc.com/incident/uploads/$pdp'),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                subtitle: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
              "${widget.prenom} ${widget.nom}",
              style: new TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: titlecolore),
            ),
                  ],
                ),
            ),
          ),
          ),
        ],
      ),
    ));
  }
}
