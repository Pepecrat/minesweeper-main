import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import '../../controller/game_controller.dart';
import '../../helper/shared_helper.dart';
import '../../model/tile_model.dart';
import '../../utils/exports.dart';
import '../../widgets/game_popup_screen.dart';

class VideoManager {
  static final Map<String, VideoPlayerController> _controllers = {};

  static Future<VideoPlayerController> getController(String id) async {
    if (!_controllers.containsKey(id)) {
      final controller = VideoPlayerController.asset('assets/images/bomb.mp4');
      await controller.initialize();
      _controllers[id] = controller;
    }
    return _controllers[id]!;
  }

  static void playVideo(String id) {
    final controller = _controllers[id];
    if (controller != null && !controller.value.isPlaying) {
      controller.seekTo(Duration.zero);
      controller.play();
    }
  }

  static void dispose(String id) {
    final controller = _controllers.remove(id);
    controller?.dispose();
  }

  static void disposeAll() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}

class MineField extends StatelessWidget {
  final GameController gameController;
  const MineField({super.key, required this.gameController});

  @override
  Widget build(BuildContext context) {
    List<List<Tile>> mineField = gameController.mineField;

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: GameSizes.getWidth(0.9),
          maxHeight: GameSizes.getWidth(0.9),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: BOARD_SIZE,
            childAspectRatio: 1,
          ),
          itemCount: BOARD_SIZE * BOARD_SIZE,
          itemBuilder: (BuildContext context, index) {
            Tile tile = mineField[index ~/ BOARD_SIZE][index % BOARD_SIZE];

            if (tile.visible == false || tile.hasFlag) {
              return Grass(
                tile: tile,
                gameController: gameController,
                parentContext: context,
              );
            } else {
              if (tile.hasMine)
                return Mine(
                    isOpened: tile.visible,
                    isBomb: tile.hasMine,
                    isFlagged: tile.hasFlag,
                    isGameOver: false,
                    onTap: () {},
                    onLongPress: () => gameController.placeFlag(tile));

              return OpenedTile(adjacentBombs: tile.value);
            }
          },
        ),
      ),
    );
  }
}

class Grass extends StatelessWidget {
  final Tile tile;
  final GameController gameController;
  final BuildContext parentContext;

  const Grass({
    super.key,
    required this.tile,
    required this.gameController,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          if (tile.hasFlag) return;

          await gameController.clickTile(tile)?.then((win) async {
            if (win != null) {
              final sharedHelper = await SharedHelper.init();
              int? bestTime = await sharedHelper.getBestTime();
              if (win) {
                await sharedHelper
                    .updateAverageTime(gameController.timeElapsed);
                await sharedHelper.increaseGamesWon();
                if (gameController.timeElapsed < (bestTime ?? 999)) {
                  bestTime = gameController.timeElapsed;
                  await sharedHelper.setBestTime(bestTime);
                }
              }
              return (win, bestTime);
            }
            return null;
          }).then((value) {
            if (value?.$1 != null) {
              GamePopupScreen.gameOver(
                parentContext,
                controller: gameController,
                bestTime: value!.$2,
                win: value.$1,
              );
            }
          });
        },
        onLongPress: () => gameController.placeFlag(tile),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: tile.row % 2 == 0 && tile.col % 2 == 0 ||
                    tile.row % 2 != 0 && tile.col % 2 != 0
                ? GameColors.grassLight
                : GameColors.grassDark,
            border: tileBorder(tile),
          ),
          child: tile.hasFlag
              ? tile.visible
                  ? Image.asset(Images.redCross.toPath)
                  : Image.asset(Images.flag.toPath)
              : const SizedBox(),
        ));
  }
}

class Mine extends StatefulWidget {
  final bool isOpened;
  final bool isBomb;
  final bool isFlagged;
  final bool isGameOver;
  final Function() onTap;
  final Function() onLongPress;

  const Mine({
    Key? key,
    required this.isOpened,
    required this.isBomb,
    required this.isFlagged,
    required this.isGameOver,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  bool _isExploded = false;
  Timer? _explosionTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isOpened && widget.isBomb) {
      _startExplosion();
    }
  }

  void _startExplosion() {
    _explosionTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isExploded = true;
        });
      }
    });
  }

  @override
  void didUpdateWidget(Mine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isOpened && widget.isOpened && widget.isBomb) {
      _startExplosion();
    }
  }

  @override
  void dispose() {
    _explosionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: _getChild(),
        ),
      ),
    );
  }

  Widget _getChild() {
    if ((widget.isGameOver || widget.isOpened) && widget.isBomb) {
      return Image.asset(
        _isExploded ? Images.bomb_2.toPath : Images.bomb_1.toPath,
        fit: BoxFit.contain,
      );
    }
    if (widget.isFlagged) {
      return Image.asset(Images.flag.toPath);
    }
    if (!widget.isOpened) {
      return const SizedBox();
    }
    if (widget.isOpened && !widget.isBomb) {
      return Image.asset(Images.coin.toPath);
    }
    return const SizedBox();
  }

  Color _getBackgroundColor() {
    if (widget.isOpened) {
      if (widget.isBomb) {
        return Colors.transparent;
      }
      return Colors.white;
    }
    return Colors.grey[300]!;
  }
}

class OpenedTile extends StatelessWidget {
  final int adjacentBombs;

  const OpenedTile({
    Key? key,
    required this.adjacentBombs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Image.asset(Images.coin.toPath),
      ),
    );
  }
}

BoxBorder tileBorder(Tile tile) {
  return Border(
    top: createBorderSide(tile.ltrb[1]),
    left: createBorderSide(tile.ltrb[0]),
    right: createBorderSide(tile.ltrb[2]),
    bottom: createBorderSide(tile.ltrb[3]),
  );
}

BorderSide createBorderSide(bool isSolid) {
  return BorderSide(
    color: GameColors.tileBorder,
    width: GameSizes.getWidth(0.005),
    style: isSolid ? BorderStyle.solid : BorderStyle.none,
  );
}
