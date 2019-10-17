import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/ApiDeezer.dart';
import 'package:musika/SelectLevelPage.dart';
import 'package:musika/widget/ArtistWidget.dart';
import 'package:musika/widget/ChoiceWidget.dart';
import 'package:musika/widget/ColorfulProgressBar.dart';
import 'package:musika/widget/MusicManager.dart';

import 'model/Track.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new SelectLevelPage(),
      theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFfdcb6e),
          backgroundColor: Color(0xFFdfe6e9),
          accentColor: Color(0xFFe17055),
          dividerColor: Color(0xFFdfe6e9),
          secondaryHeaderColor: Colors.white),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF3a4750),
          backgroundColor: Colors.black,
          accentColor: Color(0xFFe17055),
          dividerColor: Colors.white30,
          secondaryHeaderColor: Colors.white70),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GuessSongPage extends StatefulWidget {
  GuessSongPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GuessSongPageState createState() => _GuessSongPageState();
}

class _GuessSongPageState extends State<GuessSongPage> {
  List<Track> selectedTracks;
  Track selectedTrack;
  bool loadingTrack = false;
  AudioPlayer audioPlayer;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    selectedTracks = List<Track>();
    audioPlayer = AudioPlayer();
    selectFourSongsOfTheArtist(259467);
  }

  selectFourSongsOfTheArtist(int artistId) async {
    setState(() {
      loadingTrack = true;
    });
    var data = await ApiDeezer.getTopMusicByArtisteId(artistId);
    List<dynamic> body = json.decode(data.body)['data'];
    var tracks = body.map((t) => Track.fromJson(t)).toList();

    tracks.removeWhere((track) => track.artist.id != artistId);

    var random = Random();
    tracks.shuffle(random);
    var randomTracks = List<Track>();

    for (var index = 0; index < 4; index++) {
      var randomTrack = tracks.elementAt(random.nextInt(tracks.length));
      if (randomTracks
          .where((track) => track.titleShort == randomTrack.titleShort)
          .isNotEmpty) {
        index--;
        continue;
      }
      randomTracks.add(randomTrack);
    }
    setState(() {
      selectedTracks = randomTracks;
      selectedTrack = randomTracks.elementAt(random.nextInt(4));
      loadingTrack = false;
    });
  }

  onChoicePress(chosenTitle) {
    audioPlayer.stop();
    var isGoodAnswer = chosenTitle == selectedTrack.title;
    var title = isGoodAnswer ? "Bonne réponse" : "Mauvaise réposne";
    var content = isGoodAnswer
        ? "Bravo ! C'était bien: '${selectedTrack.title}'"
        : "Dommage ! Il s'agissait de: '${selectedTrack.title}'";

    setState(() {
      answered = true;
    });
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var titles = selectedTracks.map((track) => track.title).toList();
    final FlareControls _controls = FlareControls();
    initState() {
      _controls.play("run");
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Choix de la musique"),
        ),
        body: loadingTrack
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          alignment: Alignment.center,
                          width: 155,
                          height: 155,
                          child: FlareActor("assets/gramophone.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              animation: "run",
                              controller: _controls),
                        ),
                        ArtistWidget(
                          artistName: selectedTrack?.artist?.name,
                          imageUrl:
                              "https://e-cdns-images.dzcdn.net/images/artist/640e021fabe66e4f866a18d3c1406689/500x500-000000-80-0-0.jpg",
                        ),
                      ],
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
                        audioPlayer: audioPlayer,
                        audioUrl: selectedTrack.preview),
                    ChoiceWidget(
                        titles: titles,
                        onPress: onChoicePress,
                        disabled: answered)
                  ]));
  }
}
