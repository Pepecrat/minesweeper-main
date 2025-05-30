import 'package:minesweeper/helper/shared_helper.dart';

mixin StatisticsMixin {
  String timeFormatter(int? time) {
    if (time == null) {
      return "--:--";
    }
    Duration duration = Duration(seconds: time);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds - minutes * 60;
    return "${(minutes > 9 ? "" : "0")}$minutes:${(seconds > 9 ? "" : "0")}$seconds";
  }

  Future<Map<String, dynamic>> getStatistic() async {
    final SharedHelper sharedHelper = await SharedHelper.init();

    int? gamesStarted = await sharedHelper.getGamesStarted();
    int? gamesWon = await sharedHelper.getGamesWon();
    int? bestTime = await sharedHelper.getBestTime();
    int? averageTime = await sharedHelper.getAverageTime();

    String? winRate;

    if (gamesStarted != null) {
      if (gamesWon != null) {
        winRate = "${(gamesWon * 100 / gamesStarted).round()}%";
      } else {
        winRate = "0%";
      }
    }

    return {
      "gamesStarted": gamesStarted,
      "gamesWon": gamesWon,
      "winRate": winRate,
      "bestTime": timeFormatter(bestTime),
      "averageTime": timeFormatter(averageTime),
    };
  }
}
