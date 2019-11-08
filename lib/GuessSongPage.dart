import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musika/widget/ArtistWidget.dart';
import 'package:musika/widget/ChoiceWidget.dart';
import 'package:musika/widget/MusicManager.dart';
import 'package:musika/widget/ScoreWidget.dart';

import 'ApiDeezer.dart';
import 'model/Artist.dart';
import 'model/Track.dart';

class GuessSongPage extends StatefulWidget {
  final Artist artist;

  GuessSongPage({Key key, this.artist}) : super(key: key);

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
  bool isDisable = false;
  List<String> selectedTracksTitles;
  int selectedTitleIndex;
  int chosenTitleIndex;
  int audioPlayerPosition;
  bool isFinish = false;

  @override
  void initState() {
    super.initState();

    selectedTracks = List<Track>();
    audioPlayer = AudioPlayer();
    audioPlayerPosition = 0;
    audioPlayer.onPlayerStateChanged.listen(onAudioChangePlaying);
    audioPlayer.onAudioPositionChanged.listen((position) {
      if (this.mounted) {
        setState(() {
          audioPlayerPosition = position.inMilliseconds;
        });
      }
    });
    selectFourSongsOfTheArtist(widget.artist.id);
  }

  onAudioChangePlaying(AudioPlayerState playerEvent) {
    if (this.mounted) {
      setState(() {
        isDisable = true;
        audioPlaying = playerEvent == AudioPlayerState.PLAYING;
        isFinish = playerEvent == AudioPlayerState.STOPPED ||
            playerEvent == AudioPlayerState.COMPLETED;
      });
    }
  }

  selectFourSongsOfTheArtist(int artistId) async {
    if (this.mounted) {
      setState(() {
        loadingTrack = true;
      });
    }

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

    if (this.mounted) {
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

  onReplayPress() {
    answered = false;
    audioPlaying = false;
    isDisable = false;
    isFinish = false;
    selectFourSongsOfTheArtist(widget.artist.id);
  }

  @override
  Widget build(BuildContext context) {
    final FlareControls _controls = FlareControls();
    return Scaffold(
        body: SafeArea(
      child: Container(
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
        child: loadingTrack
            ? Center(
                child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ))
            : Column(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 40.0),
                                  child: FlareActor(
                                    "assets/gramophone.flr",
                                    alignment: Alignment.center,
                                    animation: "run",
                                    controller: _controls,
                                    isPaused: !audioPlaying,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: MusicManager(
                                onPress: onPlayButtonPress,
                                audioPlaying:
                                    audioPlaying && audioPlayerPosition > 0,
                                isDisable: isDisable,
                                isFinish: isFinish,
                                onReloadPress: onReplayPress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ArtistWidget(
                        artistName: selectedTrack?.artist?.name,
                        imageUrl:
                            "https://api.deezer.com/artist/${widget.artist.id}/image",
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
              ]),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.stop();
  }
}
