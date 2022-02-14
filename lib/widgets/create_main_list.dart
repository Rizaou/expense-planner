import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'detail_widget.dart';
import 'expense-card.dart';
import 'graphic.dart';
import 'income_card.dart';
import 'main_incomes_chart.dart';

class CreateMainList extends StatelessWidget {
  CreateMainList({
    Key? key,
    required this.control,
    required this.expenseData,
    required this.incomeData,
  }) : super(key: key);

  final ItemScrollController control;
  final List<ExpenseModel> expenseData;
  final List<IncomeModel> incomeData;

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: control,
      itemCount: 2 + incomeData.length + expenseData.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return MyChart();
        } else if (index == 1) {
          return MainIncomeChart();
        } else if (expenseData.isNotEmpty &&
            (index >= 2 && index - 2 < expenseData.length)) {
          return ExpenseCard(
              title: expenseData[index - 2].title,
              amount: expenseData[index - 2].amount,
              date: expenseData[index - 2].date,
              id: expenseData[index - 2].id);
        } else if (expenseData.isEmpty) {
          return Text("No expenses Added");
        } else if (incomeData.isNotEmpty &&
            (index >= 2 + expenseData.length &&
                index - (expenseData.length + 2 + incomeData.length) <=
                    incomeData.length)) {
          return IncomeCard(
              id: incomeData[index - expenseData.length - 2].id,
              title: incomeData[index - expenseData.length - 2].description,
              amount: incomeData[index - expenseData.length - 2].income);
        } else if (incomeData.isEmpty) {
          return Text("No incomes added");
        } else {
          return Text('');
        }
      },
    );
  }
}
