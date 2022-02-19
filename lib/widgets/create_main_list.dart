import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/widgets/detail_card.dart';
import 'package:gelir_gider/widgets/dialog_add_expense.dart';
import 'package:gelir_gider/widgets/dialog_add_income.dart';
import 'package:gelir_gider/widgets/general_card.dart';
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

  Widget _getAllList(BuildContext context) {
    return Column(
      children: [
        GeneralCard(),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(global_card_corner_low)),
          padding: const EdgeInsets.all(global_horizontal_padding),
          margin:
              const EdgeInsets.symmetric(horizontal: global_horizontal_padding),
          width: double.infinity,
          child: const Text("EXPENSES", textAlign: TextAlign.center),
        ),
        // MainIncomeChart(),
        ElevatedButton(
            onPressed: () {
              AddIncome().getDialog(context);
            },
            child: Text("Income")),
        ElevatedButton(
            onPressed: () {
              AddExpense().getDialog(context);
            },
            child: Text("Expense")),
        ...expenseData
            .map((e) => ExpenseCard(
                title: e.title, amount: e.amount, date: e.date, id: e.id))
            .toList(),
        ...incomeData
            .map((e) => IncomeCard(
                  id: e.id,
                  amount: e.income,
                  title: e.description,
                ))
            .toList(),
        DetailCard(),
        const Text("YOUR CARDS!"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: control,
      itemCount: 1,
      itemBuilder: (context, index) {
        return _getAllList(context);
      },
    );
  }
}
