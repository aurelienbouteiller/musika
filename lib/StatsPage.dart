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
      body: Column(
        children: <Widget>[
          Text(widget.user.uid),
          Text(widget.user.isConnected.toString()),
          Text(widget.user.name),
        ],
      ),
    );
  }
}
