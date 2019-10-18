import 'package:flutter/material.dart';

import 'ColorfulProgressBar.dart';

class MusicManager extends StatefulWidget {
  final bool audioPlaying;
  final Function onPress;
  final bool answered;

  MusicManager(
      {Key key,
      @required this.onPress,
      @required this.audioPlaying,
      @required this.answered})
      : super(key: key);

  @override
  _MusicManagerState createState() => _MusicManagerState();
}

class _MusicManagerState extends State<MusicManager> {
  onPress() {
    widget.onPress();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ColorfulProgressBar(
          animating: widget.audioPlaying,
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
        widget.audioPlaying || widget.answered
            ? Container()
            : FlatButton(
                onPressed: onPress,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Container(
                    color: Color(0xFF9F7E69),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.play_arrow,
                        color: Color(0xFFF2efc7),
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
