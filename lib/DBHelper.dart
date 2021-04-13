import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "notesdatabase.db";
  static final _databaseVersion = 1;
  static final table = 'Notes';
  static final id = '_id';
  static final title = 'title';
  static final body = 'body';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }


  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $title TEXT NOT NULL PRIMARY KEY,
            $body TEXT NOT NULL
          )
          ''');
  }




  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }



  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }




  Future<int> delete(int id1,) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [id1]);
  }
}