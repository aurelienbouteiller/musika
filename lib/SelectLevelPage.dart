import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/SelectArtistPage.dart';
import 'package:musika/model/Artist.dart';

import 'Level.dart';

class SelectLevelPage extends StatefulWidget {
  SelectLevelPage({Key key}) : super(key: key);

  @override
  _SelectLevelPageState createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  List<Level> levels;

  @override
  void initState() {
    super.initState();
    levels = List();

    List<Artist> firstLevelArtistList = List.from([
      Artist(id: 259467, name: "Orelsan"),
      Artist(id: 1412564, name: "Nekfeu"),
      Artist(id: 5175734, name: "Vald"),
      Artist(id: 9197980, name: "Damso"),
      Artist(id: 1519461, name: "PNL"),
    ]);
    levels.add(Level(id: 1, artistList: firstLevelArtistList));

    List<Artist> secondLevelArtistList = List.from([
      Artist(id: 412, name: "Queen"),
      Artist(id: 1, name: "The Beatles"),
      Artist(id: 892, name: "Coldplay"),
      Artist(id: 47, name: "Indochine"),
      Artist(id: 11, name: "The Rolling Stones"),
    ]);
    levels.add(Level(id: 2, artistList: secondLevelArtistList));

    List<Artist> thirdLevelArtistList = List.from([
      Artist(id: 542, name: "David Guetta"),
      Artist(id: 482758, name: "DJ Snake"),
      Artist(id: 12178, name: "Calvin Harris"),
      Artist(id: 293585, name: "Avicii"),
      Artist(id: 3968561, name: "Martin Garrix"),
    ]);
    levels.add(Level(id: 3, artistList: thirdLevelArtistList));

    List<Artist> fourthLevelArtistList = List.from([
      Artist(id: 4803754, name: "Dadju"),
      Artist(id: 8909272, name: "Aya Nakamura"),
      Artist(id: 4050205, name: "The Weeknd"),
      Artist(id: 228, name: "Alicia Keys"),
      Artist(id: 102, name: "Chris Brown"),
    ]);
    levels.add(Level(id: 4, artistList: fourthLevelArtistList));

    List<Artist> fifthLevelArtistList = List.from([
      Artist(id: 282118, name: "Major Lazer"),
      Artist(id: 5283366, name: "The Avener"),
      Artist(id: 7912872, name: "Petit Biscuit"),
      Artist(id: 6032634, name: "Ofenbach"),
      Artist(id: 262271, name: "Dimitri Vegas & Like Mike"),
    ]);
    levels.add(Level(id: 5, artistList: fifthLevelArtistList));

    List<Artist> sixthLevelArtistList = List.from([
      Artist(id: 1120, name: "Jean-Jacques Goldman"),
      Artist(id: 358, name: "Mylène Farmer"),
      Artist(id: 13314683, name: "Bon Entendeur"),
      Artist(id: 15887, name: "Julien Doré"),
      Artist(id: 457, name: "Tryo"),
    ]);
    levels.add(Level(id: 6, artistList: sixthLevelArtistList));
  }

  navigateToArtistPage(BuildContext context, Level level) {
    Navigator.of(context).push(
      PageRouteBuilder<SelectArtistPage>(
        transitionDuration: Duration(milliseconds: 600),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return SelectArtistPage(level: level);
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

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          title: Text("Sélection du niveau",
              style: TextStyle(color: Theme.of(context).accentColor)),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) {
              var level = levels.elementAt(index);
              var levelId = levels[index].id;

              return Hero(
                tag: levelId,
                flightShuttleBuilder: _flightShuttleBuilder,
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
                        title: Text("Niveau $levelId",
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        trailing: Icon(Icons.keyboard_arrow_right,
                            color: Theme.of(context).secondaryHeaderColor),
                        onTap: () {
                          navigateToArtistPage(context, level);
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
