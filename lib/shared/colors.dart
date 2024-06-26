import 'package:flutter/material.dart';

class MovieMaxColors {
  MovieMaxColors._();

  static Color white = Color.fromARGB(255, 255, 255, 255);
  static Color bgColor = const Color(0xFF140D2C);
  static Color black = const Color(0xFF0D0D0E);
  static Color blueTxt = const Color(0xFF305c6c);

  static Gradient blueGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 48, 92, 108),
      Color.fromARGB(255, 72, 101, 117),
    ],
  );
}
