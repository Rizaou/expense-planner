import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:gelir_gider/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<dynamic, dynamic>> _expense_data = [
    // {'type': 'market', 'amount': 100.0},
    // {'type': 'okul', 'amount': 50.0},
    // {'type': 'eğlence', 'amount': 100.0},
  ];

  List<Map<String, double>> _income = [
    {'KYK': 850.0},
  ];

  // Get
  Future<List<Map<dynamic, dynamic>>> get getExpenses async {
    List<Map<String, dynamic>> list = await DBHelperExpenses.getData();
    //print('liste : ' + list.toString());
    _expense_data = list;
    return list;
  }

  List<Map<String, double>> get getIncome => [..._income];

  // Functions
  void addData(ExpenseModel data) {
    _setDataToDataBase(data).then((value) {
      print('data was added : ' + data.toString());
      _expense_data.add({'type': data.type, 'amount': data.amount});
      notifyListeners();
    });
  }

  void addIncome(String name, double amount) {
    _income.add({name: amount});
    notifyListeners();
  }

  Future<void> getDataFromDataBase() async {
    var data = await DBHelperExpenses.getData();
  }

  Future<void> _setDataToDataBase(ExpenseModel data) async {
    DBHelperExpenses.insert(data);
  }

  double getTotalIncome() {
    double amount = 0;
    _income.forEach((element) {
      element.forEach((key, value) {
        amount += value;
      });
    });

    return amount;
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
