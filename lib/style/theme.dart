import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = const Color(0xFFFDC830);
  static const Color loginGradientEnd = const Color(0xFFF37335);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static Shader linearGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
