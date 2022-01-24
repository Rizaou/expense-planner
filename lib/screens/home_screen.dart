import 'package:gelir_gider/example.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/widgets/custom_action_button.dart';
import 'package:gelir_gider/widgets/expense-card.dart';
import 'package:gelir_gider/widgets/graphic.dart';
import 'package:gelir_gider/widgets/main_incomes_chart.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import '../widgets/dialog_add_expense.dart';

class HomeScreen extends StatefulWidget {
  final _HomeScreenState screen = _HomeScreenState();

  List<Map<dynamic, dynamic>> data = [];

  void moveToGraph() {
    screen.focus(0);
  }

  void moveToExpenses() {
    screen.focus(2);
  }

  void moveToIncomes() {}

  @override
  State<HomeScreen> createState() => screen;
}

class _HomeScreenState extends State<HomeScreen> {
  final control = ItemScrollController();

  void focus(int index) {
    control.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                focus(8);
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
      body: FutureBuilder(
          future:
              expensesProvider.getExpenses.then((value) => widget.data = value),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('loading');
            } else {
              return ScrollablePositionedList.builder(
                itemScrollController: control,
                itemCount: widget.data.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) //* insex 0 = Chart and total incomes.
                  {
                    return MyChart();
                  } else if (index == 1) {
                    return MainIncomeChart();
                  } else {
                    var card = ExpenseCard(
                      title: widget.data[index - 2]['title'],
                      amount: widget.data[index - 2]['amount'],
                      date: DateTime.parse(widget.data[index - 2]['date']),
                    );

                    return card;
                  }
                },
              );
            }
          }),
      floatingActionButton: CustomFloatingBar(
        chart: widget,
      ),
    );
  }
}

// SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//               future: expenseProvider.getExpenses
//                   .then((value) => expensesData = value),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Container(
//                     alignment: Alignment.center,
//                     height: 400,
//                     width: double.infinity,
//                     child: Card(
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 400,
//                         width: double.infinity,
//                         child: const Text('Loading'),
//                       ),
//                       elevation: 4,
//                       shape: CircleBorder(),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return const Text('There is a error');
//                 } else {
//                   return Column(
//                     children: [
//                       Container(
//                         height: 400,
//                         child: Card(
//                           elevation: 4,
//                           shape: const CircleBorder(),
//                           child: Chart(
//                             data: expensesData, //expensesData
//                             transforms: [
//                               Proportion(variable: 'amount', as: 'percent')
//                             ],
//                             variables: {
//                               'title': Variable(
//                                   accessor: (Map map) =>
//                                       map['title'] as String),
//                               'amount': Variable(
//                                   accessor: (Map map) => map['amount'] as num),
//                             },
//                             coord: PolarCoord(transposed: true, dimCount: 1),
//                             elements: [
//                               IntervalElement(
//                                 position: Varset('percent') / Varset('title'),
//                                 label: LabelAttr(
//                                     encoder: (tuple) => Label(
//                                           '${tuple['title']}\n${tuple['amount']}',
//                                           LabelStyle(Defaults.runeStyle),
//                                         )),
//                                 color: ColorAttr(
//                                     variable: 'title',
//                                     values: Defaults.colors10),
//                                 modifiers: [StackModifier()],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 10),
//                         width: double.infinity,
//                         child: Card(
//                             child: FutureBuilder(
//                           future: incomeProvider.getTotalIncome().then((value) {
//                             totalIncome = value;
//                             // print('Total : $totalIncome , value : $value');
//                           }),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasError) {
//                               return const Text('Has an error');
//                             } else if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Text('Waiting');
//                             } else {
//                               return Text(
//                                 '${totalIncome} / ${expenseProvider.getTotalExpense()}',
//                                 textAlign: TextAlign.center,
//                               );
//                             }
//                           },
//                         )),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         child: Column(
//                             children: expensesData
//                                 .map((e) => ExpenseCard(
//                                     tag: e['title'].toString(),
//                                     amount: e['amount'],
//                                     time: DateTime.now()))
//                                 .toList()),
//                       ),
//                     ],
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       )
