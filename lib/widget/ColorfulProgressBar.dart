import 'package:flutter/material.dart';
import 'package:musika/widget/ColorfulProgressBarPainter.dart';

// ignore: must_be_immutable
class ColorfulProgressBar extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  List<MaterialColor> fillColor;
  final Duration animationDuration;
  final bool animating;

  ColorfulProgressBar({
    Key key,
    this.animating,
    this.backgroundColor,
    this.animationDuration,
    this.fillColor,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  @override
  _ColorfulProgressBarState createState() => _ColorfulProgressBarState();
}

class _ColorfulProgressBarState extends State<ColorfulProgressBar>
    with TickerProviderStateMixin {
  AnimationController _controller;
  bool init;

  String get timerString {
    Duration duration = _controller.duration * _controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    init = true;

    _controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(seconds: 30),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(ColorfulProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    init = false;
    if (oldWidget.animating == false && widget.animating) {
      _controller.forward();
    } else if (oldWidget.animating == true && widget.animating == false) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = this.widget.width;
    final height = this.widget.height;
    final backgroundColor = this.widget.backgroundColor;

    return !init
        ? Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: AnimatedBuilder(
                        animation: _controller,
                        child: Container(),
                        builder: (context, child) {
                          return CustomPaint(
                            child: child,
                            foregroundPainter: ColorfulProgressBarPainter(
                              backgroundColor: backgroundColor,
                              progressColor: widget.fillColor,
                              value: _controller.value,
                              progressHeight: height,
                              progressWidth: width,
                            ),
                          );
                        },
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Text(
                      timerString,
                      style: TextStyle(fontSize: 20),
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }
}
