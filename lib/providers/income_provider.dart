import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:provider/provider.dart';

class IncomeProvider with ChangeNotifier {
  List<IncomeModel> _incomes = [];

  IncomeProvider() {
    incomes;
  }
  Future<List<IncomeModel>> get incomes async {
    List<Map> data = await DBHelperIncomes.getAllData();
    List<IncomeModel> incomeData = [];
    data.forEach((element) {
      late int id;
      late double income;
      String? desc;
      late String date;
      element.forEach((key, value) {
        switch (key) {
          case 'id':
            id = value;

            break;
          case 'income':
            income = value;
            break;
          case 'desc':
            desc = value;
            break;
          case 'date':
            date = value;
            break;
        }

        print('burada');
      });
      incomeData.add(IncomeModel(
          id: id,
          income: income,
          date: DateTime.parse(date),
          description: desc != null ? desc : 'yok'));
    });
    return incomeData;
  }

  Future<void> addIncome(IncomeModel data) async {
    DBHelperIncomes.addData(data);
    notifyListeners();
  }

  double getTotalIncome() {
    double sum = 0;

    incomes.then((value) => value.forEach((element) {
          print('buradaaa');
          sum += element.income;
        }));

    print('Sum : ' + sum.toString());
    return sum;
  }
}
