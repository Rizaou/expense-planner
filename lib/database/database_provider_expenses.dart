import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DBHelperExpenses {
  static const _TABLE_NAME_EXPENSES = 'expenses';

  static Future<sql.Database> _database() async {
    final dbPath = await sql.getDatabasesPath();
    print(dbPath);
    return sql.openDatabase(
      path.join(dbPath, '$_TABLE_NAME_EXPENSES.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount REAL,desc TEXT ,date TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(ExpenseModel data) async {
    _TABLE_NAME_EXPENSES:
    final db = await DBHelperExpenses._database();
    db.insert(
      _TABLE_NAME_EXPENSES,
      data.toJson,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await DBHelperExpenses._database();
    return db.query(_TABLE_NAME_EXPENSES);
  }

  static Future<void> deleteData({ExpenseModel? data, int? id}) async {
    if (id != null) {
      final db = await DBHelperExpenses._database();

      await db
          .rawDelete("DELETE  FROM ${_TABLE_NAME_EXPENSES} where id = ${id}");

      print('deleted');
    } else if (data != null) {}
  }

  static void temp(String va, Function(String) f) {
    int v = 0;
    DBHelperExpenses._database().then((value) {
      print('v = $v');
      v++;
      List<Map<dynamic, dynamic>> x;
      value
          .rawQuery(
              'Select * from $_TABLE_NAME_EXPENSES where title like \'%$va%\' ')
          .then((value) {
        x = value;
        // print('value leng : ${value.length} , val :$value');
        x.forEach((element) {
          element.forEach((key, value) {
            if (key == 'title') {
              print('returned value : ' + value.toString());
              f(value);
            }
          });
        });
      });
    });
  }
}
