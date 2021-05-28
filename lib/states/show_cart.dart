import 'package:bigcproj/model/sqlite_model.dart';
import 'package:bigcproj/utilities/constant/con_colors.dart';
import 'package:bigcproj/utilities/lib/sqlite_helper.dart';
import 'package:bigcproj/utilities/style/style_text.dart';
import 'package:bigcproj/widgets/show_progress.dart';
import 'package:bigcproj/widgets/show_title.dart';
import 'package:flutter/material.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> models = [];
  int total = 0;

  void initState() {
    super.initState();
    readCart();
  }

  Future<Null> readCart() async {
    await SQLiteHelper().readSQLite().then((value) {
      var result = value;
      print('${result.length}');
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
      body: models.length == 0
          ? ShowProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    buildHeader(),
                    buildListView(),
                    Divider(color: ConColors.primary),
                    buildTotal(),
                  ],
                ),
              ),
            ),
    );
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
                  onPressed: () {}, icon: Icon(Icons.delete_forever_outlined)),
            ),
          ],
        ),
      ),
    );
  }
}
