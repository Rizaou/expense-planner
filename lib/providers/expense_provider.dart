import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider.dart';
import 'package:gelir_gider/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<dynamic, dynamic>> _expense_data = [
    {'type': 'market', 'amount': 100.0},
    {'type': 'okul', 'amount': 50.0},
    {'type': 'eğlence', 'amount': 100.0},
  ];

  List<Map<String, double>> _income = [
    {'KYK': 850.0},
  ];

  // Get
  List<Map<dynamic, dynamic>> get getExpenses => [..._expense_data];
  List<Map<String, double>> get getIncome => [..._income];

  // Functions
  void addData(ExpenseModel data) {
    _expense_data.add({'type': data.type, 'amount': data.amount});
    notifyListeners();
  }

  void addIncome(String name, double amount) {
    _income.add({name: amount});
    notifyListeners();
  }

  Future<void> getDataFromDataBase() async {
    var data = await DBHelper.getData('expenses');
    print(data);
  }

  Future<void> _setDataToDataBase() async {
    DBHelper.insert(
      'expenses',
      ExpenseModel(
          amount: 10, date: DateTime.now(), type: 'Type', description: 'Yok'),
    );
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
