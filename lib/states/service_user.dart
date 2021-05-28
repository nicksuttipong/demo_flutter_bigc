import 'dart:convert';

import 'package:bigcproj/model/product_model.dart';
import 'package:bigcproj/model/sqlite_model.dart';
import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/lib/sqlite_helper.dart';
import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:bigcproj/widgets/show_description.dart';
import 'package:bigcproj/widgets/show_image.dart';
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
  final String baseAPI = 'https://www.androidthai.in.th/bigc';

  void initState() {
    super.initState();
    buildWidget();
    readData();
  }

  Future<Null> readData() async {
    String apiFoods = '$baseAPI/getAllFood.php';
    await Dio().get(apiFoods).then((value) {
      var result = json.decode(value.data);
      int count = 0;
      for (var item in result) {
        ProductModel model = ProductModel.fromMap(item);
        setState(() {
          productModels.add(model);
        });
        if(count > 10) break;
        count++;
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
          buildShowCart(context),
          buildSignOut(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBanners(),
            buildTitle(),
            productModels.length == 0 ? ShowProgress() : buildListView(),
          ],
        ),
      ),
    );
  }

  IconButton buildShowCart(BuildContext context) {
    return IconButton(
          onPressed: () => Navigator.pushNamed(context, '/showCart'),
          icon: Icon(Icons.shopping_cart),
        );
  }

  String cutWord(String word) {
    if (word.length > 100) {
      word = word.substring(0, 100);
      word = '$word ...';
    }
    return word;
  }

  Future<Null> showDetailDialog(ProductModel model) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(),
          title: ShowTitle(
            title: model.nameFood,
            textStyle: StyleText().h2Style(),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
                'https://www.androidthai.in.th/bigc${model.image}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShowTitle(
              title: model.category,
              textStyle: StyleText().h2Style(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShowTitle(
              title: model.detail,
              textStyle: StyleText().h3Style(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processAddCart(model);
                },
                child: Text('Add Cart'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> processAddCart(ProductModel productModel) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? idUser = preference.getString('id');
    String? nameUser = preference.getString('name');
    String? idProduct = productModel.id;
    String? nameProduct = productModel.nameFood;
    String? price = productModel.price;
    String? amount = '1';

    SQLiteModel model = SQLiteModel(
      id: null,
      idUser: idUser!,
      nameUser: nameUser!,
      idProduct: idProduct,
      nameProduct: nameProduct,
      price: price,
      amount: amount,
      sum: price,
    );

    await SQLiteHelper()
        .insertValueSQLite(model)
        .then((value) => print('Add OK'));
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: productModels.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showDetailDialog(productModels[index]);
        },
        child: Card(
          color: index % 2 == 0 ? Colors.grey.shade200 : Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShowTitle(
                        title: productModels[index].nameFood,
                        textStyle: StyleText().h2Style(),
                      ),
                      ShowDiscripion(
                        word: productModels[index].detail,
                        textStyle: StyleText().h3Style(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 120,
                  child:
                      Image.network('$baseAPI/${productModels[index].image}'),
                ),
              ],
            ),
          ),
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
