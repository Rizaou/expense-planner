import 'dart:io';

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
    List<Map<dynamic, dynamic>> expensesData = [];

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
            FutureBuilder(
              future: expenseProvider.getExpenses
                  .then((value) => expensesData = value),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    height: 400,
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 400,
                        width: double.infinity,
                        child: const Text('Loading'),
                      ),
                      elevation: 4,
                      shape: CircleBorder(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Text('There is a error');
                } else {
                  return Column(children: [
                    Container(
                      height: 400,
                      child: Card(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: Chart(
                          data: expensesData, //expensesData
                          transforms: [
                            Proportion(variable: 'amount', as: 'percent')
                          ],
                          variables: {
                            'title': Variable(
                                accessor: (Map map) => map['title'] as String),
                            'amount': Variable(
                                accessor: (Map map) => map['amount'] as num),
                          },
                          coord: PolarCoord(transposed: true, dimCount: 1),
                          elements: [
                            IntervalElement(
                              position: Varset('percent') / Varset('title'),
                              label: LabelAttr(
                                  encoder: (tuple) => Label(
                                        '${tuple['title']}\n${tuple['amount']}',
                                        LabelStyle(Defaults.runeStyle),
                                      )),
                              color: ColorAttr(
                                  variable: 'title', values: Defaults.colors10),
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
                          children: expensesData
                              .map((e) => ExpenseCard(
                                  tag: e['title'].toString(),
                                  amount: e['amount'],
                                  time: DateTime.now()))
                              .toList()),
                    ),
                  ]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
