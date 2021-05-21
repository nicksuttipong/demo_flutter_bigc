import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  final String? title;
  final TextStyle? textStyle;
  ShowTitle({@required this.title, @required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: textStyle,
    );
  }
}
