import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/SelectArtistPage.dart';
import 'package:musika/StatsPage.dart';
import 'package:musika/model/Artist.dart';

import 'model/Artist.dart';
import 'model/Levels.dart';

class SelectLevelPage extends StatefulWidget {
  SelectLevelPage({Key key}) : super(key: key);

  @override
  _SelectLevelPageState createState() => _SelectLevelPageState();
}

class _SelectLevelPageState extends State<SelectLevelPage> {
  Levels levels;

  @override
  void initState() {
    super.initState();
    levels = Levels();
  }

  Future<Levels> fetchLevels() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{'levels': []};
    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();
    var levelsJson = remoteConfig.getString('levels');
    var levels = json.decode(levelsJson);

    List<Level> levelsData = List();

    levels.forEach((level) {
      var levelId = level['id'];
      var levelArtistJson = remoteConfig.getString("level_$levelId");
      var levelArtist = json.decode(levelArtistJson);
      List<Artist> artistList = List();
      levelArtist.forEach((artist) {
        int artistId = int.parse(artist['artistId']);
        var artistToAdd = Artist(id: artistId, name: artist['name']);
        artistList.add(artistToAdd);
      });
      levelsData.add(Level(id: levelId, artistList: artistList));
    });

    Levels levelsToAdd = Levels();
    levelsToAdd.levels = levelsData;

    return levelsToAdd;
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle),
              color: Colors.blue,
              iconSize: 40,
              tooltip: 'Show Snackbar',
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatsPage()));
              },
            ),
          ],
          title: Text("Sélection du niveau",
              style: TextStyle(color: Theme.of(context).accentColor)),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
          future: fetchLevels(),
          builder: (BuildContext context, AsyncSnapshot<Levels> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: Text('Chargement des niveaux'));
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                var levels = snapshot.data.levels;
                return ListView.builder(
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                title: Text("Niveau $levelId",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .secondaryHeaderColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                                onTap: () {
                                  navigateToArtistPage(context, level);
                                },
                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Theme.of(context).accentColor),
                                    Text("0/5 artistes trouvés",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
            }
            return null;
          },
        ));
  }
}
