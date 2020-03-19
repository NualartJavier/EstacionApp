import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espacios Disponibles'),
      ),
      body: Container(
          child: Table(children: [
        TableRow(children: [
          Card(
              child: Container(
                height: 100,
                child: Center(child: Text('1'),),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('2'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('3'),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('4'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('5'),
              ),
              color: Colors.red),
        ]),
        TableRow(children: [
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
        ]),TableRow(children: [
          Card(
              child: Container(
                height: 100,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 100,
                child: Text('6'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('7'),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('8'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('9'),
              ),
              color: Colors.red),
        ]),TableRow(children: [
          Card(
              child: Container(
                height: 100,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 100,
                child: Text('10'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('11'),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('12'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('13'),
              ),
              color: Colors.red),
        ]),TableRow(children: [
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
          Card(
              child: Container(
                height: 50,
              ),
              color: Colors.white),
        ]),TableRow(children: [
          Card(
              child: Container(
                height: 100,
                child: Text('14'),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('15'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('16'),
              ),
              color: Colors.red),
          Card(
              child: Container(
                height: 100,
                child: Text('17'),
              ),
              color: Colors.green),
          Card(
              child: Container(
                height: 100,
                child: Text('18'),
              ),
              color: Colors.red),
        ])
      ])),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Marker> allMarkers = [];

  String inputaddr = '';

  addToList() async {
    final query = inputaddr;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    Firestore.instance.collection('markers').add({
      'coords':
          new GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
      'place': first.featureName
    });
  }

  Future addMarker() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new Text(
              'Add Marker',
              style: new TextStyle(fontSize: 17.0),
            ),
            children: <Widget>[
              new TextField(
                onChanged: (String enteredLoc) {
                  setState(() {
                    inputaddr = enteredLoc;
                  });
                },
              ),
              new SimpleDialogOption(
                child: new Text('Add It',
                    style: new TextStyle(color: Colors.blue)),
                onPressed: () {
                  addToList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget loadMap() {
    return StreamBuilder(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading maps.. Please Wait');
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          allMarkers.add(new Marker(
              width: 45.0,
              height: 45.0,
              point: new LatLng(snapshot.data.documents[i]['location'].latitude,
                  snapshot.data.documents[i]['location'].longitude),
              builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print("funciona");
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Container(
                              margin: EdgeInsets.all(20),
                              color: Colors.white,
                              child: new Center(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text('1625 Main Street',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      subtitle:
                                          Text('Nombre de estacionamiento'),
                                      leading: Icon(
                                        Icons.directions_car,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('(408) 555-1212',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                      subtitle: Text('Contacto'),
                                      leading: Icon(
                                        Icons.contact_phone,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title: Text('450 x Hora'),
                                      leading: Icon(
                                        Icons.attach_money,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    ListTile(
                                      title:
                                          Text('Lunes a Viernes: 7:00 - 21:00'),
                                      leading: Icon(
                                        Icons.calendar_today,
                                        color: Colors.blue[500],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () {},
                                          child: Text('5/10'),
                                          color: Colors.blueGrey[100],
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyApp2()));
                                          },
                                          child: Text('Ver espacios'),
                                          color: Colors.greenAccent,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        // builder:
                        // (context) => new Container(
                        //       height: 210,
                        //       width: context,
                        //       child: Card(
                        //         child: Column(
                        //           children: [
                        //             ListTile(
                        //               title: Text('1625 Main Street',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.w500)),
                        //               subtitle: Text('My City, CA 99984'),
                        //               leading: Icon(
                        //                 Icons.restaurant_menu,
                        //                 color: Colors.blue[500],
                        //               ),
                        //             ),
                        //             Divider(),
                        //             ListTile(
                        //               title: Text('(408) 555-1212',
                        //                   style: TextStyle(
                        //                       fontWeight: FontWeight.w500)),
                        //               leading: Icon(
                        //                 Icons.contact_phone,
                        //                 color: Colors.blue[500],
                        //               ),
                        //             ),
                        //             ListTile(
                        //               title: Text('costa@example.com'),
                        //               leading: Icon(
                        //                 Icons.contact_mail,
                        //                 color: Colors.blue[500],
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     );
                      },
                    ),
                  )));
        }
        return new FlutterMap(
            options: new MapOptions(
                center: new LatLng(-38.7395242, -72.5901137), zoom: 13.0),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(markers: allMarkers)
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('EstacionApp'),
          leading: new IconButton(
            icon: Icon(Icons.add),
            onPressed: addMarker,
          ),
          centerTitle: true,
        ),
        body: loadMap());
  }
}
