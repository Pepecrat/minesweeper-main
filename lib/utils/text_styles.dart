import 'package:flutter/material.dart';
import 'game_sizes.dart';

class GameTextStyles {
  static const String fontFamily = 'Pixeled';

  static TextStyle get baseStyle => TextStyle(
        fontFamily: fontFamily,
        color: Colors.white,
        height: 1.5,
      );

  static TextStyle get title => baseStyle.copyWith(
        fontSize: GameSizes.getWidth(0.045),
        fontWeight: FontWeight.bold,
      );

  static TextStyle get subtitle => baseStyle.copyWith(
        fontSize: GameSizes.getWidth(0.035),
        fontWeight: FontWeight.bold,
      );

  static TextStyle get body => baseStyle.copyWith(
        fontSize: GameSizes.getWidth(0.03),
        fontWeight: FontWeight.w500,
      );

  static TextStyle get small => baseStyle.copyWith(
        fontSize: GameSizes.getWidth(0.025),
      );

  static TextStyle get button => baseStyle.copyWith(
        fontSize: GameSizes.getWidth(0.03),
        fontWeight: FontWeight.bold,
      );
}
