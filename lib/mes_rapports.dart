import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestion_inscidents/nv_rapportid.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import './Detail.dart';
import 'main.dart';
import 'colors.dart';

class MesRapports extends StatefulWidget {
  MesRapports({this.idd});
  final String idd;
  @override
  _MesRapportsState createState() => _MesRapportsState();
}

class _MesRapportsState extends State<MesRapports> {
  Future<List> getData() async {
    final response = await http
        .post("http://soufiixinc.com/incident/getdata.php", body: {"id": idd});

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    try{
      getData();
    }catch(e){
      Toast.show('une erreur s\'est produite ', context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: back,
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: 40.0,
            ),
            Image.asset(
              'assets/ic.png',
              width: 50.0,
              height: 50.0,
            ),
            Container(
              width: 5.0,
            ),
            new Text("Vos Rapports"),
          ],
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          backgroundColor: appbarvolor,
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new NvRapportId()));
          }),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Detail(
                      list: list,
                      index: i,
                    ))),
            child: Card(
              child: new ListTile(
                title: new Text(list[i]['titre']),
                leading: list[i]['type'] == "routes"
                    ? CircleAvatar(
                        backgroundImage: new AssetImage('assets/tri9.png'),
                        backgroundColor: Colors.white,
                      )
                    : list[i]['type'] == "canaux egout"
                        ? CircleAvatar(
                            backgroundImage: new AssetImage('assets/9ados.png'),
                            backgroundColor: Colors.white,
                          )
                        : list[i]['type'] == "eclairage"
                            ? CircleAvatar(
                                backgroundImage:
                                    new AssetImage('assets/do.png'),
                                backgroundColor: Colors.white,
                              )
                            : list[i]['type'] == "environnement"
                                ? CircleAvatar(
                                    backgroundImage:
                                        new AssetImage('assets/env.png'),
                                    backgroundColor: Colors.white,
                                  )
                                : list[i]['type'] == "ordures"
                                    ? CircleAvatar(
                                        backgroundImage:
                                            new AssetImage('assets/zbel.png'),
                                        backgroundColor: Colors.white,
                                      )
                                    : Icon(Icons.error),
                subtitle: new Text("Le : ${list[i]['date']}"),
                onLongPress: () {
                  AlertDialog a = new AlertDialog(
                    
                    content: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            height: 200.0,
                            child: Image.network(
                                'http://soufiixinc.com/incident/uploads/${list[i]['photo']}'),
                          ),
                          Card(
                              child: Column(
                            children: <Widget>[
                              Text("type : " + list[i]['type'].toString()),
                              Text(" titre : " + list[i]['titre'].toString()),
                              Text("description : " +
                                  list[i]['description'].toString()),
                              Text("date : " + list[i]['date'].toString()),
                              Text("titre photo:" +
                                  list[i]['titrephoto'].toString()),
                              Text("latitude : " +
                                  list[i]['latitude'].toString()),
                              Text("longitude : " +
                                  list[i]['longitude'].toString()),
                            ],
                          )),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      RaisedButton(
                        child: new Text(
                          "Retour",
                          style: new TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/mes_rapports');
                        },
                      ),
                      RaisedButton(
                        child: new Text("Consulter",
                            style: new TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) => new Detail(
                                    list: list,
                                    index: i,
                                  )));
                        },
                      )
                    ],
                    
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return a;
                    },
                  );
                },
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )));
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
