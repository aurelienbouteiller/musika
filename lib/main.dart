import 'package:flutter/material.dart';
import 'package:musika/widget/ArtistWidget.dart';
import 'package:musika/widget/ChoiceWidget.dart';
import 'package:musika/widget/ColorfulProgressBar.dart';
import 'package:musika/widget/MusicManager.dart';
import 'package:musika/widget/ColorfulProgressBarPainter.dart';

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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                ArtistWidget(
                  artistName: "RaelSan",
                  imageUrl:
                      "https://e-cdns-images.dzcdn.net/images/artist/640e021fabe66e4f866a18d3c1406689/500x500-000000-80-0-0.jpg",
                ),
                ColorfulProgressBar(
                  height: 25,
                  width: 300,
                  animationDuration: Duration(seconds: 30),
                  fillColor: [
                    Colors.green,
                    Colors.green,
                    Colors.yellow,
                    Colors.yellow,
                    Colors.red,
                    Colors.red,
                  ],
                  backgroundColor: Colors.transparent,
                ),
                MusicManager(
                  audioUrl:
                      "https://cdns-preview-c.dzcdn.net/stream/c-c02789a7c21f84abe275eb354d292505-4.mp3",
                ),
                ChoiceWidget(
                  titles: ["Choix 1", "Choix 2", "Choix 3", "Choix 4"],
                )
              ]))
        ],
      ),
    );
  }
}
