import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/style/style_button.dart';
import 'package:bigcproj/widgets/show_image.dart';
import 'package:bigcproj/widgets/show_title.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildImage(size),
              ShowTitle(title: 'BIG C Online',),
              buildUser(size),
              buildPassword(size),
              buildLogin(size)
            ],
          ),
        ),
      )),
    );
  }

  Container buildLogin(double size) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        width: size * 0.6,
        child: ElevatedButton(
            onPressed: () {},
            child: Text('Login'),
            style: StyleButton().myButtonStyle()));
  }

  Container buildUser(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'User :',
              prefixIcon: Icon(Icons.account_circle, color: ConColors.primary),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: ConColors.primary))),
          keyboardType: TextInputType.text,
        ),
        width: size * 0.6);
  }

  Container buildPassword(double size) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye)),
              labelText: 'Password :',
              prefixIcon:
                  Icon(Icons.lock_clock_outlined, color: ConColors.primary),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: ConColors.primary))),
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
}
