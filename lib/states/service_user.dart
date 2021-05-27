import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceUser extends StatefulWidget {
  @override
  _ServiceUserState createState() => _ServiceUserState();
}

class _ServiceUserState extends State<ServiceUser> {
  List<Widget> widgets = [];
  List<String> pathImages = [
    'assets/images/b1.png',
    'assets/images/b2.png',
    'assets/images/b3.png',
  ];

  void initState() {
    super.initState();
    for (var item in pathImages) {
      widgets.add(Image.asset(item));
    }
  }

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
      body: Column(
        children: [
          buildBanners(),
        ],
      ),
    );
  }

  CarouselSlider buildBanners() {
    return CarouselSlider(
          items: widgets,
          options: CarouselOptions(
            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 2),
            aspectRatio: 16/9,
            enlargeCenterPage: true,
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
