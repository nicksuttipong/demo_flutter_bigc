import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/material.dart';

class StyleButton {

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
                primary: ConColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)));
  
}