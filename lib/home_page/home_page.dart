import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/home_page/add_expense/add_expense.dart';
import 'package:gelir_gider/home_page/expense-card.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import '../database/database_provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<dynamic, dynamic>> data = [];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: true);
    var expenseData = expenseProvider.getExpenses;
    expenseProvider.getDataFromDataBase();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              AddExpense().getDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: Card(
                elevation: 4,
                shape: CircleBorder(),
                child: Chart(
                  data: expenseData,
                  transforms: [Proportion(variable: 'amount', as: 'percent')],
                  variables: {
                    'type':
                        Variable(accessor: (Map map) => map['type'] as String),
                    'amount':
                        Variable(accessor: (Map map) => map['amount'] as num),
                  },
                  coord: PolarCoord(transposed: true, dimCount: 1),
                  elements: [
                    IntervalElement(
                      position: Varset('percent') / Varset('type'),
                      label: LabelAttr(
                          encoder: (tuple) => Label(
                                '${tuple['type']}\n${tuple['amount']}',
                                LabelStyle(Defaults.runeStyle),
                              )),
                      color: ColorAttr(
                          variable: 'type', values: Defaults.colors10),
                      modifiers: [StackModifier()],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Card(
                child: Text(
                  '${expenseProvider.getTotalIncome()} / ${expenseProvider.getTotalExpense()}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                  children: expenseData
                      .map((e) => ExpenseCard(
                          tag: e['type'].toString(),
                          amount: e['amount'],
                          time: DateTime.now()))
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
