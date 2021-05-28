import 'package:bigcproj/model/sqlite_model.dart';
import 'package:bigcproj/utilities/componants/com_dialog.dart';
import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/lib/sqlite_helper.dart';
import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:bigcproj/widgets/show_progress.dart';
import 'package:bigcproj/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> models = [];
  int total = 0;
  bool loading = true;

  void initState() {
    super.initState();
    readCart();
  }

  Future<Null> readCart() async {
    if (models.length != 0) {
      models.clear();
      total = 0;
    }
    await SQLiteHelper().readSQLite().then((value) {
      var result = value;
      setState(() {
        loading = false;
      });
      for (var item in result) {
        setState(() {
          total = total + int.parse(item.price);
          models.add(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConColors.primary,
        title: Text('Show Cart'),
      ),
      body: loading
          ? ShowProgress()
          : models.length == 0
              ? Center(
                  child: ShowTitle(
                    title: 'No Cart',
                    textStyle: StyleText().h1Style(),
                  ),
                )
              : buildContent(),
    );
  }

  SingleChildScrollView buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildHeader(),
            buildListView(),
            Divider(color: ConColors.primary),
            buildTotal(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => processOrder(),
                  icon: Icon(Icons.cloud_upload),
                  label: Text('Order'),
                ),
                SizedBox(
                  width: 16,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String changeStringToArray(int key) {
    List<String> results = [];
    for (var model in models) {
      switch (key) {
        case 0:
          results.add(model.idProduct);
          break;
        case 1:
          results.add(model.nameProduct);
          break;
        case 2:
          results.add(model.price);
          break;
        case 3:
          results.add(model.amount);
          break;
        default:
      }
    }


    return results.toString();
  }

  Future<Null> processOrder() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? idUser = preference.getString('id');
    String? nameUser = preference.getString('name');
    String? idProduct = changeStringToArray(0);
    String? nameProduct = changeStringToArray(1);
    String? price = changeStringToArray(2);
    String? amount = changeStringToArray(3);
    final apiInsert = 'https://www.androidthai.in.th/bigc/orderSu.php?isAdd=true&idUser=$idUser&nameUser=$nameUser&idProduct=$idProduct&nameProduct=$nameProduct&price=$price&amount=$amount';
    await Dio().get(apiInsert).then((value) async {
      if (value.toString() == 'true') {
         await SQLiteHelper().deleteAll().then((value) => readCart());
       } else {
         normalDialog(context, 'Cannot Order', 'Please Try Again');
       }
    });
  }

  Row buildTotal() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShowTitle(
                title: 'Total:',
                textStyle: StyleText().h1Style(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: ShowTitle(
            title: '$total',
            textStyle: StyleText().h1Style(),
          ),
        ),
      ],
    );
  }

  Container buildHeader() {
    return Container(
      decoration: BoxDecoration(color: Colors.black38),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ShowTitle(
                title: 'Name',
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Price',
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Amount',
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: 'Sum',
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: '',
                textStyle: StyleText().h2Style(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: models.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 4),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ShowTitle(
                title: models[index].nameProduct,
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: models[index].price,
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: models[index].amount,
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: ShowTitle(
                title: models[index].sum,
                textStyle: StyleText().h2Style(),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () => deleteById(models[index].id),
                  icon: Icon(Icons.delete_forever_outlined)),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> deleteById(int? id) async {
    print('Delete $id');
    await SQLiteHelper().deleteValueById(id!).then(
          (value) => readCart(),
        );
  }
}
