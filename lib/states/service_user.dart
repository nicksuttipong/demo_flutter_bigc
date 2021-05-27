import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUser extends StatefulWidget {
  @override
  _ServiceUserState createState() => _ServiceUserState();
}

class _ServiceUserState extends State<ServiceUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConColors.primary,
        title: Text('Welcome User'),
        actions: [
          buildSignOut(),
        ],
      ),
    );
  }

  IconButton buildSignOut() {
    return IconButton(
          onPressed: () async {
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.clear();
            Navigator.pushNamedAndRemoveUntil(context, '/authen', (route) => false);
          },
          icon: Icon(Icons.exit_to_app),
        );
  }
}
