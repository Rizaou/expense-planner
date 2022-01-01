import 'package:flutter/material.dart';
import 'package:gelir_gider/expense_provider.dart';
import 'package:gelir_gider/home_page/add_expense/add_expense.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpenseProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              onPressed: () {
                AddExpense().getDialog(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Chart(
          data: [
            {'genre': 'Sports', 'sold': 275},
          ],
          variables: {
            'genre': Variable(accessor: (Map map) => map['genre'] as String),
            'sold': Variable(accessor: (Map map) => map['sold'] as num),
          },
          elements: [IntervalElement()],
          axes: [
            Defaults.horizontalAxis,
            Defaults.verticalAxis,
          ],
        ),
      ),
    );
  }
}
