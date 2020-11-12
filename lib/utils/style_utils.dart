import 'dart:ui';

import 'package:wikipedia_example/widgets/text_customized.dart';


class StyleUtils{
  static Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
      '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }

  static FontWeight calculatorFontWeight(FontWeightEnum fontWeightEnum){
    switch(fontWeightEnum){
      case FontWeightEnum.LIGHT:
        return FontWeight.w300;
        break;
      case FontWeightEnum.REGULAR:
        return FontWeight.w400;
        break;
      case FontWeightEnum.MEDIUM:
        return FontWeight.w500;
        break;
      case FontWeightEnum.SEMI_BOLD:
        return FontWeight.w600;
        break;
      case FontWeightEnum.BOLD:
        return FontWeight.w700;
        break;
    }
    return FontWeight.w400;
  }

}

