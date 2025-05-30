import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/game_controller.dart';
import '../../utils/extensions.dart';
import '../../utils/game_colors.dart';
import '../../utils/game_consts.dart';
import '../../utils/game_images.dart';
import '../../utils/game_sizes.dart';
import '../../utils/text_styles.dart';

class GameTopBar extends StatelessWidget {
  const GameTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GameColors.appBar,
      padding: GameSizes.getSymmetricPadding(0.02, 0.01),
      child: Consumer<GameController>(
        builder: (context, GameController controller, child) => Row(
          children: [
            MineDisplay(mineCount: controller.mineCount),
            const Spacer(),
            Flags(flagCount: controller.flagCount),
            SizedBox(width: GameSizes.getWidth(0.04)),
            Stopwatch(timeElapsed: controller.timeElapsed),
            const Spacer(),
            IconButton(
              onPressed: () {
                controller.changeVolumeSetting = !controller.volumeOn;
              },
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: Icon(
                controller.volumeOn ? Icons.volume_up : Icons.volume_off_sharp,
                color: controller.volumeOn ? Colors.white : Colors.white70,
              ),
              iconSize: GameSizes.getWidth(0.075),
            ),
            IconButton(
              onPressed: () => controller.exitGame(context),
              icon: const Icon(Icons.close, color: Colors.white),
              visualDensity: VisualDensity.compact,
              iconSize: GameSizes.getWidth(0.07),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}

class MineDisplay extends StatelessWidget {
  final int mineCount;

  const MineDisplay({
    super.key,
    required this.mineCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: GameSizes.getSymmetricPadding(0.02, 0.01),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: GameSizes.getRadius(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Minas: ',
            style: GameTextStyles.body,
          ),
          Text(
            mineCount.toString(),
            style: GameTextStyles.body,
          ),
        ],
      ),
    );
  }
}

class Flags extends StatelessWidget {
  final int flagCount;

  const Flags({
    super.key,
    required this.flagCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Images.flag.toPath,
          width: GameSizes.getWidth(0.06),
        ),
        SizedBox(width: GameSizes.getWidth(0.01)),
        Text(
          flagCount.toString(),
          style: GameTextStyles.subtitle,
        ),
      ],
    );
  }
}

class Stopwatch extends StatelessWidget {
  final int timeElapsed;

  const Stopwatch({
    super.key,
    required this.timeElapsed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Images.stopwatch.toPath,
          width: GameSizes.getWidth(0.06),
        ),
        SizedBox(width: GameSizes.getWidth(0.01)),
        Text(
          "0" * (3 - timeElapsed.toString().length) + timeElapsed.toString(),
          style: GameTextStyles.subtitle,
        ),
      ],
    );
  }
}
