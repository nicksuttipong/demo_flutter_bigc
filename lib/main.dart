import 'package:bigcproj/states/authen.dart';
import 'package:bigcproj/states/create_account.dart';
import 'package:bigcproj/states/service_admin.dart';
import 'package:bigcproj/states/service_user.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccout': (BuildContext context) => CreateAccout(),
  '/serviceAdmin': (BuildContext context) => ServiceAdmin(),
  '/serviceUser': (BuildContext context) => ServiceUser(),
};

String? initailRoute;

void main(){
  initailRoute = '/authen';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initailRoute,
      title: 'Big C Online'
    );
  }
}