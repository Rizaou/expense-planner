import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'expenses.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount REAL,desc TEXT ,date TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String tableName, ExpenseModel data) async {
    final db = await DBHelper.database();
    db.insert(
      tableName,
      {
        'title': data.type,
        'amount': data.amount,
        'desc': data.description,
        'date': data.date.toString(),
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final db = await DBHelper.database();
    return db.query(tableName);
  }
}
