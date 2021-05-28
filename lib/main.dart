import 'package:bigcproj/states/authen.dart';
import 'package:bigcproj/states/create_account.dart';
import 'package:bigcproj/states/service_admin.dart';
import 'package:bigcproj/states/service_user.dart';
import 'package:bigcproj/states/show_cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccout': (BuildContext context) => CreateAccout(),
  '/serviceAdmin': (BuildContext context) => ServiceAdmin(),
  '/serviceUser': (BuildContext context) => ServiceUser(),
  '/showCart': (BuildContext context) => ShowCart(),
};

String? initailRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preference = await SharedPreferences.getInstance();
  String? user = preference.getString('user');
  if(user?.isEmpty?? true){
    initailRoute = '/authen';
  } else {
    initailRoute = '/serviceUser';
  }
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