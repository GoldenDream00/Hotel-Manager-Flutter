import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Data/room.dart';

class RoomDBProvider {
  RoomDBProvider._();
  String table = "Room";
  static final RoomDBProvider db = RoomDBProvider._();

  static Database? _database;
  Future<Database> get database async => _database ??= await initDB();

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "$table.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $table ("
          "id INTEGER PRIMARY KEY,"
          "cid INTEGER,"
          "name TEXT,"
          "type TEXT,"
          "occupied INTEGER"
          ")");
    });
  }

  newRoom(Room entry) async {
    final db = await database;
    var res = await db.insert(table, entry.toMap());
    return res;
  }

  getAllRoom() async {
    final db = await database;
    var res = await db.query(
      table,
      orderBy: "occupied DESC, name ASC",
    );
    List<Room> list =
        res.isNotEmpty ? res.map((c) => Room.fromMap(c)).toList() : [];
    return list;
  }

  searchRoom(int cid) async {
    final db = await database;
    var res = await db.query(table, where: "cid = ?", whereArgs: [cid]);
    List<Room> list =
        res.isNotEmpty ? res.map((c) => Room.fromMap(c)).toList() : [];
    return list;
  }

  getRoom(int id) async {
    final db = await database;
    var res = await db.query(table, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Room.fromMap(res.first) : Null;
  }

  findRoomsofType(String type) async {
    final db = await database;
    var res = await db
        .query(table, where: "type = ? and occupied = 0", whereArgs: [type]);
    List<Room> list =
        res.isNotEmpty ? res.map((c) => Room.fromMap(c)).toList() : [];
    return list;
  }

  updateRoom(Room entry) async {
    final db = await database;
    var res = await db
        .update(table, entry.toMap(), where: "id = ?", whereArgs: [entry.id]);
    return res;
  }

  deleteRoom(int id) async {
    final db = await database;
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from $table");
  }
}
