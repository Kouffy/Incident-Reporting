import 'package:flutter/material.dart';
import 'package:gestion_inscidents/main.dart';
import 'package:gestion_inscidents/lesrapports.dart';
import 'package:gestion_inscidents/mes_rapports.dart';
import 'package:gestion_inscidents/nv_rapportid.dart';
import 'package:gestion_inscidents/profile.dart';
import 'main.dart';

class MonDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text("$prenom $nom \n"),
            accountEmail: new Text(
              "$emailu",
              style: new TextStyle(fontSize: 13.0),
            ),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundImage:
                 pdp == '' ? Image.asset(
                          'assets/incognito.png',
                          width: 50,
                          height: 50,
                        ):NetworkImage(
                          'http://soufiixinc.com/incident/uploads/$pdp'),
              backgroundColor: Colors.transparent,
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/profile');
            },
      
          ),
      
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.supervised_user_circle)),
            title: new Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new Profile(),
              ));
            },
          ),
          ListTile(
            title: new Text("Mes rapports"),
            leading: CircleAvatar(child: Icon(Icons.message)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new MesRapports(),
              ));
            },
          ),
          ListTile(
            title: new Text("Nouveau rapport"),
            leading: CircleAvatar(child: Icon(Icons.add)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new NvRapportId(),
              ));
            },
          ),
          ListTile(
            title: new Text("Tous Les Rapports"),
            leading: CircleAvatar(child: Icon(Icons.list)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, new MaterialPageRoute(
                builder: (context)=> new LesRapports(),
              ));
              
            },
          ),
                ListTile(
            title: new Text("Deconnection"),
            leading: CircleAvatar(child: Icon(Icons.close)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
             

            },
          )
        ],
      ),
    );
  }
}
