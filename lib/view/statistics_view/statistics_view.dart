import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_consts.dart';
import '../../utils/game_sizes.dart';
import '../../utils/text_styles.dart';
import 'stats_table.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      appBar: AppBar(
        title: Text(
          'statistics'.tr(),
          style: GameTextStyles.title,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StatsTable(),
        ),
      ),
    );
  }
}
