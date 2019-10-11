import 'package:flutter/material.dart';

class ColorfulProgressBarPainter extends CustomPainter {
  final double value;
  final double progressHeight;
  final Color backgroundColor;
  final double progressWidth;
  final List<MaterialColor> progressColor;
  final timerValue;

  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();

  ColorfulProgressBarPainter({
    this.backgroundColor,
    @required this.progressColor,
    @required this.value,
    this.progressHeight,
    this.progressWidth,
    this.timerValue,
  }) {

    _paintBackground.color = backgroundColor;
    _paintBackground.strokeWidth = progressHeight;

    final Gradient gradient = new LinearGradient(
      colors: progressColor,
      stops: [
        0,
        0.33,
        0.33,
        0.66,
        0.66,
        1,
      ],
    );

    _paintLine.strokeWidth = progressHeight;
    Rect rect = new Rect.fromLTWH(0, 0, progressWidth, progressHeight);

    _paintLine.shader = gradient.createShader(rect);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(0.0, size.height / 2);
    final end = Offset(size.width, size.height / 2);
    canvas.drawLine(start, end, _paintBackground);

    final xProgress = size.width * value;
    canvas.drawLine(start, Offset(xProgress, size.height / 2), _paintLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as ColorfulProgressBarPainter);
    return oldPainter.value != this.value ||
      oldPainter.backgroundColor != this.backgroundColor ||
      oldPainter.progressColor != this.progressColor ||
      oldPainter.progressHeight != this.progressHeight;
  }

}