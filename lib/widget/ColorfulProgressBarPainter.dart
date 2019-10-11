
import 'package:flutter/material.dart';

class ColorfulProgressBarPainter extends CustomPainter {
  final double value;
  final double progressHeight;
  final Color backgroundColor;
  final Color progressColor;

  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();

  ColorfulProgressBarPainter({
    this.backgroundColor,
    @required this.progressColor,
    @required this.value,
    this.progressHeight,
  }) {

    _paintBackground.color = backgroundColor;
    _paintBackground.strokeWidth = progressHeight;

    _paintLine.color = progressColor;
    _paintLine.strokeWidth = progressHeight;
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