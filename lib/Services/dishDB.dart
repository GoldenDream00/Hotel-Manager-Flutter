import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Data/dish.dart';

class DishDBProvider {
  DishDBProvider._();
  String table = "Dish";
  static final DishDBProvider db = DishDBProvider._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$table.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER PRIMARY KEY,"
          "num INTEGER,"
          "name TEXT,"
          "type TEXT,"
          "photo TEXT"
          ")");
    });
  }

  newDish(Dish entry) async {
    final db = await database;
    var res = await db.insert(table, entry.toMap());
    return res;
  }

  getAllDish() async {
    final db = await database;
    var res = await db.query(
      table,
      orderBy: "type ASC, name ASC",
    );
    List<Dish> list =
        res.isNotEmpty ? res.map((c) => Dish.fromMap(c)).toList() : [];
    return list;
  }

  getDish(int id) async {
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Dish.fromMap(res.first) : Null;
  }

  updateDish(Dish entry) async {
    final db = await database;
    var res = await db
        .update(table, entry.toMap(), where: "id = ?", whereArgs: [entry.id]);
    return res;
  }

  deleteDish(int id) async {
    final db = await database;
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $table");
  }
}
