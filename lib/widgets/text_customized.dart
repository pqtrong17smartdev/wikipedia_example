import 'package:flutter/material.dart';
import 'package:wikipedia_example/utils/style_utils.dart';
import 'package:wikipedia_example/values/colors.dart';
import 'package:wikipedia_example/values/dimens.dart';
import 'package:wikipedia_example/values/fonts.dart';

enum FontWeightEnum{
  LIGHT,
  REGULAR,
  MEDIUM,
  SEMI_BOLD,
  BOLD
}

class TextCustomized extends StatelessWidget {
  final String text;
  final bool isCenter;
  final int maxLine;
  final TextOverflow textOverflow;
  final bool isRight;
  final String fontFamily;
  final double fontSize;
  final Color fontColor;
  final FontWeightEnum fontWeight;

  TextCustomized(this.text,
      {this.isCenter,
      this.maxLine,
      this.textOverflow,
      this.isRight,
      this.fontFamily,
      this.fontColor,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily ?? fSFUIText,
        fontSize: fontSize ?? d14TextSize,
        color: fontColor ?? blackText,
        fontWeight: StyleUtils.calculatorFontWeight(fontWeight)
      ),
      textAlign: isCenter != null && isCenter
          ? TextAlign.center
          : isRight != null && isRight
              ? TextAlign.right
              : null,
      maxLines: maxLine,
      overflow: textOverflow ?? null,
    );
  }
}
