import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelperProgramSettings {
  static const String _TABLE_NAME = "program";
  static const String _IS_FIRST_OPEN = "isFirstOpen";

  static Future<sql.Database> _database() async {
    final dbPath = await sql.getDatabasesPath();

    var database = await sql.openDatabase(
      path.join(dbPath, '$_TABLE_NAME.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
        CREATE TABLE $_TABLE_NAME ( _id INTEGER PRIMARY KEY AUTOINCREMENT, $_IS_FIRST_OPEN INTEGER )
        
        ''');
      },
    );

    // database.close();

    return database;
  }

  static Future<void> closeDB() async {
    final db = await DBHelperProgramSettings._database();

    db.close();
  }

  static Future<bool> get isFirstTime async {
    final db = await DBHelperProgramSettings._database();
    var list = await db.query(_TABLE_NAME);
    print('list : $list ');
    if (list.isEmpty) {
      db.insert(_TABLE_NAME, {_IS_FIRST_OPEN: 1});
      print('first time');
      return true;
    } else if (list[0][_IS_FIRST_OPEN] == 1) {
      print('first time and there is a value');
      return true;
    }

    print('not first time');
    return false;
  }

  static Future<void> userIn() async {
    final db = await DBHelperProgramSettings._database();

    int val = await db.rawUpdate(
        'Update $_TABLE_NAME Set $_IS_FIRST_OPEN = ? where _id = ?',
        ['0', '1']);
    print('user in val : $val');
  }

  static Future<void> get exe async {
    final db = await DBHelperProgramSettings._database();
    await db.execute("");
  }
}
