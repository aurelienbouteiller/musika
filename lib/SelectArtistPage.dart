import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musika/model/Artist.dart';

class SelectArtistPage extends StatefulWidget {
  SelectArtistPage({Key key, this.niveau}) : super(key: key);

  final String niveau;

  @override
  _SelectArtistPageState createState() => _SelectArtistPageState();
}

class _SelectArtistPageState extends State<SelectArtistPage> {
  List<Artist> artistes;

  @override
  void initState() {
    super.initState();

    artistes = [
      Artist(id: 1, name: "Parme San"),
      Artist(id: 2, name: "San Iter"),
      Artist(id: 3, name: "San Ex"),
      Artist(id: 4, name: "San étoi"),
      Artist(id: 5, name: "Ni San")
    ];
  }

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
              tag: widget.niveau,
              child: SizedBox(
                width: double.infinity,
                height: 125.0,
                child: Card(
                  elevation: 4.5,
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                        child: Text(widget.niveau),
                      )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: artistes.length,
                  itemBuilder: (context, index) {
                    return Card(
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
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          width: 1.0,
                                          color: Theme.of(context).dividerColor))),
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                  "https://api.deezer.com/artist/27/image",
                                ),
                              ),
                            ),
                            title: Text(artistes[index].name,
                                style: TextStyle(
                                    color: Theme.of(context).secondaryHeaderColor,
                                    fontWeight: FontWeight.bold)),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Theme.of(context).secondaryHeaderColor),
                            onTap: () {
                              print(artistes[index].name);
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
