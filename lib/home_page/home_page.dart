import 'package:gelir_gider/example.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:path/path.dart';
import '../providers/income_provider.dart';
import './add_expense/add_income.dart';
import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_expenses.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/home_page/add_expense/add_expense.dart';
import 'package:gelir_gider/home_page/expense-card.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import '../database/database_provider_expenses.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

enum Screens {
  detailed,
  expenses,
  incomes,
}

class HomePage extends StatefulWidget {
  var currentScreen = Screens.detailed;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<dynamic, dynamic>> data = [];

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: true);
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: true);
    List<Map<dynamic, dynamic>> expensesData = [];

    double totalIncome = 0;
    // incomeProvider.getTotalIncome().then((value) {});

    void _changeScreen(Screens scr) {
      print('gönderilen sc : ' +
          scr.name +
          ' current scr : ' +
          widget.currentScreen.name);
      if (widget.currentScreen != scr) {
        switch (scr) {
          case Screens.detailed:
            setState(() {
              widget.currentScreen = Screens.detailed;
            });
            break;
          case Screens.expenses:
            setState(() {
              widget.currentScreen = Screens.expenses;
            });
            break;
          case Screens.incomes:
            setState(() {
              widget.currentScreen = Screens.incomes;
            });
            break;
          default:
            setState(() {
              widget.currentScreen = Screens.detailed;
            });
        }
      }
    }

    switch (widget.currentScreen) {
      case Screens.detailed:
        {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Example()));
                    },
                    icon: const Icon(Icons.flag)),
                IconButton(
                  onPressed: () {
                    AddExpense().getDialog(context);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: widget.currentScreen == Screens.detailed
                  ? Column(
                      children: [
                        FutureBuilder(
                          future: expenseProvider.getExpenses
                              .then((value) => expensesData = value),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                          Proportion(
                                              variable: 'amount', as: 'percent')
                                        ],
                                        variables: {
                                          'title': Variable(
                                              accessor: (Map map) =>
                                                  map['title'] as String),
                                          'amount': Variable(
                                              accessor: (Map map) =>
                                                  map['amount'] as num),
                                        },
                                        coord: PolarCoord(
                                            transposed: true, dimCount: 1),
                                        elements: [
                                          IntervalElement(
                                            position: Varset('percent') /
                                                Varset('title'),
                                            label: LabelAttr(
                                                encoder: (tuple) => Label(
                                                      '${tuple['title']}\n${tuple['amount']}',
                                                      LabelStyle(
                                                          Defaults.runeStyle),
                                                    )),
                                            color: ColorAttr(
                                                variable: 'title',
                                                values: Defaults.colors10),
                                            modifiers: [StackModifier()],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: double.infinity,
                                    child: Card(
                                        child: FutureBuilder(
                                      future: incomeProvider
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
                                            '${totalIncome} / ${expenseProvider.getTotalExpense()}',
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
                                                tag: e['title'].toString(),
                                                amount: e['amount'],
                                                time: DateTime.now()))
                                            .toList()),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    )
                  : Text(''),
            ),
            floatingActionButton: SpeedDial(
              child: const Icon(Icons.menu),
              overlayOpacity: 0,
              children: [
                SpeedDialChild(
                  label: 'Expenses',
                  child: const Icon(Icons.attach_money_sharp),
                  onTap: () {
                    _changeScreen(Screens.expenses);
                  },
                ),
                SpeedDialChild(
                    label: 'Incomes',
                    child: const Icon(Icons.money_off_sharp),
                    onTap: () {
                      _changeScreen(Screens.incomes);
                    }),
              ],
            ),
          );
        }

      case Screens.expenses:
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                Text('expenses'),
                ElevatedButton(
                    onPressed: () {
                      _changeScreen(Screens.incomes);
                    },
                    child: Text(''))
              ],
            ),
          ),
        );
      case Screens.incomes:
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('Incomes'),
          ),
        );
      default:
        return Text('');
    }
  }
}
