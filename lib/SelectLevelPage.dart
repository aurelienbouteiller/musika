import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/SelectArtistPage.dart';
import 'package:musika/StatsPage.dart';
import 'package:musika/model/Artist.dart';
import 'package:musika/style/theme.dart' as Themee;

import 'AuthenticationPage.dart';
import 'model/Artist.dart';
import 'model/Level.dart';
import 'model/Levels.dart';
import 'model/User.dart';

class SelectLevelPage extends StatefulWidget {
  final User user;

  SelectLevelPage({Key key, this.user}) : super(key: key);

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

  _showSnackLogin(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Veuillez vous connecter pour accéder à ce niveau !"),
      action: SnackBarAction(
        label: "Se connecter",
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AuthenticationPage()));
        },
      ),
    );
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
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
          Visibility(
            visible: widget.user.isConnected,
            child: IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 30,
              padding: EdgeInsets.only(right: 20),
              tooltip: 'Profil',
              onPressed: () {
                if (widget.user.isConnected) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatsPage()));
                }
              },
            ),
          ),
          //A DELETE (TESTS)
          Visibility(
            visible: widget.user.isConnected,
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              iconSize: 30,
              padding: EdgeInsets.only(right: 20),
              tooltip: 'Déconnexion',
              onPressed: () {
                if (widget.user.isConnected) {
                  FirebaseAuth.instance.signOut();
                  widget.user.isConnected = false;

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectLevelPage(
                                user: User(isConnected: false),
                              )),
                      (_) => false);
                }
              },
            ),
          ),
        ],
        title: Center(
            child: Text("Sélection du niveau",
                style: TextStyle(color: Colors.white))),
        backgroundColor: Themee.Colors.loginGradientStart,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Themee.Colors.loginGradientStart,
                  Themee.Colors.loginGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: FutureBuilder(
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
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        (index > 2 && !widget.user.isConnected)
                                            ? Colors.white70
                                            : Colors.white),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  title: Text("Niveau $levelId",
                                      style: TextStyle(
                                          foreground: Paint()
                                            ..shader =
                                                Themee.Colors.linearGradient,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  trailing: Icon(
                                      (index > 2 && !widget.user.isConnected)
                                          ? Icons.lock
                                          : Icons.keyboard_arrow_right,
                                      color: Themee.Colors.loginGradientEnd),
                                  onTap: () {
                                    (index > 2 && !widget.user.isConnected)
                                        ? _showSnackLogin(context)
                                        : navigateToArtistPage(context, level);
                                  },
                                  subtitle: Visibility(
                                    visible: !(index > 2 &&
                                        !widget.user.isConnected),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.linear_scale,
                                            color: Themee
                                                .Colors.loginGradientStart),
                                        Text("0/5 artistes trouvés",
                                            style: TextStyle(
                                                foreground: Paint()
                                                  ..shader = Themee
                                                      .Colors.linearGradient))
                                      ],
                                    ),
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
          ),
        ),
      ),
    );
  }
}
