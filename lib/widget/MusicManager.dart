import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicManager extends StatefulWidget {
  final audioUrl;
  final AudioPlayer audioPlayer;

  MusicManager({Key key, @required this.audioUrl, this.audioPlayer})
      : super(key: key);

  @override
  _MusicManagerState createState() => _MusicManagerState();
}

class _MusicManagerState extends State<MusicManager> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        widget.audioPlayer.play(widget.audioUrl);
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

  @override
  void dispose() {
    super.dispose();
    widget.audioPlayer.stop();
  }
}
