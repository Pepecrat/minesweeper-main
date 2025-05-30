import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../mixins/statistics_mixin.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_consts.dart';
import '../../utils/game_sizes.dart';

class StatsTable extends StatelessWidget with StatisticsMixin {
  const StatsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getStatistic(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: GameSizes.getRadius(16),
          ),
          padding: GameSizes.getSymmetricPadding(0.04, 0.04),
          child: Column(
            children: [
              _buildStatRow(
                context,
                'gamesStarted'.tr(),
                data['gamesStarted']?.toString() ?? '0',
              ),
              _buildDivider(),
              _buildStatRow(
                context,
                'gamesWon'.tr(),
                data['gamesWon']?.toString() ?? '0',
              ),
              _buildDivider(),
              _buildStatRow(
                context,
                'winRate'.tr(),
                data['winRate'] ?? '0%',
              ),
              _buildDivider(),
              _buildStatRow(
                context,
                'bestTime'.tr(),
                data['bestTime'],
              ),
              _buildDivider(),
              _buildStatRow(
                context,
                'averageTime'.tr(),
                data['averageTime'],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: GameSizes.getSymmetricPadding(0.02, 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: GameSizes.getWidth(0.045),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: GameSizes.getWidth(0.045),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: GameSizes.getHeight(0.03),
    );
  }
}
