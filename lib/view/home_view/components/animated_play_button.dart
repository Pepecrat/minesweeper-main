import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/game_images.dart';
import '../../../utils/game_sizes.dart';
import '../../../widgets/custom_button.dart';
import '../../game_view/game_view.dart';
import 'package:minesweeper/view/game_view/mine_selector_view.dart';
import '../../../utils/game_colors.dart';

class AnimatedPlayButton extends StatefulWidget {
  const AnimatedPlayButton({super.key});

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with SingleTickerProviderStateMixin {
  double _top = 0;
  double _left = 0;
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: GameSizes.getWidth(0.25),
      end: GameSizes.getWidth(0.28),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    _controller!.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTapDown() {
    setState(() {
      _top = GameSizes.getWidth(0.03);
      _left = GameSizes.getWidth(0.02);
    });
  }

  void _onTapUp() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _top = 0;
        _left = 0;
      });
    });
  }

  void _onTapDownWithDetails(TapDownDetails details) {
    _onTapDown();
  }

  void _onTapUpWithDetails(TapUpDetails details) {
    _onTapUp();
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null) return const SizedBox();

    return Stack(
      children: [
        // Sombra pixel art
        Container(
          width: GameSizes.getWidth(0.38),
          height: GameSizes.getWidth(0.32),
          margin: EdgeInsets.only(
            top: GameSizes.getWidth(0.03),
            left: GameSizes.getWidth(0.02),
          ),
          decoration: BoxDecoration(
            color: GameColors.tileBorder,
            borderRadius: BorderRadius.zero,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: _top,
          left: _left,
          curve: Curves.easeIn,
          child: GestureDetector(
            onTap: _onTapDown,
            onTapUp: _onTapUpWithDetails,
            onTapDown: _onTapDownWithDetails,
            onTapCancel: _onTapUp,
            child: CustomButton(
              text: '',
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MineSelectorView(),
                    ),
                  );
                });
              },
              radius: 0,
              elevation: 0,
              width: GameSizes.getWidth(0.38),
              height: GameSizes.getWidth(0.32),
              padding: GameSizes.getPadding(0.025),
              color: GameColors.mainDarkGreen,
              textColor: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GameColors.darkBlue,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animation!,
                    builder: (context, child) {
                      return SizedBox(
                        width: _animation!.value,
                        height: _animation!.value,
                        child: Image.asset(
                          Images.pickaxe.toPath,
                          width: _animation!.value * 0.9,
                          height: _animation!.value * 0.9,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
