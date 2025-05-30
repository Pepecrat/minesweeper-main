import 'package:flutter/material.dart';
import 'package:minesweeper/utils/game_consts.dart';
import 'package:minesweeper/utils/game_colors.dart';
import 'package:minesweeper/utils/game_sizes.dart';
import 'package:minesweeper/utils/text_styles.dart';
import 'package:minesweeper/view/game_view/game_view.dart';

class MineSelectorView extends StatefulWidget {
  const MineSelectorView({super.key});

  @override
  State<MineSelectorView> createState() => _MineSelectorViewState();
}

class _MineSelectorViewState extends State<MineSelectorView> {
  int _mineCount = MIN_MINES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.mainSkyBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: GameSizes.getSymmetricPadding(0.05, 0),
              child: Text(
                'Número de Minas',
                textAlign: TextAlign.center,
                style: GameTextStyles.title.copyWith(
                  fontSize: GameSizes.getWidth(0.06),
                ),
              ),
            ),
            SizedBox(height: GameSizes.getHeight(0.04)),
            Container(
              width: GameSizes.getWidth(0.85),
              padding: GameSizes.getSymmetricPadding(0.05, 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: GameSizes.getRadius(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: GameColors.mainDarkGreen,
                        size: GameSizes.getWidth(0.06),
                      ),
                      SizedBox(width: GameSizes.getWidth(0.02)),
                      Text(
                        _mineCount.toString(),
                        style: GameTextStyles.title.copyWith(
                          color: GameColors.mainDarkGreen,
                          fontSize: GameSizes.getWidth(0.08),
                        ),
                      ),
                      Text(
                        ' minas',
                        style: GameTextStyles.title.copyWith(
                          color: Colors.black87,
                          fontSize: GameSizes.getWidth(0.05),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: GameSizes.getHeight(0.03)),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: GameColors.mainDarkGreen,
                      inactiveTrackColor:
                          GameColors.mainDarkGreen.withOpacity(0.2),
                      thumbColor: GameColors.mainDarkGreen,
                      overlayColor: GameColors.mainDarkGreen.withOpacity(0.2),
                    ),
                    child: Slider(
                      value: _mineCount.toDouble(),
                      min: MIN_MINES.toDouble(),
                      max: MAX_MINES.toDouble(),
                      divisions: MAX_MINES - MIN_MINES,
                      onChanged: (value) {
                        setState(() {
                          _mineCount = value.round();
                        });
                      },
                    ),
                  ),
                  Text(
                    'Desliza para ajustar (Mín: $MIN_MINES - Máx: $MAX_MINES)',
                    textAlign: TextAlign.center,
                    style: GameTextStyles.small.copyWith(
                      color: Colors.grey[600],
                      fontSize: GameSizes.getWidth(0.035),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: GameSizes.getHeight(0.05)),
            Container(
              width: GameSizes.getWidth(0.85),
              height: GameSizes.getHeight(0.07),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameView(initialMines: _mineCount),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: GameSizes.getRadius(12),
                  ),
                ),
                child: Text(
                  '¡Comenzar Partida!',
                  style: GameTextStyles.button.copyWith(
                    color: GameColors.mainSkyBlue,
                    fontSize: GameSizes.getWidth(0.045),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
