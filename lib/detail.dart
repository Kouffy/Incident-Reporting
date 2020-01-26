import 'package:flutter/material.dart';
import 'package:gestion_inscidents/colors.dart';
import 'package:gestion_inscidents/modifier.dart';
import 'package:http/http.dart' as http;
import 'mes_rapports.dart';
import 'package:toast/toast.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "http://soufiixinc.com/incident/deletedata.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
    });
  }

  void confirmation() {
    AlertDialog alert = new AlertDialog(
      content: new Text(
          "Vous voulez vraiment supprimer '${widget.list[widget.index]['titre']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            "OUI SUPPRIMER",
            style: new TextStyle(color: Colors.black),
          ),
          color: potona,
          onPressed: () {
            try {
              deleteData();
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new MesRapports(),
              ));
            } catch (e) {
              Toast.show("Erreur de suppression", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          },
        ),
        new RaisedButton(
          child: new Text(
            "NON ANNULER",
            style: new TextStyle(color: Colors.black),
          ),
          color: potona,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['titre']}"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Card(
            child: new Center(
          child: new ListView(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: new Text(
                    " titre : ${widget.list[widget.index]['titre']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "type : ${widget.list[widget.index]['type']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "description : ${widget.list[widget.index]['description']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "date : ${widget.list[widget.index]['date']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "latitude : ${widget.list[widget.index]['latitude']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "longitude : ${widget.list[widget.index]['logitude']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  title: new Text(
                    "titre photo: ${widget.list[widget.index]['titrephoto']}",
                    style: new TextStyle(fontSize: 20.0, color: titlecolore),
                  ),
                ),
              ),
              Container(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("photo :\n", style: new TextStyle(color: titlecolore)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    width: 200.0,
                    child: Image.network(
                        'http://soufiixinc.com/incident/uploads/${widget.list[widget.index]['photo']}'),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 30.0),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RaisedButton(
                    child: new Text("Modifier"),
                    color: Colors.blueAccent,
                    onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Modifier(
                                  list: widget.list,
                                  index: widget.index,
                                )));
                                Navigator.pop(context);}
                  ),
                  Container(
                    width: 20.0,
                  ),
                  new RaisedButton(
                    child: new Text("Supprimer"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      confirmation();
                    },
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
