import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Map<dynamic, dynamic>> _expense_data = [
    {'type': 'Sports', 'amount': 275},
    {'type': 'Strategy', 'amount': 115},
    {'type': 'Action', 'amount': 120},
    {'type': 'Shooter', 'amount': 350},
    {'type': 'Other', 'amount': 150},
    {'type': 'market', 'amount': 100},
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

  double getTotalIncome() {
    double totalAmount = 0;

    _income.forEach((element) {
      element.forEach((key, value) {
        totalAmount += value;
      });
    });

    return totalAmount;
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
