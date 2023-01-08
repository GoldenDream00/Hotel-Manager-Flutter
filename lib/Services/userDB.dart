import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Data/user.dart';

class UserDBProvider {
  UserDBProvider._();
  String table = "User";
  static final UserDBProvider db = UserDBProvider._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "password TEXT,"
          "phone TEXT,"
          "email TEXT"
          ")");
    });
  }

  newUser(User entry) async {
    final db = await database;
    var res = await db.insert(table, entry.toMap());
    return res;
  }

  getAllUser() async {
    final db = await database;
    var res = await db.query(
      table,
      orderBy: "name ASC",
    );
    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : [];
    return list;
  }

  searchuser(String name) async {
    final db = await database;
    var res = await db.query(table, where: "name = ?", whereArgs: [name]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null;
  }

  getUser(int id) async {
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null;
  }

  updateUser(User entry) async {
    final db = await database;
    var res = await db
        .update(table, entry.toMap(), where: "id = ?", whereArgs: [entry.id]);
    return res;
  }

  deleteTodoEntry(int id) async {
    final db = await database;
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Todo");
  }
}
