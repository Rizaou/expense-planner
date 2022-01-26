import 'package:flutter/material.dart';
import 'package:gelir_gider/database/database_provider_incomes.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/income_provider.dart';
import 'package:provider/provider.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard(
      {Key? key, required this.id, required this.title, required this.amount})
      : super(key: key);
  final int id;
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: global_horizontal_padding),
      child: Dismissible(
        key: ValueKey(id),
        onDismissed: (direction) => incomeProvider.deleteData(id),
        child: Card(
          elevation: global_elevation_value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade500,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            alignment: Alignment.center,
            height: global_card_height_px,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(Icons.attach_money),
                Text('${title}'),
                Text('${amount}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
