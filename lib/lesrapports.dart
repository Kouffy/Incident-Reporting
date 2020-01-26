import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestion_inscidents/nv_rapportid.dart';
import 'package:http/http.dart' as http;
import './Detail.dart';
import 'colors.dart';

class LesRapports extends StatefulWidget {
  LesRapports({this.idd});
  final String idd;
  @override
  _LesRapportsState createState() => _LesRapportsState();
}

class _LesRapportsState extends State<LesRapports> {
  Future<List> getData() async {
    final response = await http
        .post("http://soufiixinc.com/incident/getdataall.php");

    return jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: back,
      appBar: new AppBar(
        title: Row(
          children: <Widget>[
            Container(
              width: 20.0,
            ),
            Image.asset(
              'assets/ic.png',
              width: 50.0,
              height: 50.0,
            ),
            Container(
              width: 5.0,
            ),
            new Text("Tous Les Rapports"),
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
     
  child: ListTile(
      title: Card(child: Image.network('http://soufiixinc.com/incident/uploads/${list[i]['photo']}',fit: BoxFit.fill,), shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),),
  
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
                subtitle: new Text("   ${list[i]['titre']}\n   Le :${list[i]['date']}",style: new TextStyle(fontSize: 20.0),),
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
        );
      },
    );
  }
}
