import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/rendering.dart';

class StyleText {
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ConColors.primary,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: ConColors.primary,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
}
