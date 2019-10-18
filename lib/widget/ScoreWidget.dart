import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatefulWidget {

  final flareAnimationFile;
  final score;

  ScoreWidget({this.flareAnimationFile, this.score});

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 250,
          width: 250,
          child: FlareActor(
            widget.flareAnimationFile,
            alignment: Alignment.center,
            fit: BoxFit.cover,
            animation: "Untitled",
            controller: FlareControls(),
          )),
      Dialog(
        backgroundColor: Colors.transparent,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 250),
            style: TextStyle(
              color: Colors.white,
              fontSize: _animation.value.toDouble(),
              fontWeight: FontWeight.bold,
            ),
            child: Text("+${widget.score}"),
          ),
        ),
      )
    ]);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _animation = _controller.drive(Tween(
      begin: 0,
      end: 40,
    ))..addListener((){
      setState(() {

      });
    });
    _controller.forward();
  }
}
