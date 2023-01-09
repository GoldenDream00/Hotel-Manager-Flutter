import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Data/employee.dart';

class EmployeeDBProvider {
  EmployeeDBProvider._();
  String table = "Employee";
  static final EmployeeDBProvider db = EmployeeDBProvider._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$table.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER PRIMARY KEY,"
          "present INTEGER,"
          "name TEXT,"
          "phone TEXT"
          ")");
    });
  }

  newEmployee(Employee entry) async {
    final db = await database;
    var res = await db.insert(table, entry.toMap());
    return res;
  }

  getAllEmployee() async {
    final db = await database;
    var res = await db.query(
      table,
      orderBy: "present, name",
    );
    List<Employee> list =
        res.isNotEmpty ? res.map((c) => Employee.fromMap(c)).toList() : [];
    return list;
  }

  getEmployee(int id) async {
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Employee.fromMap(res.first) : Null;
  }

  resetAttendance() async {
    final db = await database;
    db.rawDelete("Update $table set present = 0");
  }

  updateEmployee(Employee entry) async {
    final db = await database;
    var res = await db
        .update(table, entry.toMap(), where: "id = ?", whereArgs: [entry.id]);
    return res;
  }

  deleteEmployee(int id) async {
    final db = await database;
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $table");
  }
}
