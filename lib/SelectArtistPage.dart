import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GuessSongPage.dart';
import 'StatsPage.dart';
import 'model/Artist.dart';
import 'model/Level.dart';
import 'model/User.dart';

class SelectArtistPage extends StatefulWidget {
  final User user;

  SelectArtistPage({Key key, this.level, this.user}) : super(key: key);

  final Level level;

  @override
  _SelectArtistPageState createState() => _SelectArtistPageState();
}

class _SelectArtistPageState extends State<SelectArtistPage> {
  @override
  Widget build(BuildContext context) {
    Rect rectForShader = Rect.fromLTWH(0.0, 0.0, 300.0, 70.0);
    Shader linearGradientShader = LinearGradient(colors: [
      Theme.of(context).primaryColor,
      Theme.of(context).accentColor
    ]).createShader(rectForShader);

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Visibility(
              visible: widget.user.isConnected,
              child: IconButton(
                icon: const Icon(Icons.account_circle),
                iconSize: 40,
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StatsPage()));
                },
              ),
            ),
          ],
          title: Center(
            child: Text("Sélection de l'artiste",
                style: TextStyle(color: Colors.white)),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor
                ],
                begin: FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Hero(
                  tag: widget.level.id,
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        "Niveau ${widget.level.id}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          foreground: Paint()..shader = linearGradientShader,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                  },
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.level.artistList.length,
                      itemBuilder: (context, index) {
                        Artist currentArtist =
                            widget.level.artistList.elementAt(index);

                        return Card(
                          elevation: 4.5,
                          color: Colors.transparent,
                          margin: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Theme.of(context)
                                                  .dividerColor))),
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    backgroundImage: NetworkImage(
                                      "https://api.deezer.com/artist/${currentArtist.id}/image",
                                    ),
                                  ),
                                ),
                                title: Text(currentArtist.name,
                                    style: TextStyle(
                                        foreground: Paint()
                                          ..shader = linearGradientShader,
                                        fontWeight: FontWeight.w600)),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Theme.of(context).accentColor),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => GuessSongPage(
                                            artist: currentArtist,
                                          )));
                                },
                                subtitle: Row(
                                  children: <Widget>[
                                    Icon(Icons.linear_scale,
                                        color: Theme.of(context).primaryColor),
                                    Text(" 0/5 musiques trouvées",
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..shader = linearGradientShader,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
