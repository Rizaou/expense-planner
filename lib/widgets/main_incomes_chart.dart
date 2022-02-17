import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import '../providers/program_settings_provider.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';

class MainIncomeChart extends StatefulWidget {
  MainIncomeChart({Key? key}) : super(key: key);

  @override
  State<MainIncomeChart> createState() => _MainIncomeChartState();
}

class _MainIncomeChartState extends State<MainIncomeChart> {
  late double incomes;
  double expenses = 0;

  List<Color> getColor() {
    Color red = Colors.red.shade500;
    Color green = Colors.green.shade500;
    Color white = Colors.white;
    double ratio = 100 * expenses / incomes;

    if (expenses == 0 && incomes == 0) {
      return [white, white];
    } else if (incomes == 0) {
      return [red, red];
    } else if (expenses == 0) {
      return [green, green];
    } else if (ratio < 25) {
      return [green, green, green, red];
    } else if (ratio >= 25 && ratio < 75) {
      return [green, green, red, red];
    } else {
      return [green, red, red, red];
    }
  }

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final programSettings = Provider.of<ProgramSettings>(context);
    expenses = expenseProvider.getSumOfExpenses();

    return FutureBuilder(
      future: incomeProvider.getTotalIncome().then((value) {
        incomes = value;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Card(
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('ERROR!'),
                width: double.infinity,
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(global_horizontal_padding),
            child: Column(
              children: [
                Card(
                  elevation: global_elevation_value,
                  child: Container(
                    height: global_card_height_px,
                    alignment: Alignment.center,
                    width: double.infinity,
                    padding: const EdgeInsets.all(global_horizontal_padding),
                    child: Text(
                      (incomes - expenses).toString(),
                    ),
                  ),
                ),
                Card(
                  elevation: global_elevation_value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: getColor(),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Card(
                              elevation: global_elevation_value,
                              color: Colors.green,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    (programSettings.tr_text["income"]
                                            as String)
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Card(
                              elevation: global_elevation_value,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("${incomes}")),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                              elevation: global_elevation_value,
                              color: Colors.red,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    (programSettings.tr_text["expense"]
                                            as String)
                                        .toUpperCase(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                            Card(
                              elevation: global_elevation_value,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text("${expenses}")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('wait');
        }
      },
    );
  }
}



//  Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             width: double.infinity,
//             child: Card(
//               elevation: global_elevation_value,
//               color: getColor(),
//               child: Container(
//                 height: 50,
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Flexible(child: Container()),
//                     Text('${expenses}'),
//                     Text(' \\ '),
//                     Text(
//                       '${incomes}',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                     Flexible(child: Container()),
//                   ],
//                 ),
//                 width: double.infinity,
//               ),
//             ),
//           );