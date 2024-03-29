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
      {
        'title': data.type,
        'amount': data.amount,
        'desc': data.description,
        'date': data.date.toString(),
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DBHelperExpenses._database();
    return db.query(_TABLE_NAME_EXPENSES);
  }

  static Future<void> deleteData(String tableName, ExpenseModel data) async {}

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
