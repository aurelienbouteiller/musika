import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicManager extends StatelessWidget {
  MusicManager({Key key, @required this.audioUrl}) : super(key: key);

  AudioPlayer audioPlayer = AudioPlayer();
  final audioUrl;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        audioPlayer.play(audioUrl);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }
}
