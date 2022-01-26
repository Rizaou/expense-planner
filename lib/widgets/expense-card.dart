import 'package:flutter/material.dart';
import 'package:gelir_gider/methods/global_values.dart';
import 'package:gelir_gider/providers/expense_provider.dart';
import 'package:gelir_gider/providers/program_settings_provider.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class ExpenseCard extends StatelessWidget {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  const ExpenseCard(
      {Key? key,
      required this.title,
      required this.amount,
      required this.date,
      required this.id})
      : super(key: key);

  String _checkTag() {
    if (title.length > 10) {
      String yeni = title.substring(0, 7);

      return (yeni + '...');
    } else {
      return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Dismissible(
        onDismissed: (direction) => expenseProvider.deleteData(id),
        key: Key(id.toString()),
        background: Container(
          color: Colors.red,
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
        direction: DismissDirection.endToStart,
        child: Card(
          elevation: global_elevation_value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade500,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            height: global_card_height_px,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.card_travel_outlined),
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      child: Text(_checkTag()),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 10),
                      Text('$amount'),
                      Text(
                        DateFormat('dd/MM/yyyy').format(date),
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
