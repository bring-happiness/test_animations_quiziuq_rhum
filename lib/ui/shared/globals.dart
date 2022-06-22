import 'dart:ui';
import 'package:flutter/material.dart';

class Global {
  static const Color white = Color(0xffffffff);
  static const Color primary = Color(0xff2196F3);
  static const Color success = Color(0xff009688);
  static const Color winSet = Color(0xffffd600);
  static const Color observer = Color(0xffb0bec5);
  static const Color error = Color(0xffE53935);
  static const Map<String, Color> palette = {
    'listPlayers': primary,
    'category': white,
    'question': primary,
    'success': success,
    'error': error,
    'observer': observer,
    'winSet': winSet,
    'ranking': primary,
    'endGame': white
  };
  static const double scale = 1;
  static const double radius = 88.0;
  static const double bottomPadding = 1375.0;
}