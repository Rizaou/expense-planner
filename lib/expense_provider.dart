import 'package:flutter/material.dart';
import 'package:gelir_gider/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<ExpenseModel> _expense_data = [];

  // Get
  List<ExpenseModel> get getExpenses => [..._expense_data];

  void addData(ExpenseModel data) {
    _expense_data.add(data);
    notifyListeners();
  }
}
