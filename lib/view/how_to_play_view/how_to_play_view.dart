import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minesweeper/helper/shared_helper.dart';

import '../../utils/game_colors.dart';
import '../../utils/game_sizes.dart';

class HowToPlayView extends StatefulWidget {
  const HowToPlayView({super.key, this.redirectToHome = false});

  final bool redirectToHome;

  @override
  State<HowToPlayView> createState() => _HowToPlayViewState();
}

class _HowToPlayViewState extends State<HowToPlayView> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (index < 0 || index > 4) return;
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onSkip() async {
    if (widget.redirectToHome) {
      Navigator.of(context).pushReplacementNamed('/home_view');
      final sharedHelper = await SharedHelper.init();
      await sharedHelper.setHowToPlayShown(true);
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget _buildImage(int index) {
    return Image.asset(
      'assets/images/how_to_play/how_to_play_${index + 1}.png',
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: GameSizes.getWidth(0.6),
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.image_not_supported,
              size: GameSizes.getWidth(0.15),
              color: Colors.grey[400],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('howToPlay'.tr()),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: GameSizes.getWidth(0.05),
        ),
        leading: widget.redirectToHome ? const SizedBox() : null,
        actions: [
          TextButton(
            onPressed: _onSkip,
            child: Text(
              'skip'.tr(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: GameSizes.getHorizontalPadding(0.015),
        child: Column(
          children: [
            Visibility(
              visible: !_loading,
              replacement: Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                      child: LinearProgressIndicator(
                        color: GameColors.appBar,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              child: Expanded(
                child: PageView.builder(
                    itemCount: 5,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: GameSizes.getHeight(0.05)),
                            _buildImage(index),
                            SizedBox(height: GameSizes.getHeight(0.04)),
                            Padding(
                              padding: GameSizes.getHorizontalPadding(0.045),
                              child: Text(
                                'howToPlay${index + 1}'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: GameSizes.getWidth(0.045),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: GameSizes.getHorizontalPadding(0.04)
                  .copyWith(bottom: GameSizes.getHeight(0.03)),
              child: Row(
                children: [
                  Opacity(
                    opacity: _currentPage == 0 ? 0 : 1,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: GameSizes.getWidth(0.06),
                      onPressed: () {
                        _onPageChanged(_currentPage - 1);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: GameSizes.getWidth(0.02),
                      alignment: Alignment.center,
                      child: Center(
                        child: ListView.builder(
                            itemCount: 5,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: GameSizes.getWidth(0.01)),
                                width: GameSizes.getWidth(0.02),
                                height: GameSizes.getWidth(0.02),
                                decoration: BoxDecoration(
                                  color: index == _currentPage
                                      ? GameColors.grassDark
                                      : GameColors.grassLight.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  if (_currentPage >= 4)
                    IconButton(
                      icon: const Icon(Icons.check),
                      iconSize: GameSizes.getWidth(0.06),
                      onPressed: () {
                        _onSkip();
                      },
                    )
                  else
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      iconSize: GameSizes.getWidth(0.06),
                      onPressed: () {
                        _onPageChanged(_currentPage + 1);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
