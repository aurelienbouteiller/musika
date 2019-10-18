import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/ApiDeezer.dart';
import 'package:musika/widget/ArtistWidget.dart';
import 'package:musika/widget/ChoiceWidget.dart';
import 'package:musika/widget/MusicManager.dart';

import 'model/Track.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new GuessSongPage(),
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
  bool audioPlaying = false;
  List<String> selectedTracksTitles;
  int selectedTitleIndex;
  int chosenTitleIndex;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    selectedTracks = List<Track>();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen(onAudioChangePlaying);
    selectFourSongsOfTheArtist(259467);
  }

  onAudioChangePlaying(AudioPlayerState playerEvent) {
    setState(() {
      audioPlaying = playerEvent == AudioPlayerState.PLAYING;
    });
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
      selectedTracksTitles =
          selectedTracks.map((track) => track.title).toList();
      selectedTrack = randomTracks.elementAt(random.nextInt(4));
      selectedTitleIndex = selectedTracksTitles
          .indexWhere((title) => selectedTrack.title == title);
      loadingTrack = false;
    });
  }

  onChoicePress(chosenTitle) {
    if (!audioPlaying) {
      return;
    }

    audioPlayer.stop();
    var isGoodAnswer = chosenTitle == selectedTrack.title;
    chosenTitleIndex =
        selectedTracksTitles.indexWhere((title) => chosenTitle == title);
    var content =
        isGoodAnswer ? "assets/succes-check.flr" : "assets/error-check.flr";

    setState(() {
      answered = true;
    });
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Stack(alignment: Alignment.center, children: [
        Container(
          height: 250,
          width: 250,
          child: FlareActor(content,
              alignment: Alignment.center,
              fit: BoxFit.cover,
              animation: "Untitled",
              controller: FlareControls()),
        ),
      ]),
    );

    Future.delayed(
        Duration(
          seconds: 4,
        ),
        () => Navigator.pop(context));
  }

  onPlayButtonPress() {
    audioPlayer.play(selectedTrack?.preview);
  }

  @override
  Widget build(BuildContext context) {
    final FlareControls _controls = FlareControls();

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
                        Positioned(
                          right: 75,
                          child: Container(
                            margin: EdgeInsets.only(left: 40),
                            alignment: Alignment.center,
                            width: 150,
                            height: 150,
                            child: FlareActor(
                              "assets/gramophone.flr",
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              animation: "run",
                              controller: _controls,
                              isPaused: !audioPlaying,
                            ),
                          ),
                        ),
                        ArtistWidget(
                          artistName: selectedTrack?.artist?.name,
                          imageUrl:
                              "https://e-cdns-images.dzcdn.net/images/artist/640e021fabe66e4f866a18d3c1406689/500x500-000000-80-0-0.jpg",
                        ),
                      ],
                    ),
                    MusicManager(
                      onPress: onPlayButtonPress,
                      audioPlaying: audioPlaying,
                      answered: answered,
                    ),
                    ChoiceWidget(
                        titles: selectedTracksTitles,
                        selectedTitleIndex: selectedTitleIndex,
                        chosenTitleIndex: chosenTitleIndex,
                        onPress: onChoicePress,
                        answered: answered,
                        disabled: !audioPlaying && !answered)
                  ]));
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }
}
