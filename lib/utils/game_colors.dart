import 'package:flutter/material.dart';

class GameColors {
  // Pixel Art Color Palette
  static const Color _blackPearl = Color(0xFF001d2f); // Fondo principal
  static const Color _java = Color(0xFF13BDB1); // Elementos interactivos
  static const Color _funBlue = Color(0xFF185FAA); // Detalles y bordes
  static const Color _mediumPurple =
      Color(0xFFB650E3); // Acentos y elementos especiales

  static const Color _mainDarkGreen = Color(0xFF547436);
  static const Color _darkBlue = Color(0xFF4994EC);
  static const Color _background = Color(0xFFF6F6F6);

  static const Color _grassLight = Color(0xFF13BDB1); // Java
  static const Color _grassDark = Color(0xFF0FA69B); // Java más oscuro

  static const Color _tileLight = Color(0xFF185FAA); // Fun Blue
  static const Color _tileDark = Color(0xFF1355A0); // Fun Blue más oscuro

  static const Color _tileBorder = Color(0xFF05132B); // Black Pearl

  static const Color _valueText1 = Color(0xFF13BDB1); // Java
  static const Color _valueText2 = Color(0xFF185FAA); // Fun Blue
  static const Color _valueText3 = Color(0xFFB650E3); // Medium Purple
  static const Color _valueText4 = Color(0xFF71279C);
  static const Color _valueText5 = Color(0xFFF09536);
  static const Color _valueText6 = Color(0xFFDA893D);
  static const Color _valueText7 = Color(0xFF000000);
  static const Color _valueText8 = Color(0xFFFF0000);

  static const Color _mine1 = Color(0xFFB650E3); // Medium Purple
  static const Color _mine2 = Color(0xFF13BDB1); // Java
  static const Color _mine3 = Color(0xFF185FAA); // Fun Blue
  static const Color _mine4 = Color(0xFF05132B); // Black Pearl
  static const Color _mine5 = Color(0xFFECC444);
  static const Color _mine6 = Color(0xFFCA423E);
  static const Color _mine7 = Color(0xFF7AE3EF);

  static Color get appBar => _blackPearl;
  static Color get darkBlue => _funBlue;
  static Color get mainSkyBlue => _blackPearl;
  static Color get mainDarkGreen => _java;
  static Color get background => _background;

  static Color get grassLight => _grassLight;
  static Color get grassDark => _grassDark;

  static Color get tileLight => _tileLight;
  static Color get tileDark => _tileDark;

  static Color get tileBorder => _tileBorder;

  static Color get popupBackground => _blackPearl;
  static Color get popupPlayAgainButton => _java;
  static Color get skipButton => _java;

  static List<Color> get valueTextColors => [
        _valueText1,
        _valueText2,
        _valueText3,
        _valueText4,
        _valueText5,
        _valueText6,
        _valueText7,
        _valueText8
      ];

  static List<Color> get mineColors =>
      [_mine1, _mine2, _mine3, _mine4, _mine5, _mine6, _mine7];

  static Color darken(Color color, [double amount = .2]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
