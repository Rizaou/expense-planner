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

  // Get
  Future<List<Map<dynamic, dynamic>>> get getExpenses async {
    List<Map<String, dynamic>> list = await DBHelperExpenses.getData();
    //print('liste : ' + list.toString());
    _expense_data = list;
    return [...list];
  }

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
        _expense_data.add({'type': _data.type, 'amount': _data.amount});
      } catch (error) {
        print(error.toString());
      }

      notifyListeners();
    });
  }

  Future<void> getDataFromDataBase() async {
    var data = await DBHelperExpenses.getData();
  }

  Future<void> _setDataToDataBase(ExpenseModel data) async {
    DBHelperExpenses.insert(data);
  }

  double getTotalExpense() {
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
}
