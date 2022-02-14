import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';

class Graph extends StatelessWidget {
  Graph({Key? key}) : super(key: key);

  double calculateRatio(
      {required double maxWidth,
      required double totalIncomes,
      required double totalExpenses}) {
    //double query = MediaQuery.of(context).size.width;
    if (totalExpenses >= totalIncomes) {
      return maxWidth - global_horizontal_padding;
    } else if (totalExpenses == 0 || totalIncomes == 0) {
      return 0;
    }
    double currentWidth = maxWidth - global_horizontal_padding;
    double value = currentWidth * totalExpenses / totalIncomes;

    //! Check if the income = 0
    //! Check if the income > 100;

    return (value);
  }

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(
                    global_horizontal_padding,
                  ),
                  //width: MediaQuery.of(context).size.width,
                  height: 24,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            //margin: EdgeInsets.all(global_horizontal_padding),
                            //height: 23,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Positioned(
                            left: calculateRatio(
                                maxWidth: constraints.maxWidth,
                                totalExpenses:
                                    expenseProvider.getSumOfExpenses(),
                                totalIncomes: incomeProvider.totalIncome),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ],
                      );
                    },
                  )),
            ],
          ),
          // Text('data 2'),
        ],
      ),
    );
  }
}
