import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_providder_program_settings.dart';
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
      late String desc;
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
      });
      incomeData.add(IncomeModel(
        id: id,
        income: income,
        date: DateTime.parse(date),
        description: desc,
      ));
    });
    _incomes = [...incomeData];
    return incomeData;
  }

  Future<void> addIncome({required IncomeModel data, bool? isFirstTime}) async {
    if (isFirstTime != null) {
      if (isFirstTime) {
        DBHelperProgramSettings.userIn();
        DBHelperIncomes.addData(data);
      } else {
        DBHelperIncomes.addData(data);
        notifyListeners();
      }
    } else {
      DBHelperIncomes.addData(data);
      notifyListeners();
    }
  }

  double get totalIncome {
    double sum = 0;
    _incomes.forEach((element) {
      sum += element.income;
    });

    return sum;
  }

  Future<double> getTotalIncome() async {
    double sum = 0;
    var inc = await incomes;

    inc.forEach((element) {
      sum += element.income;
    });

    return sum;

    //print('Sum : ' + sum.toString());
    //return sum;
  }

  void deleteData(int id) {
    DBHelperIncomes.deleteData(id).then((value) {
      notifyListeners();
    });
  }
}
