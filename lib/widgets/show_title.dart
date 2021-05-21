import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  final String? title;
  ShowTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: StyleText().h1Style(),
    );
  }
}
