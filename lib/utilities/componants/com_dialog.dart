import 'package:bigcproj/widgets/show_image.dart';
import 'package:flutter/material.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowImage(),
        title: Text(title),
        subtitle: Text(message),
      ), children: [TextButton(onPressed: () => Navigator.pop(context) , child: Text('OK'),),],
    ),
  );
}
