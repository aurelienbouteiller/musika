import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/ApiDeezer.dart';
import 'package:musika/SelectArtistPage.dart';
import 'package:musika/SelectLevelPage.dart';
import 'package:musika/widget/ArtistWidget.dart';
import 'package:musika/widget/ChoiceWidget.dart';
import 'package:musika/widget/MusicManager.dart';
import 'package:musika/widget/ScoreWidget.dart';

import 'model/Track.dart';

void main() => runApp(MusikaApp());

class MusikaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

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
  bool audioPlaying = false;
  List<String> selectedTracksTitles;
  int selectedTitleIndex;
  int chosenTitleIndex;
  int audioPlayerPosition;

  @override
  void initState() {
    super.initState();

    selectedTracks = List<Track>();
    audioPlayer = AudioPlayer();
    audioPlayerPosition = 0;
    audioPlayer.onPlayerStateChanged.listen(onAudioChangePlaying);
    audioPlayer.onAudioPositionChanged.listen((position) => setState(() {
          audioPlayerPosition = position.inMilliseconds;
        }));
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

  onChoicePress(chosenTitle) async {
    if (!audioPlaying) {
      return;
    }
    var position = await audioPlayer.getCurrentPosition();
    audioPlayer.stop();

    var isGoodAnswer = chosenTitle == selectedTrack.title;
    chosenTitleIndex =
        selectedTracksTitles.indexWhere((title) => chosenTitle == title);
    var content =
        isGoodAnswer ? "assets/succes-check.flr" : "assets/error-check.flr";
    var score =
        isGoodAnswer ? position < 20000 ? position < 10000 ? 30 : 20 : 10 : 0;

    setState(() {
      answered = true;
    });

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          ScoreWidget(flareAnimationFile: content, score: score),
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
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              elevation: 5,
                              color: Theme.of(context).primaryColor,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: FlareActor(
                                          "assets/gramophone.flr",
                                          alignment: Alignment.center,
                                          animation: "run",
                                          controller: _controls,
                                          isPaused: !audioPlaying,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: MusicManager(
                                          onPress: onPlayButtonPress,
                                          audioPlaying: audioPlaying &&
                                              audioPlayerPosition > 0,
                                          answered: answered,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                    ),
                    Expanded(
                      flex: 1,
                      child: ChoiceWidget(
                          titles: selectedTracksTitles,
                          selectedTitleIndex: selectedTitleIndex,
                          chosenTitleIndex: chosenTitleIndex,
                          onPress: onChoicePress,
                          answered: answered,
                          disabled: !audioPlaying && !answered),
                    )
                  ]));
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }
}
