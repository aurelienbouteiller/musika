import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/main.dart';

import 'Level.dart';
import 'model/Artist.dart';

class SelectArtistPage extends StatefulWidget {
  SelectArtistPage({Key key, this.level}) : super(key: key);

  final Level level;

  @override
  _SelectArtistPageState createState() => _SelectArtistPageState();
}

class _SelectArtistPageState extends State<SelectArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sélection de l'artiste",
              style: TextStyle(color: Theme.of(context).accentColor)),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: <Widget>[
            Hero(
              tag: widget.level.id,
              child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "Niveau ${widget.level.id}",
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.level.artistList.length,
                  itemBuilder: (context, index) {
                    Artist currentArtist =
                        widget.level.artistList.elementAt(index);

                    return Card(
                      elevation: 4.5,
                      color: Colors.transparent,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1.0,
                                          color:
                                              Theme.of(context).dividerColor))),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                  "https://api.deezer.com/artist/${currentArtist.id}/image",
                                ),
                              ),
                            ),
                            title: Text(currentArtist.name,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Theme.of(context).secondaryHeaderColor),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GuessSongPage(
                                        artist: currentArtist,
                                      )));
                            },
                            subtitle: Row(
                              children: <Widget>[
                                Icon(Icons.linear_scale,
                                    color: Theme.of(context).accentColor),
                                Text(" 0/5",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
