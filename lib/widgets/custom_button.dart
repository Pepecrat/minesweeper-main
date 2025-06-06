import 'package:flutter/material.dart';

import '../utils/game_sizes.dart';
import '../utils/game_colors.dart';
import '../utils/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    this.text,
    required this.onPressed,
    this.icon,
    this.child,
    this.loading = false,
    this.disabled = false,
    this.radius = 12,
    this.elevation = 10,
    this.color,
    this.textColor = Colors.black,
    this.borderColor = Colors.transparent,
    this.width,
    this.height,
    this.iconSize,
    this.textSize,
    this.padding,
    super.key,
  });

  final String? text;
  final Function() onPressed;
  final IconData? icon;
  final bool loading;
  final bool disabled;
  final double elevation;
  final double radius;
  final Color? color;
  final Color textColor;
  final Color borderColor;
  final double? iconSize;
  final double? textSize;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? GameSizes.getWidth(0.5),
      height: height,
      child: IgnorePointer(
        ignoring: loading || disabled,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shadowColor: Colors.black.withOpacity(0.5),
            disabledBackgroundColor: Colors.grey,
            padding: padding ?? GameSizes.getSymmetricPadding(0.04, 0.01),
            shape: RoundedRectangleBorder(
              borderRadius: GameSizes.getRadius(radius),
              side: BorderSide(color: borderColor),
            ),
            elevation: elevation,
            foregroundColor: textColor,
          ),
          child: _getButtonChild(),
        ),
      ),
    );
  }

  Widget _getButtonChild() {
    if (loading) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if (icon != null) {
      if (text == null) {
        return Icon(
          icon,
          size: iconSize ?? GameSizes.getWidth(0.1),
          color: textColor,
        );
      }
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize ?? GameSizes.getWidth(0.1),
              color: textColor,
            ),
            const SizedBox(width: 10),
            Text(
              text!,
              style: GameTextStyles.button.copyWith(
                color: textColor,
                fontSize: textSize ?? GameSizes.getWidth(0.05),
              ),
            ),
          ],
        ),
      );
    } else if (child != null) {
      return child!;
    } else if (text != null) {
      return Text(
        text!,
        style: GameTextStyles.button.copyWith(
          color: textColor,
          fontSize: textSize ?? GameSizes.getWidth(0.05),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
