import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/models/expense_model.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:gelir_gider/widgets/my_custom_graph.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';

class MyChart extends StatefulWidget {
  MyChart({Key? key}) : super(key: key);
  late List<ExpenseModel> expensesData = [];

  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  double totalIncome = 0;
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: true);
    final incomeProvider = Provider.of<IncomeProvider>(context, listen: true);
    final programSettings = Provider.of<ProgramSettings>(context);

    Widget _emptyGraph(String title) {
      return Container(
        alignment: Alignment.center,
        height: 400,
        width: double.infinity,
        child: Card(
          child: Container(
            alignment: Alignment.center,
            height: 400,
            width: double.infinity,
            child: Text(title),
          ),
          elevation: global_elevation_value,
          shape: CircleBorder(),
        ),
      );
    }

    return FutureBuilder(
      future: expenseProvider.getMonthlyExpenses
          .then((value) => widget.expensesData = value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _emptyGraph("Loading");
        } else if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            height: 400,
            width: double.infinity,
            child: Card(
              child: Container(
                alignment: Alignment.center,
                height: 400,
                width: double.infinity,
                child: const Text('There is an error.'),
              ),
              elevation: global_elevation_value,
              shape: CircleBorder(),
            ),
          );
        } else {
          return widget.expensesData.isEmpty
              ? _emptyGraph(programSettings.tr_text["no_transaction"])
              : Container(
                  // height: 400,
                  child: Graph(),
                );
        }
      },
    );
  }
}


// Chart(
//                       data: widget.expensesData, //expensesData
//                       transforms: [
//                         Proportion(variable: 'amount', as: 'percent')
//                       ],
//                       variables: {
//                         'title': Variable(
//                             accessor: (Map map) => map['title'] as String),
//                         'amount': Variable(
//                             accessor: (Map map) => map['amount'] as num),
//                       },
//                       coord: PolarCoord(transposed: true, dimCount: 1),
//                       elements: [
//                         IntervalElement(
//                           position: Varset('percent') / Varset('title'),
//                           label: LabelAttr(
//                               encoder: (tuple) => Label(
//                                     '${tuple['title']}\n${tuple['amount']}',
//                                     LabelStyle(Defaults.runeStyle),
//                                   )),
//                           color: ColorAttr(
//                               variable: 'title', values: Defaults.colors10),
//                           modifiers: [StackModifier()],
//                         )
//                       ],
//                     ),