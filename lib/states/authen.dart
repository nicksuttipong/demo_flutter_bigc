import 'dart:convert';

import 'package:bigcproj/model/user_model.dart';
import 'package:bigcproj/utilities/componants/com_dialog.dart';
import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/style/style_button.dart';
import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:bigcproj/widgets/show_image.dart';
import 'package:bigcproj/widgets/show_title.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  final formField = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: formField,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildImage(size),
                buildShowTitle(),
                buildUser(size),
                buildPassword(size),
                buildLogin(size),
                buildRow(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  ShowTitle buildShowTitle() {
    return ShowTitle(title: 'BIG C Online', textStyle: StyleText().h1Style());
  }

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(title: 'Non Account?', textStyle: StyleText().h3Style()),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/createAccout');
            },
            child: Text('Create Account'))
      ],
    );
  }

  Container buildLogin(double size) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: size * 0.6,
        child: ElevatedButton(
            onPressed: () {
              if (formField.currentState!.validate()) {
                String user = userController.text;
                String password = passwordController.text;

                checkAuthen(user: user, password: password);
              }
            },
            child: Text('Login'),
            style: StyleButton().myButtonStyle()));
  }

  Container buildUser(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          controller: userController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill User';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            labelText: 'User :',
            prefixIcon: Icon(Icons.account_circle, color: ConColors.primary),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ConColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildPassword(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          controller: passwordController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill Password';
            } else {
              return null;
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon:
                IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
            labelText: 'Password :',
            prefixIcon:
                Icon(Icons.lock_clock_outlined, color: ConColors.primary),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ConColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildImage(double size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.5,
      child: ShowImage(),
    );
  }

  Future<Null> checkAuthen({@required String? user, @required String? password}) async{
    String apiLoginUser =
        "https://www.androidthai.in.th/bigc/getUserWhereUser.php?isAdd=true&user=$user";

    await Dio().get(apiLoginUser).then((value) async {
      if(value.toString() == 'null'){
        normalDialog(context, 'Error', 'No User : $user');
      } else {
        var result = json.decode(value.data);
        for (var item in result) {
          UserModel model = UserModel.fromMap(item);
          if(password == model.password){
            SharedPreferences preference = await SharedPreferences.getInstance();
            preference.setString('user', model.user);
            preference.setString('name', model.name);
            preference.setString('id', model.id);
            Navigator.pushNamedAndRemoveUntil(context, '/serviceUser', (route) => false);
          } else {
            normalDialog(context, 'Password fail', 'Please Try Again Password');
          }
        }
      }
    });
  }
}
