import 'package:flutter/material.dart';
import 'package:musika/widget/ArtistWidget.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musica',
      home: GuessSongPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class GuessSongPage extends StatelessWidget {
  GuessSongPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choix de la musique"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
              child: ArtistWidget(
            artistName: "RaelSan",
            imageUrl:
                "https://e-cdns-images.dzcdn.net/images/artist/640e021fabe66e4f866a18d3c1406689/500x500-000000-80-0-0.jpg",
          ))
        ],
      ),
    );
  }
}
