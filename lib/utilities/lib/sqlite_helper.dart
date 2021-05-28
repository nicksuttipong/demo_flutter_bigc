import 'package:bigcproj/model/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'bigc.db';
  final String nameTable = 'orderProduct';
  final int version = 1;

  final String columnId = 'id';
  final String columnIdUser = 'idUser';
  final String columnNameUser = 'nameUser';
  final String columnIdProduct = 'idProduct';
  final String columnNameProduct = 'nameProduct';
  final String columnPrice = 'price';
  final String columnAmount = 'amount';
  final String columnSum = 'sum';

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(
      join(
        await getDatabasesPath(),
        nameDatabase,
      ),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $nameTable ($columnId INTEGER PRIMARY KEY, $columnIdUser TEXT, $columnNameUser TEXT, $columnIdProduct TEXT, $columnNameProduct TEXT, $columnPrice TEXT, $columnAmount TEXT, $columnSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(
      await getDatabasesPath(),
      nameDatabase,
    ));
  }

  Future<Null> insertValueSQLite(SQLiteModel model) async {
    Database db = await connectedDatabase();
    try {
      db.insert(
        nameTable,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {}
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database db = await connectedDatabase();
    List<SQLiteModel> models = [];

    List<Map<String, dynamic>> maps = await db.query(nameTable);
    for (var item in maps) {
      SQLiteModel model = SQLiteModel.fromMap(item);
      models.add(model);
    }

    return models;
  }

  Future<Null> deleteValueById(int id) async {
    Database db = await connectedDatabase();
    try {
      await db.delete(nameTable, where: '$columnId = $id');
    } catch (e) {
    }
  }

  Future<Null> deleteAll() async{
    Database db = await connectedDatabase();
    try {
      await db.delete(nameTable);
    } catch (e) {
    }
  }
}
