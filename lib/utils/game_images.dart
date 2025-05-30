enum Images {
  stopwatch,
  trophy,
  flag,
  redCross,
  loseScreen,
  winScreen,
  homeScreenBg,
  pickaxe,
  coin,
  bomb_1,
  bomb_2,
}

extension ImagesExtension on Images {
  String get toPath => 'assets/images/$name.png';
}
