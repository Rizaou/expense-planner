import 'package:flutter/material.dart';
import 'package:gelir_gider/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<Map<dynamic, dynamic>> _expense_data = [
    {'type': 'Sports', 'amount': 275},
    {'type': 'Strategy', 'amount': 115},
    {'type': 'Action', 'amount': 120},
    {'type': 'Shooter', 'amount': 350},
    {'type': 'Other', 'amount': 150},
    {'type': 'market', 'amount': 100},
  ];

  // Get
  List<Map<dynamic, dynamic>> get getExpenses => [..._expense_data];

  void addData(ExpenseModel data) {
    _expense_data.add({'type': data.type, 'amount': data.amount});
    notifyListeners();
  }
}
