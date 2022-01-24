import 'package:flutter/material.dart';
import 'package:gelir_gider/widgets/expense-card.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';
import 'package:graphic/graphic.dart';

class DetailedSCreen extends StatefulWidget {
  final expenseProvider;
  final incomeProvider;

  DetailedSCreen(this.expenseProvider, this.incomeProvider);

  @override
  _DetailedSCreenState createState() => _DetailedSCreenState();
}

class _DetailedSCreenState extends State<DetailedSCreen> {
  @override
  Widget build(BuildContext context) {
    // final expenseProvider = Provider.of<ExpenseProvider>(context, listen: true);
    // final incomeProvider = Provider.of<IncomeProvider>(context, listen: true);

    List<Map<dynamic, dynamic>> expensesData = [];
    double totalIncome = 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: widget.expenseProvider.getExpenses
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
                return Column(
                  children: [
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
                          child: FutureBuilder(
                        future: widget.incomeProvider
                            .getTotalIncome()
                            .then((value) {
                          totalIncome = value;
                          // print('Total : $totalIncome , value : $value');
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Has an error');
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Waiting');
                          } else {
                            return Text(
                              '${totalIncome} / ${widget.expenseProvider.getSumOfExpenses()}',
                              textAlign: TextAlign.center,
                            );
                          }
                        },
                      )),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                          children: expensesData
                              .map((e) => ExpenseCard(
                                  title: e['title'].toString(),
                                  amount: e['amount'],
                                  date: DateTime.now()))
                              .toList()),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
