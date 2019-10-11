import 'package:flutter/material.dart';
import 'package:musika/widget/ColorfulProgressBarPainter.dart';

class ColorfulProgressBar extends StatefulWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  Color fillColor;
  final double value;
  final Duration animationDuration;

  ColorfulProgressBar({
    Key key,
    this.backgroundColor,
    this.animationDuration,
    this.fillColor,
    @required this.height,
    @required this.width,
    @required this.value,
  }) : super(key: key);

  @override
  _ColorfulProgressBarState createState() => _ColorfulProgressBarState();
}

class _ColorfulProgressBarState extends State<ColorfulProgressBar>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Tween<Color> fillColorTween;
  Tween<double> valueTween;
  Tween<Color> foregroundColorTween;

  @override
  void initState() {
    super.initState();

    this._controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );

    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value,
    );

    this._controller.forward();
  }

  @override
  void didUpdateWidget(ColorfulProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (this.widget.value != oldWidget.value) {
      double beginValue =
        this.valueTween?.evaluate(this._controller) ?? oldWidget?.value ?? 0;

      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );

      if (oldWidget.fillColor != this.widget.fillColor) {
        this.foregroundColorTween = ColorTween(
          begin: oldWidget?.fillColor,
          end: this.widget.fillColor,
        );
      } else {
        this.foregroundColorTween = null;
      }

      this._controller
        ..value = 0
        ..forward();
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

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: SizedBox(
        width: width,
        height: height,
        child: AspectRatio(
            aspectRatio: 1,
            child: AnimatedBuilder(
              animation: this._controller,
              child: Container(),
              builder: (context, child) {
                final fillColor =
                  this.fillColorTween?.evaluate(this._controller) ??
                    this.widget.fillColor;

                return CustomPaint(
                  child: child,
                  foregroundPainter: ColorfulProgressBarPainter(
                    backgroundColor: backgroundColor,
                    progressColor: fillColor,
                    value: this.valueTween.evaluate(this._controller),
                    progressHeight: height,
                  ),
                );
              },
            )),
      ),
    );
  }
}
