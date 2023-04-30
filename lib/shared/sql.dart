import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SQL {
  static Database? DB;

  Future<Database?> get  db async {
    if (DB == null) {
      DB = await initialDB();
    }
    return DB;
  }

  Future<Database> initialDB() async {
    String initpath = await getDatabasesPath();
    String path = join(initpath, "todo.db");
    Database myDB = await openDatabase(path, version: 1, onCreate: _oncreate,onUpgrade: _onUpgrade);
    return myDB;
  }

  _oncreate(Database db, int version) async {
     db.execute(
        'CREATE TABLE tasks (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, note TEXT NOT NULL)');
    print("==========oncreate=======================");
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("==============onUpgrade==================");
  }

 Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> result = await mydb!.rawQuery(sql);

    return result;
  }

 Future<int> writeData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawInsert(sql);
    return result;
  }

 Future<int> deleteData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawDelete(sql);

    return result;
  }

 Future<int> updateData(sql) async {
    Database? mydb = await db;
    int result = await mydb!.rawUpdate(sql);

    return result;
  }
}
