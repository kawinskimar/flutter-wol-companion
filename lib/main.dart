import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'dart:convert';

const JsonCodec json = const JsonCodec();

void main() {
  runApp(new MaterialApp(
    theme: new ThemeData(
        primarySwatch: Colors.deepOrange, backgroundColor: Colors.white30),
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List arcana, outfits, relics;

  Future<String> _loadArcana() async {
    return await rootBundle.loadString('assets/data/arcana.json');
  }

  Future<String> _loadOutfits() async {
    return await rootBundle.loadString('assets/data/outfits.json');
  }

  Future<String> _loadRelics() async {
    return await rootBundle.loadString('assets/data/relics.json');
  }

  Future loadData() async {
    String ar = await _loadArcana();
    String out = await _loadOutfits();
    String rel = await _loadRelics();

    this.setState(() {
      arcana = json.decode(ar);
      outfits = json.decode(out);
      relics = json.decode(rel);
    });
  }

  @override
  void initState() {
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "Arcana"),
                  Tab(text: "Outfits"),
                  Tab(text: "Relics"),
                ],
              ),
              title: Text('Wizard of Legend Companion'),
            ),
            body: TabBarView(children: [
              new ListView.builder(
                  itemCount: arcana == null ? 0 : arcana.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                        margin: EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(arcana[index]['name'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrangeAccent)),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(arcana[index]['effect'])),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      "Enhanced: ${arcana[index]['enhanced']}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      "Slot: ${arcana[index]['slot']} | Type: ${arcana[index]['type']}",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic)))
                            ]));
                  }),
              new ListView.builder(
                  itemCount: outfits == null ? 0 : outfits.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(outfits[index]['name'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrangeAccent)),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(outfits[index]['effects'])),
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 5.0),
                                  child: outfits[index]['notes'] == ""
                                      ? null
                                      : Text(outfits[index]['notes'],
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)))
                            ]));
                  }),
              new ListView.builder(
                  itemCount: relics == null ? 0 : relics.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                        color: Colors.white,
                        margin: EdgeInsets.all(3.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text(relics[index]['name'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.deepOrangeAccent)),
                              ),
                              Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(relics[index]['effect'])),
                              Container(
                                  padding:
                                      EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 5.0),
                                  child: Text(relics[index]['type'],
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic)))
                            ]));
                  })
            ])));
  }
}
