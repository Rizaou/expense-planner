import 'package:flutter/material.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/models/income_model.dart';
import 'package:gelir_gider/widgets/detail_card.dart';
import 'package:gelir_gider/widgets/my_custom_graph.dart';
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

  Widget _getAllList() {
    return Column(
      children: [
        Graph(),
        MainIncomeChart(),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: control,
      itemCount: 1,
      itemBuilder: (context, index) {
        return _getAllList();
      },
    );
  }
}
