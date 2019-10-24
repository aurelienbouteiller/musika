import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/SelectArtistPage.dart';
import 'package:musika/model/Artist.dart';

class SelectLevelPage extends StatefulWidget {
  SelectLevelPage({Key key}) : super(key: key);

  @override
  _SelectLevelPageState createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  List<String> niveaux;

  @override
  void initState() {
    super.initState();

    niveaux = ["Niveau 1", "Niveau 2", "Niveau  3", "Niveau 4", "Niveau 5"];
  }

  _navigateToArtistPage(BuildContext context, String niveau) {
    Navigator.of(context).push(
      PageRouteBuilder<SelectArtistPage>(
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          ) {
          return SelectArtistPage(niveau: niveau);
        },
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection du niveau",
          style: TextStyle(color: Theme.of(context).accentColor)),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
        itemCount: niveaux.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: niveaux[index],
            child: Card(
              elevation: 4.5,
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  decoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                    title: Text(niveaux[index],
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.keyboard_arrow_right,
                      color: Theme.of(context).secondaryHeaderColor),
                    onTap: () {
                      _navigateToArtistPage(context, niveaux[index]);
                    },
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale,
                          color: Theme.of(context).accentColor),
                        Text("0/5 artistes trouvés",
                          style: TextStyle(
                            color: Theme.of(context).accentColor))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
