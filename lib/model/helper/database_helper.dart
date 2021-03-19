import 'package:sqflite/sqflite.dart';

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

  Future<Database> initializeDatabase() async {
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
}