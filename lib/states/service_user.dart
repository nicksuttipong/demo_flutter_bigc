import 'dart:convert';

import 'package:bigcproj/model/product_model.dart';
import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:bigcproj/widgets/show_progress.dart';
import 'package:bigcproj/widgets/show_title.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
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
  List<ProductModel> productModels = [];

  void initState() {
    super.initState();
    buildWidget();
    readData();
  }

  Future<Null> readData() async {
    String apiFoods = 'https://www.androidthai.in.th/bigc/getAllFood.php';
    await Dio().get(apiFoods).then((value) {
      var result = json.decode(value.data);
      for (var item in result) {
        ProductModel model = ProductModel.fromMap(item);
        setState(() {
          productModels.add(model);
        });
      }
    });
  }

  void buildWidget() {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBanners(),
            buildTitle(),
            productModels.length == 0
                ? ShowProgress()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: productModels.length,
                    itemBuilder: (context, index) =>
                        Text(productModels[index].nameFood),
                  ),
          ],
        ),
      ),
    );
  }

  Row buildTitle() {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        ShowTitle(title: 'Product: ', textStyle: StyleText().h1Style()),
      ],
    );
  }

  CarouselSlider buildBanners() {
    return CarouselSlider(
      items: widgets,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 2),
        aspectRatio: 16 / 9,
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
