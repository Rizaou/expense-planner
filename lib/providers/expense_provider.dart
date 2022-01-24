import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:gelir_gider/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<String, dynamic>> _expense_data = [
    // {'type': 'market', 'amount': 100.0},
    // {'type': 'okul', 'amount': 50.0},
    // {'type': 'eğlence', 'amount': 100.0},
  ];

  //List<Map<String, dynamic>> _monthly_expenses = [];

  // Get
  Future<List<Map<dynamic, dynamic>>> get getExpenses async {
    List<Map<String, dynamic>> list = await DBHelperExpenses.getAllData();
    if (list.isEmpty) {
      print('Expense Provider => getExpenses => list ist empty.');
    }

    _expense_data = list;
    return [...list];
  }

  Future<List<Map<dynamic, dynamic>>> get getMonthlyExpenses async {
    List<Map<String, dynamic>> list = await DBHelperExpenses.getAllData();
    List<Map<String, dynamic>> temp = [];

    for (int i = 0; i < 31 && i < list.length; i++) {
      final day = DateTime.now().subtract(Duration(days: i));
      if (DateTime.parse(list[i]['date']).month == DateTime.now().month) {
        temp.add(list[i]);
      }
    }

    _expense_data = temp;

    return [..._expense_data];
  }

  int get length => _expense_data.length;
  // Functions
  void addData(ExpenseModel data) {
    var _data = data;
    _setDataToDataBase(data).then((value) {
      print('data was added : ' + data.toString());
      try {
        // List<Map<String, dynamic>> newMap =
        //     List<Map<String, dynamic>>.from(_expense_data);
        // newMap.add({'type': _data.type, 'amount': _data.amount});
        // _expense_data = newMap;
        _expense_data.add({'title': _data.title, 'amount': _data.amount});
      } catch (error) {
        print(error.toString());
      }

      notifyListeners();
    });
  }

  Future<void> getDataFromDataBase() async {
    var data = await DBHelperExpenses.getAllData();
  }

  Future<void> _setDataToDataBase(ExpenseModel data) async {
    DBHelperExpenses.insert(data);
  }

  double getSumOfExpenses() {
    double sum = 0;
    _expense_data.forEach((element) {
      element.forEach((key, value) {
        if (key == 'amount') {
          sum += value;
        }
      });
    });

    return sum;
  }

  Future<void> deleteData(int id) async {
    await DBHelperExpenses.deleteData(id: id);
    notifyListeners();
  }
}
