import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/User.dart';

class StatsPage extends StatefulWidget {
  final User user;

  StatsPage({Key key, this.user}) : super(key: key);

  @override
  _StatsPage createState() => _StatsPage();
}

class _StatsPage extends State<StatsPage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Mon profil", style: TextStyle(color: Colors.white))),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              flex: 1,
              child: Container(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 8.0,
                    color: Colors.transparent,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  widget.user.name ?? "Vincent Roquelaure",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                                child: Text(widget.user.email ?? "roquelaurevincent@gmail.com", style: TextStyle(color: Colors.black),)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Container(
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 8.0,
                    color: Colors.transparent,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  "Statistiques",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                                child: Text("Niveau 1 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 0.0),
                                child: Text("Niveau 2 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 0.0),
                                child: Text("Niveau 3 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 0.0),
                                child: Text("Niveau 4 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 0.0),
                                child: Text("Niveau 5 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                              Container(
                                margin: EdgeInsets.fromLTRB(15.0, 45.0, 0.0, 50.0),
                                child: Text("Niveau 6 :", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
