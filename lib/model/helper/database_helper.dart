import 'package:sqflite/sqflite.dart';

import '../restaurant_model.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  static const String _tblName = "restaurant_bookmark";

  DatabaseHelper.createObject();

  factory DatabaseHelper() {
    if(_databaseHelper == null) {
      _databaseHelper = DatabaseHelper.createObject();
    }
    return _databaseHelper;
  }

  Future<Database> _initializeDatabase() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
        "$path/restaurantapp.db",
        onCreate: (db, version) async {
          await db.execute('''CREATE TABLE $_tblName(
        id VARCHAR PRIMARY KEY,
        name VARCHAR,
        description TEXT,
        pictureId VARCHAR,
        city VARCHAR,
        rating DOUBLE)''');
        }, version: 1
    );
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDatabase();
    }

    return _database;
  }

  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;

    db.insert(_tblName, restaurant.toJson());
  }

  Future<List<Restaurant>> getBookmark() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(_tblName);

    return result.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(_tblName, where: "id = ?", whereArgs: [id]);

    if(result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  Future<void> deleteBookmark(String id) async {
    final db = await database;

    db.delete(_tblName, where: "id = ?", whereArgs: [id]);
  }
}