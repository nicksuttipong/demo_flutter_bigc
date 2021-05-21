import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  ShowTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: ConColors.primary,
      ),
    );
  }
}
