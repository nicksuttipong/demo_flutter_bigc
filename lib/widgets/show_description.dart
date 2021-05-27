import 'package:flutter/material.dart';

class ShowDiscripion extends StatelessWidget {
  final String? word;
  final TextStyle? textStyle;
  ShowDiscripion({@required this.word, @required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      word!,
      style: textStyle,
      maxLines: 3,
    );
  }
}
