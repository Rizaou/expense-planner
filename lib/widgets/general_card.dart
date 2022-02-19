import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:gelir_gider/widgets/custom_bar.dart';
import 'package:provider/provider.dart';

class GeneralCard extends StatelessWidget {
  GeneralCard({Key? key}) : super(key: key);

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
    final double sumExpenses = expenseProvider.getSumOfExpenses();
    final double sumIncomes = incomeProvider.sumOfCachedIncomes;
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: global_horizontal_padding,
          horizontal: global_horizontal_padding),
      height: 170,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(global_card_corner_big)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "GENERAL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$sumExpenses',
                  style: TextStyle(
                    color: Colors.green.shade200,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  "\$$sumIncomes",
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            CustomBar(maxValue: sumIncomes, currentValue: sumExpenses),
            const SizedBox(
              height: 24,
            ),

            const Text(
              "REVENUES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${sumIncomes - sumExpenses}",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            // Text('data 2'),
          ],
        ),
      ),
    );
  }
}
