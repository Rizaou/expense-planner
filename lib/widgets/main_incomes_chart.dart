import 'package:flutter/material.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class MainIncomeChart extends StatefulWidget {
  MainIncomeChart({Key? key}) : super(key: key);

  @override
  State<MainIncomeChart> createState() => _MainIncomeChartState();
}

class _MainIncomeChartState extends State<MainIncomeChart> {
  late double incomes;
  double expenses = 0;

  Color getColor() {
    if (expenses == 0 || incomes == 0) {
      return Colors.white;
    }

    //* Calculate
    double ratio = 100 * expenses / incomes;
    double reduceBlue = 255 * ratio / 100;
    reduceBlue = 255 - reduceBlue;

    double reduceGreen = reduceBlue / 2;

    print(
        'ratio : $ratio , 255-ratio  : ${255 - ratio.round()}, /2 : ${(255 - ratio.round()) / 2}');
    Color cl = Color.fromARGB(255, 255, reduceGreen.round(),
        reduceBlue.round()); //! decrease blue, green
    return cl;
  }

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    expenses = expenseProvider.getSumOfExpenses();

    return FutureBuilder(
      future: incomeProvider.getTotalIncome().then((value) {
        incomes = value;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Card(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('ERROR!'),
                width: double.infinity,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Card(
              color: getColor(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '${incomes} / ${expenses}',
                ),
                width: double.infinity,
              ),
            ),
          );
        } else {
          return Text('wait');
        }
      },
    );
  }
}
