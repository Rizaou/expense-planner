import 'package:flutter/material.dart';
import '../models/income_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelperIncomes {
  static const _TABLE_NAME_INCOME = 'incomes';

  // ignore: prefer_final_fields
  List<Map<dynamic, dynamic>> _incomes = [];

  Future<List<Map<dynamic, dynamic>>> get incomes async {
    final data = await getAllData();
    _incomes = data;
    return [..._incomes];
  }

  static Future<sql.Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, '${_TABLE_NAME_INCOME}.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE ${_TABLE_NAME_INCOME} ( id INTEGER PRIMARY KEY AUTOINCREMENT, income REAL,desc TEXT ,date TEXT )');
      },
      version: 1,
    );
  }

  static Future<void> addData(IncomeModel data) async {
    final db = await DBHelperIncomes._database();

    int val = await db.insert(_TABLE_NAME_INCOME, data.toJson);

    if (val == 0) print('DB Incomes has a error : ' + val.toString());
  }

  static Future<List<Map<dynamic, dynamic>>> getAllData() async {
    final db = await DBHelperIncomes._database();
    return db.query(_TABLE_NAME_INCOME);
  }
}
