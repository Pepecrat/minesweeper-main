import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  late final SharedPreferences _prefs;

  SharedHelper._create();

  static Future<SharedHelper> init() async {
    var sharedHelper = SharedHelper._create();
    sharedHelper._prefs = await SharedPreferences.getInstance();
    return sharedHelper;
  }

  Future<bool> getHowToPlayShown() async {
    return _prefs.getBool("HowToPlay") ?? false;
  }

  Future<bool> setHowToPlayShown(bool value) async {
    return _prefs.setBool("HowToPlay", value);
  }

  Future<int?> getBestTime() async {
    return _prefs.getInt("BestTime");
  }

  Future<bool> setBestTime(int time) async {
    int? currentBest = await getBestTime();
    if (currentBest == null || time < currentBest) {
      return _prefs.setInt("BestTime", time);
    }
    return false;
  }

  Future<int?> getGamesWon() async {
    return _prefs.getInt("GamesWon");
  }

  Future<bool> increaseGamesWon() async {
    int gamesWon = await getGamesWon() ?? 0;
    return _prefs.setInt("GamesWon", gamesWon + 1);
  }

  Future<int?> getGamesStarted() async {
    return _prefs.getInt("GamesStarted");
  }

  Future<bool> increaseGamesStarted() async {
    int gamesStarted = await getGamesStarted() ?? 0;
    return _prefs.setInt("GamesStarted", gamesStarted + 1);
  }

  Future<int?> getAverageTime() async {
    return _prefs.getInt("AverageTime");
  }

  Future<bool> updateAverageTime(int time) async {
    int? averageTime = await getAverageTime();
    int? gamesWon = await getGamesWon();

    if (gamesWon == null) {
      averageTime = time;
    } else {
      averageTime = averageTime == null
          ? time
          : ((averageTime * gamesWon) + time) ~/ (gamesWon + 1);
    }

    return _prefs.setInt("AverageTime", averageTime);
  }
}
